module PeriodsUtils

import Base.Char

export ismember, freq2int
export isperiod

const FREQENCY_REGEXP = r"m|M|q|Q|a|A|y|Y"
const ALLOWED_FREQUENCIES_CHAR = split(FREQENCY_REGEXP.pattern,"|")

Char(x::SubString{String}) = x[1]
Char(x::Vector{SubString{String}}) = Char[ Char(x[i]) for i=1:length(x) ]

ismember(i::Int, v::Vector{Int}) = any(i.==v)
ismember(c::Char, v::Vector{Char}) = any(c.==v)

function freq2int(f::String)
    if f=="Q" || f=="q"
        return 4
    end
    if f=="M" || f=="m"
        return 12
    end
    if f=="Y" || f=="A" || f=="y" || f=="a"
        return 1
    end
end

freq2int(f::Char) = freq2int(String([f]))
freq2int(f::SubString{String}) = freq2int(String(f))

isfrequency(f::Char) = ismember(f, Char(ALLOWED_FREQUENCIES_CHAR))
isfrequency(f::String) = isfrequency(Char(f[1]))
isfrequency(f::SubString{String}) = isfrequency(String(f))

function issubperiod(f::String, s::Int)
    if ismember(s, [i for i=1:freq2int(f)])
        return true
    else
        return false
    end
end

issubperiod(f::SubString{String}, s::SubString{String}) = issubperiod(String(f), String(s))
issubperiod(f::Char, s::String) = issubperiod(Char([f]), s)
issubperiod(f::String, s::String) = issubperiod(f, parse(Int, s))
issubperiod(f::Char, s::Int) = issubperiod(String([f]), s::Int)

function isperiod(s::String)
    p = match(r"([0-9]+)(q|Q|a|A|y|Y|m|M)([0-9]*)", s)
    if isa(p, Void)
        return false
    else
        if isfrequency(p.captures[2])
            if freq2int(p.captures[2])==1
                if length(p.captures[3])==0
                    return true
                else
                    return false
                end
            else
                if issubperiod(p.captures[2], p.captures[3])
                    true
                else
                    false
                end
            end
        end
    end
end

end
