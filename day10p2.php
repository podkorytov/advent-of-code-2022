<?php

$lines = file('inputs/input_day10.txt');
$x = 1;
$tick = 0;

function tick($addx)
{
    global $tick, $x;
    echo getSymbol();
    $tick++;
    $x += $addx;
    if ($tick % 40 == 0) {
        echo "\n";
    }
}

function getSymbol()
{
    global $tick, $x;
    $pos = $tick % 40;
    return (($pos == $x) || ($pos == ($x - 1)) || ($pos == ($x + 1))) ? "#" : ".";
}

echo "\n";
foreach ($lines as $line) {
    $cmd = substr($line, 0, 4);
    switch ($cmd) {
        case 'noop':
            tick(0);
            break;
        case 'addx':
            $addx = intval(explode(" ", $line)[1]);
            tick(0);
            tick($addx);
            break;
    }
}
echo "\n";
