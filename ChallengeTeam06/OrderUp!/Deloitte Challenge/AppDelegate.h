//
//  AppDelegate.h
//  Deloitte Challenge
//
//  Created by Chelsea Rath on 1/28/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *helpButtons;
@property (strong, nonatomic) NSMutableDictionary *helpButtonValues;
@property (strong, nonatomic) NSMutableArray *xmlArray;

@end