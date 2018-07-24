//
//  DVMCard.m
//  DeckOfOneCardObjectiveC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

- (instancetype)initWithSuit:(NSString *)suit imageAsURL:(NSString *)imageAsURL
{
    self = [super init];
    if (self) {
        _suit = [suit copy];
        _imageAsURL = [imageAsURL copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *suit = dictionary[[DVMCard suitKey]];
    NSString *imageAsURL = dictionary[[DVMCard imageKey]];
    
    return [self initWithSuit:suit imageAsURL:imageAsURL];
}

+ (NSString *)suitKey
{
    return @"suit";
}

+ (NSString *)imageKey
{
    return @"image";
}



@end
