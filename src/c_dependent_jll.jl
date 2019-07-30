module c_dependent_jll
using Pkg.BinaryPlatforms, Pkg.Artifacts, Libdl

platforms = Platform[
    Linux(:x86_64, libc=:glibc),
]

# From the available options, choose the best platform
best_platform = select_platform(Dict(p => triplet(p) for p in platforms))

# Load the appropriate wrappers
include(joinpath(@__DIR__, "wrappers", "$(best_platform).jl"))

end  # module c_dependent_jll
