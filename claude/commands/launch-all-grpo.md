Run each of the following scripts in order. Wait for each to finish, then start the next one. Monitor the results. If there any errors in a script, fix them, and relaunch to verify the fix is complete.

1. @scripts/train/debug/single_gpu_on_beaker.sh
2. @scripts/train/debug/tool_grpo_fast.sh
3. @scripts/train/debug/large_test_script.sh

Use @scripts/train/build_image_and_launch.sh to launch the scripts.

If they pass, then output links to them in this format:

Runs:
1. Single GPU GRPO: [Beaker](link)
2. Single GPU GRPO with tools: [Beaker](link)
3. Multi-node GRPO: [Beaker](link)
