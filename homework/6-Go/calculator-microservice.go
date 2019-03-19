package main

import (
	"fmt"
	"net/http"
	"strings"
	"strconv"
	"errors"
	"encoding/json"
)

var operations []string

func save(operation string) {
	operations = append(operations, operation)
}

func getOperators(r *http.Request) (int, int, error) {
	path := strings.Split(r.URL.Path, "/")
	if len(path) != 5 {
		return 0, 0, errors.New("Path should be: /calc/{operation}/{a}/{b}")
	}
	a, err := strconv.Atoi(path[3])
	if err != nil {
		return 0, 0, errors.New(fmt.Sprintf("Should be an integer: %s", path[3]))
	}
	b, err := strconv.Atoi(path[4])
	if err != nil {
		return 0, 0, errors.New(fmt.Sprintf("Should be an integer: %s", path[4]))
	}
	return a, b, nil
}

func sum(w http.ResponseWriter, r *http.Request) {
	a, b, err := getOperators(r)
	if err != nil {
		fmt.Fprint(w, err)
	} else {
		result := fmt.Sprintf("%d + %d = %d", a, b, a+b)
		save(result)
		fmt.Fprintf(w, result)
	}
}

func sub(w http.ResponseWriter, r *http.Request) {
	a, b, err := getOperators(r)
	if err != nil {
		fmt.Fprint(w, err)
	} else {
		result := fmt.Sprintf("%d - %d = %d", a, b, a-b)
		save(result)
		fmt.Fprintf(w, result)
	}
}

func mul(w http.ResponseWriter, r *http.Request) {
	a, b, err := getOperators(r)
	if err != nil {
		fmt.Fprint(w, err)
	} else {
		result := fmt.Sprintf("%d * %d = %d", a, b, a*b)
		save(result)
		fmt.Fprintf(w, result)
	}
}

func div(w http.ResponseWriter, r *http.Request) {
	a, b, err := getOperators(r)
	if err != nil {
		fmt.Fprint(w, err)
	} else if b == 0 {
		result := fmt.Sprintf("%d / %d = ? (CAN'T DIVIDE BY ZERO)", a, b)
		save(result)
		fmt.Fprint(w, result)
	} else {
		result := fmt.Sprintf("%d / %d = %d", a, b, a/b)
		save(result)
		fmt.Fprint(w, result)
	}
}

func history(w http.ResponseWriter, r *http.Request) {
	operationsJson, _ := json.Marshal(operations)
	fmt.Fprint(w, string(operationsJson))
}

func main() {
	fmt.Println("Calculator Microservice started on port: 8080")
	http.HandleFunc("/calc/sum/", sum)
	http.HandleFunc("/calc/sub/", sub)
	http.HandleFunc("/calc/mul/", mul)
	http.HandleFunc("/calc/div/", div)
	http.HandleFunc("/calc/history", history)
	http.ListenAndServe(":8080", nil)
}
