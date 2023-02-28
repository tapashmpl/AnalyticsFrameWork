//
//  ClevertapManager.swift
//  MPLggx
//
//  Created by Tapash Mollick on 16/02/23.
//

import Foundation
//import CleverTapSDK

public protocol ClevertapManagerDelegate {
     func setup()
     func sendGGXWebEvent(eventName: String, eventGGXData: [AnyHashable: Any]?)
}

public class ClevertapManager {
    public static let shared = ClevertapManager()
    private init(){}

    public func setup() {
        fetchcleverTapId()
        fetchcleverTapToken()
        /*CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(0)*/
    }

    public  func sendGGXWebEvent(eventName: String, eventGGXData: [AnyHashable: Any]?) {
        guard var eventGGXData = eventGGXData else { return debugPrint("eventProperties was nil, while sending event" + eventName) }
        debugPrint("GGXDebug: sendEvent() called eventName \(eventName)")
        debugPrint("\n GGXDebug: sendEvent() called eventGGXData \(eventGGXData)")
       // CleverTap.sharedInstance()?.recordEvent(eventName, withProps: eventGGXData)
        /*val eventBuilder = EventsBuilder()
         eventBuilder.name = eventName
         eventGGXData.entries.forEach { map ->
         eventBuilder.put(map.key, map.value)
         }
         eventBuilder.build()
         Timber.d("GGXDebug:sendEvent() $eventBuilder")
         appAnalytic?.track(eventBuilder)*/
    }

    func fetchcleverTapId() -> String {
        let dictionary = getPlist(withName: "Analyticsinfo")
        let CleverTapAccountID = dictionary?["CleverTapAccountID"] as! String
        return CleverTapAccountID
    }

    func fetchcleverTapToken() -> String {
        let dictionary = getPlist(withName: "Analyticsinfo")
        let CleverTapAccountToken = dictionary?["CleverTapToken"] as! String
        return CleverTapAccountToken
    }

    func getPlist(withName name: String) -> NSDictionary?
    {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist") else { return nil }

        let url = URL(fileURLWithPath: path)

        let data = try! Data(contentsOf: url)

        guard let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [[String:String]] else {return nil }

        print(plist)
        return nil


//        if let path = Bundle.main.path(forResource: name, ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? NSDictionary
//        {
//            return dict
//        }
//        return nil
    }


}
