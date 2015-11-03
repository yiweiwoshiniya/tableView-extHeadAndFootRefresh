//
//  MZQFooterView.h
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZQStateBar.h"
@class MZQFooterView;

@protocol MZQFooterViewDelegate <NSObject>

-(void)footerViewState:(MZQFooterView *)footerView state:(MZQStateViewState)state;

@end

@interface MZQFooterView : MZQStateBar


@property (nonatomic,weak)id<MZQFooterViewDelegate> delegate;

+(id)footerView;

-(void)setTitle:(NSString *)title footerState:(MZQStateViewState)state;
@end
