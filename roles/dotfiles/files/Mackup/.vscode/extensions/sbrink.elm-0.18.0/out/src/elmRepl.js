"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const elmUtils_1 = require("./elmUtils");
const vscode_1 = require("vscode");
let repl = {};
let oc = vscode.window.createOutputChannel('Elm REPL');
function startRepl(fileName, forceRestart = false) {
    if (repl.isRunning) {
        return Promise.resolve(repl.stdin.write.bind(repl.stdin));
    }
    else {
        return new Promise(resolve => {
            repl = elmUtils_1.execCmd('elm-repl', {
                fileName: fileName,
                cmdArguments: [],
                showMessageOnError: true,
                onStart: () => resolve(repl.stdin.write.bind(repl.stdin)),
                // strip output text of leading '>'s and '|'s
                onStdout: data => oc.append(data.replace(/^((>|\|)\s*)+/gm, '')),
                onStderr: data => oc.append(data),
                notFoundText: 'Install Elm from http://elm-lang.org/.',
            });
            oc.show(vscode.ViewColumn.Three);
        });
    }
}
function stopRepl() {
    if (repl.isRunning) {
        repl.kill();
        oc.clear();
        oc.dispose();
        vscode.window.showInformationMessage('Elm REPL stopped.');
    }
    else {
        vscode.window.showErrorMessage('Cannot stop Elm REPL. The REPL is not running.');
    }
}
function send(editor, msg) {
    if (editor.document.languageId !== 'elm') {
        return;
    }
    startRepl(editor.document.fileName).then(writeToRepl => {
        const // Multiline input has to have '\' at the end of each line
        inputMsg = msg.replace(/\n/g, '\\\n') + '\n', 
        // Prettify input for display
        displayMsg = '> ' + msg.replace(/\n/g, '\n| ') + '\n';
        writeToRepl(inputMsg);
        oc.append(displayMsg);
        // when the output window is first shown it steals focus
        // switch it back to the text document
        vscode_1.window.showTextDocument(editor.document);
    });
}
function sendLine(editor) {
    send(editor, editor.document.lineAt(editor.selection.start).text);
}
function sendSelection(editor) {
    send(editor, editor.document.getText(editor.selection));
}
function sendFile(editor) {
    send(editor, editor.document.getText());
}
function activateRepl() {
    return [
        vscode.commands.registerCommand('elm.replStart', () => startRepl(vscode_1.workspace.rootPath + '/x')),
        vscode.commands.registerCommand('elm.replStop', () => stopRepl()),
        vscode.commands.registerTextEditorCommand('elm.replSendLine', sendLine),
        vscode.commands.registerTextEditorCommand('elm.replSendSelection', sendSelection),
        vscode.commands.registerTextEditorCommand('elm.replSendFile', sendFile),
    ];
}
exports.activateRepl = activateRepl;
//# sourceMappingURL=elmRepl.js.map