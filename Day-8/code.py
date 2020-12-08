#!/usr/bin/env python3
# Advent of Code 2020 Solution - Python


class HandheldHalting(object):
    def __init__(self, instructions):
        self.instructions = instructions
        self.pc = 0
        self.accumulator = 0

    def run_one_instruction(self):
        if not (0 <= self.pc < len(self.instructions)):
            raise IndexError("pc out of range of instructions", self.pc)

        inst = self.instructions[self.pc]

        if inst[0] == 'acc':
            self.accumulator += inst[1]
        elif inst[0] == 'jmp':
            self.pc += inst[1] - 1
        elif inst[0] == 'nop':
            pass
        else:
            raise RuntimeError("Unknown instruction", inst)

        self.pc += 1


if __name__ == '__main__':
    with open("input", "r") as input_file:
        instructions = input_file.read().split('\n')
    instructions.pop()

    code = []
    for line in instructions:
        inst, inst_arg = line.split(" ")
        code.append([inst, int(inst_arg)])

    # Part 1
    computer = HandheldHalting(code)
    seen_pc = set()

    while computer.pc not in seen_pc:
        seen_pc.add(computer.pc)
        computer.run_one_instruction()

    print(f"Answer to part 1: {computer.accumulator}")

    del seen_pc
    del computer

    # Part 2
    # Assumption - The current code in "code" never halts
    for possible_change in range(len(code)):
        new_code = [inst.copy() for inst in code]
        inst = new_code[possible_change][0]
        if inst == 'jmp':
            new_code[possible_change] = ['nop'] + new_code[possible_change][1:]
        elif inst == 'nop':
            new_code[possible_change] = ['jmp'] + new_code[possible_change][1:]
        else:
            # No instruction was changed, from our assumption
            # The code doesn't halt
            continue

        computer = HandheldHalting(new_code)
        seen_pc = set()

        while computer.pc not in seen_pc:
            seen_pc.add(computer.pc)
            try:
                computer.run_one_instruction()
            except IndexError as e:
                # No more code to run, meaning we reached the end
                break

        if computer.pc == len(computer.instructions):
            print(f"Answer to part 2: {computer.accumulator}")
