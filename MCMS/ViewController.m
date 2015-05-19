//
//  ViewController.m
//  MCMS
//
//  Created by Brent Dady on 5/19/15.
//  Copyright (c) 2015 Brent Dady. All rights reserved.
//

#import "ViewController.h"
#import "MagicalCreature.h"
#import "CreatureViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *creatures;
@property (weak, nonatomic) IBOutlet UITextField *inputCreatureName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Dragon *drogon = [[Dragon alloc] initWithFullName:@"Drogon" signatureClothingItem:@"Brooks Brothers Polo"];

    MagicalCreature *tupac = [[MagicalCreature alloc] initWithName:@"Tupac"];
    MagicalCreature *geasy = [[MagicalCreature alloc] initWithName:@"G-easy"];
    MagicalCreature *dannyBrown = [[MagicalCreature alloc] initWithName:@"Danny Brown"];

    self.creatures = [NSMutableArray arrayWithObjects:tupac, geasy, dannyBrown, nil];
}

- (IBAction)onAddButtonPressed:(UIButton *)sender {
    MagicalCreature *newCreature = [[MagicalCreature alloc] initWithName:self.inputCreatureName.text];
    [self.creatures addObject:newCreature];
    self.inputCreatureName.text = @"";
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.creatures.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MagicalCreature *creature = [self.creatures objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];

    cell.textLabel.text = creature.name;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];

    CreatureViewController *creatureVC = segue.destinationViewController;
    creatureVC.creature = [self.creatures objectAtIndex:indexPath.row];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

@end
