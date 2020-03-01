//
//  Created by beyond on 16/9/10.
//  Copyright © 2016年 beyond. All rights reserved.
//

#import "TaiYuAlphaModel.h"

@implementation TaiYuAlphaModel

- (NSString *)alpha_mp3
{
    return @"";
}
- (NSString *)alpha_remark
{
    return _remark;
}
- (NSString *)menuItem1
{
    return super.alpha;
}
- (NSString *)menuItem2
{
    return _read;
}
- (NSString *)menuItem3
{
    return _remark;
}
- (NSString *)menuItem4
{
    return @"";
}
- (NSString *)hongBaoTopStr
{
    return super.alpha;
}
- (NSString *)hongBaoMiddleStr
{
    return _read;
}
- (NSString *)hongBaoBottomStr
{
    return _remark;
}

- (NSString *)hongBaoImgLocalName
{
    return [NSString stringWithFormat:@"encode_%@.jpg",_resIndex];
}
@end
