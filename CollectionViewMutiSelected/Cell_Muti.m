//
//  Cell_Muti.m
//  CollectionViewMutiSelected
//
//  Created by GE on 15/11/30.
//  Copyright © 2015年 GE. All rights reserved.
//

#import "Cell_Muti.h"

@interface Cell_Muti()

@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@end

@implementation Cell_Muti






- (void)awakeFromNib {
//    [self.selectImg setImage:[UIImage imageNamed:@"框1"]];
    self.selectImg.backgroundColor = [UIColor redColor];
}

//- (void)setIsSelected:(BOOL)isSelected
//{
//    _isSelected = isSelected;
//    if (isSelected) {
//        self.selectImg.backgroundColor = [UIColor redColor];
//        
//    }else{
//        self.selectImg.backgroundColor = [UIColor blackColor];
//    }
//}

@end
