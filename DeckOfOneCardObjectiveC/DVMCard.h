//
//  DVMCard.h
//  DeckOfOneCardObjectiveC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVMCard : NSObject

@property (nonatomic, copy, readonly) NSString *suit;
@property (nonatomic, copy, readonly) NSString *imageAsURL;

- (instancetype)initWithSuit:(NSString *)suit
                  imageAsURL:(NSString *)imageAsURL;

@end

@interface DVMCard (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
