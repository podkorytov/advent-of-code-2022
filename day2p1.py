#!/usr/bin/env python3

def val_of_shape(letter):
    match letter:
        case 'X' | 'A':
            return 1
        case 'Y' | 'B':
            return 2
        case 'Z' | 'C':
            return 3
        case _:
            return 0


def val_of_set(player1, player2):
    res = val_of_shape(player2) - val_of_shape(player1)
    match res:
        case 0:
            return 3
        case 1 | -2:
            return 6
        case _:
            return 0


def score(str):
    latters = str.split()
    return val_of_shape(latters[1]) + val_of_set(latters[0], latters[1])


file1 = open('inputs/input_day2.txt', 'r')
Lines = file1.readlines()

result = 0
for line in Lines:
    result += score(line)

print(result)
