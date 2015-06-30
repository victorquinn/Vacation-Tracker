//
//  VTListViewController.m
//  Vacation-Tracker
//
//  Created by Spencer Atkin on 6/24/15.
//  Copyright (c) 2015 Spencer Atkin. All rights reserved.
//

#import "VTListViewController.h"
#import "VTTripHandler.h"
#import "VisitViewCell.h"

@interface VTListViewController ()

@end

@implementation VTListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Visits in %@", [_tripName capitalizedStringWithLocale:[NSLocale currentLocale]]]];   // Sets navigation bar title to 'Visits in <locale>'
    
    [_tableView reloadData];
    
    [VTTripHandler registerVisitObserver:^(NSNotification *note) {
        if(note.name != VTVisitsChangedNotification) {
            return;
        }
        if ([[note.object objectAtIndex:0] isEqualToString:_tripName]) {
            _visits = [note.object objectAtIndex:1];
        }
        [_tableView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_visits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"VisitCellID";
        
    VisitViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [_tableView registerNib:[UINib nibWithNibName:@"VisitViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    }
    [cell setVisit:[self getVisitForIndex:indexPath.row]];
    return cell;
}

- (IBAction)clearVisits:(id)sender {
    [self setVisits:[[NSMutableArray alloc] init]];
    [VTTripHandler notifyVisitChange:[[NSArray alloc] initWithObjects:_tripName, _visits, nil]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"VisitDetailSegueID" sender:tableView];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *trips = [VTTripHandler trips];
        NSMutableArray *tripNames = [VTTripHandler tripNames];
        
        VTVisitHandler *visitHandler = [[trips objectAtIndex:[tripNames indexOfObject:[self tripName]]] visitHandler];
        [visitHandler removeVisitAtIndex:indexPath.row];
    }
}

- (VTVisit *)getVisitForIndex:(NSUInteger)index {
    NSUInteger lastIndex = [_visits count] - 1;
    return [_visits objectAtIndex:lastIndex - index];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"VisitDetailSegueID"]) {
        VTVisit *visit = [self getVisitForIndex:[sender indexPathForSelectedRow].row];
        [_tableView deselectRowAtIndexPath:[sender indexPathForSelectedRow] animated:YES];
        [[segue destinationViewController] setVisit:visit];
    }
}

@end
