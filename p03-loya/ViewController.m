//
//  ViewController.m
//  p03-loya
//
//  Created by Harshad Loya on 2/18/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import "ViewController.h"
#import "PlayScreenViewController.h"

@interface ViewController ()


@end

@implementation ViewController

BOOL *setSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)switchValue:(id)sender
{
    UISwitch *mySwitch = (UISwitch *)sender;
    if([mySwitch isOn])
    {
        NSLog(@"Doodle Family Selected");
        *setSwitch = YES;
    }
    else
    {
        NSLog(@"Minion Family Selected");
        *setSwitch = NO;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"startGame"])
    {
        PlayScreenViewController *controller = (PlayScreenViewController *)segue.destinationViewController;
        controller.isSwitchEnabled = setSwitch;
    }
}

@end
