//
//  DataProcess.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//

import Foundation

public class DataProcess {
    
    func dataProcess(token: String) {
        self.dataUpdate(token: token)
        self.dataSubmit(token: token)
    }
    
    func dataUpdate(token: String) {
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
        let formSubmitDB: FormSubmitDBHelper = FormSubmitDBHelper()
        let formSubmits: [FormSubmit] = formSubmitDB.read()
        for formSubmit in formSubmits {
            ApiService.submit(token: token, formId: formSubmit.formId, keys: formSubmit.keys.components(separatedBy: "##"), values: formSubmit.values.components(separatedBy: "##"))
        }
        formSubmitDB.delete()
    }
}
