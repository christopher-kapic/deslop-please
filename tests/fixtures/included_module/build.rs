#[path = "src/flags.rs"]
mod flags;

fn main() {
    let flags = flags::Flags::for_target("x86_64");
    for name in flags.names.iter() {
        println!("cargo:rustc-env=FLAG_{name}=1");
    }
    println!("cargo:rustc-env=FLAGS={}", flags.describe());
}
