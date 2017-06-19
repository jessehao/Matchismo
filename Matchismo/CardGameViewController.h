//
//  ViewController.h
//  Matchismo
//
//  Created by 郝泽 on 2017/3/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//
// Abstract Class. Must implement methods as  described below

#import <UIKit/UIKit.h>
#import "Model/Deck.h"
@interface CardGameViewController : UIViewController

// protected

- (Deck *)createDeck; // abstract

@end

