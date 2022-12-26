const fs = require('fs');

var field = [];
var routes = [];

var begin;
var end;
var root;

function createNode(symbol, row, col, id) {
    return {
        'symbol': symbol,
        'row': row,
        'col': col,
        'id': id,
        'charcode': symbol.charCodeAt(0),
    };
}

function createTreeNode(node, path) {
    var newPath = [...path];
    newPath.push(node.id);
    return {
        'node': node,
        'path': newPath,
        'children': [],
    };
}

function addChildIfAllowed(treeNode, child) {
    if ((treeNode.node.charcode == child.charcode || treeNode.node.charcode == (child.charcode - 1)) && (treeNode.path.indexOf(child.id) < 0)) {
        if (child.id == end.id) {
            routes.push(treeNode.path);
        } else {
            var newNode = createTreeNode(child, treeNode.path);
            treeNode.children.push(newNode);
        }
    }
}

function goToNextLevel(treeNode) {
    var node = treeNode.node;
    // check top
    if (node.row > 0) {
        var child = field[node.row - 1][node.col];
        addChildIfAllowed(treeNode, child);
    }
    // check bottom
    if (node.row < (field.length - 1)) {
        var child = field[node.row + 1][node.col];
        addChildIfAllowed(treeNode, child);
    }
    // check left
    if (node.col > 0) {
        var child = field[node.row][node.col - 1];
        addChildIfAllowed(treeNode, child);
    }
    // check right
    if (node.col < (field[0].length - 1)) {
        var child = field[node.row][node.col + 1];
        addChildIfAllowed(treeNode, child);
    }
}

function findRoutes(treeNode) {
    goToNextLevel(treeNode);
    if (treeNode.children.length > 0) {
        console.log(routes.length);
        console.log(treeNode.path.length);
        treeNode.children.forEach(child => {
            findRoutes(child);
        });
    } else {
        delete treeNode.path
    }
}

// Read file 
const allFileContents = fs.readFileSync('../inputs/input_day12.txt', 'utf-8');

var counter = 0;
allFileContents.split(/\r?\n/).forEach((line, r) => {
    var row = [];
    for (var c in line) {
        var symbol = line[c];
        var node;
        if (symbol == 'S') {
            node = createNode('a', r, parseInt(c), counter);
            begin = node;
            root = createTreeNode(node, []);
        } else if (symbol == 'E') {
            node = createNode('z', r, parseInt(c), counter);
            end = node;
        } else {
            node = createNode(symbol, r, parseInt(c), counter);
        }
        row.push(node);
        counter++;
    }
    if (row.length > 0) {
        field.push(row);
    }
});

// main circle
findRoutes(root);

console.log(begin);
console.log(end);
console.log(Math.min.apply(Math, routes.map(route => route.length)));

