"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const elmUtils_1 = require("./elmUtils");
const request = require('request');
let oc = vscode.window.createOutputChannel('Elm Package');
function browsePackage() {
    const quickPickPackageOptions = {
        matchOnDescription: true,
        placeHolder: 'Choose a package',
    };
    const quickPickVersionOptions = {
        matchOnDescription: false,
        placeHolder: 'Choose a version, or press <esc> to browse the latest',
    };
    return getJSON()
        .then(transformToPackageQuickPickItems)
        .then(packages => vscode.window.showQuickPick(packages, quickPickPackageOptions))
        .then(selectedPackage => {
        if (selectedPackage === undefined) {
            return; // no package
        }
        return vscode.window
            .showQuickPick(transformToPackageVersionQuickPickItems(selectedPackage), quickPickVersionOptions)
            .then(selectedVersion => {
            oc.show(vscode.ViewColumn.Three);
            let uri = selectedVersion
                ? vscode.Uri.parse('http://package.elm-lang.org/packages/' +
                    selectedPackage.label +
                    '/' +
                    selectedVersion.label)
                : vscode.Uri.parse('http://package.elm-lang.org/packages/' +
                    selectedPackage.label +
                    '/latest');
            vscode.commands.executeCommand('vscode.open', uri, 3);
        });
    });
}
function transformToPackageQuickPickItems(packages) {
    return packages.map(item => {
        return { label: item.name, description: item.summary, info: item };
    });
}
function transformToPackageVersionQuickPickItems(selectedPackage) {
    return selectedPackage.info.versions.map(version => {
        return { label: version, description: null };
    });
}
function runInstall() {
    const quickPickOptions = {
        matchOnDescription: true,
        placeHolder: 'Choose a package, or press <esc> to install all packages in elm-package.json',
    };
    return getJSON()
        .then(transformToQuickPickItems)
        .then(items => vscode.window.showQuickPick(items, quickPickOptions))
        .then(value => {
        const packageName = value ? value.label : '';
        oc.show(vscode.ViewColumn.Three);
        return elmUtils_1.execCmd(`elm-package install ${packageName} --yes`, {
            onStdout: data => oc.append(data),
            onStderr: data => oc.append(data),
            showMessageOnError: true,
        }).then(() => { });
    });
}
function getJSON() {
    return new Promise((resolve, reject) => {
        request('http://package.elm-lang.org/all-packages', (err, _, body) => {
            if (err) {
                reject(err);
            }
            else {
                let json;
                try {
                    json = JSON.parse(body);
                }
                catch (e) {
                    reject(e);
                }
                resolve(json);
            }
        });
    });
}
function transformToQuickPickItems(json) {
    return json.map(item => ({ label: item.name, description: item.summary }));
}
function activatePackage() {
    return [
        vscode.commands.registerCommand('elm.install', runInstall),
        vscode.commands.registerCommand('elm.browsePackage', browsePackage),
    ];
}
exports.activatePackage = activatePackage;
//# sourceMappingURL=elmPackage.js.map