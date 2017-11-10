# LT11 - TCP and UDP
Assurances that data is arriving in order, arriving correctly
Get around problem of multiple applications running on one device and potentially talking to multiple applications on another device.

**Network Layer** - Logical communication between hosts

**Transport Layer** - Logical communication between processes (logical entities on the machine, separate bits of code)

## TCP

- Reliable, in order delivery
- Congestion control
- Flow control (to prevent overwhelming the server etc.)
- Connection setup
- Checksums

TCP socket defined by 4-tuple:

- Source IP address
- Source port number
- Destination IP address
- Destination port number

If a single value changes then this is a distinct connection.

## UDP

- Unreliable, unordered delivery
- No-frills extension of "best effort" IP
  - Segments may be lost or delivered out of order
- Adds just enough to IP to allow communication between processes as well as machines
- Connectionless
  - No handshaking between UDP server and receiver
- Each UDP segment handled independently of others
- Almost always the wrong answer

- One application per port

UDP Socket identified by 2-tuple:

- Destination IP address
- Destination port number

### Uses

- Streaming multi-media apps
- DNS
- SNMP

### Reliable transfer over UDP

- Add reliability at application layer
- Application specific error recovery

### Why does UDP exist?

- No connection establishment (which can add delay)
- Simple, no connection state at sender and receiver
- Small header size
- No congestion control

Delay guarantees and bandwidth guarantees are not available in either TCP or UDP.

TCP / UDP segment format has a source port, destination port, headers and application data.

TODO: Is connectionless demultiplexing assessable?

## Principles of Reliable Data Transfer

In an ideal world:

- Channels are perfectly reliable
  - No errors i.e. flipped bits
  - No packet loss
  - Packets received by the receiver in order

TODO

## Acknowledgement mechanisms

- Assume first that the channel might introduce errors i.e. corrupted packets, but packets are not lost
- Underlying channel may flip bits in packet
  - Checksum is used to detect bit in errors
- The key problem is how to recover from errors
Two mechanisms


TODO
