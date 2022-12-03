#!/usr/bin/env python3

def next(num):
    num += 1
    if num > 3:
        return 1
    else:
        return num


def prev(num):
    num -= 1
    if num < 1:
        return 3
    else:
        return num


def select_shape(opponent, result):
    match result:
        case 'X':
            return prev(opponent)
        case 'Y':
            return opponent
        case 'Z':
            return next(opponent)
        case _:
            return 0
    return 'A'


def val_of_shape(letter):
    match letter:
        case 'A':
            return 1
        case 'B':
            return 2
        case 'C':
            return 3
        case _:
            return 0


def val_of_set(opp, me):
    res = me - opp
    match res:
        case 0:
            return 3
        case 1 | -2:
            return 6
        case _:
            return 0


def score(str):
    latters = str.split()
    opp = val_of_shape(latters[0])
    me = select_shape(opp, latters[1])
    return me + val_of_set(opp, me)


file1 = open('inputs/input_day2.txt', 'r')
Lines = file1.readlines()

result = 0
for line in Lines:
    result += score(line)

print(result)
