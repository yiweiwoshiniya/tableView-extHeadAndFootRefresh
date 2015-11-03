//
//  MZQHeaderView.m
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MZQHeaderView.h"

@interface MZQHeaderView ()
@property (nonatomic,weak)UIButton *alertButtonView;
@property (nonatomic,weak)UIView *loadingView;
@end

@implementation MZQHeaderView

+(id)headerView
{
    return [[self alloc]init];
}

-(void)setTitle:(NSString *)title headerState:(MZQStateViewState)state
{
    switch (state) {
        case MZQHeaderViewStateBeginDrag:
            _beginText = title;
            break;
        case MZQHeaderViewStateDragging:
            _draggingText = title;
            break;
        case MZQHeaderViewStateRefresh:
            _refreshText = title;
            break;
        default:
            break;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if(self.state == MZQHeaderViewStateRefresh) return;
    [self willMoveToSuperview:_scrollView];
    if(self.scrollView.isDragging)
    {
        
        if(_scrollView.contentOffset.y<0 && _scrollView.contentOffset.y>-self.frame.size.height)
        {
            self.state = MZQHeaderViewStateBeginDrag;
        }else if(_scrollView.contentOffset.y<-self.frame.size.height){
            self.state = MZQHeaderViewStateDragging;
        }
        
    }else
    {
        if(self.state == MZQHeaderViewStateDragging)
        {
            [self setState:MZQHeaderViewStateRefresh];
            _scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
            [_delegate headerViewDelegate:self state:MZQHeaderViewStateRefresh];
            
        }
    }
}


-(void)willMoveToSuperview:(UIView *)newSuperview
{
    UITableView  *tableView = (UITableView *)newSuperview;
    
    
    //添加到什么位置
    CGFloat selfX = 0;
    CGFloat selfY = -60;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    
}

@end
