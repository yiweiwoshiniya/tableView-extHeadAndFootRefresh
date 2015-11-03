//
//  MZQStateBar.m
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MZQStateBar.h"

@interface MZQStateBar ()

@end

@implementation MZQStateBar

+(id)stateBar
{
    return [[self alloc]init];
}
-(UIButton *)alertButtonView
{
    if(_alertButtonView == nil)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = self.bounds;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        _alertButtonView = btn;
    }
    return _alertButtonView;
}
-(UIView *)loadingView
{
    if(_loadingView == nil)
    {
        UIView *loadingView = [[UIView alloc]init];
        loadingView.frame = self.bounds;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 20, 200, 30)];
        label.font = [UIFont systemFontOfSize:15];
        label.numberOfLines = 0;
        if(self.state == MZQHeaderViewStateRefresh)
        {
            label.text = [self titleWithState:MZQHeaderViewStateRefresh];
        }else
        {
            label.text = [self titleWithState:MZQFooterViewStateLoading];
        }
        //根据文本内容计算位置
        CGSize size = CGSizeMake(loadingView.frame.size.width-90, 60);
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        size = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        CGFloat X = (loadingView.frame.size.width-size.width-50)/2.0;
        CGRect rect = label.frame;
        rect.origin.x = X+50;
        rect.size.width = size.width;
        label.frame = rect;
        [loadingView addSubview:label];
        
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.frame = CGRectMake(X, 10, 50, 50);
        [loadingView addSubview:activity];
        [self addSubview:loadingView];
        _loadingView = loadingView;
        [activity startAnimating];
    }
    return _loadingView;
}

-(void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)clear
{
    [self.alertButtonView removeFromSuperview];
    [self.loadingView removeFromSuperview];
    if(self.state == MZQHeaderViewStateRefresh)
    {
        self.state = MZQHeaderViewStateBeginDrag;
    }else
    {
        self.state = MZQFooterViewStateBeginDrag;
    }
}

-(void)stopAnimation
{
    _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self clear];
    [self didMoveToSuperview];
}
-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [scrollView addSubview:self];
}
-(NSString *)titleWithState:(MZQStateViewState)state
{
    NSString *title = nil;
    switch (state) {
        case MZQHeaderViewStateBeginDrag:
            title  = _beginText?_beginText:@"下拉刷新";
            break;
        case MZQHeaderViewStateDragging:
            title = _draggingText?_draggingText:@"松开既可刷新,欢迎收藏 ^_^";
            break;
        case MZQHeaderViewStateRefresh:
            title = _refreshText?_refreshText:@"^_^正在刷新^_^";
            break;
        case MZQFooterViewStateBeginDrag:
            title = _beginText?_beginText:@"上拉加载更多";
            break;
        case MZQFooterViewStateDragging:
            title = _draggingText?_draggingText:@"松开既可加载,欢迎收藏 ^_^";
            break;
        case MZQFooterViewStateLoading:
            title = _refreshText?_refreshText:@"^_^正在加载^_^";
            break;
        default:
            break;
    }
    return title;
}
-(void)setState:(MZQStateViewState)state
{
    _state = state;
    switch (state) {
        case MZQHeaderViewStateBeginDrag:
            [self.alertButtonView setTitle:[self titleWithState:MZQHeaderViewStateBeginDrag] forState:UIControlStateNormal];
            break;
        case MZQHeaderViewStateDragging:
            [self.alertButtonView setTitle:[self titleWithState:MZQHeaderViewStateDragging] forState:UIControlStateNormal];
            break;
        case MZQHeaderViewStateRefresh:
            self.alertButtonView.hidden = YES;
            self.loadingView;
            break;
        case MZQFooterViewStateBeginDrag:
            [self.alertButtonView setTitle:[self titleWithState:MZQFooterViewStateBeginDrag] forState:UIControlStateNormal];
            break;
        case MZQFooterViewStateDragging:
            [self.alertButtonView setTitle:[self titleWithState:MZQFooterViewStateDragging] forState:UIControlStateNormal];
            break;
        case MZQFooterViewStateLoading:
            self.alertButtonView.hidden = YES;
            self.loadingView;
            break;
        default:
            break;
    }
}

-(void)didMoveToSuperview
{
    self.scrollView = self.superview;
}


@end
