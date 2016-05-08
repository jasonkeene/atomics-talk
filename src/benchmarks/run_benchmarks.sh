#!/bin/bash

run_benchmarks() {
    echo ====================================================
    echo GOMAXPROCS=$GOMAXPROCS
    echo GOROUTINES=$GOROUTINES
    for file in $(ls *.go); do
        base=$(echo $file | cut -f1 -d.)
        echo Running $base
        time ./$base
        echo
    done
}

main() {
    echo Building binaries
    ./build.sh
    echo

    for i in 1 2 4 8; do
        export GOMAXPROCS=$i
        for j in 2 4 8; do
            export GOROUTINES=$j
            run_benchmarks
        done
    done

    echo Cleaning up
    ./clean.sh
}

main
