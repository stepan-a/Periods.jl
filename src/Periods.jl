module Periods

using PeriodsUtils

export periods, @periods, @p_str

const ALLOWED_FREQUENCIES = [1, 4, 12]

type periods
    freq::Int
    time::Matrix{Int}

    """
        periods(f::Int)
    
    Returns an empty periods object with frequency f.
    
    The first input argument is an integer scalar equal to 1 (year), 4
    (quarter) or 12 (month).
    """
    function periods(f::Int)
        @assert ismember(f, ALLOWED_FREQUENCIES)
        freq = f;
        time = zeros(Int, 0, 2);
        new(freq, time)
    end

    """
        periods(f::Int, t::Matrix{Int})

    Returns a periods object.

    First input is an integer scalar equal to 1 (year), 4 (quarter) or 12
    (month). Second input argument is a matrix of integers, on each row
    the first element is the year and the second element is the subperiod.
    """
    function periods(f::Int, t::Matrix{Int})
        @assert ismember(f, ALLOWED_FREQUENCIES)
        freq = f;
        time = t;
        new(freq, time)
    end

    """
        periods(p::String)

    Returns a periods object.

    Input must be a string interpretable as a period (ie of the form 1950Y, 1990Q1,
    or 1950M11).
    """
    function periods(p::String)
        @assert isperiod(p)==true
        p = match(r"([0-9]+)(q|Q|a|A|y|Y|m|M)([0-9]*)", p)
        freq = freq2int(p.captures[2])
        time = zeros(Int, 1, 2)
        if freq==1
            time[2] = 1
        else
            time[2] = parse(Int, String(p.captures[3]))
        end
        time[1] = parse(Int, String(p.captures[1]))
        new(freq, time)
    end

end

"""
    p_str(s::String)

Defines non standard literal for periods, of the form r"1990Q1".
"""
macro p_str(s::String)
    periods(s)
end


end
