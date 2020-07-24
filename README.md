# Brainfuck Language Interpreter in Lua

Brainfuck is an esoteric language. A strangely simple esoteric language. That means it's not really useful for day-to-day challenges, but for having fun with building a very simple compiler/interpreter.

Brainfuck works much like a Turing Machine: a (nearly infinite) tape, a head, and a state register. Plus input and output operators and loops. To read more about brainfuck, check out its article on Esolang [here](https://esolangs.org/wiki/Brainfuck)!

I chose Lua mainly because it handles hash tables natively, which really helps the compiler scalability. Plus Lua is really lightweight, unlike Python.

## Running

Simply run the lua script on your terminal...

```bash
lua bf.lua
```

...and type/paste the brainfuck code and then escape input (Ctrl+D on Unix, Ctrl+Z on Windows).
...if requested input, type and escape ever after each character. Cease input by escaping twice.

Here is a demo of the interpreter running [this script](http://www.hevanet.com/cristofd/brainfuck/wc.b) by [daniel b cristofani](http://www.hevanet.com/cristofd/brainfuck/), which counts lines, words and bytes of input:

```
>>>+>>>>>+>>+>>+[<<],[
    -[-[-[-[-[-[-[-[<+>-[>+<-[>-<-[-[-[<++[<++++++>-]<
        [>>[-<]<[>]<-]>>[<+>-[<->[-]]]]]]]]]]]]]]]]
    <[-<<[-]+>]<<[>>>>>>+<<<<<<-]>[>]>>>>>>>+>[
        <+[
            >+++++++++<-[>-<-]++>[<+++++++>-[<->-]+[+>>>>>>]]
            <[>+<-]>[>>>>>++>[-]]+<
        ]>[-<<<<<<]>>>>
    ],
]+<++>>>[[+++++>>>>>>]<+>+[[<++++++++>-]<.<<<<<]>>>>>>>>]
i would like a cup of tea	0	7	25
```
