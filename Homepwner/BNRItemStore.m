//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Vishnu Ittiyamparampath on 1/3/15.
//  Copyright (c) 2015 Salvin. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@property (nonatomic) NSMutableArray *itemsLessThanFifty;

@property (nonatomic) NSMutableArray *itemsMoreThanFifty;

@end

@implementation BNRItemStore

+(instancetype)sharedStore
{
    static BNRItemStore *sharedStore;
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

-(instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use +[BNRItemStore sharedStore]"];
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _privateItems = [[NSMutableArray alloc] init];
        _itemsLessThanFifty = [[NSMutableArray alloc] init];
        _itemsMoreThanFifty = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)allItems
{
    return [self.privateItems copy];
}

-(NSArray *)allItemsLessThanFifty
{
    return [self.itemsLessThanFifty copy];
}

-(NSArray *)allItemsMoreThanFifty
{
    return [self.itemsMoreThanFifty copy];
}

-(BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    /*
    if ([item valueInDollars] > 50)
    {
        [self.itemsMoreThanFifty addObject:item];
    }
    else
    {
        [self.itemsLessThanFifty addObject:item];
    }
     */
    return item;
}

-(void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageKey:key];
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex){
        return;
    }
    
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];
}

@end
