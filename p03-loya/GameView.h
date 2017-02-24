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

-(void) arrange:(CADisplayLink *) sender;


@end
