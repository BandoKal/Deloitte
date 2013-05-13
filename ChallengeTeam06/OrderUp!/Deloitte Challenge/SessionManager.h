//
//  SessionManager.h
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//
//    Redistribution and use in source and binary forms, with or without
//    modification, are permitted provided that the following conditions are met:
//
//    1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
//    2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//    POSSIBILITY OF SUCH DAMAGE.


// Available Constants: SESSION_ID

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "Member.h"
#import "OrderUp.h"

typedef NS_ENUM(NSUInteger, MessageType ){ // enum type for the type of messages being sent
    
    SMAlertMessage = 0, // message is intended to be an UIAlertView
    SMLocalMessage = 1 // message can be used to update table or other "non" user interaction label
};

typedef NS_ENUM(NSUInteger, OrderChangeType){ // enum type for the kind of changes being made to an order
    
    SMCancelOrder = 0, // order is to be removed...
                       // Note: this member with not appear in the connectedPeers property if selected
    SMAddOrder = 1, // order is to be added.
                    // Note: member is added to connectedPeers property if selected
    SMChangeOrder = 2 // order data is being modified.
};




@class SessionManager;
@protocol SessionManagerDelegate <NSObject>

@required
// This method is called by the Session Manager when
// a message has been received from a peer.
// param list:
//          message => string of the message
//          messageType => enum type that will tell receiver
//                     how manager intends the message to
//                     be handled. see ENUM typdef above
//          manager => the sending manager
-(void)updateUIFromMessage:(NSString*) message
                    ofType:(MessageType) messageType
               fromManager: (SessionManager*) manager;


// This method is called by Session Manager when
// member states are changed. Please note member states
// can be changed by user events or network events.
// param list:
//              localOrder => the target order
//              localMember => target member (entire member object passed)
//              orderChangeType => enum type that will tell receiver
//                                 what type of modification is happening
//                                 to the member. see ENUM typedef above
//              manager => the sending manager
-(void)updateOrdersWithOrder: (OrderUp*) localOrder
                  FromMember: (Member*) localMember
              withChangeType: (OrderChangeType) orderChangeType
                 fromManager: (SessionManager*)manager;

@end



@interface SessionManager : NSObject <GKSessionDelegate>
{
    NSTimer *sessionTimer; // used for demo purposes ... this will poll available peers
    GKSession *session; // connection portal
    NSMutableArray *availablePeers; 
    
}

@property (strong,nonatomic) NSMutableArray *connectedPeers;
@property (strong, nonatomic) id<SessionManagerDelegate> delegate;

// Controller available methods
-(id)init;
-(void)sendInvitationsWithMessage: (NSString*)message ToPeers: (NSArray*)peers;

// Internal methods
-(void)beginSession;
-(void)endSession;
-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)contex;



@end
