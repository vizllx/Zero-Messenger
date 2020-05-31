//
//  ZeroUsersFetcher.swift
//  ZeroMessger
//
//  Created by Sandeep Mukherjee on 5/22/20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit
import Firebase
import PhoneNumberKit
import SDWebImage

protocol ZeroUsersUpdatesDelegate: class {
  func zeroUsers(shouldBeUpdatedTo users: [User])
}

public var shouldReFetchZeroUsers: Bool = false

class ZeroUsersFetcher: NSObject {
  
  let phoneNumberKit = PhoneNumberKit()
  var users = [User]()
  
  weak var delegate: ZeroUsersUpdatesDelegate?
  
  var userReference: DatabaseReference!
  var userQuery: DatabaseQuery!
  var userHandle = [DatabaseHandle]()
  var group = DispatchGroup()

  
  fileprivate func clearObserversAndUsersIfNeeded() {
    self.users.removeAll()
    if userReference != nil {
      for handle in userHandle {
        userReference.removeObserver(withHandle: handle)
      }
    }
  }
  
  func fetchZeroUsers(asynchronously: Bool) {
    clearObserversAndUsersIfNeeded()
    
    if asynchronously {
      print("fetching async")
      fetchAsynchronously()
    } else {
      print("fetching sync")
      fetchSynchronously()
    }
  }
  
  fileprivate func fetchSynchronously() {
    
    var preparedNumbers = [String]()
    
    for number in localPhones {
      do {
        let countryCode = try phoneNumberKit.parse(number).countryCode
        let nationalNumber = try phoneNumberKit.parse(number).nationalNumber
        let phNumber = (String(countryCode) + String(nationalNumber))

        if(phNumber == "919038865312" || phNumber == "919038865313")
               {
                preparedNumbers.append("+" + String(countryCode) + String(nationalNumber))
                
        }
       
        group.enter()
        print("entering group")
      } catch {}
    }
    
    group.notify(queue: DispatchQueue.main, execute: {
      print("COntacts load finished Zero")
      self.delegate?.zeroUsers(shouldBeUpdatedTo: self.users)
    })
    
    for preparedNumber in preparedNumbers {
        if(preparedNumber.isEmpty)
               {
                    group.notify(queue: DispatchQueue.main, execute: {
                         print("COntacts load finished Zero")
                         self.delegate?.zeroUsers(shouldBeUpdatedTo: self.users)
                       })
               }
               else
               {
                   fetchAndObserveZeroUser(for: preparedNumber, asynchronously: true)
               }
    }
  }
  
  fileprivate func fetchAsynchronously() {
    var preparedNumber = String()
    
    
    for number in localPhones {
      do {
        let countryCode = try phoneNumberKit.parse(number).countryCode
        let nationalNumber = try phoneNumberKit.parse(number).nationalNumber
        let phNumber = (String(countryCode) + String(nationalNumber))
        if(phNumber == "919038865312" || phNumber == "919038865313")
        {
            preparedNumber = "+" + String(countryCode) + String(nationalNumber)
        }
      } catch {}
        if(preparedNumber.isEmpty)
        {
             self.delegate?.zeroUsers(shouldBeUpdatedTo: self.users)
        }
        else
        {
            fetchAndObserveZeroUser(for: preparedNumber, asynchronously: true)
        }
    }
  }
  
  fileprivate func fetchAndObserveZeroUser(for preparedNumber: String, asynchronously: Bool) {
    if preparedNumber.isEmpty {
        return
    }
    print("fetchAndObserveZeroUser:- ",preparedNumber)
    userReference = Database.database().reference().child("users")
    userQuery = userReference.queryOrdered(byChild: "phoneNumber")
    let databaseHandle = DatabaseHandle()
    userHandle.insert(databaseHandle, at: 0 )
    userHandle[0] = userQuery.queryEqual(toValue: preparedNumber).observe(.value, with: { (snapshot) in
      
      if snapshot.exists() {
        guard let children = snapshot.children.allObjects as? [DataSnapshot] else { return }
        for child in children {
          guard var dictionary = child.value as? [String: AnyObject] else { return }
          dictionary.updateValue(child.key as AnyObject, forKey: "id")
          if let thumbnailURLString = User(dictionary: dictionary).thumbnailPhotoURL, let thumbnailURL = URL(string: thumbnailURLString) {
            SDWebImagePrefetcher.shared.prefetchURLs([thumbnailURL])
          }
            if let index = self.users.firstIndex(where: { (user) -> Bool in
            return user.id == User(dictionary: dictionary).id
          }) {
            self.users[index] = User(dictionary: dictionary)
          } else {
            self.users.append(User(dictionary: dictionary))
          }
          
          self.users = self.sortUsers(users: self.users)
          self.users = self.rearrangeUsers(users: self.users)
          
					if let index = self.users.firstIndex(where: { (user) -> Bool in
            return user.id == Auth.auth().currentUser?.uid
          }) {
            self.users.remove(at: index)
          }
        }
        
        if asynchronously {
          self.delegate?.zeroUsers(shouldBeUpdatedTo: self.users)
        }
      }
      
      if !asynchronously {
        self.group.leave()
        print("leaving group")
      }
    
    }, withCancel: { (error) in
      print("error")
      //search error
    })
  }
  
  func rearrangeUsers(users: [User]) -> [User] { /* Moves Online users to the top  */
    var users = users
    guard users.count - 1 > 0 else { return users }
    for index in 0...users.count - 1 {
      if users[index].onlineStatus as? String == statusOnline {
        users = rearrange(array: users, fromIndex: index, toIndex: 0)
      }
    }
    return users
  }
  
  func sortUsers(users: [User]) -> [User] { /* Sort users by last online date  */
    return users.sorted(by: { (user1, user2) -> Bool in
      if let firstUserOnlineStatus = user1.onlineStatus as? TimeInterval , let secondUserOnlineStatus = user2.onlineStatus as? TimeInterval {
        return (firstUserOnlineStatus, user1.phoneNumber ?? "") > ( secondUserOnlineStatus, user2.phoneNumber ?? "")
      } else {
        return ( user1.phoneNumber ?? "") > (user2.phoneNumber ?? "") // sort
      }
    })
  }
}
