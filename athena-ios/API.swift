//  This file was automatically generated and should not be edited.

import Apollo

public struct CellInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(fromId: Optional<String?> = nil, fromUrl: Optional<String?> = nil, img: Optional<String?> = nil, text: Optional<String?> = nil, cate: Optional<Int?> = nil, permission: Optional<Int?> = nil) {
    graphQLMap = ["fromID": fromId, "fromURL": fromUrl, "img": img, "text": text, "cate": cate, "permission": permission]
  }

  public var fromId: Optional<String?> {
    get {
      return graphQLMap["fromId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fromId")
    }
  }

  public var fromUrl: Optional<String?> {
    get {
      return graphQLMap["fromUrl"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fromUrl")
    }
  }

  public var img: Optional<String?> {
    get {
      return graphQLMap["img"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "img")
    }
  }

  public var text: Optional<String?> {
    get {
      return graphQLMap["text"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "text")
    }
  }

  public var cate: Optional<Int?> {
    get {
      return graphQLMap["cate"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "cate")
    }
  }

  public var permission: Optional<Int?> {
    get {
      return graphQLMap["permission"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "permission")
    }
  }
}

public final class InitCategoriesQuery: GraphQLQuery {
  public static let operationString =
    "query initCategories {\n  categories {\n    __typename\n    id\n    name\n    src\n    count\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("categories", type: .list(.object(Category.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(categories: [Category?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "categories": categories.flatMap { (value: [Category?]) -> [Snapshot?] in value.map { (value: Category?) -> Snapshot? in value.flatMap { (value: Category) -> Snapshot in value.snapshot } } }])
    }

    /// categories
    public var categories: [Category?]? {
      get {
        return (snapshot["categories"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Category?] in value.map { (value: Snapshot?) -> Category? in value.flatMap { (value: Snapshot) -> Category in Category(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Category?]) -> [Snapshot?] in value.map { (value: Category?) -> Snapshot? in value.flatMap { (value: Category) -> Snapshot in value.snapshot } } }, forKey: "categories")
      }
    }

    public struct Category: GraphQLSelectionSet {
      public static let possibleTypes = ["category"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("src", type: .scalar(Int.self)),
        GraphQLField("count", type: .scalar(Int.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, name: String? = nil, src: Int? = nil, count: Int? = nil) {
        self.init(snapshot: ["__typename": "category", "id": id, "name": name, "src": src, "count": count])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var src: Int? {
        get {
          return snapshot["src"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "src")
        }
      }

      public var count: Int? {
        get {
          return snapshot["count"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "count")
        }
      }
    }
  }
}

public final class FetchGirlsQueryQuery: GraphQLQuery {
  public static let operationString =
    "query fetchGirlsQuery($from: Int!, $take: Int!, $offset: Int!, $hideOnly: Boolean) {\n  girls(from: $from, take: $take, offset: $offset, hideOnly: $hideOnly) {\n    __typename\n    ...fetchGirls\n  }\n}"

  public static var requestString: String { return operationString.appending(FetchGirls.fragmentString) }

  public var from: Int
  public var take: Int
  public var offset: Int
  public var hideOnly: Bool?

  public init(from: Int, take: Int, offset: Int, hideOnly: Bool? = nil) {
    self.from = from
    self.take = take
    self.offset = offset
    self.hideOnly = hideOnly
  }

  public var variables: GraphQLMap? {
    return ["from": from, "take": take, "offset": offset, "hideOnly": hideOnly]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("girls", arguments: ["from": GraphQLVariable("from"), "take": GraphQLVariable("take"), "offset": GraphQLVariable("offset"), "hideOnly": GraphQLVariable("hideOnly")], type: .list(.object(Girl.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(girls: [Girl?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "girls": girls.flatMap { (value: [Girl?]) -> [Snapshot?] in value.map { (value: Girl?) -> Snapshot? in value.flatMap { (value: Girl) -> Snapshot in value.snapshot } } }])
    }

    /// girls
    public var girls: [Girl?]? {
      get {
        return (snapshot["girls"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Girl?] in value.map { (value: Snapshot?) -> Girl? in value.flatMap { (value: Snapshot) -> Girl in Girl(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Girl?]) -> [Snapshot?] in value.map { (value: Girl?) -> Snapshot? in value.flatMap { (value: Girl) -> Snapshot in value.snapshot } } }, forKey: "girls")
      }
    }

    public struct Girl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
        GraphQLField("permission", type: .scalar(Int.self)),
        GraphQLField("fromID", type: .scalar(String.self)),
        GraphQLField("fromURL", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var permission: Int? {
        get {
          return snapshot["permission"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "permission")
        }
      }

      public var fromId: String? {
        get {
          return snapshot["fromID"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromID")
        }
      }

      public var fromUrl: String? {
        get {
          return snapshot["fromURL"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromURL")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class InitialQuery: GraphQLQuery {
  public static let operationString =
    "query initial($from: Int!, $take: Int!, $offset: Int!) {\n  girls(from: $from, take: $take, offset: $offset) {\n    __typename\n    ...fetchGirls\n  }\n  categories {\n    __typename\n    ...fetchCategories\n  }\n}"

  public static var requestString: String { return operationString.appending(FetchGirls.fragmentString).appending(FetchCategories.fragmentString) }

  public var from: Int
  public var take: Int
  public var offset: Int

  public init(from: Int, take: Int, offset: Int) {
    self.from = from
    self.take = take
    self.offset = offset
  }

  public var variables: GraphQLMap? {
    return ["from": from, "take": take, "offset": offset]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("girls", arguments: ["from": GraphQLVariable("from"), "take": GraphQLVariable("take"), "offset": GraphQLVariable("offset")], type: .list(.object(Girl.selections))),
      GraphQLField("categories", type: .list(.object(Category.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(girls: [Girl?]? = nil, categories: [Category?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "girls": girls.flatMap { (value: [Girl?]) -> [Snapshot?] in value.map { (value: Girl?) -> Snapshot? in value.flatMap { (value: Girl) -> Snapshot in value.snapshot } } }, "categories": categories.flatMap { (value: [Category?]) -> [Snapshot?] in value.map { (value: Category?) -> Snapshot? in value.flatMap { (value: Category) -> Snapshot in value.snapshot } } }])
    }

    /// girls
    public var girls: [Girl?]? {
      get {
        return (snapshot["girls"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Girl?] in value.map { (value: Snapshot?) -> Girl? in value.flatMap { (value: Snapshot) -> Girl in Girl(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Girl?]) -> [Snapshot?] in value.map { (value: Girl?) -> Snapshot? in value.flatMap { (value: Girl) -> Snapshot in value.snapshot } } }, forKey: "girls")
      }
    }

    /// categories
    public var categories: [Category?]? {
      get {
        return (snapshot["categories"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Category?] in value.map { (value: Snapshot?) -> Category? in value.flatMap { (value: Snapshot) -> Category in Category(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Category?]) -> [Snapshot?] in value.map { (value: Category?) -> Snapshot? in value.flatMap { (value: Category) -> Snapshot in value.snapshot } } }, forKey: "categories")
      }
    }

    public struct Girl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
        GraphQLField("permission", type: .scalar(Int.self)),
        GraphQLField("fromID", type: .scalar(String.self)),
        GraphQLField("fromURL", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var permission: Int? {
        get {
          return snapshot["permission"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "permission")
        }
      }

      public var fromId: String? {
        get {
          return snapshot["fromID"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromID")
        }
      }

      public var fromUrl: String? {
        get {
          return snapshot["fromURL"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromURL")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }

    public struct Category: GraphQLSelectionSet {
      public static let possibleTypes = ["category"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("src", type: .scalar(Int.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, name: String? = nil, src: Int? = nil) {
        self.init(snapshot: ["__typename": "category", "id": id, "name": name, "src": src])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var src: Int? {
        get {
          return snapshot["src"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "src")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchCategories: FetchCategories {
          get {
            return FetchCategories(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class AddToCollectionMutation: GraphQLMutation {
  public static let operationString =
    "mutation addToCollection($cells: [Int]) {\n  addCollection(cells: $cells) {\n    __typename\n    isOk\n  }\n}"

  public var cells: [Int?]?

  public init(cells: [Int?]? = nil) {
    self.cells = cells
  }

  public var variables: GraphQLMap? {
    return ["cells": cells]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootMutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addCollection", arguments: ["cells": GraphQLVariable("cells")], type: .object(AddCollection.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addCollection: AddCollection? = nil) {
      self.init(snapshot: ["__typename": "RootMutation", "addCollection": addCollection.flatMap { (value: AddCollection) -> Snapshot in value.snapshot }])
    }

    /// add collection
    public var addCollection: AddCollection? {
      get {
        return (snapshot["addCollection"] as? Snapshot).flatMap { AddCollection(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "addCollection")
      }
    }

    public struct AddCollection: GraphQLSelectionSet {
      public static let possibleTypes = ["addCollectionReturnType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("isOk", type: .scalar(Bool.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(isOk: Bool? = nil) {
        self.init(snapshot: ["__typename": "addCollectionReturnType", "isOk": isOk])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var isOk: Bool? {
        get {
          return snapshot["isOk"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isOk")
        }
      }
    }
  }
}

public final class AddGirlCellsMutation: GraphQLMutation {
  public static let operationString =
    "mutation addGirlCells($cells: [CellInput]) {\n  addGirls(cells: $cells) {\n    __typename\n    ...fetchGirls\n  }\n}"

  public static var requestString: String { return operationString.appending(FetchGirls.fragmentString) }

  public var cells: [CellInput?]?

  public init(cells: [CellInput?]? = nil) {
    self.cells = cells
  }

  public var variables: GraphQLMap? {
    return ["cells": cells]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootMutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addGirls", arguments: ["cells": GraphQLVariable("cells")], type: .list(.object(AddGirl.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addGirls: [AddGirl?]? = nil) {
      self.init(snapshot: ["__typename": "RootMutation", "addGirls": addGirls.flatMap { (value: [AddGirl?]) -> [Snapshot?] in value.map { (value: AddGirl?) -> Snapshot? in value.flatMap { (value: AddGirl) -> Snapshot in value.snapshot } } }])
    }

    /// add some Girls
    public var addGirls: [AddGirl?]? {
      get {
        return (snapshot["addGirls"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [AddGirl?] in value.map { (value: Snapshot?) -> AddGirl? in value.flatMap { (value: Snapshot) -> AddGirl in AddGirl(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [AddGirl?]) -> [Snapshot?] in value.map { (value: AddGirl?) -> Snapshot? in value.flatMap { (value: AddGirl) -> Snapshot in value.snapshot } } }, forKey: "addGirls")
      }
    }

    public struct AddGirl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
        GraphQLField("permission", type: .scalar(Int.self)),
        GraphQLField("fromID", type: .scalar(String.self)),
        GraphQLField("fromURL", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var permission: Int? {
        get {
          return snapshot["permission"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "permission")
        }
      }

      public var fromId: String? {
        get {
          return snapshot["fromID"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromID")
        }
      }

      public var fromUrl: String? {
        get {
          return snapshot["fromURL"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromURL")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class RemoveGirlMutation: GraphQLMutation {
  public static let operationString =
    "mutation removeGirl($cells: [Int], $toRemove: Boolean) {\n  removeGirl(cells: $cells, toRemove: $toRemove) {\n    __typename\n    isOk\n  }\n}"

  public var cells: [Int?]?
  public var toRemove: Bool?

  public init(cells: [Int?]? = nil, toRemove: Bool? = nil) {
    self.cells = cells
    self.toRemove = toRemove
  }

  public var variables: GraphQLMap? {
    return ["cells": cells, "toRemove": toRemove]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootMutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("removeGirl", arguments: ["cells": GraphQLVariable("cells"), "toRemove": GraphQLVariable("toRemove")], type: .object(RemoveGirl.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(removeGirl: RemoveGirl? = nil) {
      self.init(snapshot: ["__typename": "RootMutation", "removeGirl": removeGirl.flatMap { (value: RemoveGirl) -> Snapshot in value.snapshot }])
    }

    /// remove girl cell
    public var removeGirl: RemoveGirl? {
      get {
        return (snapshot["removeGirl"] as? Snapshot).flatMap { RemoveGirl(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "removeGirl")
      }
    }

    public struct RemoveGirl: GraphQLSelectionSet {
      public static let possibleTypes = ["addCollectionReturnType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("isOk", type: .scalar(Bool.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(isOk: Bool? = nil) {
        self.init(snapshot: ["__typename": "addCollectionReturnType", "isOk": isOk])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var isOk: Bool? {
        get {
          return snapshot["isOk"] as? Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isOk")
        }
      }
    }
  }
}

public final class AuthQuery: GraphQLQuery {
  public static let operationString =
    "query auth($email: String!, $password: String!) {\n  auth(email: $email, password: $password) {\n    __typename\n    token\n    id\n  }\n}"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("auth", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(Auth.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(auth: Auth? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "auth": auth.flatMap { (value: Auth) -> Snapshot in value.snapshot }])
    }

    /// user auth by email and password
    public var auth: Auth? {
      get {
        return (snapshot["auth"] as? Snapshot).flatMap { Auth(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "auth")
      }
    }

    public struct Auth: GraphQLSelectionSet {
      public static let possibleTypes = ["auth"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .scalar(String.self)),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(token: String? = nil, id: GraphQLID? = nil) {
        self.init(snapshot: ["__typename": "auth", "token": token, "id": id])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String? {
        get {
          return snapshot["token"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "token")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class FetchCollectionsQuery: GraphQLQuery {
  public static let operationString =
    "query FetchCollections($id: Int!, $from: Int!, $size: Int!) {\n  collections(id: $id, from: $from, size: $size) {\n    __typename\n    ...fetchGirls\n  }\n}"

  public static var requestString: String { return operationString.appending(FetchGirls.fragmentString) }

  public var id: Int
  public var from: Int
  public var size: Int

  public init(id: Int, from: Int, size: Int) {
    self.id = id
    self.from = from
    self.size = size
  }

  public var variables: GraphQLMap? {
    return ["id": id, "from": from, "size": size]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("collections", arguments: ["id": GraphQLVariable("id"), "from": GraphQLVariable("from"), "size": GraphQLVariable("size")], type: .list(.object(Collection.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(collections: [Collection?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "collections": collections.flatMap { (value: [Collection?]) -> [Snapshot?] in value.map { (value: Collection?) -> Snapshot? in value.flatMap { (value: Collection) -> Snapshot in value.snapshot } } }])
    }

    /// collections
    public var collections: [Collection?]? {
      get {
        return (snapshot["collections"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Collection?] in value.map { (value: Snapshot?) -> Collection? in value.flatMap { (value: Snapshot) -> Collection in Collection(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Collection?]) -> [Snapshot?] in value.map { (value: Collection?) -> Snapshot? in value.flatMap { (value: Collection) -> Snapshot in value.snapshot } } }, forKey: "collections")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
        GraphQLField("permission", type: .scalar(Int.self)),
        GraphQLField("fromID", type: .scalar(String.self)),
        GraphQLField("fromURL", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var permission: Int? {
        get {
          return snapshot["permission"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "permission")
        }
      }

      public var fromId: String? {
        get {
          return snapshot["fromID"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromID")
        }
      }

      public var fromUrl: String? {
        get {
          return snapshot["fromURL"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromURL")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public final class InfoQuery: GraphQLQuery {
  public static let operationString =
    "query info {\n  info {\n    __typename\n    userCount\n    cellCount\n    fee\n    email\n    copyright\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("info", type: .object(Info.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(info: Info? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "info": info.flatMap { (value: Info) -> Snapshot in value.snapshot }])
    }

    /// infomations
    public var info: Info? {
      get {
        return (snapshot["info"] as? Snapshot).flatMap { Info(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "info")
      }
    }

    public struct Info: GraphQLSelectionSet {
      public static let possibleTypes = ["info"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("userCount", type: .scalar(Int.self)),
        GraphQLField("cellCount", type: .scalar(Int.self)),
        GraphQLField("fee", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("copyright", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(userCount: Int? = nil, cellCount: Int? = nil, fee: String? = nil, email: String? = nil, copyright: String? = nil) {
        self.init(snapshot: ["__typename": "info", "userCount": userCount, "cellCount": cellCount, "fee": fee, "email": email, "copyright": copyright])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userCount: Int? {
        get {
          return snapshot["userCount"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "userCount")
        }
      }

      public var cellCount: Int? {
        get {
          return snapshot["cellCount"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "cellCount")
        }
      }

      public var fee: String? {
        get {
          return snapshot["fee"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fee")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      public var copyright: String? {
        get {
          return snapshot["copyright"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "copyright")
        }
      }
    }
  }
}

public final class FetchProfileWithCollectionsQuery: GraphQLQuery {
  public static let operationString =
    "query FetchProfileWithCollections($id: Int!, $from: Int!, $size: Int!) {\n  users(id: $id) {\n    __typename\n    id\n    email\n    name\n    pwd\n    avatar\n    bio\n    token\n    role\n  }\n  collections(id: $id, from: $from, size: $size) {\n    __typename\n    ...fetchGirls\n  }\n}"

  public static var requestString: String { return operationString.appending(FetchGirls.fragmentString) }

  public var id: Int
  public var from: Int
  public var size: Int

  public init(id: Int, from: Int, size: Int) {
    self.id = id
    self.from = from
    self.size = size
  }

  public var variables: GraphQLMap? {
    return ["id": id, "from": from, "size": size]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", arguments: ["id": GraphQLVariable("id")], type: .object(User.selections)),
      GraphQLField("collections", arguments: ["id": GraphQLVariable("id"), "from": GraphQLVariable("from"), "size": GraphQLVariable("size")], type: .list(.object(Collection.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(users: User? = nil, collections: [Collection?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "users": users.flatMap { (value: User) -> Snapshot in value.snapshot }, "collections": collections.flatMap { (value: [Collection?]) -> [Snapshot?] in value.map { (value: Collection?) -> Snapshot? in value.flatMap { (value: Collection) -> Snapshot in value.snapshot } } }])
    }

    /// a user
    public var users: User? {
      get {
        return (snapshot["users"] as? Snapshot).flatMap { User(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "users")
      }
    }

    /// collections
    public var collections: [Collection?]? {
      get {
        return (snapshot["collections"] as? [Snapshot?]).flatMap { (value: [Snapshot?]) -> [Collection?] in value.map { (value: Snapshot?) -> Collection? in value.flatMap { (value: Snapshot) -> Collection in Collection(snapshot: value) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { (value: [Collection?]) -> [Snapshot?] in value.map { (value: Collection?) -> Snapshot? in value.flatMap { (value: Collection) -> Snapshot in value.snapshot } } }, forKey: "collections")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["user"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("pwd", type: .scalar(String.self)),
        GraphQLField("avatar", type: .scalar(String.self)),
        GraphQLField("bio", type: .scalar(String.self)),
        GraphQLField("token", type: .scalar(String.self)),
        GraphQLField("role", type: .scalar(Int.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, email: String? = nil, name: String? = nil, pwd: String? = nil, avatar: String? = nil, bio: String? = nil, token: String? = nil, role: Int? = nil) {
        self.init(snapshot: ["__typename": "user", "id": id, "email": email, "name": name, "pwd": pwd, "avatar": avatar, "bio": bio, "token": token, "role": role])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var pwd: String? {
        get {
          return snapshot["pwd"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "pwd")
        }
      }

      public var avatar: String? {
        get {
          return snapshot["avatar"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "avatar")
        }
      }

      public var bio: String? {
        get {
          return snapshot["bio"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "bio")
        }
      }

      public var token: String? {
        get {
          return snapshot["token"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "token")
        }
      }

      public var role: Int? {
        get {
          return snapshot["role"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "role")
        }
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
        GraphQLField("permission", type: .scalar(Int.self)),
        GraphQLField("fromID", type: .scalar(String.self)),
        GraphQLField("fromURL", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var permission: Int? {
        get {
          return snapshot["permission"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "permission")
        }
      }

      public var fromId: String? {
        get {
          return snapshot["fromID"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromID")
        }
      }

      public var fromUrl: String? {
        get {
          return snapshot["fromURL"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "fromURL")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

public struct FetchCategories: GraphQLFragment {
  public static let fragmentString =
    "fragment fetchCategories on category {\n  __typename\n  id\n  name\n  src\n}"

  public static let possibleTypes = ["category"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .scalar(GraphQLID.self)),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("src", type: .scalar(Int.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: GraphQLID? = nil, name: String? = nil, src: Int? = nil) {
    self.init(snapshot: ["__typename": "category", "id": id, "name": name, "src": src])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID? {
    get {
      return snapshot["id"] as? GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String? {
    get {
      return snapshot["name"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var src: Int? {
    get {
      return snapshot["src"] as? Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "src")
    }
  }
}

public struct FetchGirls: GraphQLFragment {
  public static let fragmentString =
    "fragment fetchGirls on girl {\n  __typename\n  id\n  img\n  text\n  permission\n  fromID\n  fromURL\n}"

  public static let possibleTypes = ["girl"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .scalar(GraphQLID.self)),
    GraphQLField("img", type: .scalar(String.self)),
    GraphQLField("text", type: .scalar(String.self)),
    GraphQLField("permission", type: .scalar(Int.self)),
    GraphQLField("fromID", type: .scalar(String.self)),
    GraphQLField("fromURL", type: .scalar(String.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
    self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID? {
    get {
      return snapshot["id"] as? GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  public var img: String? {
    get {
      return snapshot["img"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "img")
    }
  }

  public var text: String? {
    get {
      return snapshot["text"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "text")
    }
  }

  public var permission: Int? {
    get {
      return snapshot["permission"] as? Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "permission")
    }
  }

  public var fromId: String? {
    get {
      return snapshot["fromID"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "fromID")
    }
  }

  public var fromUrl: String? {
    get {
      return snapshot["fromURL"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "fromURL")
    }
  }
}