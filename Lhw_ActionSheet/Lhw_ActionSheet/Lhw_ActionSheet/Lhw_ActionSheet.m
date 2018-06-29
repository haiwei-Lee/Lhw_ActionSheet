//
//  Lhw_ActionSheet.m
//  Project_collection
//
//  Created by lee on 2018/6/28.
//  Copyright © 2018年 首约科技（北京）有限公司 Inc. All rights reserved.
//

#import "Lhw_ActionSheet.h"

#define kSectionItemHeight  50
#define kSpace              10

@interface Lhw_ActionSheet()

@property (nonatomic, strong) UIView * actionSheetView;

@property (nonatomic, strong) UIView * sectionView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UIButton * cancelBtn;

@property (nonatomic, strong) NSMutableArray * otherTitles;

@end

@implementation Lhw_ActionSheet

- (instancetype)initWithTitle:(nullable NSString *)title delegate:(nullable id<Lhw_ActionSheetDelegate>)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]){
        _delegate = delegate;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
        _sectionView = [[UIView alloc]init];
        _sectionView.backgroundColor = [UIColor whiteColor];
        [UIView animateWithDuration:.5 animations:^{
            [self addSubview:self->_sectionView];
        }];
        
        if (title){
            [self.sectionView addSubview:self.titleLabel];
            self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), kSectionItemHeight);
            self.titleLabel.text = title;
        }
        if (cancelButtonTitle){
            [UIView animateWithDuration:.5 animations:^{
                [self addSubview:self.cancelBtn];
            }];
            self.cancelBtn.frame = CGRectMake(0, CGRectGetHeight(self.frame)-kSectionItemHeight, CGRectGetWidth(self.frame), kSectionItemHeight);
            [self.cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        }
        
        _otherTitles = [NSMutableArray array];
        va_list args;
        va_start(args,otherButtonTitles);
        if (otherButtonTitles){
            [_otherTitles addObject:otherButtonTitles];
            
            id temp;
            while ((temp = va_arg(args, NSString *))){
                [_otherTitles addObject:temp];
            }
        }
        va_end(args);
        
        NSInteger maxCount = (CGRectGetHeight(self.frame) - 2*kSectionItemHeight - kSpace)/kSectionItemHeight -1;//最大的items个数
        if (!title){
            maxCount = (CGRectGetHeight(self.frame) - kSectionItemHeight - kSpace)/kSectionItemHeight -1;
        }
        
        CGFloat sectionViewHeight = 0;
        if (title && _otherTitles.count==0){
            sectionViewHeight = kSectionItemHeight;
        }else if (title && _otherTitles.count>0){
            sectionViewHeight = (MIN(_otherTitles.count, maxCount)+1) * kSectionItemHeight;
        }else if (!title && _otherTitles.count >0){
            sectionViewHeight = MIN(_otherTitles.count, maxCount) * kSectionItemHeight;
        }
    
        _sectionView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-sectionViewHeight-kSectionItemHeight-kSpace, CGRectGetWidth(self.frame), sectionViewHeight);
        if (!cancelButtonTitle){
             _sectionView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-sectionViewHeight, CGRectGetWidth(self.frame), sectionViewHeight);
        }
        if(!title && !cancelButtonTitle && _otherTitles.count ==0){
            _sectionView.frame = CGRectZero;
        }
        
        if(_otherTitles.count > 0){
            for (int index =0; index < MIN(_otherTitles.count, maxCount); index++){
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+ index * kSectionItemHeight, CGRectGetWidth(self.frame), kSectionItemHeight);
                [button setTitle:_otherTitles[index] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:15];
                button.tag = index+1;
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_sectionView addSubview:button];
                
                UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, kSectionItemHeight-.5, CGRectGetWidth(button.frame), .5)];
                line.backgroundColor = [UIColor lightGrayColor];
                [button addSubview:line];
            }
        }
    }
   
    return self;
}

- (void)show{
    if (!self) return;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.windowLevel =UIWindowLevelAlert;
    [window addSubview:self];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_titleLabel addSubview:self.lineView];
        self.lineView.frame = CGRectMake(0, kSectionItemHeight-.5, CGRectGetWidth(self.frame), .5);
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectZero;
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelBtn.tag = 0;
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)cancelButtonClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [self.delegate actionSheetCancel:self];
    }
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:sender.tag];
    }
    [self removeActionSheetView];
   
}

- (void)buttonClicked:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:sender.tag];
    }
    [self removeActionSheetView];
}

- (void)removeActionSheetView{
    [UIView animateWithDuration:.5 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

@end
