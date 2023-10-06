##
# using packages
using Feather
using Tidier
using Makie
using Plots

##
# loading processed data from jld2
# make relative path
datapath = joinpath(pwd(), "processed_data", "processed_data.feather")

# data loading
dat = Feather.read(datapath)
