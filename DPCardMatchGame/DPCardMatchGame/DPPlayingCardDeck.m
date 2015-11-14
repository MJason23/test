//
//  DPPlayingCardDeck.m
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import "DPPlayingCardDeck.h"
#import "DPPlayingCard.h"

@implementation DPPlayingCardDeck

- (instancetype)init
{
    if (self = [super init]) {
        for (NSString *suit in [DPPlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [DPPlayingCard maxRank]; rank++) {
                DPPlayingCard *card = [[DPPlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
