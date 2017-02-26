//
//  Universe.h
//  p03-loya
//
//  Created by Harshad Loya on 2/23/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Universe : NSObject

@property (nonatomic) BOOL switchStatus;
+(Universe *)sharedInstance;
@property (nonatomic) int levelCounter;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end
