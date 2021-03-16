//
//  FormElementDBHelper.swift
//  onlineAnytime
//
//  Created by Sophie on 3/16/21.
//

import Foundation
import SQLite3

class FormElementDBHelper
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
        let createTableString = "CREATE TABLE IF NOT EXISTS formElement(formId INTEGER, elementId INTEGER, elementTitle TEXT, elementGuideline TEXT, elementType TEXT, elementPosition INTEGER, elementPageNumber INTEGER, elementDefaultValue TEXT, elementConstraint TEXT, elementAddressHideline2 INTEGER, elementMediaType TEXT, elementMediaImageSrc TEXT, elementMediaPdfSrc TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("formElement table created.")
            } else {
                print("formElement table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }


    func insert(formId: Int, elementId: Int, elementTitle: String, elementGuideline: String, elementType: String, elementPosition: Int, elementPageNumber: Int, elementDefaultValue: String, elementConstraint: String, elementAddressHideline2: Int, elementMediaType: String, elementMediaImageSrc: String, elementMediaPdfSrc: String)
    {
        let formElements = read()
        for formElement in formElements
        {
            if formElement.formId == formId && formElement.formElement.element_id == elementId
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO formElement (formId, elementId, elementTitle, elementGuideline, elementType, elementPosition, elementPageNumber, elementDefaultValue, elementConstraint, elementAddressHideline2, elementMediaType, elementMediaImageSrc, elementMediaPdfSrc) VALUES (?, ?, ? ,? ,? ,? ,? ,? ,? ,? ,? ,? ,?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(formId))
            sqlite3_bind_int(insertStatement, 2, Int32(elementId))
            sqlite3_bind_text(insertStatement, 3, (elementTitle as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (elementGuideline as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (elementType as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 6, Int32(elementPosition))
            sqlite3_bind_int(insertStatement, 7, Int32(elementPageNumber))
            sqlite3_bind_text(insertStatement, 8, (elementDefaultValue as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (elementConstraint as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 10, Int32(elementAddressHideline2))
            sqlite3_bind_text(insertStatement, 11, (elementMediaType as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 12, (elementMediaImageSrc as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 13, (elementMediaPdfSrc as NSString).utf8String, -1, nil)
            
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
    
    func readFormElementByPageNumber(formId: Int, elementPageNumber: Int) -> [FormElementWithId] {
        let queryStatementString = "SELECT * FROM formElement WHERE formId = \(formId) AND elementPageNumber = \(elementPageNumber);"
        var queryStatement: OpaquePointer? = nil
        var formElements : [FormElementWithId] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let formId = sqlite3_column_int(queryStatement, 0)
                let elementId = sqlite3_column_int(queryStatement, 1)
                let elementTitle = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let elementGuideline = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let elementType = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let elementPosition = sqlite3_column_int(queryStatement, 5)
                let elementPageNumber = sqlite3_column_int(queryStatement, 6)
                let elementDefaultValue = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let elementConstraint = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let elementAddressHideline2 = sqlite3_column_int(queryStatement, 9)
                let elementMediaType = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let elementMediaImageSrc = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
                let elementMediaPdfSrc = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
                formElements.append(FormElementWithId(formElement: FormElement(element_id: Int(elementId), element_title: elementTitle, element_guidelines: elementGuideline, element_type: elementType, element_position: Int(elementPosition), element_page_number: Int(elementPageNumber), element_default_value: elementDefaultValue, element_constraint: elementConstraint, element_address_hideline2: Int(elementAddressHideline2), element_media_type: elementMediaType, element_media_image_src: elementMediaImageSrc, element_media_pdf_src: elementMediaPdfSrc), formId: Int(formId)))
//                print("Query Result:")
//                print("\(formId) | \(elementId) | \(elementTitle)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return formElements
    }
    
    func getPageNumber(formId: Int) -> Int {
        let queryStatementString = "SELECT MAX(elementPageNumber) FROM formElement WHERE formId = \(formId);"
        var queryStatement: OpaquePointer? = nil
        var pageNumber : Int = 0
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                pageNumber = Int(sqlite3_column_int(queryStatement, 0))
//                print("Query Result:")
//                print("\(formId) | \(elementId) | \(elementTitle)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return pageNumber
    }

    func read() -> [FormElementWithId] {
        let queryStatementString = "SELECT * FROM formElement;"
        var queryStatement: OpaquePointer? = nil
        var formElements : [FormElementWithId] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let formId = sqlite3_column_int(queryStatement, 0)
                let elementId = sqlite3_column_int(queryStatement, 1)
                let elementTitle = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let elementGuideline = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let elementType = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let elementPosition = sqlite3_column_int(queryStatement, 5)
                let elementPageNumber = sqlite3_column_int(queryStatement, 6)
                let elementDefaultValue = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let elementConstraint = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let elementAddressHideline2 = sqlite3_column_int(queryStatement, 9)
                let elementMediaType = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let elementMediaImageSrc = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
                let elementMediaPdfSrc = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
                formElements.append(FormElementWithId(formElement: FormElement(element_id: Int(elementId), element_title: elementTitle, element_guidelines: elementGuideline, element_type: elementType, element_position: Int(elementPosition), element_page_number: Int(elementPageNumber), element_default_value: elementDefaultValue, element_constraint: elementConstraint, element_address_hideline2: Int(elementAddressHideline2), element_media_type: elementMediaType, element_media_image_src: elementMediaImageSrc, element_media_pdf_src: elementMediaPdfSrc), formId: Int(formId)))
//                print("Query Result:")
//                print("\(formId) | \(elementId) | \(elementTitle)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return formElements
    }
}
