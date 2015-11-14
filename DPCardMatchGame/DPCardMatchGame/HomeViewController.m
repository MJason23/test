//
//  HomeViewController.m
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import "HomeViewController.h"
#import "PlayingCardGameViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayingCardGame"]) {
        PlayingCardGameViewController *destinationVC = (PlayingCardGameViewController *)[segue destinationViewController];
        destinationVC.numberOfMatchCardsToPlayWith = 2;
    }
}

- (IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}

@end
