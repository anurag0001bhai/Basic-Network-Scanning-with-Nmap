# Task 1 — Nmap Scan Report

**Target IP:** `192.168.56.102`
**Date:** 04-09-2026

---

## 1. Basic Scan

**Command:**
```
nmap 192.168.56.102
```

**Output:**
```
Starting Nmap 7.94 ( https://nmap.org ) at 2026-09-04 10:00 IST
Nmap scan report for 192.168.56.102
Host is up (0.00040s latency).
Not shown: 977 closed tcp ports (reset)
PORT     STATE SERVICE
21/tcp   open  ftp
22/tcp   open  ssh
23/tcp   open  telnet
25/tcp   open  smtp
53/tcp   open  domain
80/tcp   open  http
111/tcp  open  rpcbind
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
3306/tcp open  mysql
5432/tcp open  postgresql
8180/tcp open  unknown

Nmap done: 1 IP address (1 host up) scanned in 4.32 seconds
```

> ⚠️ **Replace this block with your own `nmap [target IP]` output before submitting.**

---

## 2. Service Version Scan

**Command:**
```
nmap -sV 192.168.56.102
```

**Output:**
```
PORT     STATE SERVICE     VERSION
21/tcp   open  ftp         vsftpd 2.3.4
22/tcp   open  ssh         OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)
23/tcp   open  telnet      Linux telnetd
25/tcp   open  smtp        Postfix smtpd
53/tcp   open  domain      ISC BIND 9.4.2
80/tcp   open  http        Apache httpd 2.2.8 ((Ubuntu) DAV/2)
111/tcp  open  rpcbind     2 (RPC #100000)
139/tcp  open  netbios-ssn Samba smbd 3.X
445/tcp  open  netbios-ssn Samba smbd 3.X
3306/tcp open  mysql       MySQL 5.0.51a-3ubuntu5
5432/tcp open  postgresql  PostgreSQL DB 8.3.0 - 8.3.7
8180/tcp open  http        Apache Tomcat/Coyote JSP engine 1.1
```

> ⚠️ **Replace this block with your own `nmap -sV [target IP]` output before submitting.**

---

## 3. OS Detection Scan

**Command:**
```
sudo nmap -O 192.168.56.102
```

**Output:**
```
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6
OS details: Linux 2.6.9 - 2.6.33
Network Distance: 1 hop
```

> ⚠️ **Replace this block with your own `sudo nmap -O [target IP]` output before submitting.**

---

## Open Ports — Analysis

### Port 21 — FTP
- **Version:** vsftpd 2.3.4
- **What it does:** File Transfer Protocol, used to upload/download files between machines.
- **Security risk:** **High** — this specific version has a well-known backdoor vulnerability (CVE-2011-2523) allowing unauthenticated remote command execution. Should be patched or replaced immediately.

### Port 22 — SSH
- **Version:** OpenSSH 4.7p1
- **What it does:** Provides encrypted remote login and command execution.
- **Security risk:** **Medium** — SSH itself is secure, but this is an old version with known vulnerabilities. Should be updated, and password authentication should be disabled in favor of key-based auth.

### Port 23 — Telnet
- **What it does:** Provides remote login, similar to SSH.
- **Security risk:** **High** — Telnet transmits all data, including credentials, in plain text. Should be disabled entirely and replaced with SSH.

### Port 25 — SMTP
- **Version:** Postfix
- **What it does:** Handles sending of email between mail servers.
- **Security risk:** **Medium** — if left open and misconfigured (open relay), can be abused to send spam or phishing emails.

### Port 80 — HTTP
- **Version:** Apache 2.2.8
- **What it does:** Serves web pages/content.
- **Security risk:** **Medium** — outdated Apache version may have known vulnerabilities; should be kept updated and configured with proper access controls.

### Port 139/445 — Samba (NetBIOS/SMB)
- **What it does:** Enables file and printer sharing between systems on a network.
- **Security risk:** **High** — older Samba versions have multiple known remote code execution vulnerabilities and should be updated or restricted to trusted networks only.

### Port 3306 — MySQL
- **What it does:** Database service for storing and retrieving application data.
- **Security risk:** **Medium-High** — a database port should never be exposed to untrusted networks; access should be restricted to localhost or specific trusted hosts, with strong authentication.

### Port 5432 — PostgreSQL
- **What it does:** Another relational database service.
- **Security risk:** **Medium-High** — same reasoning as MySQL; should not be publicly reachable and needs strong access controls.

---

## Summary

The scan identified 12 open ports on the target, several of them (FTP, Telnet, Samba) running outdated versions with publicly known vulnerabilities. The overall risk level of this target is **HIGH**.

**Recommendations:**
- Disable Telnet
- Patch or replace the vulnerable FTP service
- Update Samba/Apache to current versions
- Restrict database ports (3306/5432) to trusted hosts only
- Disable password-based SSH login in favor of key-based authentication

---

> **Note:** The values above are a *sample* (based on the commonly-used practice target, Metasploitable2) showing the expected format and depth of analysis. Replace every section with the **real output from scanning your own VM** before submitting — your actual open ports and services will likely differ, and the report should reflect what you actually found.
