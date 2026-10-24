# Modbus Register Map

All values are 16-bit holding registers (function codes 0x03 read / 0x06 write),
scaled integers unless noted. Each PLC exposes only its own stage's registers,
starting at address 0.

## plc-dosing — Modbus/TCP

| Addr | Name | Scale | R/W | Notes |
|---|---|---|---|---|
| 0 | ph_value | x100 | R | e.g. 742 = pH 7.42 |
| 1 | flow_rate | x10 | R | L/min |
| 2 | pump_speed | x1 | R/W | 0-100 (%) |
| 3 | ph_setpoint | x100 | R/W | target pH |
| 4 | pump_state | x1 (coil-like) | R/W | 0 = off, 1 = on |

## plc-raw-water — Modbus Security

| Addr | Name | Scale | R/W | Notes |
|---|---|---|---|---|
| 0 | tank_level | x1 | R | % full |
| 1 | intake_pump_speed | x1 | R/W | 0-100 (%) |

## plc-filtration — Modbus Security

| Addr | Name | Scale | R/W | Notes |
|---|---|---|---|---|
| 0 | turbidity_in | x10 | R | NTU |
| 1 | turbidity_out | x10 | R | NTU |
| 2 | filter_efficiency | x1 | R | % |

## plc-disinfection — Modbus Security

| Addr | Name | Scale | R/W | Notes |
|---|---|---|---|---|
| 0 | chlorine_dose | x100 | R/W | mg/L |
| 1 | pathogen_index | x1 | R | 0-1000, lower is better |

## plc-distribution — Modbus Security

| Addr | Name | Scale | R/W | Notes |
|---|---|---|---|---|
| 0 | final_ph | x100 | R | |
| 1 | final_turbidity | x10 | R | NTU |
| 2 | final_pathogen_index | x1 | R | |
| 3 | distribution_flow | x10 | R | L/min |

## Changing this file

If you add, move, or rescale a register, flag it to the other two — `plc-fleet`,
`scada-hmi`, and `ids-sentinel` all read these addresses and scales directly.