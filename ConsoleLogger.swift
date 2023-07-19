protocol ConsoleLogger {
    static func log(text: String)
}

/// Legacy logger for iOS 12 & 13
class LegacyConsoleLogger: ConsoleLogger {
    static func log(text: String) {
        NSLog(text)
    }
}

@available(iOS 14, *)
/// New swift logger, supports XCode 16's new logger UI
class ModernConsoleLogger: ConsoleLogger {
    private static let instance = ModernConsoleLogger()

    let logger: Logger
    
    private init() {
        logger = Logger()
    }
    
    static func log(text: String) {
        /// - Note Logger needs interpolated string to create `OSLogMessage` object
        instance.logger.log("\(text)")
    }
}
