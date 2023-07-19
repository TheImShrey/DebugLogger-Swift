extension DebugLoggable {
    
    /// Adds given text after existing loggable contents
    /// - Parameter text: New text contents to be added
    /// - Returns: A loggable by appending the text
    /// - Note Both loggables are joined with " " by default
    func words(_ text: String) -> DebugLoggable {
        return self.stringRepresentation + OneSpace().stringRepresentation + text
    }
    
    /// Adds given error object's `localizedDescription` after existing loggable contents
    /// - Parameter error: Error object to be added to the existing loggable
    /// - Returns: A loggable by appending the error
    /// - Note Both loggables are joined with " " by default
    func words(describing error: Error) -> DebugLoggable {
        return self.stringRepresentation + OneSpace().stringRepresentation + error.localizedDescription
    }
    
    /// Adds given error object's `localizedDescription` after existing loggable contents
    /// - Parameter error: Error object to be added to the existing loggable
    /// - Returns: A loggable by appending the error
    /// - Note Both loggables are joined with " " by default
    func words(describing error: NSError) -> DebugLoggable {
        return self.stringRepresentation + OneSpace().stringRepresentation + error.localizedDescription
    }
    
    /// Adds given object's `description` after existing loggable contents
    /// - Parameter object: an object to be added to the existing loggable
    /// - Returns: A loggable by appending the object
    /// - Note Both loggables are joined with " " by default
    func words(describing object: CustomStringConvertible) -> DebugLoggable {
        return self.stringRepresentation + OneSpace().stringRepresentation + object.description
    }
    
    /// Adds given object's `debugDescription` after existing loggable contents
    /// - Parameter object: an object to be added to the existing loggable
    /// - Returns: A loggable by appending the object
    /// - Note Both loggables are joined with " " by default
    func words(describing object: CustomStringConvertible & CustomDebugStringConvertible) -> DebugLoggable {
        return self.stringRepresentation + OneSpace().stringRepresentation + object.debugDescription
    }
    
    /// Adds given object's `debugDescription` after existing loggable contents
    /// - Parameter object: an object to be added to the existing loggable
    /// - Returns: A loggable by appending the object
    /// - Note Both loggables are joined with " " by default
    func words(describing object: CustomDebugStringConvertible) -> DebugLoggable {
        return self.stringRepresentation + OneSpace().stringRepresentation + object.debugDescription
    }
    
    /// Adds given object's string interpolation after existing loggable contents
    /// - Parameter object: an object to be added to the existing loggable
    /// - Returns: A loggable by appending the object
    /// - Note Both loggables are joined with " " by default
    func words(describing object: any StringInterpolationProtocol) -> DebugLoggable {
        return self.stringRepresentation + OneSpace().stringRepresentation + "\(object)"
    }
    
    /// Adds given text on new line after existing loggable contents
    /// - Parameter text: New text contents to be added
    /// - Returns: A loggable representing both
    func newLine(_ text: String) -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation + text
    }
    
    /// Adds given error object's `localizedDescription` on new line after existing loggable contents
    /// - Parameter error: Error object to be added
    /// - Returns: A loggable  representing both
    func newLine(describing error: Error) -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation + error.localizedDescription
    }
    
    /// Adds given error object's `localizedDescription` on new line after existing loggable contents
    /// - Parameter error: Error object to be added
    /// - Returns: A loggable  representing both
    func newLine(describing error: NSError) -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation + error.localizedDescription
    }
    
    /// Adds given object's `description`  on new line after existing loggable contents
    /// - Parameter object: an object to be added
    /// - Returns: A loggable representing both
    func newLine(describing object: CustomStringConvertible) -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation + object.description
    }
    
    /// Adds given object's `debugDescription`  on new line after existing loggable contents
    /// - Parameter object: an object to be added
    /// - Returns: A loggable representing both
    func newLine(describing object: CustomDebugStringConvertible) -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation + object.debugDescription
    }
    
    /// Adds given object's `debugDescription`  on new line after existing loggable contents
    /// - Parameter object: an object to be added
    /// - Returns: A loggable representing both
    func newLine(describing object: CustomDebugStringConvertible & CustomStringConvertible) -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation + object.debugDescription
    }
    
    /// Adds given object's string interpolation on new line  after existing loggable contents
    /// - Parameter object: an object to be added
    /// - Returns: A loggable representing both
    func newLine(describing object: any StringInterpolationProtocol) -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation + "\(object)"
    }
    
    /// Adds a single empty new line `\n` after existing loggable
    /// - Returns: A loggable representing both
    /// - Note: This mostly used for adding empty line around some text in order to make it less cluttered wrt other logs
    func lineBreak() -> DebugLoggable {
        return self.stringRepresentation + NewLine().stringRepresentation
    }
    
    /// Adds a single empty tab space `\t` after existing loggable
    /// - Returns: A loggable representing both
    /// - Note: This mostly used for adding spacing
    func tabSpace() -> DebugLoggable {
        return self.stringRepresentation + TabSpace().stringRepresentation
    }
    
    /// Adds a multiple empty new line `\n` after existing loggable
    /// - Parameter count: number of new lines to be added
    /// - Returns: A loggable representing both
    /// - Note: This mostly used for adding empty line around some text in order to make it less cluttered wrt other logs
    func lineBreaks(_ count: Int) -> DebugLoggable {
        return (0..<count).reduce(self.stringRepresentation) { partialResult, _ in
            partialResult.lineBreak()
        }
    }
    
    /// Adds a multiple empty tab space `\t` after existing loggable
    /// - Parameter count: number of tab spaces to be added
    /// - Returns: A loggable representing both
    /// - Note: This mostly used for adding spacing
    func tabSpaces(_ count: Int) -> DebugLoggable {
        return (0..<count).reduce(self) { partialResult, _ in
            partialResult.tabSpace()
        }
    }
    
    /// Calling this method will finally submit the accumulated Loggable to `DebugLogger` to be written to the console
    /// - Note: This method is necessary for logs to be shown on the console, without a call to this Loggable will simply stay dormant
    func submit() {
        DebugLogger.log(text: self.stringRepresentation)
    }
}
