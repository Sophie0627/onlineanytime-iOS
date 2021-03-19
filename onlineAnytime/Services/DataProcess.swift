//
//  DataProcess.swift
//  onlineAnytime
//
//  Created by Sophie on 3/15/21.
//

import Foundation

public class DataProcess {
    
    func dataUpdate(token: String, finish: @escaping (_ result: Bool) -> Void) {
        let apiService: ApiService = ApiService()
        
        apiService.fetchFormData(token: token) { result in
            apiService.fetchFormElementOption(token: token) { result in
                let formDB: FormDBHelper = FormDBHelper()
                let formIds: [Int] = formDB.getFormIds()
                
                let group = DispatchGroup()
                
                var success: Bool = true
                
                for formId in formIds {
                    group.enter()
                    apiService.fetchFormElement(token: token, formId: formId) {result in
                        group.leave()
                        if success {
                            success = result!
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    // do something here when loop finished
                    finish(success)
                }
            }
        }
    }
    
    func dataSubmit(token: String, finish: @escaping (_ result: Bool) -> Void) {

        let formSubmitDB: FormSubmitDBHelper = FormSubmitDBHelper()
        let formSubmits: [FormSubmit] = formSubmitDB.read()
        let group = DispatchGroup()
        
        var success: Bool = true
        
        for formSubmit in formSubmits {
            group.enter()
            ApiService.submit(token: token, formId: formSubmit.formId, keys: formSubmit.keys.components(separatedBy: "##"), values: formSubmit.values.components(separatedBy: "##")) { result in
                group.leave()
                if success {
                    success = result!
                }
            }
        }
        formSubmitDB.delete()
        
        group.notify(queue: .main) {
            // do something here when loop finished
            finish(success)
        }
    }
}
