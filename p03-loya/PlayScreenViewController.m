//
//  PlayScreenViewController.m
//  p03-loya
//
//  Created by Harshad Loya on 2/19/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import "PlayScreenViewController.h"

@interface PlayScreenViewController ()

@end

@implementation PlayScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    [_displayLink setPreferredFramesPerSecond:30];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)speedChange:(id)sender
{
    UISlider *s = (UISlider *)sender;
    // NSLog(@"tilt %f", (float)[s value]);
    [_gameView setTilt:(float)[s value]];
}

@end
