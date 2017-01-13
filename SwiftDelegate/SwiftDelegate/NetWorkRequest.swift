//
//  NetWorkRequest.swift
//  SwiftDelegate
//
//  Created by wangzhifei on 2017/1/13.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

import Alamofire

@objc protocol NetWorkRequestDelegate:NSObjectProtocol  {
    //设置协议方法
    @objc optional func netWorkRequestSuccess(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)
    @objc optional func netWorkRequestFailed(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)
    
}

class NetWorkRequest: NSObject {

    weak var delegate:NetWorkRequestDelegate?
    static var manager:SessionManager? = nil
    
    //MARK: 闭包回调请求
    class func requestData(_ type : HTTPMethod, URLString : String,nameString : String, parameters : NSDictionary, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Token QWxhZGRpbjpvcGVuIHNlc2FtZQ",
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        Alamofire.request(URLString, method: type, parameters: parameters as? Parameters, headers: headers).responseJSON { (response) in
            
            if response.result.isSuccess{
                let data = response.result.value
                let json = JSON(data as Any)
                finishedCallback(json)
                
            }else{
                finishedCallback(response)
            }
            
        }
        
        
    }
    //MARK: 代理请求
    class func netWorkRequestData(_ type : HTTPMethod, URLString : String,nameString : String, parameters : NSDictionary,responseDelegate : AnyObject) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Token QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        //配置 , 通常默认即可
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        
        //设置超时时间为10S
        config.timeoutIntervalForRequest = NetworkTimeoutTime
        manager = SessionManager(configuration: config)
        manager?.request(URLString, method: type, parameters: parameters as? Parameters, headers: headers).responseJSON { (response) in
            
            if response.result.isSuccess{
                let data = response.result.value
                let json = JSON(data as Any)
                if json .isEmpty{
                    return
                }
                self .successResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                
                
            }else{
                let data = response.result.value
                let json = JSON(data as Any)
                if json .isEmpty{
                    return
                }
                
                self .failedResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
            }
            
        }
        
        
    }
    //MARK: 请求成功代理
    class func successResponseDatas(responseData:AnyObject,responseDelegate:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)  {
        
        responseDelegate.netWorkRequestSuccess?(data: responseData, requestName: requestName, parameters: parameters, statusCode: statusCode)
        
        
    }
    //MARK: 请求失败代理
    class func failedResponseDatas(responseData:AnyObject,responseDelegate:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)  {
        responseDelegate.netWorkRequestFailed?(data: responseData, requestName: requestName, parameters: parameters, statusCode: statusCode)
        
    }
    
    //MARK: 图片，视频等文件上传
    func upLoadFileRequest(method : HTTPMethod , urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            //MARK：这里根据服务器给的参数自行修改
            let key = params["key"]
            let key1 = params["key1"]
            
            multipartFormData.append((key?.data(using: String.Encoding.utf8)!)!, withName: "name")
            multipartFormData.append( (key1?.data(using: String.Encoding.utf8)!)!, withName: "key1")
            
            multipartFormData.append(data[0], withName: "photo", fileName: name[0], mimeType: "image/png")
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: urlString, method: method, headers: headers) { encodingResult in
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        DLog(json)
                        
                    }
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
        }
   
    }
    
    
    
}
