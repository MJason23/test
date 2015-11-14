//
//  DPCard.m
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import "DPCard.h"

@implementation DPCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (DPCard *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end