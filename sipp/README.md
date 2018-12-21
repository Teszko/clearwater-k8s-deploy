
# Plot messages recieved by sipp

These scripts have been used to plot status codes recieved in SIP messages using the tool sipp.

First add authentication data using the `add_auth.sh` script. `./add_auth <number> <password>`

Then edit the `run_sipp.sh` script to reflect your client ip and the SIP-Proxy you want to reach.

Afterwards you can edit and run the `to_list_of_seconds.sh` script, which converts the logs into a format, that can be plotted using the gnuplot script `scaled.gnuplot` 
