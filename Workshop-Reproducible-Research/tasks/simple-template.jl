# include the model code
include("melt.jl")
# load a plotting library
using Plots

## Define the synthetic weather and glacier
function synthetic_T(t)
    ...
end

function synthetic_P(t)
    ...
end

function synthetic_glacier()
    ...
    return x, elevation
end

## Define constants
lapse_rate = -0.6/100
melt_factor = 0.005
T_threshold = 4
dt = 1/24
t = 0:dt:365

## Plot the synthetic weather
Ts = synthetic_T
plot(...)

## Run the model for one year at a point
ele = 1500
Ts_ele = lapse(...)
Ps = ...
total_point_balance(...)

## Run the model for one year for the whole glacier
xs, zs = synthetic_glacier()
Ts = ...
total_massbalance, point_massbalance = glacier_balance(...)
plot(xs, point_massbalance)

## Generate output table
# make a table of mass-balance for different temperature offsets and store it
out = []
for dT = -4:4
    Ts_ = synthetic_T.(t) .+ dT
    # run model
    # store in out
end
