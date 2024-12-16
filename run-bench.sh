#!/bin/bash
ulimit -s unlimited

#define an array variable for names of benchmarks
benchNames=utf8_test

main_dir=/local/scratch/a/$USER/utf8
mkdir -p $main_dir
# iterate over benchNames and print
for benchName in $benchNames
do
    echo "Running $benchName"
    mkdir -p $main_dir/$benchName
    rm -rf $main_dir/$benchName/*
    mkdir -p $main_dir/$benchName/klee-rundir
    mkdir -p $main_dir/$benchName/cfm-rundir
    mkdir -p $main_dir/$benchName/klee-rundir/sandbox
    mkdir -p $main_dir/$benchName/cfm-rundir/sandbox
    ${LLVM_BUILD_DIR}/bin/opt -mem2reg < $benchName.bc > $benchName.opt.bc
    python3 ${KLEE_BUILD_DIR}/../scripts/cfm_driver/driver.py -e -i $benchName.opt.bc -k driver_options.json -r $main_dir/$benchName > $main_dir/$benchName/driver_output_$benchName.txt 2>&1

done
echo "hello" | mail -s "utf8 all done!" $USER