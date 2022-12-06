import { readFileSync } from 'fs';

type Crate = string[];

type Command = {
    quantity: number;
    from: number;
    to: number;
};

function prepareCrates(data: string[]): Crate[] {
    const out: Crate[] = [];
    const amount = parseInt(data[data.length - 1].split(' ').sort().reverse()[0]);

    for (var i = 0; i < amount; i++) {
        out[i] = [];
    }

    for (var j = data.length - 2; j >= 0; j--) {
        const line = data[j];
        for (var i = 0; i < amount; i++) {
            const symbol = line[1 + 4 * i].trim();
            if (symbol) {
                out[i].push(symbol);
            }
        }
    }

    return out;
}

function parseCommand(cmd: string): Command {
    const parts = cmd.split(" ");

    return {
        quantity: parseInt(parts[1]),
        from: parseInt(parts[3]),
        to: parseInt(parts[5]),
    };
}

function getAnswer(crates: Crate[]): string {
    const out: string[] = [];

    for (var crate of crates) {
        out.push(crate.pop() ?? '');
    }

    return out.join("");
}

function executeCommand(cmd: Command, crates: Crate[]): void {
    for (var i = 0; i < cmd.quantity; i++) {
        crates[cmd.to - 1].push(crates[cmd.from - 1].pop() ?? '');
    }
}

function readData(lines: string[], structure: string[], commands: string[]): void {
    var isCommand = false;

    for (var line of lines) {
        if (line.length == 0) {
            isCommand = true;
        } else if (isCommand) {
            commands.push(line);
        } else {
            structure.push(line);
        }
    }
}

// Main logic:
const file = readFileSync('inputs/input_day5.txt', 'utf-8');
const initial: string[] = [];
const commands: string[] = [];

readData(file.split(/\r?\n/), initial, commands);
const crates = prepareCrates(initial);
commands.map(parseCommand).forEach((cmd) => executeCommand(cmd, crates));

console.log(getAnswer(crates));
