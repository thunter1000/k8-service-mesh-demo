package main

import (
	"context"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/gorilla/mux"
)

type options struct {
	calc     int
	delay    int
	requests []request
}

type request struct {
	options options
	url     string
}

func handler(w http.ResponseWriter, r *http.Request) {
	var o options

	b, err := ioutil.ReadAll(r.Body)
	defer r.Body.Close()

	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}

	log.Printf("%s", b)
	log.Println()

	err = json.Unmarshal(b, &o)

	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	if o.delay > 0 {
		time.Sleep(time.Duration(o.delay) * time.Millisecond)
		log.Printf("Paused for %i", o.delay)
		log.Println()
	}

	w.Write([]byte(fmt.Sprintf("Hello")))
}

func main() {
	r := mux.NewRouter()

	// Route all requests to the same handler.
	r.NotFoundHandler = http.HandlerFunc(handler)

	srv := &http.Server{
		Handler:      r,
		Addr:         ":8080",
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
	}

	// TODO: Configure logging.

	// Start the server
	go func() {
		log.Println("Starting Server")
		if err := srv.ListenAndServe(); err != nil {
			log.Fatal(err)
		}
	}()

	waitForShutdown(srv)
}

func waitForShutdown(srv *http.Server) {
	interruptChan := make(chan os.Signal, 1)
	signal.Notify(interruptChan, os.Interrupt, syscall.SIGINT, syscall.SIGTERM)

	<-interruptChan

	ctx, cancel := context.WithTimeout(context.Background(), time.Second*10)
	defer cancel()
	srv.Shutdown(ctx)

	log.Println("Shutting down")
	os.Exit(0)
}
