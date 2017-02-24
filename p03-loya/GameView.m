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
@synthesize x, y;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder
{
    [[Universe sharedInstance] setLevelCounter:1];
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self startLevel];
    }
    return self;
}

-(void)makeBricks:(id)sender
{
    CGRect bounds = [self bounds];
    float width = 100;
    float height = 167;
    
    srand(time(NULL));
    
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
        
        if([[Universe sharedInstance] levelCounter] == 1)
        {
            [b setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noodle.png"]]];
            [self setBackgroundColor:[UIColor purpleColor]];
            [_Level setText:@"Level 1"];
        }
        else if ([[Universe sharedInstance] levelCounter] == 2)
        {
            [b setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noodle.png"]]];
            [self setBackgroundColor:[UIColor blueColor]];
            [_Level setText:@"Level 2"];
        }
        else if ([[Universe sharedInstance] levelCounter] == 3)
        {
            [b setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noodle.png"]]];
            [self setBackgroundColor:[UIColor lightGrayColor]];
            [_Level setText:@"Level 3"];
        }
        else
            [_Level setText:@"Level"];
        
        [self addSubview:b];
        x = rand() % (int)(bounds.size.width * .8) + width/2;
        NSLog(@"X %f", x);
        
        y = (int)(bounds.size.height/11 * i + 37);
        
        NSLog(@"Y %f", y);
        
        [b setCenter:CGPointMake(x , y)];
        [bricks addObject:b];
    }
    
}

-(void) startLevel
{
    CGRect bounds = [self bounds];
    
    
    NSLog(@"Brick Point %f", bounds.size.width/2);
    NSLog(@"Jumper Point %f", bounds.size.height - 50);
    jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height-50, 50, 50)];
    
    [jumper setDx:0];
    [jumper setDy:5];
    
    if([[Universe sharedInstance] switchStatus])
    {
        if([[Universe sharedInstance] levelCounter] == 1)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"snowman.png"]]];
        
        else if([[Universe sharedInstance] levelCounter] == 2)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"astro.png"]]];
        
        else if([[Universe sharedInstance] levelCounter] == 3)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"original.png"]]];
        
    }
    else
    {
        if([[Universe sharedInstance] levelCounter] == 1)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ironman.png"]]];
        
        else if ([[Universe sharedInstance] levelCounter] == 2)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"batman.png"]]];
        
        else if ([[Universe sharedInstance] levelCounter] == 3)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"superman.png"]]];
    }
    
    [self addSubview:jumper];
    [self makeBricks:nil];
}

-(void)arrange:(CADisplayLink *)sender
{
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .3];
    
   
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
    if (p.y > bounds.size.height-23)
    {
        [jumper setDy:5];
        p.y = bounds.size.height-23;
    }
    
    // If we've gone past the top of the screen, wrap around
    if (p.y < 0)
    {
        //p.y += bounds.size.height;
        p.y = bounds.size.height;
        [jumper removeFromSuperview];
        
        //NSLog(@"Count %d", [[Universe sharedInstance] levelCounter]);
        if([[Universe sharedInstance] levelCounter] < 3)
        {
            [[Universe sharedInstance] setLevelCounter:([[Universe sharedInstance] levelCounter] + 1)];
            [self startLevel];
        }
        else
        {
            [[Universe sharedInstance] setLevelCounter:1];
            [self startLevel];
            //temp commenting below and putting above call
            //[self gameWin];
        }

    }
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
            //NSLog(@" %d   %d", b, p);
            
            p.y -= 23;
            if (CGRectContainsPoint(b, p))
            {
             //   NSLog(@"Brick Point %@", NSStringFromCGRect(b));
               // NSLog(@"Jumper Point %@", NSStringFromCGPoint(p));
                // Yay!  Bounce!
                NSLog(@"Bounce!");
                [jumper setDy:10];
            }
            p.y += 23;
        }
    }
    
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}

-(void) gameWin
{
    NSLog(@"You passed all levels, congrats you win.");
    //alert to pop up instead of exit
    exit(0);
}

@end
