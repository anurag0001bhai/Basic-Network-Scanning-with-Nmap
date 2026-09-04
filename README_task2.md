# Task 2 — Basic Firewall Configuration with UFW

## What Does a Firewall Do?
A firewall is a network security tool that monitors and controls incoming
and outgoing traffic based on a defined set of rules. It acts as a barrier
between a trusted internal system and untrusted external networks (like
the internet), allowing legitimate traffic through while blocking
traffic that matches "deny" rules or doesn't match any "allow" rule.

UFW (Uncomplicated Firewall) is a user-friendly front-end for Linux's
iptables/netfilter firewall system, making it easy to add rules without
writing raw iptables syntax.

## Installation
```bash
sudo apt update
sudo apt install ufw -y
```

## Default Policy
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```
This means: by default, all inbound connections are blocked unless
explicitly allowed, while outbound connections (the machine reaching out
to the internet) are permitted. This is the standard secure baseline —
it minimizes the attack surface by closing everything not specifically needed.

## Rules Configured and Why

| Rule | Command | Reason |
|---|---|---|
| Allow SSH (22) | `sudo ufw allow ssh` | SSH is needed for remote administration of the VM. Without this rule, enabling UFW would lock out remote access. |
| Deny HTTP (80) | `sudo ufw deny http` | Plain HTTP is unencrypted; traffic and credentials can be intercepted. This VM doesn't need to serve unencrypted web traffic. |
| Allow HTTPS (443) | `sudo ufw allow https` | HTTPS encrypts traffic in transit, so it's kept open for any web service that should still be reachable securely. |
| Deny from 203.0.113.0/24 | `sudo ufw deny from 203.0.113.0/24` | Demonstrates IP-range blocking — useful for blocking a known malicious network or restricting access to a specific untrusted source. Replace this range with any IP block you want to restrict. |

## Verifying the Rules
```bash
sudo ufw status verbose
```
This lists every active rule, the default policies, and logging status.
A screenshot of this output is included in this repository
(`screenshots/ufw_status.png`).

## Testing That Denied Traffic Is Actually Blocked
Method used:
1. From another machine (or the same VM, targeting itself), attempted to
   connect to the blocked service: `curl http://<VM-IP>` (port 80).
2. The connection timed out / was refused, confirming HTTP traffic is
   being dropped by the firewall.
3. As a control, the same test was done against the allowed HTTPS port
   (`curl -k https://<VM-IP>`), which succeeded (or was reachable) since
   that port remains open — showing the firewall is actively
   differentiating between allowed and denied ports rather than
   blocking everything.
4. Screenshots of both test results are included in `/screenshots`.

## Running the Configuration
All rules above are applied in sequence by the included script:
```bash
sudo chmod +x ufw_configuration.sh
sudo ./ufw_configuration.sh
```

## Tools Used
- UFW
- Ubuntu / Kali Linux VM
