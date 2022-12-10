<?php

$lines = file('inputs/input_day10.txt');
$x = 1;
$tick = 0;
$strength = 0;

function tick($addx)
{
    global $tick, $x, $strength;
    $tick++;
    if ((($tick - 20) % 40) == 0) {
        $strength += $tick * $x;
    }
    $x += $addx;
}

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
echo "$strength\n";
