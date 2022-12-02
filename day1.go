package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {

	readFile, err := os.Open("inputs/input_day1.txt")
	if err != nil {
		fmt.Println(err)
	}

	fileScanner := bufio.NewScanner(readFile)
	fileScanner.Split(bufio.ScanLines)

	var counter = 0
	var max = 0

	for fileScanner.Scan() {
		var str = fileScanner.Text()

		if len(str) == 0 {
			if counter > max {
				max = counter
			}
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
	fmt.Println(max)
}
