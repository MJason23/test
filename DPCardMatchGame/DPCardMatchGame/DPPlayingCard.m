//
//  DPPlayingCard.m
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import "DPPlayingCard.h"

static const int RANK_MATCH_POINTS = 16;
static const int SUIt_MATCH_POINTS = 4;

@implementation DPPlayingCard

@synthesize suit = _suit;

- (NSString *)contents
{
    NSArray *rankStrings = [DPPlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (DPPlayingCard *otherCard in otherCards) {
        if (otherCard.rank == self.rank) {
            score += RANK_MATCH_POINTS;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score += SUIt_MATCH_POINTS;
        }
    }
    
    return score;
}

#pragma mark - suits

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♣", @"♠"];
}
- (void)setSuit:(NSString *)aSuit
{
    if ([[DPPlayingCard validSuits] containsObject:aSuit]) {
        _suit = aSuit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

#pragma mark - ranks

//rank starts from 1 not 0
+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [DPPlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
