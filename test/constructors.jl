push!(LOAD_PATH,"../src/")

using Periods

# Instantiation of empty periods objects (annual frequency).
a = periods(1)
@assert a.freq==1

# Instantiation of empty periods objects (quarterly frequency).
b = periods(4)
@assert b.freq==4

# Instantiation of empty periods objects (monthly frequency).
c = periods(12)
@assert c.freq==12

# Instantiation of a non empty periods object.
d = periods(4, [1950 1; 1950 2])
@assert d.freq==4
@assert d.time==[1950 1; 1950 2]
