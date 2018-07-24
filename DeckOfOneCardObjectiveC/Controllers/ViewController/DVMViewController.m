//
//  DVMCardViewController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

#import "DVMCardViewController.h"
#import "DVMCardController.h"
#import "DVMCard.h"

@interface DVMCardViewController ()

#pragma mark - Outlets
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *suitLabel;

@end

@implementation DVMCardViewController

#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions
- (IBAction)drawCardButtonTapped:(UIButton *)sender {
    [self updateViews];
}

#pragma mark - Methods
- (void)updateViews
{
    [[DVMCardController sharedController] drawNewCard:1 completion:^(NSArray<DVMCard *> *cards) {
        DVMCard *card = [cards objectAtIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.suitLabel.text = card.suit.capitalizedString;
        });
        
        [[DVMCardController sharedController] fetchCardImage:card completion:^(UIImage *cardImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImage.image = cardImage;
            });
        }];
    }];
}

@end
