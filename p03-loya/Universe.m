//
//  Universe.m
//  p03-loya
//
//  Created by Harshad Loya on 2/23/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import "Universe.h"

@implementation Universe

@synthesize switchStatus;
@synthesize levelCounter;
@synthesize displayLink;

static Universe *singleton = nil;

-(id)init
{
    if (singleton)
        return singleton;
    
    self = [super init];
    if (self)
    {
        singleton = self;
    }
    
    return self;
}

+(Universe *)sharedInstance
{
    if (singleton)
        return singleton;
    
    return [Universe init];
}

@end
