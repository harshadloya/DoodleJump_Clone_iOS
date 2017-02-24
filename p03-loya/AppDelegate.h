//
//  AppDelegate.h
//  p03-loya
//
//  Created by Harshad Loya on 2/18/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Universe.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

