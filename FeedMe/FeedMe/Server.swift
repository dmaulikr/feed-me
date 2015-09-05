//
//  Server.swift
//  FeedMe
//
//  Created by Jordan Brown on 9/5/15.
//  Copyright (c) 2015 woosufjordaline. All rights reserved.
//

import UIKit

class Server: NSObject {
    var domain = "http://ec2-52-10-65-63.us-west-2.compute.amazonaws.com/api.php"
    var friends = [Int]();
    
    func doesUserExist(user: User) -> Bool {
        let url = NSURL(string: domain + "?action=check_user_exists&f_id=" + (user.fbid as String))
        var data = NSData(contentsOfURL: url!)
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            if let val = json["val"] as? NSNumber {
                return val.integerValue > 0
            }
        }
        return false;
    }
    
    func createUser(user: User) -> Bool {
        let urlString = domain + "?action=create_user&f_id=" + (user.fbid as String) + "&name=" + (user.name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)! as String)
        let url = NSURL(string: urlString)
        var data = NSData(contentsOfURL: url!)
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            if let val = json["val"] as? NSNumber {
                return val.integerValue > 0
            }
        }
        return false;
    }
    
    func createFriendship(user1: User, user2: User) -> Bool {
        let urlString = domain + "?action=create_relationship&f_id1=" + (user1.fbid as String) + "&f_id2" + (user2.fbid as String)
        let url = NSURL(string: urlString)
        var data = NSData(contentsOfURL: url!)
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            if let val = json["val"] as? NSNumber {
                return val.integerValue > 0
            }
        }
        return false;
    }
    
    func getAllFriends(user: User) -> [User] {
        println("getting friends")
        let urlString = domain + "?action=get_all_relationships&f_id=" + (user.fbid as String)
        println(urlString)
        let url = NSURL(string: urlString)
        var data = NSData(contentsOfURL: url!)
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            println(json)
            if let val = json["val"] as? NSArray {
                // This is na array of fbids
                // You have to generate local user's friends and check here to see which names match which ids 
                // so we can create the users
                println(val[0]);
                
            }
        }
        
        return [];
    }
    
    func getNameForID(id: String) -> String {
        return "";
    }
    
}
