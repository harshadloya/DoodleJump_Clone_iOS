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
@synthesize bricks, brickCenters;
@synthesize tilt;
@synthesize x, y;
@synthesize animatedImageView;
@synthesize startOfNewLevel;
@synthesize brickVerticalMovers, brickHorizontalMovers;

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
    brickCenters = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; ++i)
    {
        Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [b setDx:8];
        [b setDy:8];
        
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
        while (x < 100) {
            x = rand() % (int)(bounds.size.width * .8) + width/2;
        }
        
        y = (int)(bounds.size.height/11 * i + 37);
        
       // NSLog(@"Y %f", y);
        
        [b setCenter:CGPointMake(x , y)];
        
        [brickCenters addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
        
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
    if(startOfNewLevel)
    {
        [self randomBrickSelect];
    }
    [self addSubview:jumper];
    
}

-(void) randomBrickSelect
{
    if(brickVerticalMovers.count > 0)
    {
     //   [brickVerticalMovers removeAllObjects];
    }
    if(brickHorizontalMovers.count > 0)
    {
       // [brickHorizontalMovers removeAllObjects];
    }
    
    brickHorizontalMovers = [[NSMutableArray alloc] init];
    brickVerticalMovers = [[NSMutableArray alloc] init];
    
    for (int z=0; z < 4; z++)
    {
        int num = (int)arc4random_uniform(10);
        if(![brickHorizontalMovers containsObject:[NSNumber numberWithInt:num]])
        {
            [brickHorizontalMovers addObject:[NSNumber numberWithInt:num]];
        }
    }
    
    //Removing extra bricks.... cannot have more than 5 bricks moving in left&right direction
    if([brickHorizontalMovers count] > 5)
    {
        int length = (int)[brickHorizontalMovers count];
        NSLog(@"%d", length);
        for (int z=5; z < length; z++)
        {
            [brickHorizontalMovers removeLastObject];
        }
    }
    
    
    for (int z=0; z < 7; z++)
    {
        int num = (int)arc4random_uniform(10);
        if(![brickHorizontalMovers containsObject:[NSNumber numberWithInt:num]] && ![brickVerticalMovers containsObject:[NSNumber numberWithInt:num]])
        {
            [brickVerticalMovers addObject:[NSNumber numberWithInt:num]];
        }
    }
    
    //Removing extra bricks.... cannot have more than 4 bricks moving in up&down direction
    if([brickVerticalMovers count] > 4)
    {
        int length = (int)[brickVerticalMovers count];
        NSLog(@"%d", length);
        for (int z=4; z < length; z++)
        {
           [brickVerticalMovers removeLastObject];
        }
    }
    
    //NSLog(@"YO YO");
}

-(void)arrange:(CADisplayLink *)sender
{
    CGRect bounds = [self bounds];
    
    if(([[Universe sharedInstance] levelCounter] == 1) || ([[Universe sharedInstance] levelCounter] == 3))
    {
        //brick horizontal movement
        for (int i=0; i<[brickHorizontalMovers count]; i++)
        {
            [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] setDx:[[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] dx] - .7];
            [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] setDy:0];
        
            CGPoint pb = [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] center];
            pb.x -= [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] dx];
        
            //not necessary for horizontal movement
            //pb.y += [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] dy];
        
            //Move Right after Left 50px
            if (pb.x <  [[brickCenters objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] CGPointValue].x - 275)
            {
                pb.x = [[brickCenters objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] CGPointValue].x - 275;
                [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] setDx:-8];
            }
        
            //Move Left after Right 50px
            if (pb.x > [[brickCenters objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] CGPointValue].x)
            {
                pb.x = [[brickCenters objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] CGPointValue].x;
                [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] setDx:8];
            }
        
            [[bricks objectAtIndex:[[brickHorizontalMovers objectAtIndex:i] integerValue]] setCenter:pb];
        }
    }
    
    if(([[Universe sharedInstance] levelCounter] == 2) || ([[Universe sharedInstance] levelCounter] == 3))
    {
        //brick vertical movement
        for (int i=0; i<[brickVerticalMovers count]; i++)
        {
            [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] setDy:[[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] dy] - .7];
            [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] setDx:0];
        
            CGPoint pb = [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] center];
            pb.y -= [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] dy];
        
            //not necessary for vertical movement
            //pb.x -= [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] dx];
        
            
            //Move Up
            if (pb.y <  [[brickCenters objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] CGPointValue].y - 170)
            {
                
                if(([[brickCenters objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] CGPointValue].y - 170) > 10)
                    pb.y = [[brickCenters objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] CGPointValue].y - 170;
                else
                    pb.y = 10;
                [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] setDy:-8];
            }
            
            //Move Down
            if (pb.y > [[brickCenters objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] CGPointValue].y)
            {
                if(([[brickCenters objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] CGPointValue].y) < (bounds.size.height-10))
                    pb.y = [[brickCenters objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] CGPointValue].y;
                else
                    pb.y = bounds.size.height - 10;
                
                [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] setDy:8];
            }
        
            [[bricks objectAtIndex:[[brickVerticalMovers objectAtIndex:i] integerValue]] setCenter:pb];
        }
    }
    
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
        p.y = bounds.size.height-25;
        [jumper removeFromSuperview];
        
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
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            CGRect b = [brick frame];
            
            p.y += 17;
            if (CGRectContainsPoint(b, p))
            {
                // Yay!  Bounce!
                NSLog(@"Bounce!");
                [jumper setDy:10];
                startOfNewLevel = NO;
            }
            p.y -= 17;
        }
    }
    
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


/*
 Referenced below method for UIAlert shown when Player Looses from http://stackoverflow.com/questions/1372977/given-a-view-how-do-i-get-its-viewcontroller
 */
- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
    return (UIViewController *)responder;
}
@end
