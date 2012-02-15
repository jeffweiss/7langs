fib := method(arg,
         if(arg <= 1, 
            1, 
            if(arg == 2, 
              1, 
              fib(arg-1)+fib(arg-2))))
writeln(fib(4))

fib_loop := method(arg,
     vals := list(1, 1)
     for(i, 3, arg,
       (vals prepend(vals sum)
       vals pop)
     )
     vals at(0)
)
writeln(fib_loop(6))

for(i, 1, 10, writeln(fib_loop(i)))
