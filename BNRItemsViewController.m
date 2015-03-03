//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Vishnu Ittiyamparampath on 12/30/14.
//  Copyright (c) 2014 Salvin. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRDetailViewController.h"

#import "BNRItem.h"
#import "BNRItemStore.h"

@interface BNRItemsViewController ()

@property (nonatomic) NSMutableArray *sectionTitles;
@property  (nonatomic,strong) IBOutlet UIView *headerView; /* Strong because it's a top level object. Use week if top owns other objects */

@end

@implementation BNRItemsViewController

-(instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain]; //Initialize table view
    
    if (self) {
        //Set UINavigationBarItem
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
        
        for(int i=0;i<5;i++){
            [[BNRItemStore sharedStore] createItem];
        }
        BNRItem *lastItem = [[BNRItemStore sharedStore] createItem];
        lastItem.itemName = @"No more items.";
        self.sectionTitles = [[NSMutableArray alloc] init];
        [self.sectionTitles addObject:@"Less Than 50 Dollar"];
        [self.sectionTitles addObject:@"All Other"];
        
        //Set footer
        /*
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        footerLabel.text = NSLocalizedString(@"No more items!", @"");
        footerLabel.backgroundColor = [UIColor clearColor];
        [footer addSubview:footerLabel];
        
        self.tableView.tableFooterView = footer;
        */
    }
    return self;
}

-(instancetype) initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.00;
}
*/

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [self.sectionTitles count];
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    NSUInteger sectionRowCount;
    
    switch (section) {
            case 0:
                sectionRowCount = [[[BNRItemStore sharedStore] allItemsLessThanFifty] count];
                NSLog(@"Total rows %i",sectionRowCount);
                return sectionRowCount;
            default:
                sectionRowCount = [[[BNRItemStore sharedStore] allItemsMoreThanFifty] count];
                NSLog(@"Total rows %i",sectionRowCount);
                return sectionRowCount;

    }
     */
    return [[[BNRItemStore sharedStore] allItems] count];
    
}

/*
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionText = [self.sectionTitles objectAtIndex:section];
    NSLog(@"Table Cell Data %@",sectionText);
    return sectionText;
}
*/

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    NSArray *item = items[indexPath.row];
    NSInteger totalRow = [items count] - 1;
    
    //NSLog(@"%d",indexPath.row);
    //cell.textLabel.text = @"No more items";
    
    if (indexPath.row == totalRow)
    {
        cell.textLabel.text = @"No more items";
    }
    else {
        cell.textLabel.text = [item description];
    }
    return cell;
    /*
    if (indexPath.section==0){
        
        NSArray *items = [[BNRItemStore sharedStore] allItemsLessThanFifty];
        NSLog(@"Table Cell Data %i",[items count]);
        NSArray *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    }
    else {
        
        NSArray *items = [[BNRItemStore sharedStore] allItemsMoreThanFifty];
        NSLog(@"Table Cell Data %i",[items count]);
        NSArray *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    }
    
    return cell;
    */
}

-(void)tableView:(UITableView *)tableView
                    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

//Change the delete button text
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    detailViewController.item = selectedItem;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    /*
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
     */
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(IBAction)addNewItem:(id)sender
{
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

/*
-(IBAction)toggleEditingMode:(id)sender
{
    
    if (self.isEditing)
    {
        NSLog(@"Done editing");
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }
    else
    {
        NSLog(@"Start editing");
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

-(UIView *)headerView
{
    if (!_headerView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    return _headerView;
}
 */

@end
