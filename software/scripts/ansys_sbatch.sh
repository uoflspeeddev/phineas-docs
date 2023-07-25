#!/bin/env bash

BASE_DIR="/home/username/simulation"
WORK_DIR="/tmp/$SLURM_JOB_ID"
INPUT_FILE="$WORK_DIR/remote.dat"
OUTPUT_FILE="$WORK_DIR/mapdl_output.out"
RETRIES=1

# Get hostnames of allocated nodes for the job
declare -a NODES
mapfile -t NODES < <(srun hostname | uniq)

# Create working directory in scratch space
# of each allocated node
for node in ${NODES[@]}; do
    cmd="cp -r $BASE_DIR $WORK_DIR"
    if [ "$node" != `hostname` ]; then
        ssh $node "$cmd"
    else
        eval "$cmd"
    fi
done

# Get list of nodes to use for the computation
# in the format:
# <node_1>:<cores>:<node_2>:<cores>:...:<node_n>:<cores>
MACHINES=$(srun hostname | sort | uniq -c | \
            awk '{print $2 ":" $1}' | \
            paste -s -d ":" -)

module load infiniband ansys/2023r1

cd $WORK_DIR

try=0
while [ $try -le $RETRIES ]; do
        mapdl -dis -usessh -b -s noread -apip on \
                -mpi openmpi \
                -p ansys \
                -j 'file' \
                -machines "$MACHINES" \
                -dir "$WORK_DIR" \
                -i "$INPUT_FILE" \
                -o "$OUTPUT_FILE"
        if [ $? == 0 ]; then try=$(( $RETRIES + 1 )) else try=$(( $try + 1)); fi
done