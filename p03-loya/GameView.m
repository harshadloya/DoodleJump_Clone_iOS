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

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        CGRect bounds = [self bounds];
        
        jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height - 20, 78, 70)];
        [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"original.png"]]];
        [jumper setDx:0];
        [jumper setDy:10];
        [self addSubview:jumper];
        [self makeBricks:nil];
    }
    return self;
}
	-(IBAction)makeBricks:(id)sender
{
    CGRect bounds = [self bounds];
    float width = (bounds.size.width * .2) + 40;
    float height = 167;
    
    
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    NSLog(@"Size of Bricks %f %f", width, height);
    bricks = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; ++i)
    {
        Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [b setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noodle.png"]]];
        [self addSubview:b];
        [b setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), rand() % (int)(bounds.size.height * .8))];
        [bricks addObject:b];
    }
    
}

-(void)arrange:(CADisplayLink *)sender
{
   // CFTimeInterval ts = [sender timestamp];
    
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .3];
    
   // NSLog(@"Tilt %f", tilt);
    // Apply the tilt.  Limit maximum tilt to + or - 5
    [jumper setDx:[jumper dx] + tilt];
    if ([jumper dx] > 5)
        [jumper setDx:5];
    if ([jumper dx] < -5)
        [jumper setDx:-5];
    
    // Jumper moves in the direction of gravity
    CGPoint p = [jumper center];
    p.x += [jumper dx];
    p.y -= [jumper dy];
    
    // If the jumper has fallen below the bottom of the screen,
    // add a positive velocity to move him
    if (p.y > bounds.size.height)
    {
        [jumper setDy:10];
        p.y = bounds.size.height;
    }
    
    // If we've gone past the top of the screen, wrap around
    if (p.y < 0)
        p.y += bounds.size.height;
    
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0)
        p.x += bounds.size.width;
    if (p.x > bounds.size.width)
        p.x -= bounds.size.width;
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            CGRect b = [brick frame];
            if (CGRectContainsPoint(b, p))
            {
                // Yay!  Bounce!
                NSLog(@"Bounce!");
                [jumper setDy:10];
            }
        }
    }
    
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}


@end
