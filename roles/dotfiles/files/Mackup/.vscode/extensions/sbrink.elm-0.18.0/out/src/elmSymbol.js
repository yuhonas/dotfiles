"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
class ElmSymbolProvider {
    constructor() {
        this.provideDocumentSymbols = (doc, _) => Promise.resolve(processDocument(doc));
    }
}
exports.ElmSymbolProvider = ElmSymbolProvider;
function processDocument(doc) {
    const docRange = doc.validateRange(new vscode_1.Range(0, 0, Number.MAX_SAFE_INTEGER, Number.MAX_SAFE_INTEGER));
    const symbols = getSymbolsForRange(docRange, /^(?=\S)/m, 0, rootProcessor());
    const moduleName = symbols.filter(x => x.kind === vscode_1.SymbolKind.Module).map(x => {
        return x.name;
    })[0];
    return symbols.map(s => {
        s.containerName = moduleName;
        return s;
    });
    /** Get the symbols in a range */
    function getSymbolsForRange(range, splitter, splitterLength, subProcessor) {
        // get the whole text for the range & split it with the splitter
        const docText = doc.getText(range), texts = docText.split(splitter);
        // convert split strings into RangeAndText tuples. Handles block comments
        const rangeTexts = [];
        let insideCommentBlock = false;
        for (let p = doc.offsetAt(range.start), i = 0; i < texts.length; i++) {
            let [text, isInsideCommentBlock] = cleanupBlockComments(texts[i], insideCommentBlock);
            insideCommentBlock = isInsideCommentBlock;
            const startPos = doc.positionAt(p), endPos = doc.positionAt(p + text.length);
            rangeTexts.push([new vscode_1.Range(startPos, endPos), text]);
            p += text.length + splitterLength;
        }
        // process these tuples to extract symbols
        const symbols = rangeTexts
            .map(rangeText => {
            const [textRange, text] = trimRange(rangeText);
            return subProcessor([textRange, text]);
        })
            .reduce((acc, x) => acc.concat(x), []);
        return symbols;
    }
    /** A function with a hack to handle block comments */
    function cleanupBlockComments(text, insideCommentBlock) {
        if (text.trim().includes('{-')) {
            text = text.replace(/.{2}/, '--');
            insideCommentBlock = true;
        }
        else if (text.trim().includes('-}')) {
            text = text.replace(/.{2}/, '--');
            insideCommentBlock = false;
        }
        else if (insideCommentBlock === true) {
            text = text.replace(/.{2}/, '--');
        }
        return [text, insideCommentBlock];
    }
    /** Takes the first word of the given text as the name and creates a symbol
     *  with the given kind
     */
    function defaultProcessor(kind) {
        return function ([range, text]) {
            const // this RegExp could be improved
            nameMatch = text.match(/^(([\w']+)|\(.*?\))\s*/), name = nameMatch && nameMatch[0];
            // Filter out type annotations too
            if (name && text.substr(name.length).charAt(0) !== ':') {
                return [new vscode_1.SymbolInformation(name.trim(), kind, range, doc.uri)];
            }
            else {
                return [];
            }
        };
    }
    /** For ignoring the range eg import, infix, ... */
    function ignoreProcessor(_) {
        return [];
    }
    /** Processes module... statements. Extends the range to the whole document */
    function moduleProcessor([range, text]) {
        const matches = text.match(/^[A-Z][a-zA-Z0-9_.]*/);
        if (matches[0]) {
            return [new vscode_1.SymbolInformation(matches[0], vscode_1.SymbolKind.Module, new vscode_1.Range(range.start, docRange.end), doc.uri)];
        }
        else {
            return [];
        }
    }
    /** Processor for ranges found at the top level of the document.
     *  Processes according to type of statement
     */
    function rootProcessor() {
        const types = [
            ['module ', moduleProcessor],
            ['type alias ', defaultProcessor(vscode_1.SymbolKind.Class)],
            ['type ', typeProcessor],
            ['port ', defaultProcessor(vscode_1.SymbolKind.Interface)],
            ['import ', ignoreProcessor],
            ['infix ', ignoreProcessor],
            ['infixl ', ignoreProcessor],
            ['infixr ', ignoreProcessor],
            ['', defaultProcessor(vscode_1.SymbolKind.Variable)],
        ];
        return function ([range, text]) {
            for (let [prefix, processor] of types) {
                if (text.startsWith(prefix)) {
                    return processor([range, text.substr(prefix.length).trim()]);
                }
            }
        };
    }
    /** For type ... statements. Splits rest of text by | to create s symbol
     *  for each constructor
     */
    function typeProcessor([range, text]) {
        const symbols = defaultProcessor(vscode_1.SymbolKind.Class)([range, text]), allText = doc.getText(range), equalPos = allText.indexOf('='), childrenStart = doc.positionAt(doc.offsetAt(range.start) + equalPos + 1);
        if (equalPos > -1) {
            const constructorSymbols = getSymbolsForRange(new vscode_1.Range(childrenStart, range.end), /\|/, 1, defaultProcessor(vscode_1.SymbolKind.Constructor));
            constructorSymbols.forEach(s => (s.containerName = symbols[0].name));
            return symbols.concat(constructorSymbols);
        }
        else {
            return symbols;
        }
    }
    /** Strip whitespace and comments from start & end of range */
    function trimRange([range, text]) {
        let startOffset = doc.offsetAt(range.start) + text.length;
        text = text.replace(/^(\s*((--.*)|({-[\s\S]*?-})))*\s*/, '');
        startOffset -= text.length;
        let endOffset = doc.offsetAt(range.end) - text.length;
        text = text.replace(/\s+$/, '');
        endOffset += text.length;
        return [
            new vscode_1.Range(doc.positionAt(startOffset), doc.positionAt(endOffset)),
            text,
        ];
    }
}
exports.processDocument = processDocument;
//# sourceMappingURL=elmSymbol.js.map