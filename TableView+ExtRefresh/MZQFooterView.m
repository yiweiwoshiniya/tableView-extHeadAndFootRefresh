//
//  MZQFooterView.m
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MZQFooterView.h"
@interface MZQFooterView()
@property (nonatomic,weak)UIButton *alertButtonView;
@property (nonatomic,weak)UIView *loadingView;
@end
@implementation MZQFooterView


+(id)footerView{
    return [[self alloc]init];
}


-(void)setTitle:(NSString *)title footerState:(MZQStateViewState)state
{
    switch (state) {
        case MZQFooterViewStateBeginDrag:
            _beginText = title;
            break;
        case MZQFooterViewStateDragging:
            _draggingText = title;
            break;
        case MZQFooterViewStateLoading:
            _refreshText = title;
            break;
        default:
            break;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if(self.state == MZQFooterViewStateLoading) return;
    [self willMoveToSuperview:_scrollView];
    if(self.scrollView.isDragging)
    {
        CGFloat maxY = _scrollView.contentSize.height - _scrollView.frame.size.height;
        if(_scrollView.contentOffset.y>maxY && _scrollView.contentOffset.y<self.frame.size.height+maxY)
        {
            self.state = MZQFooterViewStateBeginDrag;
        }else if(_scrollView.contentOffset.y>self.frame.size.height+maxY){
            self.state = MZQFooterViewStateDragging;
        }

    }else
    {
        if(self.state == MZQFooterViewStateDragging)
        {
            [self setState:MZQFooterViewStateLoading];
            _scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
            [_delegate footerViewState:self state:MZQFooterViewStateLoading];
        }
    }
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView  *tableView = (UITableView *)newSuperview;
    
    
    //添加到什么位置
    CGFloat selfX = 0;
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);

}

@end
