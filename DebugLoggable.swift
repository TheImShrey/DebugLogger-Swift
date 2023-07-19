protocol DebugLoggable {
    var stringRepresentation: String { get }
}

struct EmptyLog: DebugLoggable {
    var stringRepresentation: String {
        ""
    }
}

struct OneSpace: DebugLoggable {
    var stringRepresentation: String {
        " "
    }
}

struct NewLine: DebugLoggable {
    var stringRepresentation: String {
        "\n"
    }
}

struct TabSpace: DebugLoggable {
    var stringRepresentation: String {
       "\t"
    }
}

extension String: DebugLoggable {
    var stringRepresentation: String {
        self
    }
}
