//
//  ZPSnowflakeView.m
//  下雪动画
//
//  Created by 赵鹏 on 2018/12/28.
//  Copyright © 2018 赵鹏. All rights reserved.
//

#import "ZPSnowflakeView.h"

static CGFloat snowflakeY = 0;  //雪花的Y值

@implementation ZPSnowflakeView

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"snowflake"];
    
    //绘制雪花
    [image drawAtPoint:CGPointMake(50, snowflakeY)];
    
    //修改雪花的Y值
    snowflakeY += 10;
    
    //如果雪花下到屏幕之外的话，雪花要重新从Y = 0的位置开始。
    if (snowflakeY > rect.size.height)
    {
        snowflakeY = 0;
    }
}

//系统在加载完xib文件以后就会调用这个方法
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    /**
     NSTimer类很少用于绘图，因为调用的优先级比较低，在设定的时间内并不会准时被调用；
     在绘图中一般用CADisplayLink类来作为定时器使用，CADisplayLink类在每次屏幕刷新的时候都会被调用，屏幕一般一秒刷新60次，故而CADisplayLink类一秒会被调用60次。
     */
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(moveSnowflake)];
    
    //把CADisplayLink类的对象添加到主运行循环中：
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark ————— 移动雪花 —————
- (void)moveSnowflake
{
    /**
     调用这个方法的时候并不会马上调用"drawRect:"方法。这个方法只是给当前控件添加刷新的标记，等下一次屏幕刷新的时候才会调用"drawRect:"方法了。
     */
    [self setNeedsDisplay];
}

@end
