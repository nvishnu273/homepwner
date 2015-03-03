//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Vishnu Ittiyamparampath on 1/17/15.
//  Copyright (c) 2015 Salvin. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()

@property (nonatomic, strong)NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+(instancetype)sharedStore
{
    static  BNRImageStore *sharedStore;
    if(!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

-(instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use + BNRStore]"];
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.dictionary setObject:image forKey:key];
}

-(UIImage *)imageForKey:(NSString *)key
{
    return [self.dictionary objectForKey:key];
}

-(void)deleteImageKey:(NSString *)key
{
    if (!key)
    {
        [self.dictionary removeObjectForKey:key];
    }
}

@end
