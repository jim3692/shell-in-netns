# Shell in network namespace

Usage: "bash create-ns.sh [-andc] [command [command parameters]]"
- -a|--any: Use any existing NS without creating a new one (Interactive selection if omitted)
- -n|--new: Create a new NS, even if others exist
- -d|--detach: Detach instead of entering namespace
- -c|--config-file: Use a config file for Uplink/IP/Gateway (Interactive entry if omitted)

Config file structure:

```bash
uplink="eno1"
ip="192.168.1.10/24"
gateway="192.168.1.1"
```
