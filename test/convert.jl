push!(LOAD_PATH,"../src/")

using Periods

# Instantiation of periods objects.
a = p"1938Y"
b = p"1938Q4"
c = p"1938M11"

# Conversion to a String.
a0 = String(a)
b0 = String(b)
c0 = String(c)

# Check conversions
@assert a0=="1938Y"
@assert b0=="1938Q4"
@assert c0=="1938M11"
