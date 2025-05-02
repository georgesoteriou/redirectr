# redirectr  

Simple dockered socat wrapper to redicect one port-ip pair to another  

Variables to be passed to docker:  
LISTEN_ADDRESS: The adderess of the maching to listen (generaly host maching. can use 0.0.0.0 to accept listening on all interfaces)  
LISTEN_PORTS: comma separated ports to listen on.  
FORWARD_ADDRESS: The adderes to forward requests to. Can be the same as the host, or can be another ip in the network.  
FORWARD_PORTS: comma separated ports to redirect traffic to. This is a 1:1 mapping with LISTEN_PORTS.  
