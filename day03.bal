import ballerina/io;
import ballerina/regex;

class Day03 {
    final string[] noSymbols = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."];

    public function part1() returns int|error {
        int sum = 0;
        var input = check io:fileReadLines("inputs/day03.txt");
        var validNumber = false;
        var number = 0;
        foreach [int, string] [y, line] in input.enumerate() {
            foreach [int, string] pair in regex:split(line, "").enumerate() {
                if self.isNumber(pair[1]) {
                    if validNumber {
                        number *= 10;
                        number += check int:fromString(pair[1]);
                        continue;
                    }
                    foreach int i in -1 ... 1 {
                        foreach int j in -1 ... 1 {
                            int y1 = y + i;
                            int x1 = pair[0] + j;
                            if (y1 >= 0 && x1 >= 0 && x1 < line.length() && y1 < input.length() && self.isSymbol(input[y1][x1])) {
                                validNumber = true;
                                break;
                            }
                        }
                        if validNumber {
                            break;
                        }
                    }
                    number *= 10;
                    number += check int:fromString(pair[1]);
                } else {
                    if validNumber {
                        //io:println("Adding ", number);
                        sum += 1;
                    }
                    number = 0;
                    validNumber = false;
                }
            }
        }

        return sum;
    }

    function isNumber(string char) returns boolean {
        return char != "." && char != "\n" && !self.isSymbol(char);
    }

    function isSymbol(string char) returns boolean {
        return self.noSymbols.every(other => other != char);
    }

    public function part2() returns int|error {
        //first find all symbols
        var input = check io:fileReadLines("inputs/day03.txt");
        [int, int][] gears = [];
        foreach [int, string] [y, line] in input.enumerate() {
            foreach [int, string] pair in regex:split(line, "").enumerate() {
                if pair[1] == "*" {
                    int adjacent = 0;
                    foreach int i in -1 ... 1 {
                        boolean nextToEachOther = false;
                        foreach int j in -1 ... 1 {
                            int y1 = y + i;
                            int x1 = pair[0] + j;
                            if (y1 >= 0 && x1 >= 0 && x1 < line.length() && y1 < input.length()) {
                                if self.isNumber(input[y1][x1]) {
                                    if !nextToEachOther {
                                        adjacent += 1;
                                        nextToEachOther = true;
                                    }
                                } else {
                                    nextToEachOther = false;
                                }
                            }

                        }
                    }
                    if adjacent == 2 {
                        gears.push([y, pair[0]]);
                    }
                }
            }
        }
        io:println(gears);
        var validNumber = false;
        var number = 0;
        map<int[]> numbersAtGear = map from [int, int] g in gears
            select [string `${g[0]} ${g[1]}`, []];

        [int, int][] currentGears = [];
        //then go through it again
        foreach [int, string] [y, line] in input.enumerate() {
            foreach [int, string] pair in regex:split(line, "").enumerate() {
                //io:println("Reading: ", pair[1]);
                if self.isNumber(pair[1]) {
                    if validNumber {
                        number *= 10;
                        number += check int:fromString(pair[1]);
                        continue;
                    }
                    foreach int i in -1 ... 1 {
                        foreach int j in -1 ... 1 {
                            int y1 = y + i;
                            int x1 = pair[0] + j;
                            if (gears.some(g => g == [y1, x1])) {
                                validNumber = true;
                                currentGears.push([y1, x1]);
                                break;
                            }
                        }
                        if validNumber {
                            break;
                        }
                    }
                    number *= 10;
                    number += check int:fromString(pair[1]);
                } else {
                    if (validNumber) {
                        io:println("Adding ", number);
                        if currentGears.length() > 1 {
                            io:println("EDGE CASE", currentGears);
                        }
                        foreach var currentGear in currentGears {
                            numbersAtGear.get(string `${currentGear[0]} ${currentGear[1]}`).push(number);
                        }
                        currentGears = [];
                    }
                    number = 0;
                    validNumber = false;
                }
            }
            if (validNumber) {
                io:println("Adding ", number);
                foreach var currentGear in currentGears {
                    numbersAtGear.get(string `${currentGear[0]} ${currentGear[1]}`).push(number);
                }
                currentGears = [];
                number = 0;
                validNumber = false;
            }
        }
        io:println(numbersAtGear);

        return numbersAtGear.reduce(isolated function(int total, int[] numbers) returns int => total + (numbers[0] * numbers[1]), 0);
    }
}
