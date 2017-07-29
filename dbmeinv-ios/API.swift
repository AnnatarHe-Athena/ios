//  This file was automatically generated and should not be edited.

import Apollo

public final class HelloQuery: GraphQLQuery {
  public static let operationString =
    "query hello {" +
    "  hello" +
    "}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootQueryType"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("hello", type: .scalar(String.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(hello: String? = nil) {
      self.init(snapshot: ["__typename": "RootQueryType", "hello": hello])
    }

    public var hello: String? {
      get {
        return snapshot["hello"]! as! String?
      }
      set {
        snapshot.updateValue(newValue, forKey: "hello")
      }
    }
  }
}