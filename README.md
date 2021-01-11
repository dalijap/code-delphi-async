# Code examples from Delphi Event-based and Asynchronous Programming Book

[https://dalija.prasnikar.info/delphiebap/](https://dalija.prasnikar.info/delphiebap/)

[https://dalija.prasnikar.info](https://dalija.prasnikar.info)


## Part 1. The Loop

### Chapter 1. Hidden complexity
 
  + ConHelloWorld.dpr  
  + HelloWorld.dpr

### Chapter 2. Peeking at the console

  + ConSumParams.dpr
  + ConSumRead.dpr
  + ConSumLoop.dpr


## Part 2. Messaging Systems

### Chapter 7. Windows Messaging System
  
  + 7.1 Windows Message Queue 
    - WinApp.dpr

### Chapter 8. Windows Messaging System in VCL

  + 8.2 Window for non-visual components
    - GearApp.dpr
    - GearU.pas
    - GearMainF.pas
    - GearMainF.dfm

### Chapter 10. System.Messaging

  + MsgApp.dpr
  + MsgMainF.pas
  + MsgMainF.dfm


## Part 3. Life, the Universe, and Everything

### Chapter 12. Automatic memory management and Chapter 14. Class helpers

  + XMLBuilderApp.dpr
  + XMLBuilderU.pas
  + XMLBuilderMainF.pas
  + XMLBuilderMainF.dfm
  + XMLBuilderIntfU.pas

### Chapter 13.6 Interfaces and generics

  + GenIntf.dpr

### Chapter 15. Anonymous methods and lambdas

  + 15.4 Anonymous method variable capture
    
    - AnonymousVar.dpr
    - AnonymousVarProc.dpr
    - AnonymousVarProc2.dpr
    - Anonymous1.dpr
    - Anonymous2.dpr
    - Anonymous3.dpr
    - Anonymous4.dpr
    - Anonymous5.dpr
    - Anonymous6.dpr
    - Anonymous7.dpr
    - Anonymous8.dpr    

+ 15.5 Capturing and loops

  - CaptureLoops.dpr
  - CaptureLoopsCorrect.dpr
  - CaptureLoopsObject.dpr

+ 15.6 Anonymous method reference cycles

  - Cycle1.dpr
  - Cycle2.dpr
  - Cycle3.dpr
  - Cycle4.dpr   

+ 15.7 Using weak references to break anonymous method reference cycles

  - CycleWeak.dpr


## Part 4. Asynchronous Programming and Multithreading

### Chapter 16. Asynchronous programming and multithreading 

  + SynchronousApp.dpr
  + SynchronousMainF.pas
  + SynchronousMainF.dfm

### Chapter 19. Application.ProcessMessages reentrancy problem

  + ProcessMsgApp.dpr
  + ProcessMsgMainF.pas
  + ProcessMsgMainF.dfm

### Chapter 20. Moving long operations to a background thread

  + BackgroundApp.dpr
  + BackgroundMainF.pas
  + BackgroundMainF.dfm

### Chapter 21. Asynchronous message dialog

  + AsyncDlg.dpr
  + AsyncDlg.dproj
  + AsyncDlgMainF.pas
  + AsyncDlgMainF.fmx

### Chapter 22. Tasks

  + TasksApp.dpr
  + TasksMainF.pas
  + TasksMainF.dpr 

### Chapter 23. Back to the Future

  + FutureApp.dpr
  + FutureMainF.pas
  + FutureMainF.dfm

### Chapter 24. There is no Future like your own Future

  + 24.1 Generic approach to future

    - GenFutureApp.dpr
    - GenFutureMainF.pas
    - GenFutureMainF.dfm
    - NX.Core.pas
    - NX.GenFuture.pas

  + 24.2 TValue approach to future

    - ValueFutureApp.dpr
    - ValueFutureMainF.pas
    - ValueFutureMainF.dfm
    - NX.Future.pas


## Part 5. Thread Safety

### Chapter 25. What is thread safety anyway?

  + 25.2 Working example of thread-unsafe code

    - ThreadUnsafe.dpr

### Chapter 29. Use immutable data
    
  + Mutability.dpr

### Chapter 31. Initialization pattern

  + InitializationPattern.pas

### Chapter 32. Protecting shared data

  + 32.1 Synchronization primitives (objects)

    - UsingSyncObjs.pas
    - DeadlockApp.dpr
    - DeadlockMainF.pas
    - DeadlockMainF.dfm
  
  + 32.2 Thread synchronization

    - ThreadSyncApp.dpr
    - ThreadSyncMainF.pas
    - ThreadSyncMainF.dfm

  + 32.4 Events

    - EventsApp.dpr
    - EventsMainF.pas
    - EventsMainF.dfm
  
  
## Part 6. GUI and Multithreading

### Chapter 34. Communicating with the main thread

  + GUICommApp.dpr
  + GUICommMainF.pas
  + GUICommMainF.dfm
  + ProgressF.pas
  + ProgressF.dfm
  + ControlsF.pas
  + ControlsF.dfm
  + SpeedF.pas
  + SpeedF.dfm
  + MessagingF.pas
  + MessagingF.dfm

### Chapter 35. Communication and GUI issues  

  + 35.1 Deadlocking the main thread

    - GUIDeadlockApp.dpr
    - GUIDeadlockMainF.pas
    - GUIDeadlockMainF.dfm

  + 35.2 Cleanup on GUI destruction

    - GUICleanupApp.dpr
    - GUICleanupMainF.pas
    - GUICleanupMainF.dfm
    - DestroyF.pas
    - DestroyF.dfm
    - GuardianF.pas
    - GuardianF.dfm
    - WaitF.pas
    - WaitF.dfm
        

  