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
#import "BattleViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *creatures;
@property (weak, nonatomic) IBOutlet UITextField *inputCreatureName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputCreatureDetail;

@property UITableViewCell *firstSelected;
@property UITableViewCell *secondSelected;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MagicalCreature *tupac = [[MagicalCreature alloc] initWithName:@"Tupac" hometown:@"East Harlem" accessories:[NSMutableArray arrayWithObjects:@"Bandana", @"Crown", @"Winning smile", @"Death Row Records chain", nil]];

    MagicalCreature *geasy = [[MagicalCreature alloc] initWithName:@"G-eazy" hometown:@"Oakland" accessories:[NSMutableArray arrayWithObjects:@"Anders' undying love", @"A chip on his shoulder", @"Denim jacket", @"Hair gel", nil]];

    MagicalCreature *dannyBrown = [[MagicalCreature alloc] initWithName:@"Danny Brown" hometown:@"Detroit" accessories:[NSMutableArray arrayWithObjects:@"Hairpick", @"Lean", @"Bowtie", @"A contagious laugh", nil]];

    MagicalCreature *earlSweatshirt = [[MagicalCreature alloc] initWithName:@"Earl Sweatshirt" hometown:@"Los Angeles" accessories:[NSMutableArray arrayWithObjects:@"Supreme camp hat", @"Short-sleeved collared shirts", @"Boat shoes", @"Hoodie", nil]];

    self.creatures = [NSMutableArray arrayWithObjects:tupac, geasy, dannyBrown, earlSweatshirt, nil];

    //[self.tableView allowsMultipleSelection];

}

- (IBAction)onAddButtonPressed:(UIButton *)sender {

    if (self.inputCreatureName.text.length > 0) {

        MagicalCreature *newCreature = [[MagicalCreature alloc] initWithName:self.inputCreatureName.text hometown:self.inputCreatureDetail.text accessories:nil];

        [self.creatures addObject:newCreature];

        self.inputCreatureName.text = @"";
        self.inputCreatureDetail.text = @"";

        [self.tableView reloadData];
    }
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

    if ([segue.identifier isEqualToString:@"ShowCreatureSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CreatureViewController *creatureVC = segue.destinationViewController;
        creatureVC.creature = [self.creatures objectAtIndex:indexPath.row];
    }
    else {

        BattleViewController *battleVC = segue.destinationViewController;

        MagicalCreature *creatureOne;
        MagicalCreature *creatureTwo;

        if (self.firstSelected == nil) {
            creatureOne = [self getRandomCreature];
        }
        else {
            creatureOne = [self.creatures objectAtIndex:[self.tableView indexPathForCell:self.firstSelected].row];
        }

        if (self.secondSelected == nil) {
            creatureTwo = [self getRandomCreature];
        }
        else {
            creatureTwo = [self.creatures objectAtIndex:[self.tableView indexPathForCell:self.secondSelected].row];
        }

        while ([creatureTwo isEqual:creatureOne]) {
            creatureTwo = [self getRandomCreature];
        }

        battleVC.creatureOne = creatureOne;
        battleVC.creatureTwo = creatureTwo;
        // set creatures to battle
    }
}

-(MagicalCreature *)getRandomCreature {
    u_int32_t randomNumber = arc4random_uniform(self.creatures.count);
    return [self.creatures objectAtIndex:randomNumber];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    if (self.firstSelected == nil) {
        self.firstSelected = cell;
    }
    else if (self.secondSelected == nil) {
        self.secondSelected = cell;
    }
    else {
        NSLog(@"first selected: %@", [[self.creatures objectAtIndex:[self.tableView indexPathForCell:self.firstSelected].row] name]);
        NSLog(@"second selected: %@", [[self.creatures objectAtIndex:[self.tableView indexPathForCell:self.secondSelected].row] name]);

        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForCell:self.firstSelected] animated:true];
        self.firstSelected = self.secondSelected;
        self.secondSelected = cell;
    }

    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"FUUUUUUCK");
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.tableView reloadData];

    NSLog(@"Selected Rows: ");

    for (NSIndexPath *indexPath in [self.tableView indexPathsForSelectedRows]) {
        NSLog(@"%@", [self.creatures objectAtIndex:indexPath.row]);
    }

}

@end
