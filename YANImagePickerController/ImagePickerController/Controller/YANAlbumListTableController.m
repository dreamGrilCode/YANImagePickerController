//
//  YANAlbumListTableController.m
//  YANImagePickerController
//
//  Created by yan on 2017/8/8.
//  Copyright © 2017年 yan.liu. All rights reserved.
//

#import "YANAlbumListTableController.h"
#import "YANAlbumListTableCell.h"
#import "YANAlbumManage.h"
#import "YANAlbumModel.h"
#import "YANPreviewCollectionController.h"
#import "YANNavigationViewController.h"


#define defaultRowHeight 65

@interface YANAlbumListTableController ()

@property(nonatomic, strong)NSArray *albumArray;

@property(nonatomic, assign)CGFloat rowHeight;

@property(nonatomic, assign)CGFloat previewSpacing;

@property(nonatomic, assign)NSInteger columnNumber;

@end

static NSString *identifier = @"albumCell";
@implementation YANAlbumListTableController
+(UINavigationController *)albumListTableControllerRowHeight:(CGFloat)rowHeight columnNumber:(NSInteger)columnNumber previewSpacing:(CGFloat)previewSpacing{
    
    YANNavigationViewController *navVC = [[YANNavigationViewController alloc] initWithRootViewController:[[self alloc] initWithRowHeight:rowHeight columnNumber:columnNumber previewSpacing:previewSpacing]];
    YANPreviewCollectionController *previewCC = [[YANPreviewCollectionController alloc] initWithColumnNumber:columnNumber previewSpacing:previewSpacing];
    __weak typeof(YANPreviewCollectionController *)weakPreviewCC = previewCC;
    [[YANAlbumManage defaultManager] getCameraRollAlbumAllowPickingImageCompletion:^(YANAlbumModel *model) {
        weakPreviewCC.model = model;
        weakPreviewCC.navigationItem.title = model.name;
    }];
    [navVC pushViewController:previewCC animated:YES];
    return navVC;
    
}
- (instancetype)initWithRowHeight:(CGFloat)rowHeight columnNumber:(NSInteger)columnNumber previewSpacing:(CGFloat)previewSpacing{

    if (self = [super init]) {
        self.rowHeight = rowHeight;
        self.previewSpacing = previewSpacing;
        self.columnNumber = columnNumber;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[YANAlbumListTableCell class] forCellReuseIdentifier:identifier];
    self.navigationItem.title = @"相册";
    
    YANNavigationViewController *navVC = (YANNavigationViewController *)self.navigationController;
    [navVC addLeftCancleToViewController:self];
    self.tableView.rowHeight = self.rowHeight > 0 ? self.rowHeight : defaultRowHeight;
    __weak typeof(self)weakSelf = self;
    [[YANAlbumManage defaultManager] getAllAlbumsCompletion:^(NSArray<YANAlbumModel *> *models) {
        weakSelf.albumArray = models;
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.albumArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YANAlbumModel *model = self.albumArray[indexPath.row];
    YANAlbumListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[YANAlbumListTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.albumInfo = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YANAlbumModel *model = self.albumArray[indexPath.row];
    YANPreviewCollectionController *previewCC = [[YANPreviewCollectionController alloc] initWithColumnNumber:self.columnNumber previewSpacing:self.previewSpacing];
    previewCC.navigationItem.title = model.name;
    previewCC.model = model;
    [self.navigationController pushViewController:previewCC animated:YES];
    
}


@end
