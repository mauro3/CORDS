# A simple mass balance model

### Melt at a point *M*

$$
M(z,t) =
\begin{cases}
mf T(z,t): T(z,t) \ge 0\\
0 \hspace{2.85cm}: T(z,t)<0
\end{cases}
$$

where $melt_factor$ (m/d/C) is the melt factor.

### Accumulation at a point *C*
$$
C(z,t) =
\begin{cases}
P : T(z,t) \le T_{th}\\
0 \hspace{1.6cm}: T(z,t)>T_{th}
\end{cases}
$$

where $P$ is a given precipitation and $T_{th}$ is the temperature below which it snows.


### Lapsed temperature

$$ T(z,t) = l \Delta z + T(z_{s},t) $$

where $z_s$ is the elevation of the weather station (which provides temperature) and $l$ (C/m) is the lapse rate.

# Synthetic example

## Temperature and precipitation

Temperature [C] at weather station `-10*cos(2pi/364 * t) - 8*cos(2pi* t) + 5` with t in days

Precipitation [m/d] at weather station `8e-3` with threshold 4 [C]. (yes, it's alway raining/snowing on our wee glacier...)

Weather station altitude 0m.

## A 1D glacier

Horizontal extent `x = 0:500:5000` with elevation

$$z(x) = x/5  + 1400$$
