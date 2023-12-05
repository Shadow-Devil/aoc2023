import ballerina/lang.regexp;
import ballerina/io;

var namesToNums = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];


class Day01 {
    public function part1() returns int|error {
        var sum = 0;
        foreach var line in check io:fileReadLines("inputs/day01.txt") {
            string nums = from string char in line where int:fromString(char) !is error select char;
            //io:println(nums);
            sum += check int:fromString(nums[0] + nums[nums.length() - 1]);
        }
        return sum;
    }

    public function part2() returns int|error {
        var sum = 0;
        foreach var line in check io:fileReadLines("inputs/day01.txt") {
            var l = line;
            boolean allreplaced = false;
            while !allreplaced {
                var startingpoints = from var name in namesToNums.enumerate()
                                    where l.indexOf(name[1]) !is () 
                                    order by l.indexOf(name[1])
                                    select name;
                
                if startingpoints.length() != 0 {
                    //io:println("Replacing ", startingpoints[0], " in ", l);
                    l = startingpoints[0][1][0] + 
                        (check regexp:fromString(startingpoints[0][1])).replace(l, string `${startingpoints[0][0] + 1}` + startingpoints[0][1][startingpoints[0][1].length() - 1]);
                } else {
                    allreplaced = true;
                }
            }

            string nums = from string char in l where int:fromString(char) !is error select char;

            //io:println(nums);
            sum += check int:fromString(nums[0] + nums[nums.length() - 1]);
        }
        return sum;
    }    
}
