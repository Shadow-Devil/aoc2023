import ballerina/io;

class Day04 {

    public function part1() returns int|error {
        int sum = 0;
        foreach var input in check io:fileReadLines("inputs/day04.txt") {
            var x = re `\|`.split(input);
            var winningNumbers = self.parseNumbers(re `:`.split(x[0])[1]);
            var myNumbers = self.parseNumbers(x[1]);
            var y = from var num in myNumbers
                where winningNumbers.indexOf(num) !is ()
                select num;

            sum += y.length() == 0 ? 0 : <int>(2f.pow(<float>y.length() - 1));
        }
        return sum;
    }

    private function parseNumbers(string input) returns int[] {

        return (re ` +`.split(input.trim())).map(n => checkpanic int:fromString(n));
    }

    public function part2() returns int|error {
        int sum = 0;
        int[] helper = [];
        foreach var input in check io:fileReadLines("inputs/day04.txt") {
            var x = re `\|`.split(input);
            var winningNumbers = self.parseNumbers(re `:`.split(x[0])[1]);
            var myNumbers = self.parseNumbers(x[1]);
            var winning = from var num in myNumbers
                where winningNumbers.indexOf(num) !is ()
                select num;
            sum += 1 + helper.length();
            helper = helper.map(n => n - 1);

            foreach int i in 0 ... helper.length() {
                helper.push(winning.length());
            }
            helper = helper.filter(n => n > 0);
        }
        return sum;
    }
}
