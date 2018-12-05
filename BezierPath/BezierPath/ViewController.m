//
//  ViewController.m
//  BezierPath
//
//  Created by zk on 2018/12/4.
//  Copyright © 2018年 zk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CAShapeLayer *movingCircleLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self circle];
//    [self createTwoCircle:CGRectMake(100, 0, 200, 200)];
//    [self movingCircle];
//    [self pentagon];
//    [self dottedLine];
    [self curvedLine];
    // Do any additional setup after loading the view, typically from a nib.
}

//画一个圆形
- (void)circle {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, 200, 200);//设置shapelayer的尺寸和位置
    shapeLayer.position = self.view.center;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.75;
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 200, 200)];
    shapeLayer.path = bezierPath.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
}

//两个圆 内圆表示进度
- (void)createTwoCircle:(CGRect)bounds {
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(bounds.size.width - 0.7) / 2 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.fillColor = nil;
    trackLayer.strokeColor = [UIColor grayColor].CGColor;
    trackLayer.path = trackPath.CGPath;
    trackLayer.lineWidth = 2;
    trackLayer.frame = bounds;
    [self.view.layer addSublayer:trackLayer];
    
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:(bounds.size.width - 0.7) / 2 startAngle:-M_PI_2 endAngle:(M_PI * 2) * 0.7 - M_PI_2 clockwise:YES];
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.fillColor = nil;
    progressLayer.strokeColor = [UIColor redColor].CGColor;
    progressLayer.lineCap = kCALineCapRound;
    progressLayer.path = progressPath.CGPath;
    progressLayer.lineWidth = 2;
    progressLayer.frame = bounds;
    [self.view.layer addSublayer:progressLayer];
}

//创建一个转动的圆
- (void)movingCircle {
    self.movingCircleLayer = [CAShapeLayer layer];
    self.movingCircleLayer.frame = CGRectMake(0, 0, 150, 150);
    self.movingCircleLayer.position = self.view.center;
    self.movingCircleLayer.fillColor = [UIColor clearColor].CGColor;
    //设置线条宽度和颜色
    self.movingCircleLayer.lineWidth = 2;
    self.movingCircleLayer.strokeColor = [UIColor redColor].CGColor;
    //设置stroke起始点
    self.movingCircleLayer.strokeStart = 0;
    self.movingCircleLayer.strokeEnd = 0;
    
    //创建贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 150, 150)];
    
    self.movingCircleLayer.path = circlePath.CGPath;
    
    [self.view.layer addSublayer:self.movingCircleLayer];
    
    __weak typeof(self) weakSelf = self;
    //修改起始点位置 形成转动圆
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakSelf.movingCircleLayer.strokeEnd > 1 && weakSelf.movingCircleLayer.strokeStart < 1) {
            weakSelf.movingCircleLayer.strokeStart += 0.1;
        } else if (weakSelf.movingCircleLayer.strokeStart == 0) {
            weakSelf.movingCircleLayer.strokeEnd += 0.1;
        }
        if (weakSelf.movingCircleLayer.strokeEnd == 0) {
            weakSelf.movingCircleLayer.strokeStart = 0;
        }
        if (weakSelf.movingCircleLayer.strokeStart == weakSelf.movingCircleLayer.strokeEnd) {
            weakSelf.movingCircleLayer.strokeEnd = 0;
        }
    }];
}

//画一个五边形
- (void)pentagon {
    UIBezierPath *pentagonPath = [UIBezierPath bezierPath];
    //开始点
    [pentagonPath moveToPoint:CGPointMake(100, 100)];
    //添加线
    [pentagonPath addLineToPoint:CGPointMake(60, 140)];
    [pentagonPath addLineToPoint:CGPointMake(60, 240)];
    [pentagonPath addLineToPoint:CGPointMake(160, 240)];
    [pentagonPath addLineToPoint:CGPointMake(160, 140)];
    [pentagonPath closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //设置边框颜色
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //设置填充颜色
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.path = pentagonPath.CGPath;
    [self.view.layer addSublayer:shapeLayer];
}

//一条虚线
- (void)dottedLine {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.view.bounds];
    [shapeLayer setPosition:self.view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:3.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:1],nil]];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 89);
    CGPathAddLineToPoint(path, NULL, 320,89);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[self.view layer] addSublayer:shapeLayer];
}

//一条弧线
- (void)curvedLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;//线条拐角
    path.lineJoinStyle = kCGLineCapRound;//终点处理
    [path moveToPoint:CGPointMake(20, 100)];
    [path addQuadCurveToPoint:CGPointMake(120, 100) controlPoint:CGPointMake(70, 0)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
}

@end
