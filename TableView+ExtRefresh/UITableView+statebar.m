//
//  UITableView+statebar.m
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UITableView+statebar.h"
#import <objc/runtime.h>
@interface UITableView ()

@end

@implementation UITableView (statebar)
static char FooterViewKey;
static char HeaderViewKey;
-(void)addHeaderView
{
    self.headerView = [MZQHeaderView headerView];
    [self addSubview:self.headerView];
    
    
//    [self.headerView setTitle:@"下拉我" headerState:MZQHeaderViewStateBeginDrag];
//    [self.headerView setTitle:@"手拿开" headerState:MZQHeaderViewStateDragging];
//    [self.headerView setTitle:@"玩命加载咯" headerState:MZQHeaderViewStateRefresh];
}
-(void)addFooterView
{
    self.footerView = [MZQFooterView footerView];
    [self addSubview:self.footerView];
    
    
    
//    [self.footerView setTitle:@"拖我" footerState:MZQFooterViewStateBeginDrag];
//    [self.footerView setTitle:@"把手撒开" footerState:MZQFooterViewStateDragging];
//    [self.footerView setTitle:@"玩命加载中" footerState:MZQFooterViewStateLoading];
}
-(void)addHeaderViewAndFooterView
{
    [self addHeaderView];
    [self footerView];
}
-(void)headerViewFinish
{
    [self.headerView stopAnimation];
}
-(void)footerViewFinish
{
    [self.footerView stopAnimation];
}







-(void)setHeaderView:(MZQHeaderView *)headerView{
    objc_setAssociatedObject(self, &HeaderViewKey, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MZQFooterView *)headerView{
    return objc_getAssociatedObject(self, &HeaderViewKey);
}


-(void)setFooterView:(MZQFooterView *)footerView{
    objc_setAssociatedObject(self, &FooterViewKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(MZQFooterView *)footerView{
    return objc_getAssociatedObject(self, &FooterViewKey);
}
@end
