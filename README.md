
Alamofire - swift 代理请求封装，闭包回调封装

用法

override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.accessToServerForGetLogin()
    }
    
    func accessToServerForGetLogin(){
        
        
        let parameters:NSDictionary = [
            "menu": "土豆",
            "pn":  1,
            "rn": "10",
            "key": "2ba215a3f83b4b898d0f6fdca4e16c7c",
            ]
        
        
//        MARK: 闭包回调请求
        NetWorkRequest.requestData(.post, URLString: URL, nameString: loginName, parameters: parameters as NSDictionary) { (result) in
            DLog(result)
        }
        //MARK: 代理请求
        NetWorkRequest.netWorkRequestData(.post, URLString: URL, nameString: loginName, parameters: parameters, responseDelegate: self)
    
        
    }
    //MARK:实现网络请求协议中的方法 --请求成功
    internal func netWorkRequestSuccess(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int){
        if requestName == loginName{
            DLog("\(data):(\(requestName):(\(parameters):(\(statusCode))")
        }else if (requestName == exitName){
            
        }
        
    }
    //MARK:实现网络请求协议中的方法 --请求失败或者服务器指定返回400等statusCode
    internal func netWorkRequestFailed(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int){
        DLog("\(data):(\(requestName):(\(parameters):(\(statusCode))")
    }
