//
//  CircleView.m
//  Rountine
//
//  Created by lifei on 15/8/8.
//  Copyright (c) 2015年 fan. All rights reserved.
//

#import "CircleView.h"
@interface CircleView ()
@property (strong, nonatomic) CAShapeLayer* circleShapeLayer;
@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGFloat dimension;
@property (nonatomic) CGMutablePathRef path;
@property (nonatomic) CGMutablePathRef oneSecondDimensionCirclePath;
@property (nonatomic) CGMutablePathRef oneForthDimensionCirclePath;
@property (nonatomic) CGMutablePathRef oneThirdDimensionCircelPath;
@end
@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitializer];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitializer];
    }
    return self;
}

- (void)commonInitializer
{
    _circleShapeLayer = [[CAShapeLayer alloc] init];
    _circleShapeLayer.fillColor = [UIColor blackColor].CGColor;
    _circleShapeLayer.lineCap = kCALineCapRound;
    _circleShapeLayer.lineJoin = kCALineJoinRound;
    _circleShapeLayer.contentsScale = self.layer.contentsScale;
    
    self.centerPoint = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    self.dimension = MIN(self.frame.size.width, self.frame.size.height);

    self.oneSecondDimensionCirclePath = CGPathCreateMutable();
    self.oneThirdDimensionCircelPath = CGPathCreateMutable();
    self.oneForthDimensionCirclePath = CGPathCreateMutable();

    CGPathMoveToPoint(_oneSecondDimensionCirclePath, NULL, self.centerPoint.x + _dimension / 2.0f, self.centerPoint.y);
    CGPathAddArc(_oneSecondDimensionCirclePath, NULL, self.centerPoint.x, self.centerPoint.y, _dimension / 2.0f, 0, 2 * M_PI, false);

    CGPathMoveToPoint(_oneThirdDimensionCircelPath, NULL, self.centerPoint.x + _dimension / 3.0f, self.centerPoint.y);
    CGPathAddArc(_oneThirdDimensionCircelPath, NULL, self.centerPoint.x, self.centerPoint.y, _dimension / 3.0f, 0, 2 * M_PI, false);
    _circleShapeLayer.path = _oneThirdDimensionCircelPath;
    
    CGPathMoveToPoint(_oneForthDimensionCirclePath, NULL, self.centerPoint.x + _dimension / 4.0f, self.centerPoint.y);
    CGPathAddArc(_oneForthDimensionCirclePath, NULL, self.centerPoint.x, self.centerPoint.y, _dimension / 4.0f, 0, 2 * M_PI, false);
    
    self.path = _oneThirdDimensionCircelPath;
    
    [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.layer addSublayer:_circleShapeLayer];

}

- (void)touchDown
{
    NSLog(@"touchDown");
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = 0.25f;
    anim.removedOnCompletion = NO;
    anim.fromValue = (__bridge id) self.path;
    anim.toValue = (__bridge id) _oneForthDimensionCirclePath;
    _circleShapeLayer.path = _oneForthDimensionCirclePath;
    [_circleShapeLayer addAnimation:anim forKey:nil];
}

- (void)touchUp
{
    NSLog(@"touchUp");
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = 0.25f;
    anim.removedOnCompletion = NO;
    anim.fromValue = (__bridge id) self.path;
    anim.toValue = (__bridge id) _oneSecondDimensionCirclePath;
    _circleShapeLayer.path = _oneThirdDimensionCircelPath;
    [_circleShapeLayer addAnimation:anim forKey:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
