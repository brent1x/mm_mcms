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

    MagicalCreature *tupac = [[MagicalCreature alloc] initWithName:@"Tupac" hometown:@"East Harlem"];
    MagicalCreature *geasy = [[MagicalCreature alloc] initWithName:@"G-eazy" hometown:@"Oakland"];
    MagicalCreature *dannyBrown = [[MagicalCreature alloc] initWithName:@"Danny Brown" hometown:@"Detroit"];
    MagicalCreature *earlSweatshirt = [[MagicalCreature alloc] initWithName:@"Earl Sweatshirt" hometown:@"Los Angeles"];

    self.creatures = [NSMutableArray arrayWithObjects:tupac, geasy, dannyBrown, earlSweatshirt, nil];
}

- (IBAction)onAddButtonPressed:(UIButton *)sender {
    MagicalCreature *newCreature = [[MagicalCreature alloc] initWithName:self.inputCreatureName.text hometown:nil];
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
    cell.detailTextLabel.text = creature.hometown;
    cell.imageView.image = creature.image;
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
