#!/usr/bin/env sh
folder=$(date +%-d)
mkdir $folder
cd $folder
touch demo
touch input
touch benchmark
cp ../`date -d "yesterday" +%0d`/solver.jl .