//
//  FMDBUpdate.swift
//  FMDBUpdate
//
//  Created by zhijibeijing on 2022/4/20.
//

import UIKit

class FMDBUpdate: NSObject {
    let createTB_info: String = "create table if not exists t_info (version text)"
    let create_tusersql: String = "CREATE TABLE IF NOT EXISTS T_User (userid INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, username TEXT, usergender TEXT, usercreatetime date, userupdatetime date,age INTEGER,islogined INTEGER)"
    let update_tusersql: String = "alter table T_User  add  column useraddress TEXT"
    let modify = "alter table T_User add column password text not null default '111111'"
   
   var dataBase: FMDatabase!
   var dbversion = "1.0"
    
    
    override init() {
        if self.veriIsHaveDB() == false {//不存在数据库
            //初始化数据库
        } else {
            //获取数据库的版本信息
            self.dataBase = FMDatabase(path: self.getDBfilePath())
            let currentVersion = self.getFMDBVersionInfo()
            self.dbversion = currentVersion!
        }
        switch self.dbversion {
          
        case "1.0":
            do {
                //说明用户第一次安装  1.0版本
                //创建版本表
                self.createSqliteTabel(createsql: createTB_info)
                //创建信息表
                self.createSqliteTabel(createsql: create_tusersql)
                //保存1.0+1.0信息到数据库   用于下一次判断版本号
                self.setDBInfoValueWithString(str: "2.0")
            }
        case "2.0":
            do {
                //更新信息表
                self.createSqliteTabel(createsql: update_tusersql)
                //保存2.0+1.0到数据库
                self.setDBInfoValueWithString(str: "3.0")
                
            }
        case "3.0":
            do {
                //更新信息表
                self.createSqliteTabel(createsql: modify)
                //保存2.0+1.0到数据库
                self.setDBInfoValueWithString(str: "4.0")
                
            }
        default:
            break
        
        }
        
    }
    
    
}
