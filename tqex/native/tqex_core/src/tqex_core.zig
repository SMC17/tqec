const std = @import("std");
const c = @cImport({
    @cInclude("erl_nif.h");
});

export fn shift_in_direction(env: ?*c.ErlNifEnv, argc: c_int, argv: [*c]const c.ERL_NIF_TERM) c.ERL_NIF_TERM {
    if (argc != 5) return c.enif_make_badarg(env);

    var x: c_int = 0;
    var y: c_int = 0;
    var z: c_int = 0;
    var direction: c_int = 0; // 0=X, 1=Y, 2=Z
    var shift: c_int = 0;

    if (c.enif_get_int(env, argv[0], &x) == 0) return c.enif_make_badarg(env);
    if (c.enif_get_int(env, argv[1], &y) == 0) return c.enif_make_badarg(env);
    if (c.enif_get_int(env, argv[2], &z) == 0) return c.enif_make_badarg(env);
    if (c.enif_get_int(env, argv[3], &direction) == 0) return c.enif_make_badarg(env);
    if (c.enif_get_int(env, argv[4], &shift) == 0) return c.enif_make_badarg(env);

    if (direction == 0) {
        x += shift;
    } else if (direction == 1) {
        y += shift;
    } else if (direction == 2) {
        z += shift;
    }

    const term_x = c.enif_make_int(env, x);
    const term_y = c.enif_make_int(env, y);
    const term_z = c.enif_make_int(env, z);

    return c.enif_make_tuple3(env, term_x, term_y, term_z);
}

var funcs = [_]c.ErlNifFunc{
    c.ErlNifFunc{
        .name = "shift_in_direction",
        .arity = 5,
        .fptr = shift_in_direction,
        .flags = 0,
    },
};

var entry: c.ErlNifEntry = undefined;

export fn nif_init() *c.ErlNifEntry {
    entry.major = c.ERL_NIF_MAJOR_VERSION;
    entry.minor = c.ERL_NIF_MINOR_VERSION;
    entry.name = "Elixir.Tqex.Core";
    entry.num_of_funcs = funcs.len;
    entry.funcs = &funcs;
    entry.load = null;
    entry.reload = null;
    entry.upgrade = null;
    entry.unload = null;
    entry.vm_variant = "beam.vanilla";
    entry.options = 1;
    entry.sizeof_ErlNifResourceTypeInit = @sizeOf(c.ErlNifResourceTypeInit);
    entry.min_erts = "erts-10.4";
    return &entry;
}
