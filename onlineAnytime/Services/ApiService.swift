//
//  ApiService.swift
//  onlineAnytime
//
//  Created by Sophie on 3/10/21.
//

import Foundation

class ApiService
{
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url:URL, token: String, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
    {
        print("------------------callpost function------------------")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        request.setValue(token, forHTTPHeaderField: "token")
        
        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
            }

            finish(result)
            print(result.message)
        }
        task.resume()
    }
    
    // Make sure the API calls once they are finished modify the values on the Main Thread
    static func signIn(email: String, password: String, finish: @escaping (_ signedIn: Bool?, _ token: String?) -> Void) {
        
            let params:[String:String] = ["email": email, "password": password]
            
            let url = URL(string: "https://online-anytime.com.au/olat/newapi/login")!
  
            self.callPost(url: url, token: "", params: params) { (message, data) in
            do
            {
                if let jsonData = data
                {
                    let parsedData = try JSONDecoder().decode(UserInfo.self, from: jsonData)
                    print(parsedData)
                    finish(true, parsedData.token)
                } else {
                    finish(false, "")
                }
            }
            catch
            {
                finish(false, "")
                print("Parse Error: \(error)")
            }
        }
    }
    
    static func submit(token: String, formId: Int, keys: [String], values: [String], finish: @escaping (_ result: Bool?) -> Void) {
        
        print("--------------------submit function---------------------")
        var params:[String: String] = ["formId": String(formId), "id": "0"]
        
        for (index, element) in keys.enumerated() {
            if String(Array(element)[0..<3]) != "tmp" {
                params[element] = values[index]
            }
        }
        
        print("params \(params)")
        
        let url = URL(string: "https://online-anytime.com.au/olat/newapi/form/save")!
        
        self.callPost(url: url, token: token, params: params) { (message, data) in
            if message == "success" {
                finish(true)
            } else {
                finish(false)
            }
        }
    }
    
    func fetchFormElement(token: String, formId: Int, finish: @escaping (_ result: Bool?) -> Void) {
        guard let url = URL(string: "https://online-anytime.com.au/olat/newapi/form_elements/\(formId)") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "token")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(FormDetailResponse.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        var formElements: [FormElement]
                        formElements = decodedResponse.forms
                        
                        let formElementDB: FormElementDBHelper = FormElementDBHelper()
                        
                        for formElement in formElements {
                            formElementDB.insert(formId: formId, elementId: formElement.element_id, elementTitle: formElement.element_title, elementGuideline: formElement.element_guidelines, elementType: formElement.element_type, elementPosition: formElement.element_position, elementPageNumber: formElement.element_page_number, elementDefaultValue: formElement.element_default_value, elementConstraint: formElement.element_constraint, elementAddressHideline2: formElement.element_address_hideline2, elementMediaType: formElement.element_media_type, elementMediaImageSrc: formElement.element_media_image_src ?? "", elementMediaPdfSrc: formElement.element_media_pdf_src ?? "")
                        }
                    }
                    finish(true)

                    // everything is good, so we can exit
                    return
                }
            }
            finish(false)

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func fetchFormElementOption(token: String, finish: @escaping (_ result: Bool?) -> Void) {
        guard let url = URL(string: "https://online-anytime.com.au/olat/newapi/form_elements_options") else {
            print("Invalid URL")
            finish(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "token")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(FormElementOptionResponse.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        var formElementOptions: [FormElementOption]
                        formElementOptions = decodedResponse.forms
                        
                        let formOptionDB: FormOptionDBHelper = FormOptionDBHelper()
                        
                        for formElementOption in formElementOptions {
                            formOptionDB.insert(aeoId: formElementOption.aeo_id, formId: formElementOption.form_id, elementId: formElementOption.element_id, optionId: formElementOption.option_id, position: formElementOption.position, option: formElementOption.option, optionIsDefault: formElementOption.option_is_default, optionIsHidden: formElementOption.option_is_hidden, live: formElementOption.live)
                        }
                        
                    }
                    finish(true)
                    return
                }
            }

            // if we're still here it means there was a problem
            finish(false)
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
       }.resume()
    }
    
    func fetchFormData(token: String, finish: @escaping (_ result: Bool?) -> Void) {
        guard let url = URL(string: "https://online-anytime.com.au/olat/newapi/forms") else {
            print("Invalid URL")
            finish(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(FormListResponse.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        var formList: [FormList]
                        formList = decodedResponse.forms
                        
                        let formDB: FormDBHelper = FormDBHelper()
                        
                        for form in formList {
                            formDB.insert(formId: form.form_id, formName: form.form_name, formDescription: form.form_description)
                        }
                    }
                    finish(true)
                    // everything is good, so we can exit
                    return
                }
            }
            finish(false)
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
