# How to run

Build the wasm image and load it into your ctr and then run `./test_scratch_containerd_runwasi_wasmtime.sh <number>`

# Result
```
#########################################
Containerd + RUNWASI with WASMTIME SHIM
#########################################

Running experiment 1
Start timestamp in milis: 1715905542146 milliseconds
End timestamp in milis: 1715905542559 milliseconds
Time difference: 413 milliseconds

Running experiment 2
Start timestamp in milis: 1715905542824 milliseconds
End timestamp in milis: 1715905543251 milliseconds
Time difference: 427 milliseconds

Running experiment 3
Start timestamp in milis: 1715905543340 milliseconds
End timestamp in milis: 1715905543767 milliseconds
Time difference: 427 milliseconds

Running experiment 4
Start timestamp in milis: 1715905543855 milliseconds
End timestamp in milis: 1715905544266 milliseconds
Time difference: 411 milliseconds

Running experiment 5
Start timestamp in milis: 1715905544384 milliseconds
End timestamp in milis: 1715905544804 milliseconds
Time difference: 420 milliseconds

Mean: 419 milliseconds
Median: 420 milliseconds
Mode: 427 milliseconds
Standard Deviation: 6.70 milliseconds
Minimum Time: 411 milliseconds
Maximum Time: 427 milliseconds
```
