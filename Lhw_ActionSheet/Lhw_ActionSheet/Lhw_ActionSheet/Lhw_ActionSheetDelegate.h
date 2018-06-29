//
//  Lhw_ActionSheetDelegate.h
//  Project_collection
//
//  Created by lee on 2018/6/28.
//  Copyright © 2018年 首约科技（北京）有限公司 Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Lhw_ActionSheet;

@protocol Lhw_ActionSheetDelegate <NSObject>

@optional

- (void)actionSheet:(Lhw_ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)actionSheetCancel:(Lhw_ActionSheet *)actionSheet;

@end
