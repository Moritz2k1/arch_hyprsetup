"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClipboardProvider = exports.deactivate = exports.activate = void 0;
const vscode = require("vscode");
const vscode_1 = require("vscode");
var clipboardList = [];
function activate(context) {
    return __awaiter(this, void 0, void 0, function* () {
        const config = vscode.workspace.getConfiguration("clipboard");
        let maximumClips = config.get('maximumClips', 200);
        vscode.workspace.onDidChangeConfiguration(event => {
            let affected = event.affectsConfiguration("clipboard.maximumClips");
            if (affected) {
                const config = vscode.workspace.getConfiguration("clipboard");
                maximumClips = config.get('maximumClips', 200);
            }
        });
        function addClipboardItem() {
            return __awaiter(this, void 0, void 0, function* () {
                let copied = yield vscode.env.clipboard.readText();
                copied = copied.replace(/\n/gi, "↵");
                const item = new Clipboard(copied, vscode_1.TreeItemCollapsibleState.None);
                if (clipboardList.find(c => c.label === copied)) {
                    clipboardList = clipboardList.filter(c => c.label !== copied);
                }
                clipboardList.push(item);
                if (maximumClips > 0) {
                    clipboardList = clipboardList.reverse().slice(0, maximumClips).reverse();
                }
            });
        }
        function createTreeView() {
            vscode.window.createTreeView('clipboard.history', {
                treeDataProvider: new ClipboardProvider()
            });
        }
        vscode_1.commands.registerCommand('clipboard.copy', () => {
            vscode_1.commands.executeCommand("editor.action.clipboardCopyAction").then(() => {
                addClipboardItem().then(() => {
                    vscode_1.window.setStatusBarMessage('copy!');
                    createTreeView();
                });
            });
        });
        vscode_1.commands.registerCommand('clipboard.cut', () => {
            vscode_1.commands.executeCommand("editor.action.clipboardCutAction").then(() => {
                addClipboardItem().then(() => {
                    vscode_1.window.setStatusBarMessage('cut!');
                    createTreeView();
                });
            });
        });
        vscode_1.commands.registerCommand('clipboard.pasteFromClipboard', () => {
            vscode_1.window.setStatusBarMessage('pasteFromClipboard!');
            createTreeView();
            const items = clipboardList.map(c => {
                return {
                    label: c.label,
                    description: ''
                };
            }).reverse();
            vscode_1.window.showQuickPick(items).then(item => {
                const label = item.label.replace(/↵/gi, "\n");
                vscode.env.clipboard.writeText(label).then(() => {
                    vscode_1.window.setStatusBarMessage("copied in history!");
                    if (!!vscode_1.window.activeTextEditor) {
                        const editor = vscode_1.window.activeTextEditor;
                        editor.edit((textInserter => textInserter.delete(editor.selection))).then(() => {
                            editor.edit((textInserter => textInserter.insert(editor.selection.start, label)));
                        });
                    }
                });
            });
        });
        vscode.commands.registerCommand('clipboard.history.copy', (item) => {
            const label = item.label.replace(/↵/gi, "\n");
            vscode.env.clipboard.writeText(label).then(() => {
                vscode_1.window.setStatusBarMessage("copied in history!");
            });
        });
        vscode.commands.registerCommand('clipboard.history.remove', (item) => {
            clipboardList = clipboardList.filter(c => c.label !== item.label);
            createTreeView();
            vscode_1.window.setStatusBarMessage("removed in history!");
        });
    });
}
exports.activate = activate;
function deactivate() { }
exports.deactivate = deactivate;
class ClipboardProvider {
    constructor() { }
    getTreeItem(element) {
        return element;
    }
    getChildren(element) {
        const temp = Object.assign([], clipboardList);
        return Promise.resolve(temp.reverse());
    }
}
exports.ClipboardProvider = ClipboardProvider;
class Clipboard extends vscode_1.TreeItem {
    constructor(label, collapsibleState) {
        super(label, collapsibleState);
        this.label = label;
        this.collapsibleState = collapsibleState;
        this.contextValue = "clipHistoryItem:";
    }
}
//# sourceMappingURL=extension.js.map