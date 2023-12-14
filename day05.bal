import ballerina/io;

class Day05 {

    public function part1() returns int|error {
        var input = re `\n\n`.split(check io:fileReadString("inputs/day05.txt"));
        var seeds = self.parseNumbers(re `: `.split(input[0])[1]);

        var maps = input.slice(1, input.length()).map(
            m => re `:\n`.split(m)[1] //remove ... map:
        ).map(m =>
            re `\n`.split(m).map(l => self.parseNumbers(l)) // parse to numbers
        );

        seeds = seeds.map(function(int seed) returns int {
            int current = seed;
            foreach var mappings in maps {
                foreach var mapping in mappings {
                    if current >= mapping[1] && current < mapping[1] + mapping[2] {
                        current = mapping[0] + (current - mapping[1]);
                        break;
                    }
                }
            }
            return current;
        });

        return int:min(seeds[0], ...seeds);
    }

    private function parseNumbers(string input) returns int[] {
        return (re ` +`.split(input.trim())).map(n => checkpanic int:fromString(n));
    }

    public function part2() returns int|error {
        var input = re `\n\n`.split(check io:fileReadString("inputs/day05.txt"));
        var seeds = self.parseNumbers(re `: `.split(input[0])[1]);

        var maps = input.slice(1, input.length()).map(
            m => re `:\n`.split(m)[1] //remove ... map:
        ).map(m =>
            re `\n`.split(m).map(l => self.parseNumbers(l)) // parse to numbers
        );

        seeds = seeds.map(function(int seed) returns int {
            int current = seed;
            foreach var mappings in maps {
                foreach var mapping in mappings {
                    if current >= mapping[1] && current < mapping[1] + mapping[2] {
                        current = mapping[0] + (current - mapping[1]);
                        break;
                    }
                }
            }
            return current;
        });

        return int:min(seeds[0], ...seeds);
    }
}
