//
//  SessionManager.m
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager
@synthesize delegate;
@synthesize connectedPeers;


// Controller available methods
-(id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

-(void)sendInvitationsWithMessage: (NSString*)message ToPeers: (NSArray*)peers
{
    
}


// Internal methods
-(void)beginSession
{
    
}

-(void)endSession
{
    
}

-(void)receiveData:(NSData *)data
          fromPeer:(NSString *)peer
         inSession:(GKSession *)session
           context:(void *)contex
{
    
}

@end
