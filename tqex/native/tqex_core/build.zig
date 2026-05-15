const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .root_source_file = b.path("src/tqex_core.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    const lib = b.addLibrary(.{
        .name = "tqex_core",
        .root_module = mod,
        .linkage = .dynamic,
    });
    
    // Add Erlang include path
    const erl_root = "/home/stax2/.local/share/mise/installs/erlang/26.2.5";
    mod.addIncludePath(.{ .cwd_relative = b.fmt("{s}/usr/include", .{erl_root}) });

    b.installArtifact(lib);
}
