"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cp = require("child_process");
const readline = require("readline");
const utils = require("./elmUtils");
const vscode = require("vscode");
function severityStringToDiagnosticSeverity(severity) {
    switch (severity) {
        case 'error':
            return vscode.DiagnosticSeverity.Error;
        case 'warning':
            return vscode.DiagnosticSeverity.Warning;
        default:
            return vscode.DiagnosticSeverity.Error;
    }
}
function elmMakeIssueToDiagnostic(issue) {
    let lineRange = new vscode.Range(issue.region.start.line - 1, issue.region.start.column - 1, issue.region.end.line - 1, issue.region.end.column - 1);
    return new vscode.Diagnostic(lineRange, issue.overview + ' - ' + issue.details.replace(/\[\d+m/g, ''), severityStringToDiagnosticSeverity(issue.type));
}
function checkForErrors(filename) {
    return new Promise((resolve, reject) => {
        const config = vscode.workspace.getConfiguration('elm');
        const makeCommand = config.get('makeCommand');
        const cwd = utils.detectProjectRoot(filename) || vscode.workspace.rootPath;
        let make;
        if (utils.isWindows) {
            filename = "\"" + filename + "\"";
        }
        const args = [filename, '--report', 'json', '--output', '/dev/null'];
        if (utils.isWindows) {
            make = cp.exec(makeCommand + ' ' + args.join(' '), { cwd: cwd });
        }
        else {
            make = cp.spawn(makeCommand, args, { cwd: cwd });
        }
        // output is actually optional
        // (fixed in https://github.com/Microsoft/vscode/commit/b4917afe9bdee0e9e67f4094e764f6a72a997c70,
        // but unreleased at this time)
        const stdoutlines = readline.createInterface({
            input: make.stdout,
            output: undefined,
        });
        const lines = [];
        stdoutlines.on('line', (line) => {
            // Ignore compiler success.
            if (line.startsWith('Successfully generated')) {
                return;
            }
            // Elm writes out JSON arrays of diagnostics, with one array per line.
            // Multiple lines may be received.
            lines.push(...JSON.parse(line));
        });
        const stderr = [];
        make.stderr.on('data', (data) => {
            if (data) {
                stderr.push(data);
            }
        });
        make.on('error', (err) => {
            stdoutlines.close();
            if (err && err.code === 'ENOENT') {
                vscode.window.showInformationMessage("The 'elm-make' compiler is not available.  Install Elm from http://elm-lang.org/.");
                resolve([]);
            }
            else {
                reject(err);
            }
        });
        make.on('close', (code, signal) => {
            stdoutlines.close();
            if (stderr.length) {
                let errorResult = {
                    tag: 'error',
                    overview: '',
                    subregion: '',
                    details: stderr.join(''),
                    region: {
                        start: {
                            line: 1,
                            column: 1,
                        },
                        end: {
                            line: 1,
                            column: 1,
                        },
                    },
                    type: 'error',
                    file: filename,
                };
                resolve([errorResult]);
            }
            else {
                resolve(lines);
            }
        });
    });
}
function runLinter(document, elmAnalyse) {
    if (document.languageId !== 'elm' || document.uri.scheme !== 'file') {
        return;
    }
    let compileErrors = vscode.languages.createDiagnosticCollection('elm');
    let uri = document.uri;
    compileErrors.clear();
    checkForErrors(uri.fsPath)
        .then((compilerErrors) => {
        const cwd = utils.detectProjectRoot(uri.fsPath) || vscode.workspace.rootPath;
        let splitCompilerErrors = new Map();
        compilerErrors.forEach((issue) => {
            // If provided path is relative, make it absolute
            if (issue.file.startsWith('.')) {
                issue.file = cwd + issue.file.slice(1);
            }
            if (splitCompilerErrors.has(issue.file)) {
                splitCompilerErrors.get(issue.file).push(issue);
            }
            else {
                splitCompilerErrors.set(issue.file, [issue]);
            }
        });
        // Turn split arrays into diagnostics and associate them with correct files in VS
        splitCompilerErrors.forEach((issue, path) => {
            compileErrors.set(vscode.Uri.file(path), issue.map(error => elmMakeIssueToDiagnostic(error)));
        });
    })
        .catch(error => {
        compileErrors.set(document.uri, []);
    });
    if (elmAnalyse.elmAnalyseIssues.length > 0) {
        let splitCompilerErrors = new Map();
        elmAnalyse.elmAnalyseIssues.forEach((issue) => {
            if (splitCompilerErrors.has(issue.file)) {
                splitCompilerErrors.get(issue.file).push(issue);
            }
            else {
                splitCompilerErrors.set(issue.file, [issue]);
            }
            splitCompilerErrors.forEach((analyserIssue, path) => {
                compileErrors.set(vscode.Uri.file(path), analyserIssue.map(error => elmMakeIssueToDiagnostic(error)));
            });
        });
    }
}
exports.runLinter = runLinter;
//# sourceMappingURL=elmLinter.js.map