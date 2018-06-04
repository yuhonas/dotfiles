"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const cp = require("child_process");
const path = require("path");
const vscode = require("vscode");
const elmUtils_1 = require("./elmUtils");
let reactor;
let oc = vscode.window.createOutputChannel('Elm Reactor');
let statusBarStopButton;
function startReactor() {
    try {
        stopReactor(/*notify*/ false);
        const config = vscode.workspace.getConfiguration('elm');
        const host = config.get('reactorHost');
        const port = config.get('reactorPort');
        const subdir = config.get('reactorSubdir');
        const args = ['-a=' + host, '-p=' + port], cwd = path.join(vscode.workspace.rootPath, subdir);
        if (elmUtils_1.isWindows) {
            reactor = cp.exec('elm-reactor ' + args.join(' '), { cwd: cwd });
        }
        else {
            reactor = cp.spawn('elm-reactor', args, { cwd: cwd, detached: true });
        }
        reactor.stdout.on('data', (data) => {
            if (data && data.toString().startsWith('| ') === false) {
                oc.append(data.toString());
            }
        });
        reactor.stderr.on('data', (data) => {
            if (data) {
                oc.append(data.toString());
            }
        });
        oc.show(vscode.ViewColumn.Three);
        statusBarStopButton.show();
    }
    catch (e) {
        console.error('Starting Elm reactor failed', e);
        vscode.window.showErrorMessage('Starting Elm reactor failed');
    }
}
function stopReactor(notify) {
    if (reactor) {
        if (elmUtils_1.isWindows) {
            cp.spawn('taskkill', ['/pid', reactor.pid.toString(), '/f', '/t']);
        }
        else {
            process.kill(-reactor.pid, 'SIGKILL');
        }
        reactor = null;
        statusBarStopButton.hide();
        oc.dispose();
        oc.hide();
    }
    else {
        if (notify) {
            vscode.window.showInformationMessage('Elm Reactor not running');
        }
    }
}
function activateReactor() {
    statusBarStopButton = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left);
    statusBarStopButton.text = '$(primitive-square)';
    statusBarStopButton.command = 'elm.reactorStop';
    statusBarStopButton.tooltip = 'Stop reactor';
    return [
        vscode.commands.registerCommand('elm.reactorStart', startReactor),
        vscode.commands.registerCommand('elm.reactorStop', () => stopReactor(/*notify*/ true)),
    ];
}
exports.activateReactor = activateReactor;
function deactivateReactor() {
    stopReactor(/*notify*/ false);
}
exports.deactivateReactor = deactivateReactor;
//# sourceMappingURL=elmReactor.js.map