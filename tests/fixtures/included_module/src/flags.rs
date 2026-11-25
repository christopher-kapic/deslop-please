pub struct Flags {
    pub names: Vec<String>,
    target: String,
}

impl Flags {
    pub fn for_target(target: &str) -> Flags {
        Flags {
            names: vec![format!("TARGET_{}", target.to_uppercase())],
            target: target.to_owned(),
        }
    }

    pub fn describe(&self) -> String {
        format!("{}: {}", self.target, self.names.join(","))
    }
}
