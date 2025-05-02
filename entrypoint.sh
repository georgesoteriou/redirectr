#!/bin/sh
echo "Hello from entrypoint.sh!"
echo "LISTEN_ADDRESS: ${LISTEN_ADDRESS}"
echo "LISTEN_PORTS: ${LISTEN_PORTS}"
echo "FORWARD_ADDRESS: ${FORWARD_ADDRESS}"
echo "FORWARD_PORTS: ${FORWARD_PORTS}"
echo "Starting socat listeners..."

# Split the comma-separated port lists into arrays (POSIX sh compatible)
listen_ports=$(echo "$LISTEN_PORTS" | tr ',' ' ')
forward_ports=$(echo "$FORWARD_PORTS" | tr ',' ' ')

# Determine the number of ports
num_listen_ports=$(echo "$listen_ports" | wc -w)
num_forward_ports=$(echo "$forward_ports" | wc -w)


# Check if the number of listen and forward ports match
if [ "$num_listen_ports" -ne "$num_forward_ports" ]; then
  echo "Error: Number of LISTEN_PORTS and FORWARD_PORTS must be the same."
  exit 1
fi

# Loop through the listen ports and start a socat instance for each
i=1
for listen_port in $listen_ports; do
  forward_port=$(echo "$forward_ports" | awk "{print $"$i"}")
  echo "Starting socat listener on ${LISTEN_ADDRESS}:${listen_port} forwarding to ${FORWARD_ADDRESS}:${forward_port}..."
  socat "TCP4-LISTEN:${listen_port},bind=${LISTEN_ADDRESS},fork" "TCP4:${FORWARD_ADDRESS}:${forward_port}" &
  i=$((i+1))
done

# Keep the script running in the background to allow socat processes to continue
wait

