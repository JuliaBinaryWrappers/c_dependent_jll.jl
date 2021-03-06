module c_dependent_jll
using Pkg.BinaryPlatforms, Pkg.Artifacts, Libdl

platforms = Platform[
    Linux(:powerpc64le, libc=:glibc),
    Linux(:i686, libc=:glibc),
    Linux(:armv7l, libc=:glibc, call_abi=:eabihf),
    FreeBSD(:x86_64),
    Windows(:x86_64),
    Linux(:x86_64, libc=:musl),
    Windows(:i686),
    Linux(:aarch64, libc=:glibc),
    MacOS(:x86_64),
    Linux(:aarch64, libc=:musl),
    Linux(:x86_64, libc=:glibc),
    Linux(:armv7l, libc=:musl, call_abi=:eabihf),
    Linux(:i686, libc=:musl),
]

# From the available options, choose the best platform
best_platform = select_platform(Dict(p => triplet(p) for p in platforms))

# Load the appropriate wrappers
include(joinpath(@__DIR__, "wrappers", "$(best_platform).jl"))

end  # module c_dependent_jll
