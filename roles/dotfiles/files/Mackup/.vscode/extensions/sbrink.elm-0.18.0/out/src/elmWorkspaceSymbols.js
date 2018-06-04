"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const elmSymbol_1 = require("./elmSymbol");
const config = vscode.workspace.getConfiguration('elm');
class ElmWorkspaceSymbolProvider {
    constructor(languagemode) {
        this.languagemode = languagemode;
        this.provideWorkspaceSymbols = (query, token) => {
            if (this.symbols != null) {
                return this.symbols;
            }
            else {
                let result = Promise.resolve(processWorkspace(query));
                this.symbols = result;
                return result;
            }
        };
        this.symbols = null;
    }
    update(document) {
        if (this.symbols != null) {
            this.symbols.then(s => {
                let otherSymbols = s.filter(docSymbol => docSymbol.location.uri !== document.uri);
                symbolsFromFile(document).then(symbolInfo => {
                    let updated = otherSymbols.concat(symbolInfo);
                    this.symbols = Promise.resolve(updated);
                });
            });
        }
    }
}
exports.ElmWorkspaceSymbolProvider = ElmWorkspaceSymbolProvider;
function symbolsFromFile(document) {
    let processed = processTextDocuments([document]).then(val => {
        let res = val[0];
        return res;
    }, err => {
        return [];
    });
    return processed;
}
function openTextDocuments(uris) {
    return Promise.all(uris.map(uri => vscode.workspace.openTextDocument(uri).then(doc => doc)));
}
function processTextDocuments(documents) {
    return Promise.all(documents.map(document => elmSymbol_1.processDocument(document)));
}
function processWorkspace(query) {
    let maxFiles = config['maxWorkspaceFilesUsedBySymbols'];
    let excludePattern = config['workspaceFilesExcludePatternUsedBySymbols'];
    let docs = vscode.workspace
        .findFiles('**/*.elm', excludePattern, maxFiles)
        .then(workspaceFiles => {
        let openedTextDocuments = openTextDocuments(workspaceFiles);
        let processedTextDocuments = openedTextDocuments.then(results => {
            return processTextDocuments(results);
        }, err => {
            return [];
        });
        let symbolInformation = processedTextDocuments.then(symbols => {
            return [].concat.apply([], symbols);
        }, err => {
            return [];
        });
        return symbolInformation;
    }, fileError => {
        return [];
    });
    return docs;
}
//# sourceMappingURL=elmWorkspaceSymbols.js.map