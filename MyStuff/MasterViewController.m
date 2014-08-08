//
//  MasterViewController.m
//  MyStuff
//
//  Created by Prasong on 4/08/2014.
//  Copyright (c) 2014 Prasong Techapanyo. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MyWhatsit.h"

@interface MasterViewController ()
            
@property NSMutableArray* things;

@end

@implementation MasterViewController

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.things = [@[
                [[MyWhatsit alloc] initWithName:@"Gort" location:@"den"],
                [[MyWhatsit alloc] initWithName:@"Disappearing TARDIS mug" location:@"kitchen"],
                [[MyWhatsit alloc] initWithName:@"Robot USB drive" location:@"Office"],
                [[MyWhatsit alloc] initWithName:@"Sad Robot USB hub" location:@"Office"],
                [[MyWhatsit alloc] initWithName:@"Solar Powered Bunny" location:@"Office"]] mutableCopy];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whatsitDidChangeNotification:) name:kWhatsitDidChangeNotification object:nil];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.things) {
        self.things = [[NSMutableArray alloc] init];
    }
    static unsigned int itemNumber = 1;
    NSString *newItemName = [NSString stringWithFormat:@"My Item %u", itemNumber++];
    MyWhatsit *newItem = [[MyWhatsit alloc] initWithName:newItemName location:nil];
    [self.things insertObject:newItem atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MyWhatsit *thing = self.things[indexPath.row];
        [(DetailViewController *)[[segue destinationViewController] topViewController] setDetailItem:thing];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.things.count;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleInsert;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    MyWhatsit *thing = self.things[indexPath.row];
    cell.textLabel.text = thing.name;
    cell.detailTextLabel.text = thing.location;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.things removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        MyWhatsit *thing = self.things[indexPath.row];
        self.detailViewController.detailItem = thing;
    }
}

-(void)whatsitDidChangeNotification:(NSNotification *)notification{
    NSUInteger index = [self.things indexOfObject:notification.object];
    if (index != NSNotFound) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    }
}

@end
