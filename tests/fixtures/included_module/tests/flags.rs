mod flags {
    include!("../src/flags.rs");
}

#[test]
fn one_flag_per_target() {
    let flags = flags::Flags::for_target("x86_64");
    assert_eq!(flags.names, ["TARGET_X86_64"]);
}
