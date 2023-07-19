//
//  DebugLogger.swift
//
//  Created by Shreyash Shah on 19/07/23.
//  GPL-3.0 license
//

import Foundation

final class DebugLogger {
    
    static func log(text: String) {
        #if DEBUG
        if #available(iOS 14, *) {
            ModernConsoleLogger.log(text: text)
        } else {
            LegacyConsoleLogger.log(text: text)
        }
        #endif
    }
    
    /**
     Creates a empty Loggable, you can then add words, lines to this stepwise to build complete string block to log all at once

     - returns: Empty Loggable

     # Notes: #
     1. Any Loggable won't be logged unless you explicitly call `submit()` on it

     # Example #
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
     # Output #
     ```
     Attempt failed, something went wrong.
     ERROR:
            ArrayIndexOutOfBoundsError - index: 18, size 15
     ```
    */
    static func prepare() -> DebugLoggable {
        return EmptyLog()
    }
}
