//
//  Created by beyond on 16/9/10.
//  Copyright © 2016年 beyond. All rights reserved.
//

#import "AlphaModel.h"

@interface TaiYuAlphaModel : AlphaModel

@property (nonatomic,copy) NSString *read;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *resIndex;
// typeNo 1 for 10 high consonants,
// 2 for 9 medium consonants,
// 3 for 23 low consonants
// 4 for 18 vowels,
// 5 for 6 compound vowels,
// 6 for 4 special vowels
@property (nonatomic,copy) NSString *typeNo;
@property (nonatomic,copy) NSString *groupSymbol;
@property (nonatomic,copy) NSString *author;

@end
