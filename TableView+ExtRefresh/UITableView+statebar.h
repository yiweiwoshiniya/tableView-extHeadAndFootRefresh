//
//  UITableView+statebar.h
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZQHeaderView.h"
#import "MZQFooterView.h"


@interface UITableView (statebar)
@property (retain, nonatomic) MZQFooterView *footerView;
@property (retain, nonatomic) MZQHeaderView *headerView;
-(void)addHeaderView;
-(void)addFooterView;
-(void)headerViewFinish;
-(void)footerViewFinish;
@end
