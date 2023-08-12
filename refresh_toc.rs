// use std::env;

use regex::Regex;
use std::fs;
// use std::str::pattern::Pattern;

fn main() {
    // let args: Vec<String> = env::args().collect();
    // let filename = &args[1];
    let filename =
        "/Users/bom_d_van/Code/xhu.buzz/to-glob-10m-metrics-using-trie-and-dfa/readme.md";

    // let mut nfile = File::create(filename + ".tmp")?;
    // file.write_all(b"Hello, world!")?;

    let contents = fs::read_to_string(filename).unwrap();
    // println!("contents = {}", contents);

    let mut lines = contents.split('\n');

    let headers = Regex::new(r"^#+ ").unwrap();

    // lines.clone().for_each(move |line| {
    //     if line.is_prefix_of("") {
    //         println!("line = {}", line);
    //     }
    // });

    // let count = lines.count();
    // for i in 0..count {
    //     let line = lines.nth(i).unwrap();
    //     if line == "Table of Contents" {
    //         println!("line = {}", line);
    //     }
    // }

    let mut prev_new_line = false;
    loop {
        let line = lines.next();
        if line == None {
            break;
        }

        if line.unwrap() == "" {
            prev_new_line = true;
        } else if line.unwrap() == "Table of Contents" {
            println!("line = {}", line.unwrap());
        } else if headers.is_match(line.unwrap()) {
            println!("line = {}", line.unwrap());
        }
    }
}
