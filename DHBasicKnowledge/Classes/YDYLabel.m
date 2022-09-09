//
//  YDYLabel.m
//  meetCRM
//
//  Created by jabraknight on 2022/3/17.
//  Copyright © 2022 edianyun. All rights reserved.
//

#import "YDYLabel.h"
@interface YDYLabel()
@end
@implementation YDYLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.edgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.edgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.edgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.edgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets) limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}
//
//+ (UIEdgeInsets)edgeInsets {
//    /*- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSString *, id> *)attributes context:(nullable NSStringDrawingContext *)context NS_AVAILABLE(10_11, 7_0);
//     方法计算label的大小时，由于不会调用textRectForBounds方法，并不会计算自己通过edgeInsets插入的内边距，而是实际的大小，因此手动返回进行修正*/
//    return UIEdgeInsetsMake(5, 0, 5, 0);
//}

- (void)createUI {
    
    [self makeConstraints];
}

- (void)makeConstraints {

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
