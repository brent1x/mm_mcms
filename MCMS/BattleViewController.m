//
//  BattleViewController.m
//  MCMS
//
//  Created by Brent Dady on 5/19/15.
//  Copyright (c) 2015 Brent Dady. All rights reserved.
//

#import "BattleViewController.h"

@interface BattleViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *creatureOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *creatureTwoImageView;

@property (weak, nonatomic) IBOutlet UILabel *creatureOneName;
@property (weak, nonatomic) IBOutlet UILabel *creatureTwoName;

@end

@implementation BattleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.creatureOneName.text = self.creatureOne.name;
    self.creatureOneImageView.image = self.creatureOne.image;

    self.creatureTwoName.text = self.creatureTwo.name;
    self.creatureTwoImageView.image = self.creatureTwo.image;

}


- (IBAction)onFightPressed:(UIButton *)sender {

    u_int32_t randomNum = arc4random_uniform(2);

    MagicalCreature *winner = (randomNum ? self.creatureOne : self.creatureTwo);
    NSString *alertViewTitle = [NSString stringWithFormat:@"%@ wins!", winner.name];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertViewTitle message:nil delegate:self cancelButtonTitle:@"Rematch" otherButtonTitles:nil, nil];

    [alertView show];

}

@end






