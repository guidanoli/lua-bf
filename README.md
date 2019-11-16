# Brainfuck language compiler in Lua

Brainfuck is an esoteric language. A strangely simple esoteric language. That means it's not really useful for day-to-day challenges, but for having fun with building a very simple compiler.

Brainfuck works much like a Turing Machine: a (nearly infinite) tape, a head, and a state register. Plus input and output operators and loops. To read more about brainfuck, check out its article on Esolang [here](https://esolangs.org/wiki/Brainfuck)!

I chose Lua mainly because it handles arbitrary precision numbers, and hash tables natively, which really helps the compiler scalability. Plus Lua is really lightweight, unlike Python.
