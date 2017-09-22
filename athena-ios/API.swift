//  This file was automatically generated and should not be edited.

import Apollo

public struct CellInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(img: Optional<String?> = nil, text: Optional<String?> = nil, cate: Optional<Int?> = nil) {
    graphQLMap = ["img": img, "text": text, "cate": cate]
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
}

public final class InitCategoriesQuery: GraphQLQuery {
  public static let operationString =
    "query initCategories {" +
    "  categories {" +
    "    __typename" +
    "    id" +
    "    name" +
    "    src" +
    "    count" +
    "  }" +
    "}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["RootSchema"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("categories", type: .list(.object(Category.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(categories: [Category?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "categories": categories])
    }

    /// categories
    public var categories: [Category?]? {
      get {
        return (snapshot["categories"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Category(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "categories")
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var src: Int? {
        get {
          return snapshot["src"]! as! Int?
        }
        set {
          snapshot.updateValue(newValue, forKey: "src")
        }
      }

      public var count: Int? {
        get {
          return snapshot["count"]! as! Int?
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
    "query fetchGirlsQuery($from: Int!, $take: Int!, $offset: Int!) {" +
    "  girls(from: $from, take: $take, offset: $offset) {" +
    "    __typename" +
    "    ...fetchGirls" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(FetchGirls.fragmentString) }

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
      GraphQLField("girls", arguments: ["from": Variable("from"), "take": Variable("take"), "offset": Variable("offset")], type: .list(.object(Girl.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(girls: [Girl?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "girls": girls])
    }

    /// girls
    public var girls: [Girl?]? {
      get {
        return (snapshot["girls"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Girl(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "girls")
      }
    }

    public struct Girl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text])
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }
  }
}

public final class InitialQuery: GraphQLQuery {
  public static let operationString =
    "query initial($from: Int!, $take: Int!, $offset: Int!) {" +
    "  girls(from: $from, take: $take, offset: $offset) {" +
    "    __typename" +
    "    ...fetchGirls" +
    "  }" +
    "  categories {" +
    "    __typename" +
    "    ...fetchCategories" +
    "  }" +
    "}"

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
      GraphQLField("girls", arguments: ["from": Variable("from"), "take": Variable("take"), "offset": Variable("offset")], type: .list(.object(Girl.self))),
      GraphQLField("categories", type: .list(.object(Category.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(girls: [Girl?]? = nil, categories: [Category?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "girls": girls, "categories": categories])
    }

    /// girls
    public var girls: [Girl?]? {
      get {
        return (snapshot["girls"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Girl(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "girls")
      }
    }

    /// categories
    public var categories: [Category?]? {
      get {
        return (snapshot["categories"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Category(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "categories")
      }
    }

    public struct Girl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text])
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }

    public struct Category: GraphQLSelectionSet {
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var src: Int? {
        get {
          return snapshot["src"]! as! Int?
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
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchCategories: FetchCategories {
          get {
            return FetchCategories(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }
  }
}

public final class AddGirlCellsMutation: GraphQLMutation {
  public static let operationString =
    "mutation addGirlCells($cells: [CellInput]) {" +
    "  addGirls(cells: $cells) {" +
    "    __typename" +
    "    ...fetchGirls" +
    "  }" +
    "}"

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
      GraphQLField("addGirls", arguments: ["cells": Variable("cells")], type: .list(.object(AddGirl.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(addGirls: [AddGirl?]? = nil) {
      self.init(snapshot: ["__typename": "RootMutation", "addGirls": addGirls])
    }

    /// add some Girls
    public var addGirls: [AddGirl?]? {
      get {
        return (snapshot["addGirls"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { AddGirl(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "addGirls")
      }
    }

    public struct AddGirl: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text])
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }
  }
}

public final class AuthQuery: GraphQLQuery {
  public static let operationString =
    "query auth($email: String!, $password: String!) {" +
    "  auth(email: $email, password: $password) {" +
    "    __typename" +
    "    token" +
    "    id" +
    "  }" +
    "}"

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
      GraphQLField("auth", arguments: ["email": Variable("email"), "password": Variable("password")], type: .object(Auth.self)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(auth: Auth? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "auth": auth])
    }

    /// user auth by email and password
    public var auth: Auth? {
      get {
        return (snapshot["auth"]! as! Snapshot?).flatMap { Auth(snapshot: $0) }
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
          return snapshot["token"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "token")
        }
      }

      public var id: GraphQLID? {
        get {
          return snapshot["id"]! as! GraphQLID?
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
    "query FetchCollections($id: Int!, $from: Int!, $size: Int!) {" +
    "  collections(id: $id, from: $from, size: $size) {" +
    "    __typename" +
    "    ...fetchGirls" +
    "  }" +
    "}"

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
      GraphQLField("collections", arguments: ["id": Variable("id"), "from": Variable("from"), "size": Variable("size")], type: .list(.object(Collection.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(collections: [Collection?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "collections": collections])
    }

    /// collections
    public var collections: [Collection?]? {
      get {
        return (snapshot["collections"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Collection(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "collections")
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text])
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }
  }
}

public final class FetchProfileWithCollectionsQuery: GraphQLQuery {
  public static let operationString =
    "query FetchProfileWithCollections($id: Int!, $from: Int!, $size: Int!) {" +
    "  users(id: $id) {" +
    "    __typename" +
    "    id" +
    "    email" +
    "    name" +
    "    pwd" +
    "    avatar" +
    "    bio" +
    "    token" +
    "  }" +
    "  collections(id: $id, from: $from, size: $size) {" +
    "    __typename" +
    "    ...fetchGirls" +
    "  }" +
    "}"

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
      GraphQLField("users", arguments: ["id": Variable("id")], type: .object(User.self)),
      GraphQLField("collections", arguments: ["id": Variable("id"), "from": Variable("from"), "size": Variable("size")], type: .list(.object(Collection.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(users: User? = nil, collections: [Collection?]? = nil) {
      self.init(snapshot: ["__typename": "RootSchema", "users": users, "collections": collections])
    }

    /// a user
    public var users: User? {
      get {
        return (snapshot["users"]! as! Snapshot?).flatMap { User(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "users")
      }
    }

    /// collections
    public var collections: [Collection?]? {
      get {
        return (snapshot["collections"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Collection(snapshot: $0) } } }
      }
      set {
        snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "collections")
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
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, email: String? = nil, name: String? = nil, pwd: String? = nil, avatar: String? = nil, bio: String? = nil, token: String? = nil) {
        self.init(snapshot: ["__typename": "user", "id": id, "email": email, "name": name, "pwd": pwd, "avatar": avatar, "bio": bio, "token": token])
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }

      public var name: String? {
        get {
          return snapshot["name"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      public var pwd: String? {
        get {
          return snapshot["pwd"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "pwd")
        }
      }

      public var avatar: String? {
        get {
          return snapshot["avatar"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "avatar")
        }
      }

      public var bio: String? {
        get {
          return snapshot["bio"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "bio")
        }
      }

      public var token: String? {
        get {
          return snapshot["token"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "token")
        }
      }
    }

    public struct Collection: GraphQLSelectionSet {
      public static let possibleTypes = ["girl"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("img", type: .scalar(String.self)),
        GraphQLField("text", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil) {
        self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text])
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
          return snapshot["id"]! as! GraphQLID?
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var img: String? {
        get {
          return snapshot["img"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "img")
        }
      }

      public var text: String? {
        get {
          return snapshot["text"]! as! String?
        }
        set {
          snapshot.updateValue(newValue, forKey: "text")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot = newValue.snapshot
        }
      }

      public struct Fragments {
        public var snapshot: Snapshot

        public var fetchGirls: FetchGirls {
          get {
            return FetchGirls(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }
      }
    }
  }
}

public struct FetchGirls: GraphQLFragment {
  public static let fragmentString =
    "fragment fetchGirls on girl {" +
    "  __typename" +
    "  id" +
    "  img" +
    "  text" +
    "}"

  public static let possibleTypes = ["girl"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .scalar(GraphQLID.self)),
    GraphQLField("img", type: .scalar(String.self)),
    GraphQLField("text", type: .scalar(String.self)),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(id: GraphQLID? = nil, img: String? = nil, text: String? = nil) {
    self.init(snapshot: ["__typename": "girl", "id": id, "img": img, "text": text])
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
      return snapshot["id"]! as! GraphQLID?
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  public var img: String? {
    get {
      return snapshot["img"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "img")
    }
  }

  public var text: String? {
    get {
      return snapshot["text"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "text")
    }
  }
}

public struct FetchCategories: GraphQLFragment {
  public static let fragmentString =
    "fragment fetchCategories on category {" +
    "  __typename" +
    "  id" +
    "  name" +
    "  src" +
    "}"

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
      return snapshot["id"]! as! GraphQLID?
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String? {
    get {
      return snapshot["name"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  public var src: Int? {
    get {
      return snapshot["src"]! as! Int?
    }
    set {
      snapshot.updateValue(newValue, forKey: "src")
    }
  }
}