import ballerina/io;

public function main() returns error? {
    Day02 day = new();
    int part1 = check day.part1();
    io:println(`Part 1: ${part1}`);
    int part2 = check day.part2();
    io:println(`Part 2: ${part2}`);
}