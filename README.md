Profiler
========
Easy, targeted Ruby profiling

Overview
--------

Profiler lets you easily measure the time spent in specified code paths.

If a certain code path is taking some time, call `Profiler.start` before it, `Profiler.stop` after it, and `Profiler.check` at significant checkpoints throughout it. Profiler will print information about all of the edges (between the nodes that are specified by `Profiler.check`) that run:

```ruby
class MyClass
  def initialize
    Profiler.start
    do_something
    Profiler.stop
  end

  def do_something
    # ...
    Profiler.check
    # ...
    Profiler.check
    # ...
    100.times do
      Profiler.check
      # ...
    end
  end
end
```

```
Time      Calls Path
0.01509   1     my_class.rb:75:in `do_something' -> my_class.rb:84:in `block in do_something'
0.0126    100   my_class.rb:84:in `block in do_something' -> my_class.rb:84:in `block in do_something'
0.00027   1     my_class.rb:84:in `block in do_something' -> my_class.rb:111:in `do_something'
0.00015   1     my_class.rb:3:in `initialize' -> my_class.rb:62:in `do_something'
0.0001    1     my_class.rb:62:in `do_something' -> my_class.rb:75:in `do_something'
5.0e-05   1      -> my_class.rb:3:in `initialize'
Total time: 0.028271198272705078
```

Installation
------------

Add Profiler to your Gemfile:

```ruby
gem 'profiler'
```

License
-------

Profiler is released under the MIT License. Please see the MIT-LICENSE file for details.
