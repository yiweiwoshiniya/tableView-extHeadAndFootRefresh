//
//  MZQStateBar.h
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MZQStateViewState) {
    MZQHeaderViewStateBeginDrag,
    MZQHeaderViewStateDragging,
    MZQHeaderViewStateRefresh,
    
    MZQFooterViewStateBeginDrag,
    MZQFooterViewStateDragging,
    MZQFooterViewStateLoading,
    
};
@interface MZQStateBar : UIView

{
    UIScrollView *_scrollView;
    MZQStateViewState _state;
    NSString * _beginText;
    NSString * _draggingText;
    NSString * _refreshText;
}
@property (nonatomic ,assign)MZQStateViewState state;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,weak)UIButton *alertButtonView;
@property (nonatomic,weak)UIView *loadingView;
+(id)stateBar;
-(void)stopAnimation;
@end
