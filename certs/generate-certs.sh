#!/usr/bin/env bash
# Generates a local root CA and per-PLC certificates for the stages running Modbus
# Security (TLS). Self-signed, intended for the internal lab/testbed environment.
#
# Usage: ./generate-certs.sh
# Output: ./out/ca.crt, ./out/ca.key, and per-PLC cert/key pairs

set -euo pipefail

OUT_DIR="$(dirname "$0")/out"
mkdir -p "$OUT_DIR"
cd "$OUT_DIR"

SECURED_PLCS=("plc-raw-water" "plc-filtration" "plc-disinfection" "plc-distribution")
DAYS=825

echo "== Generating root CA =="
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days "$DAYS" \
  -subj "/O=AquaFlow Systems/CN=AquaFlow Root CA" \
  -out ca.crt

for plc in "${SECURED_PLCS[@]}"; do
  echo "== Generating cert for ${plc} =="
  openssl genrsa -out "${plc}.key" 2048
  openssl req -new -key "${plc}.key" \
    -subj "/O=AquaFlow Systems/CN=${plc}" \
    -out "${plc}.csr"
  openssl x509 -req -in "${plc}.csr" -CA ca.crt -CAkey ca.key -CAcreateserial \
    -days "$DAYS" -sha256 -out "${plc}.crt"
  rm "${plc}.csr"
done

echo "== Done. Certificates written to ${OUT_DIR} =="