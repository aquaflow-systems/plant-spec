# Network Plan

## Docker networks

Two bridge networks:

- `control-net` — internal only, no external egress. All 5 PLCs, the HMI, and
  `ids-sentinel` live here. Models the Level 1 control network.
- `telemetry-net` — carries process data from `plant-sim` to `ops-dashboard`
  directly, separate from the control network, for monitoring purposes.

```
                 telemetry-net                       control-net
plant-sim  ──────────────────────┐        ┌────────────────────────── plc-fleet (x5)
     │                           │        │                                │
     └────────────► ops-dashboard ◄───────┼──────── ids-sentinel ──────────┘
                                           │                                │
                                           └──────────── scada-hmi ─────────┘
```

## Containers, IPs, ports

| Container | Network(s) | IP (control-net) | Port | Protocol |
|---|---|---|---|---|
| plant-sim | telemetry-net | — | 8000 | HTTP/WebSocket |
| plc-raw-water | control-net | 10.10.0.11 | 502 | Modbus Security (TLS) |
| plc-dosing | control-net | 10.10.0.12 | 502 | Modbus/TCP |
| plc-filtration | control-net | 10.10.0.13 | 502 | Modbus Security (TLS) |
| plc-disinfection | control-net | 10.10.0.14 | 502 | Modbus Security (TLS) |
| plc-distribution | control-net | 10.10.0.15 | 502 | Modbus Security (TLS) |
| scada-hmi | control-net | 10.10.0.20 | 8081 | HTTP (polls all 5 PLCs) |
| ids-sentinel | control-net | 10.10.0.21 | — | passive monitoring |
| ops-dashboard | control-net, telemetry-net | 10.10.0.22 | 8080 | HTTP |