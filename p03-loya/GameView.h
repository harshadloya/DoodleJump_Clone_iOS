//
//  GameView.h
//  p03-loya
//
//  Created by Harshad Loya on 2/19/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jumper.h"
#import "Brick.h"
#import "Universe.h"

@interface GameView : UIView

@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic) float tilt;
@property (strong, nonatomic) IBOutlet UILabel *Level;
@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) UIImageView *animatedImageView;
@property (nonatomic) BOOL startOfNewLevel;
@property (nonatomic, strong) NSMutableArray *brickCenters;
@property (nonatomic, strong) NSMutableArray *brickVerticalMovers;
@property (nonatomic, strong) NSMutableArray *brickHorizontalMovers;

-(void) arrange:(CADisplayLink *) sender;


@end
