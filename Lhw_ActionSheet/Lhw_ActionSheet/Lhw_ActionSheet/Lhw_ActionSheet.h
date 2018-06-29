//
//  Lhw_ActionSheet.h
//  Project_collection
//
//  Created by lee on 2018/6/28.
//  Copyright © 2018年 首约科技（北京）有限公司 Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lhw_ActionSheetDelegate.h"

@interface Lhw_ActionSheet : UIView

- (instancetype)initWithTitle:(nullable NSString *)title delegate:(nullable id<Lhw_ActionSheetDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@property (nonatomic, weak) id <Lhw_ActionSheetDelegate> delegate;

@property (nonatomic, strong) UIColor * titleColor;

- (void)show;

@end
