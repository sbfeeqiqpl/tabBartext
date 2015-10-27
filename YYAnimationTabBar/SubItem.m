//
//  SubItem.m
//  YYAnimationTabBar
//
//  Created by 王园园 on 15/10/26.
//  Copyright © 2015年 王园园. All rights reserved.
//

#import "SubItem.h"


@implementation Item

-(instancetype)initItemWithDictionary:(NSDictionary *)dict;
{
    self = [super init];
    if(self){
        self.title = dict[@"title"];
        self.imageStr = dict[@"imageStr"];
        self.imageStr_s = dict[@"imageStr_s"];
    }
    return self;
}
@end




@implementation SubItem
{
    UIImageView *ico;
    UILabel *titleLable;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        ico = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-15, 3, 30,30)];
        ico.userInteractionEnabled = NO;
        [self addSubview:ico];
        
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 19)];
        titleLable.userInteractionEnabled = NO;
        titleLable.textColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:12.];
        [self addSubview:titleLable];
    }
    return self;
}



-(void)setItem:(Item *)item
{
    ico.image = [UIImage imageNamed:item.imageStr_s];
    titleLable.text = item.title;
}


-(void)setItemSlected:(Complete)finish;
{
    [UIView animateWithDuration:0.5 animations:^{
        //缩放动画
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.toValue = [NSNumber numberWithFloat:2.0];
        scaleAnimation.duration = 0.5f;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //透明度变化
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.1];
        
        //位置移动
        CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.fromValue =  [NSValue valueWithCGPoint: titleLable.layer.position];
        CGPoint toPoint = titleLable.layer.position;
        toPoint.y -= 80;
        animation.toValue = [NSValue valueWithCGPoint:toPoint];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = 0.5f;
        animationGroup.autoreverses = NO;   //是否重播，原动画的倒播
        animationGroup.repeatCount = 0;
        [animationGroup setAnimations:[NSArray arrayWithObjects:opacityAnimation, scaleAnimation,animation, nil]];
        //将上述动画添加至目标层
        [titleLable.layer addAnimation:animationGroup forKey:@"animationGroup"];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            ico.transform = CGAffineTransformMakeScale(4/3, 4/3);
        } completion:^(BOOL finished) {
            ico.frame = CGRectMake(self.frame.size.width/2-20, 3, 40,40);
            titleLable.alpha = 0;
            titleLable.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 20);
        }];
    }];
    
    finish();
}

-(void)setItemNomal;
{
    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ico.transform = CGAffineTransformMakeScale(1.0, 1.0);
        ico.frame = CGRectMake(self.frame.size.width/2-15, 3, 30,30);
        
        titleLable.alpha = 1.0;
        titleLable.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    } completion:^(BOOL finished) {
        
    }];
}

@end
