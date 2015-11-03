//
//  MZQHeaderView.h
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZQStateBar.h"
@class MZQHeaderView;



@protocol MZQHeaderViewDelegate <NSObject>

-(void)headerViewDelegate:(MZQHeaderView *)headerView state:(MZQStateViewState)state;

@end

@interface MZQHeaderView : MZQStateBar

@property(nonatomic,weak)id<MZQHeaderViewDelegate> delegate;



+(id)headerView;

-(void)setTitle:(NSString *)title headerState:(MZQStateViewState)state;

@end
