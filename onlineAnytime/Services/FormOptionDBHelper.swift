//
//  FormOptionDBHelper.swift
//  onlineAnytime
//
//  Created by Sophie on 3/16/21.
//

import Foundation
import SQLite3

class FormOptionDBHelper
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
        let createTableString = "CREATE TABLE IF NOT EXISTS formOption(aeoId INTEGER PRIMARY KEY, formId INTEGER, elementId INTERGER, optionId INTERGER, position INTERGER, option TEXT, optionIsDefault INTERGER, optionIsHidden INTERGER, live INTERGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("formOption table created.")
            } else {
                print("formOption table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }


    func insert(aeoId: Int, formId: Int, elementId: Int, optionId: Int, position: Int, option: String, optionIsDefault: Int, optionIsHidden: Int, live: Int)
    {
        let formOptions = read()
        for formOption in formOptions
        {
            if formOption.aeo_id == aeoId
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO formOption (aeoId, formId, elementId, optionId, position, option, optionIsDefault, optionIsHidden, live) VALUES (?, ?, ? ,? ,? ,? ,? ,? ,?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(aeoId))
            sqlite3_bind_int(insertStatement, 2, Int32(formId))
            sqlite3_bind_int(insertStatement, 3, Int32(elementId))
            sqlite3_bind_int(insertStatement, 4, Int32(optionId))
            sqlite3_bind_int(insertStatement, 5, Int32(position))
            sqlite3_bind_text(insertStatement, 6, (option as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 7, Int32(optionIsDefault))
            sqlite3_bind_int(insertStatement, 8, Int32(optionIsHidden))
            sqlite3_bind_int(insertStatement, 9, Int32(live))
            
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
    
    func getOptions(formId: Int, elementId: Int) -> [String] {
        let queryStatementString = "SELECT option FROM formOption WHERE formId = \(formId) AND elementId = \(elementId);"
        var queryStatement: OpaquePointer? = nil
        var options : [String] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let option = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                options.append(option)
//                print("Query Result: \(option)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return options
    }

    func read() -> [FormElementOption] {
        let queryStatementString = "SELECT * FROM formOption;"
        var queryStatement: OpaquePointer? = nil
        var formOptions : [FormElementOption] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let aeoId = sqlite3_column_int(queryStatement, 0)
                let formId = sqlite3_column_int(queryStatement, 1)
                let elementId = sqlite3_column_int(queryStatement, 2)
                let optionId = sqlite3_column_int(queryStatement, 3)
                let position = sqlite3_column_int(queryStatement, 4)
                let option = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let optionIsDefault = sqlite3_column_int(queryStatement, 6)
                let optionIsHidden = sqlite3_column_int(queryStatement, 7)
                let live = sqlite3_column_int(queryStatement, 8)
                formOptions.append(FormElementOption(aeo_id: Int(aeoId), form_id: Int(formId), element_id: Int(elementId), option_id: Int(optionId), position: Int(position), option: option, option_is_default: Int(optionIsDefault), option_is_hidden: Int(optionIsHidden), live: Int(live)))
//                print("Query Result:")
//                print("\(aeoId) | \(option) | \(formId)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return formOptions
    }
}
