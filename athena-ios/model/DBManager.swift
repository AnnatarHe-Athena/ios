//
//  dbInit.swift
//  athena-ios
//
//  Created by le.he on 24/03/2018.
//  Copyright © 2018 AnnatarHe. All rights reserved.
//

import Foundation
import SQLite

class DBManager {
    
    var Conn: Connection
    
    var Users: Table
    
    private static var sharedDBInstance: DBManager = {
        
        // Configuration
        // ...
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("athen-database.sqlite")
        
        let db = try! Connection(fileURL.absoluteString)
        
        let users = Table("users")
        
        let id = Expression<Int64>("id")
        let email = Expression<String>("email")
        let pwd = Expression<String>("pwd")
        
        try! db.run(users.create{t in
            t.column(id, primaryKey: true)
            t.column(email)
            t.column(pwd)
        })
        
        let inst = DBManager(conn: db, users: users)
        return inst
    }()
    
    // Initialization
    
    private init(conn: Connection, users: Table) {
        self.Users = users
        self.Conn = conn
    }
    
    // MARK: - Accessors
    
    class func shared() -> DBManager {
        return sharedDBInstance
    }

}
