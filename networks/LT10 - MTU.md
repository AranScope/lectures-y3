# LT10 - MTU

Not really assessable ->

## Maximum Transmission Unit

When IP packets are sent, they have a maximum size dictated by the link over which they are send and by the IP protocol.

MTUs vary by network

The IP standard requires that for a link to pass IP it must be able to pass IP frames of 576 bytes.

We need some kind of assurance that frames of > 576 will be carried. We don't have prior knowledge of the path a packet will take, so there is no direct way of knowing.

### Solution 1. Hard Limits

1 - If the device you are talking to is on the same physical network (ethernet), then you know the MTU is the same as the network MTU, so the limit is ~1500 bytes
2 - Otherwise, 576 is the legal lower limit

This is a very conservative approach that is inefficient as the data is pushed in very small packets.

### Solution 2. Fragmentation

#### Basic Idea

- Divide packet into two or more fragments, each < MTU bytes

## Path MTU Discovery

Work out in real time what the max MTU we can use to and from a particular destination is.
PMTU discovery doesn't require explicit support in the protocol, though one small change is very helpful. The "DF", "Don't fragment" bit. This was originally used for dealing with a recipient that was known to be resource constrained so they couldn't support fragment reassembly.

- Periodically send packets to destinations we are communicating with which
    a - Are the maximum size we want to send
    b - Have the DF flag set
- If that MTU gets all the way to the other end, fine
- If the packet encounters a link that is not large enough for the packet
    1 - Router will generate an error (ICMP destination unreachable) indicating the packet could not be delivered because fragmentation was required but was forbidden
    2 - An RFC extension is to add the maximum accepted size to this error
- If there is a size specified, reduce to that size
- If no size is specified, drop the size either to 576 or try various sizes through binary search (advised against)

## IPv6

- Mandates minimum packet size of 1280 bytes
- Fragmentation only available as an option, not as core part of the protocol
- Is seriously recommended against
