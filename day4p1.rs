use std::fs::File;
use std::io::BufRead;
use std::io::BufReader;

fn read_file_line_by_line(filepath: &str) -> Result<usize, Box<dyn std::error::Error>> {
    let file = File::open(filepath)?;
    let reader = BufReader::new(file);

    let mut correct_lines = Vec::new();

    for line in reader.lines() {
        let str = line?;
        match str.split_once(',') {
            Some((first, second)) => {
                let mut fb = 0;
                let mut fe = 0;
                let mut sb = 0;
                let mut se = 0;
                match first.split_once('-') {
                    Some((begin, end)) => {
                        fb = begin.parse::<i32>().unwrap();
                        fe = end.parse::<i32>().unwrap();
                    }
                    None => {
                        println!("😔");
                    }
                }
                match second.split_once('-') {
                    Some((begin, end)) => {
                        sb = begin.parse::<i32>().unwrap();
                        se = end.parse::<i32>().unwrap();
                    }
                    None => {
                        println!("😔");
                    }
                }
                if (fb <= sb && se <= fe) || (sb <= fb && fe <= se) {
                    correct_lines.push(str);
                }
            }
            None => {
                println!("😔");
            }
        }
    }

    Ok(correct_lines.len())
}

fn main() {
    let answer =
        read_file_line_by_line("inputs/input_day4.txt").map_err(|err| println!("{:?}", err));

    println!("{:?}", answer);
}
