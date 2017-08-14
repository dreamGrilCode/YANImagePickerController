//
//  YANPreviewCollectionController.m
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import "YANPreviewCollectionController.h"
#import "YANPreviewCollectionCell.h"
#import "YANNavigationViewController.h"
#import "YANAlbumManage.h"
#import "YANAlbumModel.h"
#import "YANBottomSendView.h"

#define defaultColumnNumber 4
#define defaultPreviewSpacing 2
#define bottomViewHeight 44
#define defaultMaxSelectCount 3
@interface YANPreviewCollectionController ()<YANPreviewCollectionCellDelegate,YANBottomSendViewDelegate>
/** 照片数组**/
@property(nonatomic, strong)NSArray *contentArray;

@property(nonatomic, weak) YANBottomSendView *sendView;
/** 最多选中的图片数 **/
@property(nonatomic, assign) NSInteger maxSelectImageCount;
/** 间距 **/
@property(nonatomic, assign)CGFloat previewSpacing;
/** 列数 **/
@property(nonatomic, assign)NSInteger columnNumber;
/** 选中图片 **/
@property(nonatomic, strong) NSMutableArray *selectImageArray;
/** 选中的label **/
@property(nonatomic, strong) NSMutableArray *selectLabelArray;

@end

@implementation YANPreviewCollectionController

static NSString * const reuseIdentifier = @"previewCell";
- (NSMutableArray *)selectImageArray{

    if (!_selectImageArray) {
        _selectImageArray = [NSMutableArray array];
    }
    return _selectImageArray;
}
- (NSMutableArray *)selectLabelArray{

    if (!_selectLabelArray) {
        _selectLabelArray = [NSMutableArray array];
    }
    return _selectLabelArray;
}
- (instancetype)initWithColumnNumber:(NSInteger)columnNumber previewSpacing:(CGFloat)previewSpacing{
    
    self.previewSpacing = previewSpacing > 0 ? previewSpacing : defaultColumnNumber;
    self.columnNumber = columnNumber > 0 ? columnNumber : defaultColumnNumber;

    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - (self.columnNumber-1) * self.previewSpacing) / self.columnNumber;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = self.previewSpacing;
    flowLayout.minimumInteritemSpacing = self.previewSpacing;
    flowLayout.itemSize = CGSizeMake(itemW, itemW);
    return [self initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[YANPreviewCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, bottomViewHeight, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, bottomViewHeight, 0);
    YANNavigationViewController *navVC = (YANNavigationViewController *)self.navigationController;
    [navVC addLeftCancleToViewController:self];
    self.maxSelectImageCount = navVC.maxSelectImageCount > 0 ? navVC.maxSelectImageCount:defaultMaxSelectCount;
    
    __weak typeof(self)weakSelf = self;
    [[YANAlbumManage defaultManager] getAssetsFromFetchResult:self.model.result completion:^(NSArray *photoArray) {
        weakSelf.contentArray = photoArray;
    }];
    [self scrollToButtom];
    [self addSendView];
}
- (void)addSendView{

    YANBottomSendView *view = [[YANBottomSendView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - bottomViewHeight, [UIScreen mainScreen].bounds.size.width, bottomViewHeight)];
    [self.navigationController.view addSubview:view];
    view.delegate_ = self;
    self.sendView = view;
}
- (void)scrollToButtom{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.contentArray.count > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.contentArray.count - 1 inSection:0];
            [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        }
    });
    
}
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.sendView removeFromSuperview];
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    YANPreviewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[YANPreviewCollectionCell alloc] init];
    }
    cell.delegate_ = self;
    UILabel *label = [cell setImage:self.contentArray[indexPath.row] selectImageArray:self.selectImageArray];
    if (!label.isHidden) {
        [self.selectLabelArray replaceObjectAtIndex:[label.text intValue] - 1 withObject:label];
    }
    return cell;
}
#pragma mark - YANPreviewCollectionCellDelegate
- (void)previewCollectionCellSelectImage:(id)asset  label:(UILabel *)label{
    if (self.maxSelectImageCount > self.selectImageArray.count || !label.isHidden) {
        label.hidden = !label.isHidden;
        if (!label.isHidden) {
            
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = label.bounds.size.width / 2;
            [self.selectImageArray addObject:asset];
            [self.selectLabelArray addObject:label];
            label.text = [NSString stringWithFormat:@"%lu",self.selectLabelArray.count];
            
        }else{
            
            [self.selectImageArray removeObject:asset];
            [self.selectLabelArray removeObject:label];
            for (int i = [label.text intValue]; i <= self.selectImageArray.count; i ++) {
                UILabel *selectLabel = (UILabel *)self.selectLabelArray[i - 1];
                selectLabel.text = [NSString stringWithFormat:@"%d",i];
            }
        }
        
    }else{
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"您最多只能选中%ld张照片",(long)self.maxSelectImageCount] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    
    
}
#pragma mark - YANBottomSendViewDelegate
- (void)bottomSendViewClickSendPhoto{

    if (self.selectImageArray.count > 0) {
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        YANNavigationViewController *navVC = (YANNavigationViewController *)self.navigationController;
        navVC.artworkMaster(self.selectImageArray);
    }
}

@end
