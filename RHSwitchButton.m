//
//  RHSwitchButton.m
//  RHSwitchButton
//
//  Created by taitanxiami on 16/8/28.
//  Copyright © 2016年 taitanxiami. All rights reserved.
//

#import "RHSwitchButton.h"

@implementation RHSwitchButton {
    
    float thumbOnPosition;
    float thumbOffPosition;
    float bounceOffset;
    
}

- (instancetype)init {
    
    return [self initWithState:RHSwitchButtonStateOn];
}

-(instancetype)initWithState:(RHSwitchButtonState)state {
    
    
    // Determin UIColor
    self.trackOnTintColor  = [UIColor colorWithRed:143./255. green:179./255. blue:247./255. alpha:1.0];
    self.trackOffTintColor = [UIColor colorWithRed:193./255. green:193./255. blue:193./255. alpha:1.0];
    self.thumbOnTintColor  = [UIColor colorWithRed:52./255. green:109./255. blue:241./255. alpha:1.0];
    self.thumbOffTintColor = [UIColor colorWithRed:249./255. green:249./255. blue:249./255. alpha:1.0];
    
    // Determine switch size
    CGRect frame = frame = CGRectMake(0, 0, 40, 30);
    CGRect trackFrame = CGRectMake(0, 0, 40, 17);
    CGRect thumbFrame = CGRectMake(0, -3, 24, 24);
    
    thumbOnPosition  =frame.size.width - thumbFrame.size.width;
    thumbOffPosition = thumbFrame.origin.x;

    bounceOffset = 3.0f;
    if (self = [super initWithFrame:frame]) {
     
        
        
        self.trackView = [[UIView alloc]initWithFrame:trackFrame];
        self.trackView.layer.cornerRadius = MIN(trackFrame.size.width, trackFrame.size.height / 2);
        [self addSubview:self.trackView];
        
        
        
        self.switchThumb = [[UIButton alloc]initWithFrame:thumbFrame];
        [self addSubview:self.switchThumb];
        self.switchThumb.layer.cornerRadius = thumbFrame.size.height/2;
        self.switchThumb.layer.shadowColor = [UIColor blackColor].CGColor;
        self.switchThumb.layer.shadowRadius = 2.0f;
        self.switchThumb.layer.shadowOffset = CGSizeMake(0, 1);
        self.switchThumb.layer.shadowOpacity = 0.5;
        
        [self.switchThumb addTarget:self action:@selector(onTouchDown) forControlEvents:UIControlEventTouchDown];
        
        
        
        switch (state) {
            case RHSwitchButtonStateOn:
            {
                self.trackView.backgroundColor = self.trackOnTintColor;
                self.switchThumb.backgroundColor = self.thumbOnTintColor;
                self.isOn = YES;
                
                CGRect thumbFrame = self.switchThumb.frame;
                thumbFrame.origin.x = thumbOnPosition;
                self.switchThumb.frame = thumbFrame;
                
            }
                break;
            case RHSwitchButtonStateOff:
            {
                self.trackView.backgroundColor = self.trackOffTintColor;
                self.switchThumb.backgroundColor = self.thumbOffTintColor;
                self.isOn = NO;
            }
            default:
                break;
        }
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swicthAreaTap:)];
        [self addGestureRecognizer:singleTap];
        
    }
    return self;
}

#pragma mark - Action

- (void)swicthAreaTap:(UITapGestureRecognizer *)gesture {
    
    [self changeThumbState];
}

- (void)changeThumbState {
    
    //response selector
    
    if (self.switchDelegate && [self.switchDelegate respondsToSelector:@selector(switchStateChanged:)]) {
        
        if (self.isOn) {
            [self.switchDelegate switchStateChanged:RHSwitchButtonStateOff];
        }else {
            [self.switchDelegate switchStateChanged:RHSwitchButtonStateOn];            
        }
    }
    
    if (self.isOn) {
        
        [self changeThumbOffWithAnimation];
        
    }else {
        
        [self changeThumbOnWithAanimation];
    }
    
}

- (void)changeThumbOffWithAnimation {
    
    [UIView animateWithDuration:0.15 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGRect thumbFrame = self.switchThumb.frame;
        thumbFrame.origin.x = thumbOffPosition - bounceOffset;
        self.switchThumb.frame = thumbFrame;
        self.switchThumb.backgroundColor = self.thumbOffTintColor;
        self.trackView.backgroundColor = self.trackOffTintColor;
        
        self.userInteractionEnabled = NO;
    } completion:^(BOOL finished) {
        
        if (finished) {
            
            self.isOn = NO;
            [UIView animateWithDuration:0.15 animations:^{
                CGRect thumbFrame = self.switchThumb.frame;
                thumbFrame.origin.x = thumbOffPosition;
                self.switchThumb.frame = thumbFrame;
            } completion:^(BOOL finished) {
                if (finished) {
                    self.userInteractionEnabled = YES;
                }
            }];
        }
    }];
    
}

- (void)changeThumbOnWithAanimation {
    [UIView animateWithDuration:0.15 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGRect thumbFrame = self.switchThumb.frame;
        thumbFrame.origin.x = thumbOnPosition + bounceOffset;
        self.switchThumb.frame = thumbFrame;
        self.switchThumb.backgroundColor = self.thumbOnTintColor;
        self.trackView.backgroundColor = self.trackOnTintColor;
        
        self.userInteractionEnabled = NO;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            self.isOn = YES;
            
            [UIView animateWithDuration:0.15 animations:^{
                
                CGRect thumbFrame = self.switchThumb.frame;
                thumbFrame.origin.x = thumbOnPosition;
                self.switchThumb.frame = thumbFrame;

            } completion:^(BOOL finished) {
                
                if (finished) {
                    self.userInteractionEnabled = YES;
                }
            }];
        }
    }];

    
}
- (BOOL)getSwitchState {
    return self.isOn;
}

- (void)onTouchDown {
    
    if (self.isOn) {
        
        [self changeThumbOffWithAnimation];
        
    }else {
        
        [self changeThumbOnWithAanimation];
    }
}
@end
