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
@synthesize animatedImageView;
@synthesize startOfNewLevel;

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

    if (animatedImageView)
    {
        [animatedImageView removeFromSuperview];
    }
    
    animatedImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    if([[Universe sharedInstance] levelCounter] == 1)
    {
        animatedImageView.animationImages = [NSArray arrayWithObjects: [UIImage imageNamed:@"noodleback.jpg"], nil] ;
    }
    else if ([[Universe sharedInstance] levelCounter] == 2)
    {
        animatedImageView.animationImages = [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"space1.gif"], [UIImage imageNamed:@"space2.gif"],
                                             [UIImage imageNamed:@"space3.gif"], [UIImage imageNamed:@"space4.gif"],
                                             [UIImage imageNamed:@"space5.gif"], [UIImage imageNamed:@"space6.gif"],
                                             [UIImage imageNamed:@"space7.gif"], [UIImage imageNamed:@"space8.gif"],
                                             [UIImage imageNamed:@"space9.gif"], [UIImage imageNamed:@"space10.gif"],
                                             [UIImage imageNamed:@"space11.gif"], [UIImage imageNamed:@"space12.gif"],
                                             [UIImage imageNamed:@"space13.gif"], [UIImage imageNamed:@"space14.gif"],
                                             [UIImage imageNamed:@"space15.gif"], [UIImage imageNamed:@"space16.gif"],
                                             [UIImage imageNamed:@"space17.gif"], [UIImage imageNamed:@"space18.gif"],
                                             [UIImage imageNamed:@"space19.gif"], [UIImage imageNamed:@"space20.gif"],
                                             [UIImage imageNamed:@"space21.gif"], [UIImage imageNamed:@"space22.gif"],
                                             [UIImage imageNamed:@"space23.gif"], [UIImage imageNamed:@"space24.gif"],
                                             [UIImage imageNamed:@"space25.gif"], [UIImage imageNamed:@"space26.gif"],
                                             [UIImage imageNamed:@"space27.gif"], [UIImage imageNamed:@"space28.gif"],
                                             [UIImage imageNamed:@"space29.gif"], [UIImage imageNamed:@"space30.gif"],
                                             [UIImage imageNamed:@"space31.gif"], [UIImage imageNamed:@"space32.gif"],
                                             [UIImage imageNamed:@"space33.gif"], [UIImage imageNamed:@"space34.gif"],
                                             [UIImage imageNamed:@"space35.gif"], [UIImage imageNamed:@"space36.gif"],
                                             [UIImage imageNamed:@"space37.gif"], [UIImage imageNamed:@"space38.gif"], nil];
    }
    else if ([[Universe sharedInstance] levelCounter] == 3)
    {
        animatedImageView.animationImages = [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"snow1.gif"], [UIImage imageNamed:@"snow2.gif"],
                                             [UIImage imageNamed:@"snow3.gif"], [UIImage imageNamed:@"snow4.gif"],
                                             [UIImage imageNamed:@"snow5.gif"], [UIImage imageNamed:@"snow6.gif"],
                                             [UIImage imageNamed:@"snow7.gif"], [UIImage imageNamed:@"snow8.gif"],
                                             [UIImage imageNamed:@"snow9.gif"], [UIImage imageNamed:@"snow10.gif"],
                                             [UIImage imageNamed:@"snow11.gif"], [UIImage imageNamed:@"snow12.gif"],
                                             [UIImage imageNamed:@"snow13.gif"], [UIImage imageNamed:@"snow14.gif"],
                                             [UIImage imageNamed:@"snow15.gif"], [UIImage imageNamed:@"snow16.gif"],
                                             [UIImage imageNamed:@"snow17.gif"], [UIImage imageNamed:@"snow18.gif"],
                                             [UIImage imageNamed:@"snow19.gif"], [UIImage imageNamed:@"snow20.gif"], nil];
    }
    animatedImageView.animationDuration = 1.0f;
    animatedImageView.animationRepeatCount = 0;
    [animatedImageView startAnimating];
    [self addSubview: animatedImageView];
    
    CGRect bounds = [self bounds];
    float width = 50;
    float height = 10;
    
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
            [b setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noodlebrick.png"]]];
            [self setBackgroundColor:[UIColor purpleColor]];
            [_Level setText:@"Level 1"];
            
            
        }
        else if ([[Universe sharedInstance] levelCounter] == 2)
        {
            [b setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"spacebrick.png"]]];
            [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"spacebackground.gif"]]];
            [_Level setText:@"Level 2"];
        }
        else if ([[Universe sharedInstance] levelCounter] == 3)
        {
            [b setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"snowbrick.png"]]];
            [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"snow.gif"]]];
            [_Level setText:@"Level 3"];
        }
        else
            [_Level setText:@"Level"];
        
        [self addSubview:b];
        x = rand() % (int)(bounds.size.width * .8) + width/2;
       // NSLog(@"X %f", x);
        
        y = (int)(bounds.size.height/11 * i + 37);
        
       // NSLog(@"Y %f", y);
        
        [b setCenter:CGPointMake(x , y)];
        [bricks addObject:b];
    }
   // Brick *c = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    //[c setBackgroundColor:[UIColor blackColor]];
    //[c setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"noodle.png"]]];
    //[self addSubview:c];
    //[c setCenter:CGPointMake(bounds.size.width/2 , bounds.size.height-150)];
    //[bricks addObject:c];
}

-(void) startLevel
{
    startOfNewLevel = YES;
    CGRect bounds = [self bounds];
    
    jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height-50, 50, 50)];
    
    [jumper setDx:0];
    [jumper setDy:10];
    
    if([[Universe sharedInstance] switchStatus])
    {
        if([[Universe sharedInstance] levelCounter] == 1)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ninja.png"]]];
        
        else if([[Universe sharedInstance] levelCounter] == 2)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"astro.png"]]];
        
        else if([[Universe sharedInstance] levelCounter] == 3)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"snowman.png"]]];
        
    }
    else
    {
        if([[Universe sharedInstance] levelCounter] == 1)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"superman.png"]]];
        
        else if ([[Universe sharedInstance] levelCounter] == 2)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ironman.png"]]];
        
        else if ([[Universe sharedInstance] levelCounter] == 3)
            [jumper setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"batman.png"]]];
    }
    
    [self makeBricks:nil];
    [self addSubview:jumper];
    
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
    if (p.y > bounds.size.height-25)
    {
        p.y = bounds.size.height-25;
        if (startOfNewLevel)
        {
            [jumper setDy:10];
        }
        else
        {
            [self gameLoose];
        }
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
            //[self startLevel];
            //temp commenting below and putting above call
            [self gameWin];
        }

    }
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0)
        p.x += bounds.size.width;
    if (p.x > bounds.size.width)
        p.x -= bounds.size.width;
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    //
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            CGRect b = [brick frame];
            //NSLog(@" %d   %d", b, p);
            
            p.y += 17;
            if (CGRectContainsPoint(b, p))
            //CGPoint temp = [brick center];
            //if(temp.x == p.x && temp.y == p.y)
            {
             //   NSLog(@"Brick Point %@", NSStringFromCGRect(b));
               // NSLog(@"Jumper Point %@", NSStringFromCGPoint(p));
                // Yay!  Bounce!
                NSLog(@"Bounce!");
                [jumper setDy:10];
                startOfNewLevel = NO;
            }
            p.y -= 17;
        }
    }
    //p.y -= 117;
    
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}


-(void) gameLoose
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Game Over" message:@"You LOST!!! Press Cancel or Play Again." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Play Again", @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"Play Again Selected");
                                   [self playAgain];
                               }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"Cancel Selected");
                               }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    NSLog(@"Game Loose");
    
    UIViewController *vc = [self parentViewController];
    [vc presentViewController:alertController animated:YES completion:nil];
    
    [self reset];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    [text setText:@"YOU LOOSE"];
    [text setFont:[UIFont systemFontOfSize:30]];
    [text setAdjustsFontSizeToFitWidth:YES];
    [text setCenter:CGPointMake((int)self.bounds.size.width/2, 100)];
    [self addSubview: text];
    
    UIImageView *gameLooseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameloose.jpg"]];
    [gameLooseImageView setCenter:CGPointMake((int)self.bounds.size.width/2, (int)self.bounds.size.height/2)];
    [self addSubview: gameLooseImageView];
    
    [[[Universe sharedInstance] displayLink] removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
-(void) gameWin
{
    NSLog(@"Game WIN");
    
    [self reset];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    [text setText:@"YOU WIN"];
    [text setFont:[UIFont systemFontOfSize:30]];
    [text setAdjustsFontSizeToFitWidth:YES];
    [text setCenter:CGPointMake((int)self.bounds.size.width/2, 100)];
    [self addSubview: text];
    
    UIImageView *gameWinImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gamewin.jpg"]];
    [gameWinImageView setCenter:CGPointMake((int)self.bounds.size.width/2, (int)self.bounds.size.height/2)];
    [self addSubview: gameWinImageView];
    
    [[[Universe sharedInstance] displayLink] removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void) reset
{
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    if (jumper)
    {
        [jumper setDx:0];
        [jumper setDy:0];
        [jumper removeFromSuperview];
    }
    
    if (animatedImageView)
    {
        [animatedImageView removeFromSuperview];
    }
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [[Universe sharedInstance] setLevelCounter:1];
}

//Not used, may need later
- (void) playAgain
{
    [[[Universe sharedInstance] displayLink] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self reset];
    [self startLevel];
}


- (IBAction)back
{
    [self reset];
    [[Universe sharedInstance] setSwitchStatus:NO];
}


//Referenced below method from http://stackoverflow.com/questions/1372977/given-a-view-how-do-i-get-its-viewcontroller
- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
    return (UIViewController *)responder;
}
@end
