//
//  ViewController.m
//  CollectionViewMutiSelected
//
//  Created by GE on 15/11/30.
//  Copyright © 2015年 GE. All rights reserved.
//

#import "ViewController.h"
#import "Cell_Muti.h"

static NSString * cellIdentifier = @"cell";

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSMutableArray * selectedArr;

@property (nonatomic, strong) NSMutableDictionary * selectDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
}

- (void)initData
{
    self.selectedArr = [NSMutableArray array];
    self.selectDic = [[NSMutableDictionary alloc]init];
}

- (void)createUI
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(160, 50);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, 320, 568 - 64 - 80) collectionViewLayout:flowLayout];
    self.collectionView.allowsMultipleSelection = YES;

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"Cell_Muti" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.collectionView];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), 320, 60)];
    [btn addTarget:self action:@selector(displaySelectedResult) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"显示" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_Muti * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSArray * keyArr = [self.selectDic allKeys];
    if ([keyArr containsObject:[NSString stringWithFormat:@"%d",indexPath.row]]) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }else{
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    

    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(160, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionViewDelegate

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell_Muti * cell = (Cell_Muti *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    [self.selectDic setObject:@"测试" forKey:[NSString stringWithFormat:@"%d",indexPath.row]];


}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"测试删除");
    Cell_Muti * cell = (Cell_Muti *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self.selectDic removeObjectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    cell.contentView.backgroundColor = [UIColor blackColor];
//    [self.collectionView reloadData];
}


- (void) displaySelectedResult
{
    NSString * keyStr =  @"已选";
    NSArray * keyArr = [self.selectDic allKeys];
    for (NSInteger i = 0; i<keyArr.count; i++) {
        NSString * str = [keyArr objectAtIndex:i];
        keyStr = [keyStr stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
    }
    
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"已选" message:keyStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
                        
//    NSLog(@"已选择key = %@",[self.selectDic allKeys]);
}
@end
