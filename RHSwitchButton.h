//
//  RHSwitchButton.h
//  RHSwitchButton
//
//  Created by taitanxiami on 16/8/28.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RHSwitchButtonState) {
    RHSwitchButtonStateOn,
    RHSwitchButtonStateOff,
};


@protocol RHSwitchButtonDelegate <NSObject>

- (void)switchStateChanged:(RHSwitchButtonState)state;

@end
@interface RHSwitchButton : UIControl


@property (weak, nonatomic)  id<RHSwitchButtonDelegate>switchDelegate;


// state

@property (nonatomic) BOOL isOn;


// UIColor
@property (strong, nonatomic) UIColor *trackOnTintColor;
@property (strong, nonatomic) UIColor *trackOffTintColor;
@property (strong, nonatomic) UIColor *thumbOnTintColor;
@property (strong, nonatomic) UIColor *thumbOffTintColor;

// UIView
@property (strong, nonatomic) UIButton *switchThumb;
@property (strong, nonatomic) UIView   *trackView;


- (instancetype)init ;

-(instancetype)initWithState:(RHSwitchButtonState)state;

- (BOOL)getSwitchState;

@end
