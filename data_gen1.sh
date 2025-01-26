#!/bin/bash
conda activate sky-t1
cd /SkyThought/skythought/tools
# Define the datasets
datasets=("math" "gsm8k" "amc_aime")
result_dir="./data"
mkdir -p $result_dir
# Define the command template
command_template="python inference_and_check.py --dataset NUMINA --model deepseek-ai/DeepSeek-R1-Distill-Qwen-32B --tp 8 --max_tokens 16384 --split train --source {dataset} --filter-difficulty --result-dir ./data --inference --math-difficulty-lower-bound 0 --math-difficulty-upper-bound 7"

# Loop through each dataset and execute the command
for dataset in "${datasets[@]}"; do
    # Replace {dataset} with the actual dataset name
    command=$(echo $command_template | sed "s/{dataset}/$dataset/")
    # Define a unique log file for each dataset
    log_file="$log_dir/${dataset}_log.txt"
    echo "Processing dataset: $dataset"
    echo "Command: $command"
    # Execute the command and redirect output to the log file
    $command
done
