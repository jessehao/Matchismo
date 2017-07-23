//
//  SetGameViewController.h
//  Matchismo
//
//  Created by 郝泽 on 2017/7/23.
//  Copyright © 2017年 JesseHao. All rights reserved.
//

#import "CardGameViewController.h"

@class SetGame;

@interface SetGameViewController : CardGameViewController

#pragma mark - Properties
@property(nonatomic, strong, readonly) SetGame *setGame;

@end
