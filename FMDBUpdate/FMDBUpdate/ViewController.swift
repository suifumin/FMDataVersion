//
//  ViewController.swift
//  FMDBUpdate
//
//  Created by zhijibeijing on 2022/4/20.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        
        
        
        
        
    }

    //判断是否存在数据库
    func veriIsHaveDB() -> Bool {
        let flag = FileManager.default.fileExists(atPath: self.getDBfilePath())
        return flag
    }
    
    //获取数据库路径
    func getDBfilePath() -> String {
        let filePath = "\(NSHomeDirectory())/My.sqlite"
        return filePath
        
    }
    
    
    
    
    //创建版本信息
    func setDBInfoValueWithString(str: String) -> Bool {
        if self.getFMDBVersionInfo() != nil {//之前有版本号 直接更新
            self.updateVersionInfoWithString(str: str)
        } else {//之前没有版本号，称初始化给一个版本号
            self.insertVersionInfoWithString(version: str)
        }
        return true
    }
    //更新版本号
    func updateVersionInfoWithString(str: String) -> Bool {
        let sql = "update t_info set version = ?"
        let flag = self.dataBase.executeUpdate(sql, withArgumentsIn: [])
        return flag
    }
    
    //插入版本号
    func insertVersionInfoWithString(version: String) -> Bool{
        let insertsql = "insert into t_info (version) values (?)"
        let flag = self.dataBase.executeUpdate(insertsql, withArgumentsIn: [])
        return flag
    }
    
    //获取数据库版本信息
    func getFMDBVersionInfo() -> String? {
        let sqliteserch = "select version from t_info"
        
        //打开数据库
        self.dataBase.open()
        
        let resultSet: FMResultSet = self.dataBase.executeQuery(sqliteserch, withArgumentsIn: [])!
        var version: String?
        while ((resultSet.next())) {
            version = resultSet.string(forColumn: "version") ?? nil
        }
        return version
        
    }

    //初始化数据库
    func initDataBase() {
       self.dataBase = FMDatabase(path: self.getDBfilePath())
        if self.dataBase != nil {
            print("数据库创建成功")
        } else {
            print("数据库创建失败")
        }
        
    }
    //执行数据库语句
    func createSqliteTabel(createsql: String) -> Bool{
        let flag = self.dataBase.executeUpdate(createsql, withArgumentsIn: [])
        if flag == true {
            print("表创建成功")
        } else {
            print("表创建失败")
        }
        return flag
        
    }
    
    
    
    
}

