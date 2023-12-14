import ballerina/io;

public function main() returns error? {
    Day05 day = new ();
    var part1 = check day.part1();
    io:println(`Part 1: ${part1}`);
    var part2 = check day.part2();
    io:println(`Part 2: ${part2}`);
}
