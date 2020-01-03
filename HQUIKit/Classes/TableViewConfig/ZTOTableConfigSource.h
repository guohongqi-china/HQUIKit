//
//  ZTOTableConfigSource.h
//  ZTOShop
//
//  Created by guohongqi on 2019/12/30.
//  Copyright © 2019 caiyanzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CellConfigureBefore)(id cell, id model, NSIndexPath * indexPath);
typedef void (^selectCell) (NSIndexPath *indexPath);
typedef void (^reloadData) (NSMutableArray *array);
typedef void (^deleteCell) (NSIndexPath *array);
typedef CGFloat (^cellHeight) (NSIndexPath *indexPath);
typedef UITableViewCell* _Nullable (^configCell) (UITableView *talbeView, NSIndexPath *indexPath);

@protocol ZTOTableConfigSourceDelegate <NSObject>
- (NSInteger)sectionTableView;
- (NSInteger)numberOfRowsInSection:(NSInteger )section;
- (CGFloat)heigthForSection:(NSInteger)section;
- (UIView *)viewForSection:(NSInteger)section;
- (void)willBeginEditingCellIndex:(NSIndexPath *)indexPath;
- (id)modelIndexCell:(NSIndexPath *)indexPath;


@end

@interface ZTOTableConfigSource : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  NSMutableArray                              *dataArray;
@property (nonatomic, assign)  id <ZTOTableConfigSourceDelegate>           delegate;
@property (nonatomic, assign)  BOOL                                        isEdit;


/**
 加载指定标记cell
 @param identifier 标记
 @param before   返回cell
 @param selectBlock 选择下标
 @param deleteBlock 删除下标
 @param reloadData  当前数据
 */
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock deleteBlock:(deleteCell)deleteBlock reloadData:(reloadData)reloadData;
/**
 加载指定标记cell
 @param identifier 标记
 @param before   返回cell
 @param selectBlock 选择下标
 @param deleteBlock 删除下标
 @param cellHeight  指定行高
 @param reloadData  当前数据
 */
- (id)initWithIdentifier:(NSString *)identifier configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock deleteBlock:(deleteCell)deleteBlock indexCellHeight:(cellHeight)cellHeight reloadData:(reloadData)reloadData;
/**
 加载不同标记的cell
 @param idenCell 返回要加载标记cell
 @param before   返回cell
 @param selectBlock 选择下标
 @param deleteBlock 删除下标
 @param cellHeight  指定行高
 @param reloadData  当前数据
 */
- (id)initWithCell:(configCell)idenCell configureBlock:(CellConfigureBefore)before selectBlock:(selectCell)selectBlock deleteBlock:(deleteCell)deleteBlock indexCellHeight:(cellHeight)cellHeight reloadData:(reloadData)reloadData;
// 加载更多
- (void)addDataArray:(NSArray *)datas;
// 加载最新
- (void)reloadData:(NSArray *)datas;
// 删除某行数据
- (void)deleteDataIndex:(NSIndexPath *)index;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
