//
//  BNRItem.h
//  Homepwner
//
//  Created by Vishnu Ittiyamparampath on 12/31/14.
//  Copyright (c) 2014 Salvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
//INSTANCE VARIABLES are declared in classes imediately after declaration
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
}

//INITIALIZERS
-(instancetype)initWithItemName:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber;

-(instancetype)initWithItemName:(NSString *)name;

//ACCESSING INSTANCE VARIABLES
-(void)setItemName:(NSString *)str;//SETTER (set+Capitalized name of the instance variable it is changing)
-(NSString *)itemName;//GETTER (Just the name without underscore)

-(void)setSerialNumber:(NSString *)str;
-(NSString *)serialNumber;

-(void)setValueInDollars:(int)v;
-(int)valueInDollars;

-(NSString *)dateCreated;

+(instancetype)randomItem;//STATIC class

//@property NSString *itemName; //SAME as doing all of these things above for _itemName.

@end
