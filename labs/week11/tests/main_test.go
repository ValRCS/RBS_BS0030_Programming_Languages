package main

import (
    "reflect"
    "testing"
)

func TestSequentialSquares(t *testing.T) {
    got, sum := sequentialSquares([]int{1, 2, 3, 4})
    if !reflect.DeepEqual(got, []int{1, 4, 9, 16}) || sum != 30 {
        t.Fatalf("baseline = %v, %d", got, sum)
    }
}

func TestConcurrentSquares(t *testing.T) {
    cases := []struct {
        name string
        input, want []int
        sum int
    }{
        {"empty", []int{}, []int{}, 0},
        {"single", []int{7}, []int{49}, 49},
        {"four", []int{1, 2, 3, 4}, []int{1, 4, 9, 16}, 30},
        {"negative and zero", []int{-3, 0, 2}, []int{9, 0, 4}, 13},
    }
    for _, tc := range cases {
        t.Run(tc.name, func(t *testing.T) {
            got, sum := concurrentSquares(tc.input)
            if !reflect.DeepEqual(got, tc.want) || sum != tc.sum {
                t.Fatalf("got %v, %d; want %v, %d", got, sum, tc.want, tc.sum)
            }
        })
    }
}

// Passing these tests with the sequential placeholder is NOT completion of the TODO.
