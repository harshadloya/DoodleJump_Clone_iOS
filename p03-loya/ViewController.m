//
//  ViewController.m
//  p03-loya
//
//  Created by Harshad Loya on 2/18/17.
//  Copyright © 2017 Harshad Loya. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bggrid.png"]]];
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
        [[Universe sharedInstance] setSwitchStatus:YES];
    }
    else
    {
        NSLog(@"Minion Family Selected");
        [[Universe sharedInstance] setSwitchStatus:NO];
    }
}

@end
