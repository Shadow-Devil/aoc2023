import ballerina/regex;
import ballerina/io;


class Day02 {
    int maxRed = 12;
    int maxGreen = 13;
    int maxBlue = 14;

    public function part1() returns int|error {
        int sum = 0;
        int i = 1;
        foreach var line in check io:fileReadLines("inputs/day02.txt") {
            var illegalMove = false;
            foreach var hand in regex:split(regex:split(line, ": ")[1], "; ") {
                var curRed = 0;
                var curGreen = 0;
                var curBlue = 0;
                foreach var pair in regex:split(hand, ", ") {
                    var color = regex:split(pair, " ");
                    match color[1] {
                        "blue" => {
                            curBlue += check int:fromString(color[0]);
                        }
                        "red" => {
                            curRed += check int:fromString(color[0]);
                        }
                        "green" => {
                            curGreen += check int:fromString(color[0]);
                        }
                    }
                }
                if curRed > self.maxRed || curGreen > self.maxGreen || curBlue > self.maxBlue {
                    
                    illegalMove = true;
                    break;
                }
            }
            if !illegalMove {
                //io:println(string `plus ${i} => ${sum + i}`);
                sum += i;
            }
            i += 1;
        }
        return sum;
    }

    public function part2() returns int|error {
        int sum = 0;
        foreach var line in check io:fileReadLines("inputs/day02.txt") {
            var illegalMove = false;
            var maxRed = 0;
            var maxBlue = 0;
            var maxGreen = 0;
            foreach var hand in regex:split(regex:split(line, ": ")[1], "; ") {
                var curRed = 0;
                var curGreen = 0;
                var curBlue = 0;
                foreach var pair in regex:split(hand, ", ") {
                    var color = regex:split(pair, " ");
                    match color[1] {
                        "blue" => {
                            curBlue += check int:fromString(color[0]);
                        }
                        "red" => {
                            curRed += check int:fromString(color[0]);
                        }
                        "green" => {
                            curGreen += check int:fromString(color[0]);
                        }
                    }
                }
                maxRed = int:max(maxRed, curRed);
                maxBlue = int:max(maxBlue, curBlue);
                maxGreen = int:max(maxGreen, curGreen);
            }
            if !illegalMove {
                io:println(string `${maxRed} ${maxBlue} ${maxGreen}`);
                sum += maxRed * maxBlue * maxGreen;
            }
        }
        return sum;
    }
}

