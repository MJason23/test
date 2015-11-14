//
//  PlayingCardGameViewController.m
//  DPCardMatchGame
//
//  Created by user on 15-11-1.
//  Copyright (c) 2015年 XuShuai. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "DPPlayingCardDeck.h"
#import "DPPlayingCardMatchGame.h"

@interface PlayingCardGameViewController ()

@property (strong, nonatomic) DPPlayingCardMatchGame *game;
@property (nonatomic) NSUInteger currentClickedCardIndex;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation PlayingCardGameViewController

- (DPPlayingCardMatchGame *)game
{
    if (!_game) {
        _game = [[DPPlayingCardMatchGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck] numberOfCardsToPlayWith:self.numberOfMatchCardsToPlayWith];
        self.currentClickedCardIndex = [self.cardButtons count];
    }
    return _game;
}

- (DPDeck *)createDeck
{
    return [[DPPlayingCardDeck alloc] init];
}

- (NSInteger)numberOfMatchCardsToPlayWith
{
    if (!_numberOfMatchCardsToPlayWith) _numberOfMatchCardsToPlayWith = 2;
    return _numberOfMatchCardsToPlayWith;
}

#pragma mark - redeal cards

- (IBAction)redealCardsAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Redeal Cards?"
                                                    message:@"This will reset your current score."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self redealCards];
    }
}

- (void)redealCards
{
    self.game = [[DPPlayingCardMatchGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                    numberOfCardsToPlayWith:self.numberOfMatchCardsToPlayWith];
    self.currentClickedCardIndex = [self.cardButtons count];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.currentClickedCardIndex = chosenButtonIndex;
    [self updateUI];
}

# pragma mark - update UI

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        DPCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        if (cardButtonIndex == self.currentClickedCardIndex) {
            [self flipCardAnimation:cardButton withCard:card];
        }
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    self.statusLabel.text = self.game.status;
}

- (NSString *)titleForCard:(DPCard *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(DPCard *)card
{
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

//This is just for the animation of card flip
- (void)flipCardAnimation:(UIButton *)cardBtn withCard:(DPCard *)card{
    UIImageView *flipOverImgView = [[UIImageView alloc]initWithFrame:cardBtn.frame];
    flipOverImgView.image = [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
    [self.view addSubview:flipOverImgView];
    [flipOverImgView setAlpha:0.0f];
    
    UIImageView *currentImgView = [[UIImageView alloc]initWithFrame:cardBtn.frame];
    currentImgView.image = [UIImage imageNamed:card.chosen ? @"cardback" : @"cardfront"];
    [self.view addSubview:currentImgView];
    [cardBtn setAlpha:0.0f];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect rect = cardBtn.bounds;
        rect.size.width = 1.0f;
        currentImgView.bounds = rect;
    } completion:^(BOOL finished) {
        flipOverImgView.bounds = currentImgView.bounds;
        [currentImgView setAlpha:0.0f];
        [flipOverImgView setAlpha:1.0f];
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [currentImgView removeFromSuperview];
            flipOverImgView.bounds = cardBtn.bounds;
        } completion:^(BOOL finished) {
            [flipOverImgView removeFromSuperview];
            [cardBtn setAlpha:1.0f];
        }];
    }];
}

@end
