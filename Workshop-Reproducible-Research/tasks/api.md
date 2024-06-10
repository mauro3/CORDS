## API (application programming interface)

melt-rate function:
- signature: (T, melt_factor) -> meltrate (m/d)
- name `melt`

accumulation-rate function:
- signature: (T, P, T_threshold) -> accumulate (m/d)
- name: `accumulate`

lapsed-temperature function
- signature: (T, dz, lapse_rate) -> T
- name: `lapse`

synthetic temperature function:
- signature: (t) -> T
  - where t is time
- name: `synthetic_T`

synthetic precipitation function:
- signature: (t) -> P
  - where t is time
- name: `synthetic_P`

net balance (balance rate integrated over time)
- signature: `(dt, Ts, Ps, melt_factor, T_threshold) -> net_balance`
  - where dt is the time step, Ts is the temperature time series, Ps precipitation time series,
- name: `net_balance_fn`

glacier net balance (balance rate integrated over time and space)
- signature `(zs, dt, Ts, Ps, melt_factor, T_threshold, lapse_rate) -> glacier_net_balance, net_balance`
  - where zs are the elevations of the grid points
- name: `glacier_net_balance_fn`
