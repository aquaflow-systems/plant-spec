# plant-spec

Shared engineering reference for the AquaFlow Systems treatment plant control
system. Not a running service — other repos read from here instead of
duplicating register addresses, network configuration, or certificates.

## Contents

- [`register-map.md`](./register-map.md) — Modbus register addresses and value
  scaling per stage
- [`network-plan.md`](./network-plan.md) — container names, IPs, ports, protocol per
  stage
- [`certs/generate-certs.sh`](./certs/generate-certs.sh) — generates a local CA and
  per-PLC certificates for Modbus Security

## Changing the spec

Open a PR before merging. Changes here affect `plc-fleet`, `scada-hmi`, and
`ids-sentinel` simultaneously, so review before you merge.