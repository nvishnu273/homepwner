//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Vishnu Ittiyamparampath on 1/17/15.
//  Copyright (c) 2015 Salvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

+(instancetype)sharedStore;

-(void)setImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
-(void)deleteImageKey:(NSString *)key;

@end
