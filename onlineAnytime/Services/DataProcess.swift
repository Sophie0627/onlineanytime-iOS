//
//  DataProcess.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//

import Foundation

public class DataProcess {
    
    func dataProcess(token: String) {
        print("Data processing...")
        self.dataUpdate(token: token)
        self.dataSubmit(token: token)
    }
    
    func dataUpdate(token: String) {
        print("Data updating...")
        let apiService: ApiService = ApiService()
        
        apiService.fetchFormData(token: token)
        apiService.fetchFormElementOption(token: token)
        
        let formDB: FormDBHelper = FormDBHelper()
        let formIds: [Int] = formDB.getFormIds()
        
        for formId in formIds {
            apiService.fetchFormElement(token: token, formId: formId)
        }
    }
    
    func dataSubmit(token: String) {
        print("Data submitting...")
    }
}
