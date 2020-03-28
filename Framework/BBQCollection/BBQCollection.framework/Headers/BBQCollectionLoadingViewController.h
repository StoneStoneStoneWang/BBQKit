//
//  BBQCollectionLoadingViewController.h
//  ZContainer
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

@import BBQLoading;

NS_ASSUME_NONNULL_BEGIN

@interface BBQCollectionLoadingViewController : BBQLoadingViewController

@property (nonatomic ,strong ,readonly) UICollectionView *collectionView;

- (UICollectionView *)createCollectionWithLayout:(UICollectionViewFlowLayout *)layout;

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip ;

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip ;

- (void)collectionEmptyShow;

- (void)collectionEmptyHidden;

@end

NS_ASSUME_NONNULL_END
