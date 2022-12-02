package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"sort"
)

func main() {

	readFile, err := os.Open("inputs/input_day1.txt")
	if err != nil {
		fmt.Println(err)
	}

	fileScanner := bufio.NewScanner(readFile)
	fileScanner.Split(bufio.ScanLines)

	var counter = 0
	var sums []int

	for fileScanner.Scan() {
		var str = fileScanner.Text()

		if len(str) == 0 {
			sums = append(sums, counter)
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
	sort.Sort(sort.Reverse(sort.IntSlice(sums)))
	var max3 = sums[0] + sums[1] + sums[2]
	fmt.Println(max3)
}
