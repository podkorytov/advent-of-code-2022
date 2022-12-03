package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

const elves = 3

func main() {

	readFile, err := os.Open("inputs/input_day1.txt")
	if err != nil {
		fmt.Println(err)
	}

	fileScanner := bufio.NewScanner(readFile)
	fileScanner.Split(bufio.ScanLines)

	var counter = 0
	var sums [elves]int
	for i := 0; i < elves; i++ {
		sums[i] = 0
	}

	for fileScanner.Scan() {
		var str = fileScanner.Text()

		if len(str) == 0 {
			addToMax(counter, &sums)
			counter = 0
		} else {
			intVar, err := strconv.Atoi(str)
			if err != nil {
				fmt.Println(err)
			}

			counter += intVar
		}
	}

	readFile.Close()
	maxSum := 0
	for _, v := range sums {
		maxSum += v
	}

	fmt.Println(maxSum)
}

func addToMax(max int, sums *[elves]int) {
	isMove := false
	prev := 0
	cur := 0
	for i := 0; i < elves; i++ {
		if isMove {
			cur = sums[i]
			sums[i] = prev
			prev = cur
		} else {
			if max > sums[i] {
				prev = sums[i]
				sums[i] = max
				isMove = true
			}
		}
	}
}
