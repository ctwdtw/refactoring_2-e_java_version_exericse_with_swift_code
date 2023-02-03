@main
public struct refactoring_java_ed {
    public private(set) var text = "Hello, World!"
    public init(text: String = "Hello, World!") {
        self.text = text
    }
    public static func main() {
        print(refactoring_java_ed().text)
    }
}



