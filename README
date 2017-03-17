## DistGen

This is just a quickly written & simple bash+php script pair to make computing vanity Bitcoin and Tor .onion addresses on multiple devices easier.

## Using it

* Make sure vanitygen/shallot are in your path
* Configure your server address in the client script
* Configure the client name for every machine so you know what machine solved it (which is written to output.txt on the server)
* Run the scripts, they will close when 1 machine finds the specified keys
* Check address.txt on the machine that solved it

## Warnings

* Make sure you trust the worker machines
* There is no authentication, so someone could tell your server that it was falsely solved (I will fix this later)
* The computed key is written to disk, appended to address.txt
* This will max out the client CPUs, and does no temperature monitoring.
