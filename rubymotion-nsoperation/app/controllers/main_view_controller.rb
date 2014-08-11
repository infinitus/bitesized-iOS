class MainViewController < UIViewController

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor

    p "--------"
    p "Calculating 3x fib(35) synchronously in the main thread"
    start = NSDate.date
    p fib(35)
    p fib(35)
    p fib(35)
    stop_timer(start)

    NSThread.sleepForTimeInterval(1.0)
    
    p "--------"
    p "Calculating 3x fib(35) asynchronously in an NSOperationQueue"
    queue1 = NSOperationQueue.new
    sema = Dispatch::Semaphore.new(0)
    start = NSDate.date
    3.times do 
      queue1.addOperationWithBlock( -> { p fib(35); sema.signal })
    end
    3.times do
      sema.wait
    end
    stop_timer(start)

    NSThread.sleepForTimeInterval(1.0)

    p "--------"
    p "Calculating 3x fib(35) asynchronously in 3 separate NSOperationQueues"
    queue1 = NSOperationQueue.new
    queue2 = NSOperationQueue.new
    queue3 = NSOperationQueue.new
    sema = Dispatch::Semaphore.new(0)
    start = NSDate.date
    queue1.addOperationWithBlock( -> { p fib(35); sema.signal })
    queue2.addOperationWithBlock( -> { p fib(35); sema.signal })
    queue3.addOperationWithBlock( -> { p fib(35); sema.signal })
    3.times do
      sema.wait
    end
    stop_timer(start)

  end

  def stop_timer(start_time)
    single_thread_stop = NSDate.date
    execution_time = single_thread_stop.timeIntervalSinceDate(start_time)
    p "Execution time for thread: #{execution_time}"
  end

  def fib(n)
    if n < 2
      n
    else
      fib(n - 1) + fib(n - 2)
    end
  end

end
