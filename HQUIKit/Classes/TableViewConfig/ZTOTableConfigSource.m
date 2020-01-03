//
//  ZTOTableConfigSource.m
//  ZTOShop
//
//  Created by guohongqi on 2019/12/30.
//  Copyright © 2019 caiyanzhi. All rights reserved.
//

#import "ZTOTableConfigSource.h"

@interface ZTOTableConfigSource()
@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;

@property (nonatomic, copy) CellConfigureBefore cellConfigureBefore;

@property (nonatomic, copy)   selectCell selectBlock;

@property (nonatomic, copy)   deleteCell deleteBlock;

@property (nonatomic, copy)   reloadData reloadData;

@property (nonatomic, copy)   cellHeight cellHeight;

@property (nonatomic, copy)   configCell idenCell;
@end

@implementation ZTOTableConfigSource


#pragma mark --  接口

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock deleteBlock:(deleteCell)deleteBlock reloadData:(reloadData)reloadData{
    
    if(self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
        _selectBlock = [selectBlock copy];
        _reloadData = [reloadData copy];
        _deleteBlock = [deleteBlock copy];
    }
    return self;
}

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock deleteBlock:(deleteCell)deleteBlock indexCellHeight:(cellHeight)cellHeight reloadData:(reloadData)reloadData{
    if(self = [super init]) {
        _cellIdentifier      = identifier;
        _cellConfigureBefore = [before copy];
        _selectBlock         = [selectBlock copy];
        _reloadData          = [reloadData copy];
        _deleteBlock         = [deleteBlock copy];
        _cellHeight          = [cellHeight copy];
    }
    return self;
}

- (id)initWithCell:(configCell)idenCell configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock deleteBlock:(deleteCell)deleteBlock indexCellHeight:(cellHeight)cellHeight reloadData:(reloadData)reloadData{
    if(self = [super init]) {
        _idenCell            = [idenCell copy];
        _cellConfigureBefore = [before copy];
        _selectBlock         = [selectBlock copy];
        _reloadData          = [reloadData copy];
        _deleteBlock         = [deleteBlock copy];
        _cellHeight          = [cellHeight copy];
    }
    return self;
}



// 加载最新
- (void)reloadData:(NSArray *)datas{
    if(!datas) return;
    
    if (self.dataArray.count>0) {
        [self.dataArray removeAllObjects];
    }
    
    [self.dataArray addObjectsFromArray:datas];
}

// 删除某行数据
- (void)deleteDataIndex:(NSIndexPath *)index{
    [self.dataArray removeObjectAtIndex:index.row];
    __weak ZTOTableConfigSource *weakself = self;
    self.reloadData(weakself.dataArray);
}

// 加载更多
- (void)addDataArray:(NSArray *)datas{
    
    [self.dataArray addObjectsFromArray:datas];
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sectionTableView)]) {
        return [self.delegate sectionTableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfRowsInSection:)]) {
        return [self.delegate numberOfRowsInSection:section];
    }
    return !self.dataArray  ? 0: self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellHeight) {
        return _cellHeight(indexPath);
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (_idenCell) {
        // 多类型cell
        cell = _idenCell(tableView,indexPath);
    }else{
        // 单类型cell
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    id model;
    if (self.delegate && [self.delegate respondsToSelector:@selector(modelIndexCell:)]) {
        // 多分区model
        model = [self.delegate modelIndexCell:indexPath];
    }else{
        // 单分区model
        model = [self modelsAtIndexPath:indexPath];
    }
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return _isEdit;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.deleteBlock(indexPath);
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableview:(UITableView *)tableview titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete";
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.deleteBlock) {
            self.deleteBlock(indexPath);
        }
    }];
    return @[deleteAction];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(heigthForSection:)]) {
        return [self.delegate heigthForSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewForSection:)]) {
        return [self.delegate viewForSection:section];
    }
    return nil;
}


#pragma mark --  scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 140;
    if(scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}




#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 将点击事件通过block的方式传递出去
    self.selectBlock(indexPath);
}


- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(willBeginEditingCellIndex:)]) {
        [self.delegate willBeginEditingCellIndex:indexPath];
    }
    //    self.editingIndexPath = indexPath;
    //    [self.view setNeedsLayout];   // 触发-(void)viewDidLayoutSubviews
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
    
}

@end
