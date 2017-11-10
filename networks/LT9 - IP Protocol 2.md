# LT9 - IP Protocol 2

## Ethernet Addresses

- Ethernet Addresses (MAC Addresses) are normally inherent to the machine
- 48 bits (6 bytes)
  - 3 bytes identify manufacturer
  - 3 bytes identify device
- Can be changed
  - Good reasons: Older protocols modify address to match higher layer addresses
  - Bad reasons: MAC spoofing to evade access control
- Debate on whether machines with two interfaces should have one or two addresses: standard says one, reality says two

## Network Numbers/ DHCPv6

- Where to get an IP network?
  - Small allocations from your ISP, belong to ISP (business ISP)
  - If you change ISP you need to change your IP numbers
  - Larger allocations can be obtained from **regional registries**
  - Need a very good case to get these

## Local IP numbers

- Static allocation
- bootp
- DHCP
- SLAAC (IPv6 only)

### Static Allocation

- Endpoint given an IP in some sort of config file
- Every time device boots it gets exactly that IP, even if it's wrong or clashes etc.
- The machine might notice that it is a duplicate but otherwise has very little protection

- Essential for routers and infrastructure devices that need to be up in very early stages after power failure
- Often used for servers that need to have fixed addresses (www.my.domain, mail.my.domain etc.)

### bootp

- Device broadcasts its ethernet address (MAC)
- "bootp server" hands back an IP number and DNS servers, default router etc.
- Can only be used for static assignments, as no means to reclaim addresses
- Large table statically mapping MAC addresses to IP numbers
- Obsolete

### DHCP

- Dynamic Host Configuration Protocol (RFC2131)
- **Lease** a temporary IP number for a specified duration
  - Also obtain address mappingss for routers, DNS, time servers etc.
- Can also be used to inform devices of a statically allocated IP number
- Main means of allocating IPv4 addresses on LANs in 2017

Handing out leases, a temporary IP number with a time, only allowed to use it for that period, after you have to give it back or renew the least. DHCP servers are much more complicated than bootp servers, as they have to handle an address pool.

#### Initial Operation

- *DHCPDISCOVER* - Client broadcasts a request for an IP number, including its MAC address
- *DHCPOFFER* - Server(s) reserve an available IP number, broadcasts an an offer of it with a lease time
- *DHCPREQUEST* - Client chooses from amongst offers, broadcasts reply containing chosen IP number
  - If it matches the offer, the IP number is locked for the duration of the lease
  - If the IP or MAC doesn't match they do nothing
- *DHCPACK* - Server that offered the IP finishes reserving it and acknowledges; other servers see their offer has been declined and unreserve their offer.

A client can directly request to a known server, in order to renew a lease. Conventionally, renewal attempts start after half the lease has passed. Leases typically last between 30s - 1 year

#### Static vs Pools

- DHCP can work like bootp, always handing out the same IP number for the same MAC address, to configure static machines
- Or it can manage a pool of temporary addresses
- Smart DHCP servers store the assignments so if you ask for an address you always get the same one from the pool, unless it has been allocated to someone else in the meantime
- Very smart DHCP servers can update DNS servers to record the name to IP binding

#### Redundancy

- Loss of DHCP server will wipe out your network
- But DHCP servers contain delicate state
- Simple home routes can be careless about this, so a route restart may require client device restart to get state into agreement, hence the typically short lease times
- Choices include:
  - Two DHCP servers managing disjoint poolts, let client select TODO
    - One server lags the other by a second, only to be used in an emergency
  - Complex failover protocol so both servers make the same offer and commit to the same lease (no standards, implementations are rare)
  - Using higher-level redundancy protocols to have one virtual server (probably best)

#### Relaying

TODO


DHCP relay agent totally stateless, one per network or more, can be buried in routers

#### Relaying

- Relay agent hears a broadcast packet
- Is configured to send all requests to a known DHCP server, after filling in its own address
TODO