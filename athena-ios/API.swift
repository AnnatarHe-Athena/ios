//  This file was automatically generated and should not be edited.

import Apollo

public struct CellInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(cate: Swift.Optional<Int?> = nil, permission: Swift.Optional<Int?> = nil, fromId: Swift.Optional<String?> = nil, fromUrl: Swift.Optional<String?> = nil, img: Swift.Optional<String?> = nil, text: Swift.Optional<String?> = nil) {
    graphQLMap = ["cate": cate, "permission": permission, "fromID": fromId, "fromURL": fromUrl, "img": img, "text": text]
  }

  public var cate: Swift.Optional<Int?> {
    get {
      return graphQLMap["cate"] as? Swift.Optional<Int?> ?? .none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "cate")
    }
  }

  public var permission: Swift.Optional<Int?> {
    get {
      return graphQLMap["permission"] as? Swift.Optional<Int?> ?? .none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "permission")
    }
  }

  public var fromId: Swift.Optional<String?> {
    get {
      return graphQLMap["fromID"] as? Swift.Optional<String?> ?? .none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fromID")
    }
  }

  public var fromUrl: Swift.Optional<String?> {
    get {
      return graphQLMap["fromURL"] as? Swift.Optional<String?> ?? .none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "fromURL")
    }
  }

  public var img: Swift.Optional<String?> {
    get {
      return graphQLMap["img"] as? Swift.Optional<String?> ?? .none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "img")
    }
  }

  public var text: Swift.Optional<String?> {
    get {
      return graphQLMap["text"] as? Swift.Optional<String?> ?? .none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "text")
    }
  }
}

public final class InitCategoriesQuery: GraphQLQuery {
  /// query initCategories {
  ///   categories {
  ///     __typename
  ///     id
  ///     name
  ///     src
  ///     count
  ///   }
  /// }
  public let operationDefinition =
    "query initCategories { categories { __typename id name src count } }"

  public let operationName = "initCategories"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("categories", type: .list(.object(Category.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(categories: [Category?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootSchema", "categories": categories.flatMap { (value: [Category?]) -> [ResultMap?] in value.map { (value: Category?) -> ResultMap? in value.flatMap { (value: Category) -> ResultMap in value.resultMap } } }])
    }

    /// categories
    public var categories: [Category?]? {
      get {
        return (resultMap["categories"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Category?] in value.map { (value: ResultMap?) -> Category? in value.flatMap { (value: ResultMap) -> Category in Category(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Category?]) -> [ResultMap?] in value.map { (value: Category?) -> ResultMap? in value.flatMap { (value: Category) -> ResultMap in value.resultMap } } }, forKey: "categories")
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

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, name: String? = nil, src: Int? = nil, count: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "category", "id": id, "name": name, "src": src, "count": count])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return resultMap["id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var src: Int? {
        get {
          return resultMap["src"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "src")
        }
      }

      public var count: Int? {
        get {
          return resultMap["count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "count")
        }
      }
    }
  }
}

public final class FetchGirlsQueryQuery: GraphQLQuery {
  /// query fetchGirlsQuery($from: Int!, $take: Int!, $offset: Int!, $hideOnly: Boolean) {
  ///   girls(from: $from, take: $take, offset: $offset, hideOnly: $hideOnly) {
  ///     __typename
  ///     ...fetchGirls
  ///   }
  /// }
  public let operationDefinition =
    "query fetchGirlsQuery($from: Int!, $take: Int!, $offset: Int!, $hideOnly: Boolean) { girls(from: $from, take: $take, offset: $offset, hideOnly: $hideOnly) { __typename ...fetchGirls } }"

  public let operationName = "fetchGirlsQuery"

  public var queryDocument: String { return operationDefinition.appending(FetchGirls.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(girls: [Girl?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootSchema", "girls": girls.flatMap { (value: [Girl?]) -> [ResultMap?] in value.map { (value: Girl?) -> ResultMap? in value.flatMap { (value: Girl) -> ResultMap in value.resultMap } } }])
    }

    /// girls
    public var girls: [Girl?]? {
      get {
        return (resultMap["girls"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Girl?] in value.map { (value: ResultMap?) -> Girl? in value.flatMap { (value: ResultMap) -> Girl in Girl(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Girl?]) -> [ResultMap?] in value.map { (value: Girl?) -> ResultMap? in value.flatMap { (value: Girl) -> ResultMap in value.resultMap } } }, forKey: "girls")
      }
    }

    public struct Girl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FetchGirls.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, content: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "girl", "id": id, "img": img, "text": text, "content": content, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class InitialQuery: GraphQLQuery {
  /// query initial($from: Int!, $take: Int!, $offset: Int!) {
  ///   girls(from: $from, take: $take, offset: $offset) {
  ///     __typename
  ///     ...fetchGirls
  ///   }
  ///   categories {
  ///     __typename
  ///     ...fetchCategories
  ///   }
  /// }
  public let operationDefinition =
    "query initial($from: Int!, $take: Int!, $offset: Int!) { girls(from: $from, take: $take, offset: $offset) { __typename ...fetchGirls } categories { __typename ...fetchCategories } }"

  public let operationName = "initial"

  public var queryDocument: String { return operationDefinition.appending(FetchGirls.fragmentDefinition).appending(FetchCategories.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(girls: [Girl?]? = nil, categories: [Category?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootSchema", "girls": girls.flatMap { (value: [Girl?]) -> [ResultMap?] in value.map { (value: Girl?) -> ResultMap? in value.flatMap { (value: Girl) -> ResultMap in value.resultMap } } }, "categories": categories.flatMap { (value: [Category?]) -> [ResultMap?] in value.map { (value: Category?) -> ResultMap? in value.flatMap { (value: Category) -> ResultMap in value.resultMap } } }])
    }

    /// girls
    public var girls: [Girl?]? {
      get {
        return (resultMap["girls"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Girl?] in value.map { (value: ResultMap?) -> Girl? in value.flatMap { (value: ResultMap) -> Girl in Girl(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Girl?]) -> [ResultMap?] in value.map { (value: Girl?) -> ResultMap? in value.flatMap { (value: Girl) -> ResultMap in value.resultMap } } }, forKey: "girls")
      }
    }

    /// categories
    public var categories: [Category?]? {
      get {
        return (resultMap["categories"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Category?] in value.map { (value: ResultMap?) -> Category? in value.flatMap { (value: ResultMap) -> Category in Category(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Category?]) -> [ResultMap?] in value.map { (value: Category?) -> ResultMap? in value.flatMap { (value: Category) -> ResultMap in value.resultMap } } }, forKey: "categories")
      }
    }

    public struct Girl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FetchGirls.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, content: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "girl", "id": id, "img": img, "text": text, "content": content, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public struct Category: GraphQLSelectionSet {
      public static let possibleTypes = ["category"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FetchCategories.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, name: String? = nil, src: Int? = nil, count: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "category", "id": id, "name": name, "src": src, "count": count])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fetchCategories: FetchCategories {
          get {
            return FetchCategories(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class AddToCollectionMutation: GraphQLMutation {
  /// mutation addToCollection($cells: [Int]) {
  ///   addCollection(cells: $cells) {
  ///     __typename
  ///     isOk
  ///   }
  /// }
  public let operationDefinition =
    "mutation addToCollection($cells: [Int]) { addCollection(cells: $cells) { __typename isOk } }"

  public let operationName = "addToCollection"

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addCollection: AddCollection? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootMutation", "addCollection": addCollection.flatMap { (value: AddCollection) -> ResultMap in value.resultMap }])
    }

    /// add collection
    public var addCollection: AddCollection? {
      get {
        return (resultMap["addCollection"] as? ResultMap).flatMap { AddCollection(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addCollection")
      }
    }

    public struct AddCollection: GraphQLSelectionSet {
      public static let possibleTypes = ["addCollectionReturnType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("isOk", type: .scalar(Bool.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(isOk: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "addCollectionReturnType", "isOk": isOk])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var isOk: Bool? {
        get {
          return resultMap["isOk"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isOk")
        }
      }
    }
  }
}

public final class AddGirlCellsMutation: GraphQLMutation {
  /// mutation addGirlCells($cells: [CellInput]) {
  ///   addGirls(cells: $cells) {
  ///     __typename
  ///     ...fetchGirls
  ///   }
  /// }
  public let operationDefinition =
    "mutation addGirlCells($cells: [CellInput]) { addGirls(cells: $cells) { __typename ...fetchGirls } }"

  public let operationName = "addGirlCells"

  public var queryDocument: String { return operationDefinition.appending(FetchGirls.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addGirls: [AddGirl?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootMutation", "addGirls": addGirls.flatMap { (value: [AddGirl?]) -> [ResultMap?] in value.map { (value: AddGirl?) -> ResultMap? in value.flatMap { (value: AddGirl) -> ResultMap in value.resultMap } } }])
    }

    /// add some Girls
    public var addGirls: [AddGirl?]? {
      get {
        return (resultMap["addGirls"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AddGirl?] in value.map { (value: ResultMap?) -> AddGirl? in value.flatMap { (value: ResultMap) -> AddGirl in AddGirl(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AddGirl?]) -> [ResultMap?] in value.map { (value: AddGirl?) -> ResultMap? in value.flatMap { (value: AddGirl) -> ResultMap in value.resultMap } } }, forKey: "addGirls")
      }
    }

    public struct AddGirl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FetchGirls.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, content: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "girl", "id": id, "img": img, "text": text, "content": content, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class RemoveGirlMutation: GraphQLMutation {
  /// mutation removeGirl($cells: [Int], $toRemove: Boolean) {
  ///   removeGirl(cells: $cells, toRemove: $toRemove) {
  ///     __typename
  ///     isOk
  ///   }
  /// }
  public let operationDefinition =
    "mutation removeGirl($cells: [Int], $toRemove: Boolean) { removeGirl(cells: $cells, toRemove: $toRemove) { __typename isOk } }"

  public let operationName = "removeGirl"

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(removeGirl: RemoveGirl? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootMutation", "removeGirl": removeGirl.flatMap { (value: RemoveGirl) -> ResultMap in value.resultMap }])
    }

    /// remove girl cell
    public var removeGirl: RemoveGirl? {
      get {
        return (resultMap["removeGirl"] as? ResultMap).flatMap { RemoveGirl(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "removeGirl")
      }
    }

    public struct RemoveGirl: GraphQLSelectionSet {
      public static let possibleTypes = ["addCollectionReturnType"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("isOk", type: .scalar(Bool.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(isOk: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "addCollectionReturnType", "isOk": isOk])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var isOk: Bool? {
        get {
          return resultMap["isOk"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isOk")
        }
      }
    }
  }
}

public final class AuthQuery: GraphQLQuery {
  /// query auth($email: String!, $password: String!) {
  ///   auth(email: $email, password: $password) {
  ///     __typename
  ///     token
  ///     id
  ///   }
  /// }
  public let operationDefinition =
    "query auth($email: String!, $password: String!) { auth(email: $email, password: $password) { __typename token id } }"

  public let operationName = "auth"

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(auth: Auth? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootSchema", "auth": auth.flatMap { (value: Auth) -> ResultMap in value.resultMap }])
    }

    /// user auth by email and password
    public var auth: Auth? {
      get {
        return (resultMap["auth"] as? ResultMap).flatMap { Auth(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "auth")
      }
    }

    public struct Auth: GraphQLSelectionSet {
      public static let possibleTypes = ["auth"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .scalar(String.self)),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String? = nil, id: GraphQLID? = nil) {
        self.init(unsafeResultMap: ["__typename": "auth", "token": token, "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      public var id: GraphQLID? {
        get {
          return resultMap["id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class FetchCollectionsQuery: GraphQLQuery {
  /// query FetchCollections($id: Int!, $from: Int!, $size: Int!) {
  ///   collections(id: $id, from: $from, size: $size) {
  ///     __typename
  ///     ...fetchGirls
  ///   }
  /// }
  public let operationDefinition =
    "query FetchCollections($id: Int!, $from: Int!, $size: Int!) { collections(id: $id, from: $from, size: $size) { __typename ...fetchGirls } }"

  public let operationName = "FetchCollections"

  public var queryDocument: String { return operationDefinition.appending(FetchGirls.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(collections: [Collection?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootSchema", "collections": collections.flatMap { (value: [Collection?]) -> [ResultMap?] in value.map { (value: Collection?) -> ResultMap? in value.flatMap { (value: Collection) -> ResultMap in value.resultMap } } }])
    }

    /// collections
    public var collections: [Collection?]? {
      get {
        return (resultMap["collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Collection?] in value.map { (value: ResultMap?) -> Collection? in value.flatMap { (value: ResultMap) -> Collection in Collection(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Collection?]) -> [ResultMap?] in value.map { (value: Collection?) -> ResultMap? in value.flatMap { (value: Collection) -> ResultMap in value.resultMap } } }, forKey: "collections")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FetchGirls.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, content: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "girl", "id": id, "img": img, "text": text, "content": content, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class InfoQuery: GraphQLQuery {
  /// query info {
  ///   info {
  ///     __typename
  ///     userCount
  ///     cellCount
  ///     fee
  ///     email
  ///     copyright
  ///   }
  /// }
  public let operationDefinition =
    "query info { info { __typename userCount cellCount fee email copyright } }"

  public let operationName = "info"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("info", type: .object(Info.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(info: Info? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootSchema", "info": info.flatMap { (value: Info) -> ResultMap in value.resultMap }])
    }

    /// infomations
    public var info: Info? {
      get {
        return (resultMap["info"] as? ResultMap).flatMap { Info(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "info")
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

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(userCount: Int? = nil, cellCount: Int? = nil, fee: String? = nil, email: String? = nil, copyright: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "info", "userCount": userCount, "cellCount": cellCount, "fee": fee, "email": email, "copyright": copyright])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var userCount: Int? {
        get {
          return resultMap["userCount"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "userCount")
        }
      }

      public var cellCount: Int? {
        get {
          return resultMap["cellCount"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "cellCount")
        }
      }

      public var fee: String? {
        get {
          return resultMap["fee"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "fee")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var copyright: String? {
        get {
          return resultMap["copyright"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "copyright")
        }
      }
    }
  }
}

public final class FetchProfileWithCollectionsQuery: GraphQLQuery {
  /// query FetchProfileWithCollections($id: Int!, $from: Int!, $size: Int!) {
  ///   users(id: $id) {
  ///     __typename
  ///     ...profile
  ///   }
  ///   collections(id: $id, from: $from, size: $size) {
  ///     __typename
  ///     ...fetchGirls
  ///   }
  /// }
  public let operationDefinition =
    "query FetchProfileWithCollections($id: Int!, $from: Int!, $size: Int!) { users(id: $id) { __typename ...profile } collections(id: $id, from: $from, size: $size) { __typename ...fetchGirls } }"

  public let operationName = "FetchProfileWithCollections"

  public var queryDocument: String { return operationDefinition.appending(Profile.fragmentDefinition).appending(FetchGirls.fragmentDefinition) }

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: User? = nil, collections: [Collection?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "RootSchema", "users": users.flatMap { (value: User) -> ResultMap in value.resultMap }, "collections": collections.flatMap { (value: [Collection?]) -> [ResultMap?] in value.map { (value: Collection?) -> ResultMap? in value.flatMap { (value: Collection) -> ResultMap in value.resultMap } } }])
    }

    /// a user
    public var users: User? {
      get {
        return (resultMap["users"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "users")
      }
    }

    /// collections
    public var collections: [Collection?]? {
      get {
        return (resultMap["collections"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Collection?] in value.map { (value: ResultMap?) -> Collection? in value.flatMap { (value: ResultMap) -> Collection in Collection(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Collection?]) -> [ResultMap?] in value.map { (value: Collection?) -> ResultMap? in value.flatMap { (value: Collection) -> ResultMap in value.resultMap } } }, forKey: "collections")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["user"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(Profile.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, email: String? = nil, name: String? = nil, pwd: String? = nil, avatar: String? = nil, bio: String? = nil, token: String? = nil, role: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "user", "id": id, "email": email, "name": name, "pwd": pwd, "avatar": avatar, "bio": bio, "token": token, "role": role])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var profile: Profile {
          get {
            return Profile(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(FetchGirls.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, content: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "girl", "id": id, "img": img, "text": text, "content": content, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public struct FetchCategories: GraphQLFragment {
  /// fragment fetchCategories on category {
  ///   __typename
  ///   id
  ///   name
  ///   src
  ///   count
  /// }
  public static let fragmentDefinition =
    "fragment fetchCategories on category { __typename id name src count }"

  public static let possibleTypes = ["category"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .scalar(GraphQLID.self)),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("src", type: .scalar(Int.self)),
    GraphQLField("count", type: .scalar(Int.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID? = nil, name: String? = nil, src: Int? = nil, count: Int? = nil) {
    self.init(unsafeResultMap: ["__typename": "category", "id": id, "name": name, "src": src, "count": count])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID? {
    get {
      return resultMap["id"] as? GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var src: Int? {
    get {
      return resultMap["src"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "src")
    }
  }

  public var count: Int? {
    get {
      return resultMap["count"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "count")
    }
  }
}

public struct FetchGirls: GraphQLFragment {
  /// fragment fetchGirls on girl {
  ///   __typename
  ///   id
  ///   img
  ///   text
  ///   content
  ///   permission
  ///   fromID
  ///   fromURL
  /// }
  public static let fragmentDefinition =
    "fragment fetchGirls on girl { __typename id img text content permission fromID fromURL }"

  public static let possibleTypes = ["girl"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .scalar(GraphQLID.self)),
    GraphQLField("img", type: .scalar(String.self)),
    GraphQLField("text", type: .scalar(String.self)),
    GraphQLField("content", type: .scalar(String.self)),
    GraphQLField("permission", type: .scalar(Int.self)),
    GraphQLField("fromID", type: .scalar(String.self)),
    GraphQLField("fromURL", type: .scalar(String.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil, content: String? = nil, permission: Int? = nil, fromId: String? = nil, fromUrl: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "girl", "id": id, "img": img, "text": text, "content": content, "permission": permission, "fromID": fromId, "fromURL": fromUrl])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID? {
    get {
      return resultMap["id"] as? GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var img: String? {
    get {
      return resultMap["img"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "img")
    }
  }

  public var text: String? {
    get {
      return resultMap["text"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "text")
    }
  }

  public var content: String? {
    get {
      return resultMap["content"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "content")
    }
  }

  public var permission: Int? {
    get {
      return resultMap["permission"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "permission")
    }
  }

  public var fromId: String? {
    get {
      return resultMap["fromID"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "fromID")
    }
  }

  public var fromUrl: String? {
    get {
      return resultMap["fromURL"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "fromURL")
    }
  }
}

public struct Profile: GraphQLFragment {
  /// fragment profile on user {
  ///   __typename
  ///   id
  ///   email
  ///   name
  ///   pwd
  ///   avatar
  ///   bio
  ///   token
  ///   role
  /// }
  public static let fragmentDefinition =
    "fragment profile on user { __typename id email name pwd avatar bio token role }"

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

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID? = nil, email: String? = nil, name: String? = nil, pwd: String? = nil, avatar: String? = nil, bio: String? = nil, token: String? = nil, role: Int? = nil) {
    self.init(unsafeResultMap: ["__typename": "user", "id": id, "email": email, "name": name, "pwd": pwd, "avatar": avatar, "bio": bio, "token": token, "role": role])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID? {
    get {
      return resultMap["id"] as? GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var email: String? {
    get {
      return resultMap["email"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  public var pwd: String? {
    get {
      return resultMap["pwd"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "pwd")
    }
  }

  public var avatar: String? {
    get {
      return resultMap["avatar"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "avatar")
    }
  }

  public var bio: String? {
    get {
      return resultMap["bio"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "bio")
    }
  }

  public var token: String? {
    get {
      return resultMap["token"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "token")
    }
  }

  public var role: Int? {
    get {
      return resultMap["role"] as? Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "role")
    }
  }
}
