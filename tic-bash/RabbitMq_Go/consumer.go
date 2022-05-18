package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os/exec"

	"github.com/streadway/amqp"
)

func main() {
	fmt.Println("Go RabbitMQ")
	conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
	if err != nil {
		fmt.Println("Failed Initializing Broker Connection")
		panic(err)
	}

	ch, err := conn.Channel()
	if err != nil {
		fmt.Println(err)
	}
	defer ch.Close()

	if err != nil {
		fmt.Println(err)
	}

	msgs, err := ch.Consume(
		"TIC_queue",
		"",
		true,
		false,
		false,
		false,
		nil,
	)

	if err != nil {
		fmt.Println(err)
	}

	forever := make(chan bool)
	go func() {
		for res := range msgs {
			fmt.Printf("Recieved Message: %s\n", res.Body)
			m := make(map[string]interface{})
			err := json.Unmarshal(res.Body, &m)
			if err != nil {
				log.Fatal(err)
			}
			fmt.Println(m["tenantName"])
			cmd := exec.Command("../Bash_Scripts/modules/launchpad.sh")
			stdout, err := cmd.Output()

			if err != nil {
				fmt.Println(err.Error())
				return
			}
			fmt.Print(string(stdout))
		}
	}()

	fmt.Println("Successfully Connected to our RabbitMQ Instance")
	fmt.Println(" [*] - Waiting for messages")
	<-forever
}
