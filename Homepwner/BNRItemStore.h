//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Vishnu Ittiyamparampath on 1/3/15.
//  Copyright (c) 2015 Salvin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem; //just a reference not used.

@interface BNRItemStore : NSObject

+(instancetype)sharedStore;

@property(nonatomic,readonly,copy)NSArray *allItems;

@property(nonatomic,readonly,copy)NSArray *allItemsMoreThanFifty;

@property(nonatomic,readonly,copy)NSArray *allItemsLessThanFifty;

-(BNRItem *)createItem;

-(void)removeItem:(BNRItem *)item;

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
