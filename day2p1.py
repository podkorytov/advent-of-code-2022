#!/usr/bin/env python3

def val_of_shape(letter):
    match letter:
        case 'X':
            return 1
        case 'Y':
            return 2
        case 'Z':
            return 3
        case _:
            return 0

def val_of_set(player1, player2):
    match player2:
        case 'X':
            match player1:
                case 'A':
                    return 3
                case 'B':
                    return 0
                case 'C':
                    return 6
                case _:
                    return 0
        case 'Y':
            match player1:
                case 'A':
                    return 6
                case 'B':
                    return 3
                case 'C':
                    return 0
                case _:
                    return 0
        case 'Z':
            match player1:
                case 'A':
                    return 0
                case 'B':
                    return 6
                case 'C':
                    return 3
                case _:
                    return 0
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
