//
//  Connection.swift
//  ios_assignment_jenius
//
//  Created by Yesiska Putri on 13/10/18.
//  Copyright © 2018 yesiska. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

protocol MainCallback{
    func onSuccessResponse<T>(message: String, response: DataResponse<T>)
    //func onFailedResponse<T>(message: String, object: AnyObject, response: DataResponse<T>)
    //func onFailureResponse(message: String, object: AnyObject)
}

class ConnectionManager {
    
    var mainCallback: MainCallback?
    var view: UIView!
    var viewController: UIViewController?
    
    func connectionCallback<T>(responseData: DataResponse<T>) -> Void{
        let statusResponse = responseData.result
        var message = ""
        
        if statusResponse.isSuccess {
            print("success")
            let mainResponse = responseData.result.value as? BaseResponse
            message = mainResponse?.message ?? ""
            
            if let httpStatusCode = responseData.response?.statusCode {
                if httpStatusCode >= 200 && httpStatusCode < 400{
                    print("200")
                    mainCallback?.onSuccessResponse(message: message, response: responseData)
                } else {
                    print("< 200")
                    showErrorAlert(message: message)                    
                }
            }
        } else {
            print("failed")
            showErrorAlert(message: "We are having trouble. Please try again")
        }
        
    }
    
    private func showErrorAlert(message: String?) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okBtn)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
