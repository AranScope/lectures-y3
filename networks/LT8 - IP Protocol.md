# LT8 - IP Protocol

- Dominant networking protocol over the past thirty years
- Single network lalyer, over which all transports run
- Single network layer which can run over all available lower layers

## What is IP

- Unreliable, unsequenced datagram service
- Put an address on a packet, the network attempts to deliver it somewhere, hopefully the right place
- No checksum covering the data (there is one for the header), corruption protection is the responsibility of the upper layers
- Barebones

## Why did IP win

- Easy to implement
- Works over all mediums e.g. long haul radio to high speed fibre
- Support of US DoD, ARPA, NSF

## Packet Format

- Each row is 32 bits, four bytes, 1 word
- Typical header is 20 bytes, 5 words
- Fields aren't byte aligned
- Options are optional

![Packet Format Diagram](networks/image/ipv4packet.png)\

## 32 Bit Addresses

- At the time, insanely large
- Original concept: 8 bits indicating the site, 24 bits specifying a machine at the site
- Obviously 256 sites was not enough

### Notation

- Four decimal numbers, each encoding one byte (wastefully) seperated by dots
- Typically not zero padded
```
192.168.1.1
```
TODO

## Routing Decisions

- Identify network using leftmost part of address
- Identify host on network with the rest of the address
- Router ignores host for all non-local addresses
- Network is looked up in a routing a routing table, chooses which interface to send a packet through
  - "Default network" in all other cases

## Routing problems

- Speeds and ram limitations of the time made building large distributed routing tables hard
- Limiting to 256 networks was unreasonable
- 32 bits, ~ 4 billion addresses, utilisation was anticipated at a fraction of a percent

## "Classful" Addresses

If the address starts with a 0, the first 8 bits identify the network, the remaining 24 identify the host *1.x.y.z* through *127.x.y.z* So there are 128 "Class A" addresses for large sites, they get 2^24 (~16 million) hosts each.

If the address starts with 10, the first 16 bits identify the network, the remaining 16 bits identify the host *128.x.y.z* through to *191.x.y.z* So there are 2^14 (16384) "Class B" addresses, they get 2^16 hosts each.

If the address starts with 1010 etc. there are also classes C, D and experimental class E.

![Classes diagram](networks/image/classful.png)\

### Wasteful allocation

- Totally reachable space is 87% of the available addresses
- Class A space is very sparsely occupied, as is class B
- In both cases very few hosts are externally accessible
- Class C space was initially available to everyone
- Likely that < 25% of address space is usefully deployed
- Huge shortages outside USA, Canada and west Europe

### Easy for routers

- Most of early internet was class A addresses
- Look at the address to see if it's local, send straight to the destination
- Otherwise Look at first bit of address, if zero then lookup first byte in 127-entry "next hops" table
- With 32 bit addresses a 128 entry table takes 512 bytes, easy.
- If found, send packet to that router
- Otherwise look up remaining bytes in more complex table
- Otherwise use default route

### Routing vs Memory

- Fully populated routing table for every /24 in 128MB of RAM
- Every unique destination for every IP number in 32GB of RAM
- Routing not a big computational problem, can just index into a sparsely populated array instead of trees or hash tables
- No need for caching

## Sub-Netting

- Using large amounts of address space to plan internal networking by structuring "host" part of the network
- Class B treat 2^16 addresses as 256 networks of 256 hosts
- Later you could "subnet" on non-byte boundaries
  - Systems that don't support this are now obsolete
- Outside world sees one network, internally everyone knows extra information about address layout

### Netmasks

- The bit pattern which can be bitwise and'd with an address to yield a network number

```Bash
Class A (/8)) - 255.0.0.0

Class B (/16) - 255.255.0.0

Class C (/24) - 255.255.255.0
```

![Subnet diagram](networks/image/subnetting.png)\

### CIDR and Slash Notation

- Classful networking was wasteful and needed more flexible sub-netting
- Hence, Classless Interdomain Routing, **CIDR**
- Every network address has a netmask which describes how much of it is network and how much is host
- Class A now */8*
- Class B now */16*
- Class C now */24*

```C
18.0.0.0/18
// First 18 bits are network number, // rest are host
```

- *Super netting* rarely used to group lower classes into blocks
- Eight contiguous class Cs placed under a */21* for example

## Non Byte Masks

- Extends to boundaries that are not classful
- A */28* would give the user 16 IP addresses

## Recovering Class As

- Some of the class As were recovered (by threats, bankruptcy etc.)
- Allocation stopped at 57 anyway
- Remainder and returns were broken up into different clsases

## IPv6: IP with big addresses

- 32 bit addresses have run out
- 128 bit addresses gives 2^96 more addresses
- Minimum allocation is a /64, you're mobile phone will probably get a /64
- IPv6 is "really" a 64 bit protocol 
- 2^64 gives 2^30 per person, ~ 1B

![IPv6 Packet Structure](networks/image/ipv6packet.png)\

- Hex string, broken into 16 bit chunks, width colons, no leading zeros
- Certain addresses are reserved 

## IPv6 Routing Tables

- In the long-term will require complexity originally used for Ipv4
- Very sparsely used currently
- 2^64 addresses = 2^24 TB, obviously a way off but so is 2^64 allocated networks

## IP in Operation

- Sender: choose an interface believed to be closer to the destination, send the packet
- Recipient: if the packet is for us, process locally, otherwise send it on

## IP on Ethernet

How do we find the address of the next "hop" on an ethernet?

- IPv4 uses **ARP** - Address resolution protocol
  - Simple, old, insecure
  - Ask "who has" a particular IP
  - Station with that IP or someone who knows tells us
  - Ripe for exploitation

- IPv6 uses "Neighbour Discovery Protocol" to do a similar job

## IP To Gateways

TODO

## IP Data Transfer

### On Point to Point Links

- Just send a packet down the link
- Might be physical, might be a tunnel

### To Gateways

- Look up gateway address using **ARP**
- IP destination remains the ultimate destination
- Gateways don't appear on IP header
- Gateway at other end of point-to-point links just involves sending the packet

### Hop Counts

- Each packet has time to live **TTL**
- Decremented each time packet is processed, or router holds it for more than a second
- When it hits zero, packet is discarded "ICMP Time Exceeded" error report is generated
- Typical initial value **30 - 60** depending on estimates of "diameter" of internet
- Prevents packets circulating endlessly
- Requires re-computation of header checksum in IPv4
  - Fast algorithms can recompute based on knowing what's changed (not a secure hash).
- IPv6 doesn't have a header checksum, it instead relies on lower layers being reliable and upper being sensible
- Good reason for routers and switches to use ECC ram, to avoid flipped bits

## Reading

- EEEE Vinton Serf, a protocol for packet network intercommunication
- RFC791