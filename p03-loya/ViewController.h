//
//  ViewController.h
//  p03-loya
//
//  Created by Harshad Loya on 2/18/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameView.h"

@interface ViewController : UIViewController
@property (nonatomic, strong) IBOutlet GameView *gameView;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

