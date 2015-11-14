//
//  DPDeck.h
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPCard.h"

@interface DPDeck : NSObject

- (void)addCard:(DPCard *)card atTop:(BOOL)atTop;
- (void)addCard:(DPCard *)card;
- (DPCard *)drawRandomCard;

@end
