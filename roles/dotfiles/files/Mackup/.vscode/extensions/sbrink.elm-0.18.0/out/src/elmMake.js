"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cp = require("child_process");
const path = require("path");
const utils = require("./elmUtils");
const vscode = require("vscode");
let make;
let oc = vscode.window.createOutputChannel('Elm Make');
function execMake(editor, warn) {
    try {
        if (editor.document.languageId !== 'elm') {
            return;
        }
        if (make) {
            make.kill();
            oc.clear();
        }
        let file = editor.document.fileName;
        const cwd = utils.detectProjectRoot(file) || vscode.workspace.rootPath;
        const config = vscode.workspace.getConfiguration('elm');
        const name = config.get('makeOutput');
        const specialFile = config.get('makeSpecialFile');
        const makeCommand = config.get('makeCommand');
        if (specialFile.length > 0) {
            file = path.resolve(cwd, specialFile);
        }
        if (utils.isWindows) {
            file = "\"" + file + "\"";
        }
        let args = [file, '--yes', '--output=' + name];
        if (warn) {
            args.push('--warn');
        }
        if (utils.isWindows) {
            make = cp.exec(makeCommand + ' ' + args.join(' '), { cwd: cwd });
        }
        else {
            make = cp.spawn(makeCommand, args, { cwd: cwd });
        }
        make.stdout.on('data', (data) => {
            if (data) {
                oc.append(data.toString());
            }
        });
        make.stderr.on('data', (data) => {
            if (data) {
                oc.append(data.toString());
            }
        });
        oc.show(vscode.ViewColumn.Three);
    }
    catch (e) {
        console.error('Running Elm Make failed', e);
        vscode.window.showErrorMessage('Running Elm Make failed');
    }
}
function runMake(editor) {
    execMake(editor, false);
}
function runMakeWarn(editor) {
    execMake(editor, true);
}
function activateMake() {
    return [
        vscode.commands.registerTextEditorCommand('elm.make', runMake),
        vscode.commands.registerTextEditorCommand('elm.makeWarn', runMakeWarn),
    ];
}
exports.activateMake = activateMake;
//# sourceMappingURL=elmMake.js.map