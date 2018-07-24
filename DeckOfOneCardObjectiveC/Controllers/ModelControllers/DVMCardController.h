//
//  DVMCardController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
@class DVMCard;

@interface DVMCardController : NSObject

+ (DVMCardController *)sharedController;

- (void)drawNewCard:(NSInteger)cardCount completion:(void(^) (NSArray<DVMCard *> *cards))completion;

- (void)fetchCardImage:(DVMCard *)card completion:(void(^) (UIImage *cardImage))completion;

@end
