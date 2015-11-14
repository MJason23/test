//
//  DPCard.h
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPCard : NSObject

@property (strong, nonatomic) NSString *contents;
@property (getter = isChosen, nonatomic,) BOOL chosen;
@property (getter = isMatched, nonatomic) BOOL matched;

//See if current card matched any other cards chosen(Not only for 2 cards matching game)
- (int)match:(NSArray *)otherCards;

@end
