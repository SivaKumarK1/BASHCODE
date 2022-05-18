package main

import (
	"bytes"
	"encoding/csv"
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"

	"os"
)

//If the struct variable names does not match with json attributes
//then you can define the json attributes actual name after json:attname as shown below.
type Teraform struct {
	TeraformIps []Instance `json:"teraformIps"`
}
type Instance struct {
	Name string `json:"name"`
	Ip   string `json:"ip"`
}

func main() {

	csvFile := flag.String("csv", "problem.csv", "a csv file in the format of 'instanceName,instanceIp'")
	url := flag.String("url", "https://localhost", "provide the url to send post requ")
	flag.Parse()

	file, err := os.Open(*csvFile)
	if err != nil {
		exit(err)
	}
	defer file.Close()

	r := csv.NewReader(file)
	var instance Instance
	var instances []Instance
	var teraform Teraform

	line, err := r.ReadAll()
	if err != nil {
		exit(err)
	}
	// fmt.Println(line[0][0])
	for i := range line {
		instance.Name = line[i][0]
		instance.Ip = line[i][1]
		instances = append(instances, instance)

	}

	teraform.TeraformIps = instances

	test, _ := json.Marshal(teraform)
	fmt.Println(string(test))

	sendPost(*url, teraform)
}

// function to send post request
func sendPost(url string, teraform Teraform) {
	body, err := json.Marshal(teraform)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	resp, err := http.Post(url, "application/json", bytes.NewBuffer(body))
	if err != nil {
		exit(err)
	}

	defer resp.Body.Close()

	// Checking the response of the above request
	if resp.StatusCode == http.StatusOK {
		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			exit(err)
		}

		jsonStr := string(body)
		fmt.Println("Response: ", jsonStr)

	} else {
		fmt.Println("Get failed with error: ", resp.Status)
	}
}

func exit(err error) {
	panic(err)
}
