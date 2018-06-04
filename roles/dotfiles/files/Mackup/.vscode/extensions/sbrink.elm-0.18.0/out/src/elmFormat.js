"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const vscode_1 = require("vscode");
const elmUtils_1 = require("./elmUtils");
class ElmFormatProvider {
    constructor(statusBarItem) {
        statusBarItem.hide();
        this.showError = statusBarMessage(statusBarItem);
        this.clearError = clearStatus(statusBarItem);
    }
    provideDocumentFormattingEdits(document, options, token) {
        return elmFormat(document)
            .then(({ stdout }) => {
            this.clearError();
            const lastLineId = document.lineCount - 1;
            const wholeDocument = new vscode_1.Range(0, 0, lastLineId, document.lineAt(lastLineId).text.length);
            return [vscode_1.TextEdit.replace(wholeDocument, stdout)];
        })
            .catch(this.showError);
    }
}
exports.ElmFormatProvider = ElmFormatProvider;
class ElmRangeFormatProvider {
    constructor(statusBarItem) {
        statusBarItem.hide();
        this.showError = statusBarMessage(statusBarItem);
        this.clearError = clearStatus(statusBarItem);
    }
    /*
    Formatting range is the same as formatting whole document,
    rather than user's current selection.
    */
    provideDocumentRangeFormattingEdits(document, range, options, token) {
        return elmFormat(document)
            .then(({ stdout }) => {
            this.clearError();
            const lastLineId = document.lineCount - 1;
            const wholeDocument = new vscode_1.Range(0, 0, lastLineId, document.lineAt(lastLineId).text.length);
            return [vscode_1.TextEdit.replace(wholeDocument, stdout)];
        })
            .catch(this.showError);
    }
}
exports.ElmRangeFormatProvider = ElmRangeFormatProvider;
function elmFormat(document) {
    const config = vscode.workspace.getConfiguration('elm');
    const formatCommand = config.get('formatCommand');
    const options = {
        cmdArguments: [],
        notFoundText: 'Install Elm-format from https://github.com/avh4/elm-format',
    };
    const format = elmUtils_1.execCmd(formatCommand + ' --stdin', options);
    format.stdin.write(document.getText());
    format.stdin.end();
    return format;
}
function clearStatus(statusBarItem) {
    return function () {
        statusBarItem.text = '';
        statusBarItem.hide();
    };
}
function statusBarMessage(statusBarItem) {
    return function (err) {
        const message = err.message.includes('SYNTAX PROBLEM')
            ? 'Running elm-format failed. Check the file for syntax errors.'
            : 'Running elm-format failed. Install from ' +
                "https://github.com/avh4/elm-format and make sure it's on your path";
        let editor = vscode.window.activeTextEditor;
        if (editor) {
            statusBarItem.text = message;
            statusBarItem.show();
        }
        return;
    };
}
//# sourceMappingURL=elmFormat.js.map