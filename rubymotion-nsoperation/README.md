rubymotion-nsoperation
======================

This is an experiment dealing with NSOperationQueue and Semaphores, mostly for
self-learning how multi-threading works in iOS 

There are three tests in viewDidLoad

1) fibonacci(35) is calculated 3 times, synchronously, in the main thread. 
2) fibonacci(35) is calculated 3 times, asynchronously, by adding it 3 times
into a NSOperationQueue.
3) fibonacci(35) is calculated 3 times, asynchronously, by adding it to three
different NSOperationQueues.

Here's the trace from Instruments:

![Imgur](http://i.imgur.com/QvVvILi.png)

![Imgur](http://i.imgur.com/tmu8AUf.png)

The first test performed as expected, clocking in at slightly over 11.1
seconds.

![Imgur](http://i.imgur.com/Lzh4UY9.png)

The second test, being asynchronous, completed in 6.5 seconds. The three method
calls are split into three separate threads, chugging along by themselves. This
resulted with a performance improvement of 1.7x.

![Imgur](http://i.imgur.com/hH1k3oD.png)

The third test, to my surprise, completed in about the same amount of time as the
second test. To be exact, the three threads were exactly the same as the ones
used in the second test, hence there is no advantage in using multiple 
NSOperationQueues.
