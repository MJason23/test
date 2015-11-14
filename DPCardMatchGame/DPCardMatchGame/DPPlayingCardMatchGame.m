//
//  DPPlayingCardMatchGame.m
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import "DPPlayingCardMatchGame.h"

static const int MISMATCH_COST = 2;
static const int CLICK_COST = 1;

@interface DPPlayingCardMatchGame ()

@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger currentMatchCardFlipCount;
@property (nonatomic) NSInteger numberOfMatchCardsToPlayWith;

@end

@implementation DPPlayingCardMatchGame


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(DPDeck *)deck
          numberOfCardsToPlayWith:(NSInteger)numberOfCardsToPlayWith
{
    if (self = [super init]) {
        self.numberOfMatchCardsToPlayWith = numberOfCardsToPlayWith;
        for (int i = 0; i < count; i++) {
            DPCard *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    DPCard *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.status = @"";
        } else {
            //We need to store all the cards that are chosen but not
            //matched into currentChosenCards
            NSMutableArray *currentChosenCards = [[NSMutableArray alloc] init];
            NSMutableString *statusCurrentChosenCards = [[NSMutableString alloc] init];
            for (DPCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [currentChosenCards addObject:otherCard];
                    [statusCurrentChosenCards appendFormat:@"%@ ", otherCard.contents];
                }
            }
            if ([currentChosenCards count]) {
                self.status = [[NSString stringWithFormat:@"Chose %@ to match with: ", card.contents] stringByAppendingString:statusCurrentChosenCards];
            } else {
                self.status = [NSString stringWithFormat:@"Chose %@", card.contents];
            }
            
            //We need to compare now how many cards are chosen but not
            //matched, to the number of match cards we are playing,
            //only when the cards number equal to the number of match
            //cards we are play, then we need to do the process of
            //updating score and status
            //The card that just cliked was not stored in
            //currentChosenCards, so we need to -1 here
            if ([currentChosenCards count] == self.numberOfMatchCardsToPlayWith - 1) {
                int matchScore = [card match:currentChosenCards];
                if (matchScore) {
                    self.score += matchScore;
                    for (DPCard *otherCard in currentChosenCards) {
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                    self.status = [[NSString stringWithFormat:@"Scored: %d. Found a match for: %@ ", matchScore, card.contents] stringByAppendingString:statusCurrentChosenCards];
                } else {
                    self.score -= MISMATCH_COST;
                    for (DPCard *otherCard in currentChosenCards) {
                        otherCard.chosen = NO;
                    }
                    self.status = [[NSString stringWithFormat:@"Mismatch cost: %d. No match found for: %@ ", MISMATCH_COST, card.contents] stringByAppendingString:statusCurrentChosenCards];
                }
            }
            
            self.score -= CLICK_COST;
            card.chosen = YES;
        }
    }
}

- (DPCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil ;
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

@end
