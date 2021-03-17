//
//  FormSubmitDBHelper.swift
//  onlineAnytime
//
//  Created by Sophie on 3/17/21.
//

import Foundation
import SQLite3

class FormSubmitDBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "onlineAnytimeDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS formSubmit(formId INTEGER, submitKeys TEXT, submitValues TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("formSubmit table created.")
            } else {
                print("formSubmit table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }


    func insert(formId: Int, keys: String, values: String)
    {
//        let formSubmits = read()
//        for form in forms
//        {
//            if form.form_id == formId
//            {
//                return
//            }
//        }
        let insertStatementString = "INSERT INTO formSubmit (formId, submitKeys, submitValues) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(formId))
            sqlite3_bind_text(insertStatement, 2, (keys as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (values as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [FormSubmit] {
        let queryStatementString = "SELECT * FROM formSubmit;"
        var queryStatement: OpaquePointer? = nil
        var formSubmits : [FormSubmit] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let formId = sqlite3_column_int(queryStatement, 0)
                let keys = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let values = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                formSubmits.append(FormSubmit(formId: Int(formId), keys: keys, values: values))
//                print("Query Result:")
//                print("\(formId) | \(formName) | \(formDescription)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return formSubmits
    }
    
    func delete() {
        let deleteStatementStirng = "DELETE FROM formSubmit;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            while sqlite3_step(deleteStatement) == SQLITE_ROW {
                print("Successfully deleted row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
        
    }
}
