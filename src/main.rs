use regex::Regex;
use std::env;
use std::fs;
use std::fs::File;
use std::io::prelude::*;

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = &args[1];
    let filename_tmp = [filename, ".tmp"].join("");

    let contents = fs::read_to_string(filename).unwrap();

    let mut prev_new_line = false;
    let mut toc_list = vec![];
    let headers = Regex::new(r"^##+ ").unwrap();
    for line in contents.split("\n") {
        if line == "" {
            prev_new_line = true;
            continue;
        }

        if headers.is_match(line) {
            if prev_new_line {
                toc_list.push(line);
            }
        }

        prev_new_line = false;
    }

    // let res: Vec<String> = contents.split("\n").map(|s| s.to_string()).collect();
    // println!("{:?}", res);

    let mut tmp_file = File::create(filename_tmp.clone()).unwrap();
    let mut toc_started = false;
    let mut toc_ended = false;
    let mut toc_written = false;
    let toc_item_matcher = Regex::new(r"^[ ]*\*+ ").unwrap();
    let mut lines: Vec<&str> = contents.split("\n").collect();
    if lines[lines.len() - 1] == "" {
        lines = (&lines[..lines.len() - 1]).to_vec();
    }
    for line in lines {
        if line == "Table of Contents" {
            toc_started = true;
        } else if toc_started && (line != "" && !toc_item_matcher.is_match(line)) {
            toc_ended = true;
        }

        if toc_ended {
            if toc_started && !toc_written {
                write!(tmp_file, "Table of Contents\n\n").unwrap();

                for toc_line in toc_list.iter() {
                    let mut depth = 0;
                    let mut index = 0;
                    for c in toc_line.chars() {
                        if c == '#' {
                            depth += 1;
                        } else if c != ' ' {
                            break;
                        }
                        index += 1;
                    }

                    write!(
                        tmp_file,
                        "{}\n",
                        vec![
                            "    ".repeat(depth - 2),
                            "* ".to_string(),
                            toc_line.to_string().get(index..).unwrap().to_string(),
                        ]
                        .join("")
                    )
                    .unwrap();
                }

                write!(tmp_file, "\n").unwrap();

                toc_written = true;
            }
        }

        if !toc_started || toc_ended {
            write!(tmp_file, "{}\n", line).unwrap();
        }
    }

    fs::rename(filename_tmp, filename).unwrap();
}
