//
//  DPPlayingCardMatchGame.h
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPCard.h"
#import "DPDeck.h"

@interface DPPlayingCardMatchGame : NSObject

@property (readonly, nonatomic) NSInteger score;
@property (strong, nonatomic) NSString *status;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(DPDeck *)deck
          numberOfCardsToPlayWith:(NSInteger)numberOfCardsToPlayWith;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (DPCard *)cardAtIndex:(NSUInteger)index;

@end
