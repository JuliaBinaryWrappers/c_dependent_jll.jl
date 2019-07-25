# Autogenerated wrapper script for c_dependent_jll for x86_64-linux-gnu-libgfortran5-libstdcxx26-cxx11
export deppy, libdependent

using c_simple_jll_jll
## Global variables
const PATH_list = String[]
const LIBPATH_list = String[]
PATH = ""
LIBPATH = ""
LIBPATH_env = "LD_LIBRARY_PATH"

# Relative path to `deppy`
const deppy_splitpath = ["bin", "deppy"]

# This will be filled out by __init__() for all products, as it must be done at runtime
deppy_path = ""

# deppy-specific global declaration
function deppy(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(ENV["PATH"], ':', PATH)
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(ENV[LIBPATH_env], ':', LIBPATH)
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(deppy_path)
    end
end


# Relative path to `libdependent`
const libdependent_splitpath = ["lib", "libdependent.so"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libdependent_path = ""

# libdependent-specific global declaration
# This will be filled out by __init__()
libdependent_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libdependent = "libdependent.so"


"""
Open all libraries
"""
function __init__()
    global prefix = abspath(joinpath(@__DIR__, ".."))

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list

    append!(PATH_list, c_simple_jll_jll.PATH_list)
    append!(LIBPATH_list, c_simple_jll_jll.LIBPATH_list)
    global deppy_path = abspath(joinpath(artifact"c_dependent", deppy_splitpath...))

    push!(PATH_list, dirname(deppy_path))
    global libdependent_path = abspath(joinpath(artifact"c_dependent", libdependent_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libdependent_handle = dlopen(libdependent_path)
    push!(LIBPATH_list, dirname(libdependent_path))

    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ':')
    global LIBPATH = join(LIBPATH_list, ':')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

