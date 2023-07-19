# DebugLogger-Swift
A builder pattern based logger that makes logging complex data look beautiful
- Better syntaxing support for multiline and objects-based logging
- Forget `print` / `debugPrint` for logging
- Adds timestamps to logs
- Adds future support for swift’s new Logger API, this will also make logs compatible with Xcode 16’s new logging UI.

## USAGE
Suppose you want print log that looks like:
```
// Attempt failed, something went wrong.
//  ERROR:
//            ArrayIndexOutOfBoundsError - index: 18, size 15
```

Previously you would have written something like:
```
DebugLogger.log(text: "Attempt failed, something went wrong. \n ERROR: \n \t\t \(error.localizedDescription)")
```

This obviously looks ugly, so here is a new and improved way of doing it:
```
DebugLogger.prepare()
           .words("Attempt failed, something went wrong.")
           .newLine("Error:")
           .lineBreak()
           .tabSpaces(2)
           .words(describing: error)
           .submit()
            
 // OR if you prefer more readability
 
 DebugLogger.prepare()
            .words("Attempt failed, something went wrong.")
            .newLine("Error:")
            .lineBreak().tabSpaces(2).words(describing: error)
            .submit()
```

## HOW IT WORKS?
A call to `DebugLogger.prepare()` will create a `DebugLoggable`, which is nothing but a empty string, and then we will use [builder pattern](https://www.swiftbysundell.com/articles/using-the-builder-pattern-in-swift/) to step by step add things to this loggable, then finally we call `.submit()` to log the entire accumulated log string.

- Notice that, logger now supports logging Errors, value types & Objects directly without explicit string interpolation. This is achieved by adding support from protocols `StringInterpolationProtocol`, `CustomDebugStringConvertible`, `CustomStringConvertible` etc. so now its as easy as:
```
DebugLogger.prepare()
          .words(describing: error)     /// error: Error / NSError
          .submit()

DebugLogger.prepare()
          .words(describing: viewModel) /// viewModel: conforms to `CustomDebugStringConvertible`
          .submit()

DebugLogger.prepare()
          .words(describing: userList)  /// userList: is array hence comforms to `CustomDebugStringConvertible`
          .submit()
```


- Advanced scenario where new logger setup helps:
Imagine a complex method where you go through 'n' different steps and phases, they can be async as well, what if you wanted to log entire execution flow of then method at once while collecting critical info from various parts of the code, new logging setup will give you an ability collect the logs in one place through the method life cycle and the finally submit the entire thing to console at once. eg:

```
func someBigMethod() {
    var loggable = DebugLogger.prepare()
                      .words("Preparing for plan")
    if ... {
        loggable = loggable.newLine("Using Pan A")
    } else {
        loggable = loggable.newLine("Using Plan B instead")
    }
    
    someAyncExecutePlanMethod { result, error in
        loggable = loggable.lineBreaks(2)

        if let result {
            loggable = loggable
                .newLine("Plan success:")
                .words(describing: result)
        } else if let error {
            loggable = loggable
                .newLine("Plan failed:")
                .words(describing: error)
        } else {
          loggable = loggable
              .newLine("Unexpected bug")
        }

        loggable.submit()
    }
}
```
