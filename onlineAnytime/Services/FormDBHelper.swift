//
//  FormDBHelper.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//

import Foundation
import SQLite3

class FormDBHelper
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
        let createTableString = "CREATE TABLE IF NOT EXISTS form(formId INTEGER PRIMARY KEY, formName TEXT, formDescription TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("form table created.")
            } else {
                print("form table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }


    func insert(formId: Int, formName: String, formDescription: String)
    {
        let forms = read()
        for form in forms
        {
            if form.form_id == formId
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO form (formId, formName, formDescription) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(formId))
            sqlite3_bind_text(insertStatement, 2, (formName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (formDescription as NSString).utf8String, -1, nil)
            
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
    
    func getFormIds() -> [Int] {
        let queryStatementString = "SELECT formId FROM form;"
        var queryStatement: OpaquePointer? = nil
        var formIds : [Int] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let formId = sqlite3_column_int(queryStatement, 0)
                formIds.append(Int(formId))
                print("Query Result: \(formId)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return formIds
    }
    
    func read() -> [FormList] {
        let queryStatementString = "SELECT * FROM form;"
        var queryStatement: OpaquePointer? = nil
        var forms : [FormList] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let formId = sqlite3_column_int(queryStatement, 0)
                let formName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let formDescription = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                forms.append(FormList(form_id: Int(formId), form_name: formName, form_description: formDescription))
                print("Query Result:")
                print("\(formId) | \(formName) | \(formDescription)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return forms
    }
//
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }
    
}
