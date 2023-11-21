//
//  ViewController.swift
//  Chapter06-SQLite
//
//  Created by JuSun Kang on 11/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dbPath = self.getDBPath()
        self.dbExecute(dbPath: dbPath)
    }
    
    func dbExecute(dbPath: String) {
        var db: OpaquePointer? = nil
        
        // 접속 체크
        guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
            print("Database Connect Fail")
            return
        }
        
        defer {
            print("Close Database Connection")
            sqlite3_close(db)
        }
        
        var stmt: OpaquePointer? = nil
        let sql = "CREATE TABLE IF NOT EXISTS sequence (num INTEGER)"
        
        // 준비 체크
        guard sqlite3_prepare(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            print("Prepare Statement Fail")
            return
        }
        
        defer {
            print("Finalize Statement")
            sqlite3_finalize(stmt)
        }
        
        // 구문실행 체크
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Create Table Success!")
        }
    }
    
    func getDBPath() -> String {
        let fileMgr = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first!
        //        let dbPath = docPathURL.appending(path: "db.sqlite", directoryHint: .isDirectory).path(percentEncoded: false)
        let dbPath = docPathURL.appendingPathComponent("db.sqlite").path
        //        let dbPath = "/Users/jusunkang/db.sqlite"
        
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        return dbPath
    }
    
}

