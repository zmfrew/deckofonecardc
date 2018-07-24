//
//  DVMCardController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import "DVMCardController.h"
#import "DVMCard.h"
#import "UIKit/UIKit.h"


@implementation DVMCardController

static NSString *const baseURLString = @"https://deckofcardsapi.com/api/deck/new/draw";

#pragma mark - Properties
+ (DVMCardController *)sharedController
{
    static DVMCardController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [DVMCardController new];
    });
    return sharedController;
}

#pragma mark - Methods
//+ (NSString *)getImageURL:(NSURL *)
//{
//    return [DVMCardController.ca]
//}

- (void)drawNewCard:(NSInteger)numberOfCards completion:(void(^) (NSArray<DVMCard *> *cards))completion
{
    NSString *cardCount = [@(numberOfCards) stringValue];
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *countQuery = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[countQuery];
    NSURL *searchURL = urlComponents.URL;
    
    [[NSURLSession.sharedSession dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error occurred fetching card data: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error occurred. No data returned.");
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionaries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSArray *cardsArray = jsonDictionaries[@"cards"];
        NSMutableArray *cardsPlaceholder = [[NSMutableArray alloc] init];
        
        for (NSDictionary *cardDictionary in cardsArray) {
            DVMCard *card = [[DVMCard alloc] initWithDictionary:cardDictionary];
            [cardsPlaceholder addObject: card];
        }
        
        completion(cardsPlaceholder);
        
    }] resume];
    
}

- (void)fetchCardImage:(DVMCard *)card completion:(void (^)(UIImage *))completion
{
    NSURL *imageURL = [NSURL URLWithString:card.imageAsURL];
    
    [[NSURLSession.sharedSession dataTaskWithURL:imageURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error occurred fetching image: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error occurred. No data returned.");
            completion(nil);
            return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        
        completion(cardImage);
        
    }] resume];
    
}

@end
