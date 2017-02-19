//
//  GameView.m
//  p03-loya
//
//  Created by Harshad Loya on 2/19/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import "GameView.h"

@implementation GameView
@synthesize jumper;
@synthesize bricks;
@synthesize tilt;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(IBAction)makeBricks:(id)sender
{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
    
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++i)
    {
        Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [b setBackgroundColor:[UIColor blueColor]];
        [self addSubview:b];
        [b setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), rand() % (int)(bounds.size.height * .8))];
        [bricks addObject:b];
    }
}

-(void) arrange:(CADisplayLink *) sender
{
    
}

@end
