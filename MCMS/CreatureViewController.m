//
//  CreatureViewController.m
//  MCMS
//
//  Created by Brent Dady on 5/19/15.
//  Copyright (c) 2015 Brent Dady. All rights reserved.
//

#import "CreatureViewController.h"

@interface CreatureViewController ()
@property (weak, nonatomic) IBOutlet UITextField *editCreatureName;
@property (weak, nonatomic) IBOutlet UILabel *creatureNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIImageView *creatureImage;
@property BOOL isEditing;

@end

@implementation CreatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editCreatureName.hidden = TRUE;
    self.creatureNameLabel.text = self.creature.name;
    self.navigationItem.title = self.creature.name;
    self.editCreatureName.text = self.creature.name;

    [self.editCreatureName addTarget:self action:@selector(updateTitleUsingTextField:) forControlEvents:UIControlEventEditingChanged];
    self.detailTextView.text = self.creature.hometown;

    self.creatureImage.image = self.creature.image;
}

- (IBAction)onEditButtonPressed:(UIButton *)sender {
    if (!self.isEditing) {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        self.editCreatureName.text = self.creature.name;
    } else {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        if (self.editCreatureName.text.length > 0) {
            self.creature.name = self.editCreatureName.text;
            self.navigationItem.title = self.creature.name;
            self.creatureNameLabel.text = self.creature.name;
        }
        else {
            self.navigationItem.title = self.creature.name;
        }
    }
    self.isEditing = !self.isEditing;
    self.editCreatureName.hidden = !self.editCreatureName.hidden;
}

-(void)updateTitleUsingTextField:(UITextField *)sender {
    self.navigationItem.title = sender.text;
}

@end
