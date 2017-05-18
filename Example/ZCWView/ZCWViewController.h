//
//  ZCWViewController.h
//  ZCWView
//
//  Created by zhaochangwu on 04/24/2017.
//  Copyright (c) 2017 zhaochangwu. All rights reserved.
//

@import UIKit;

@interface ZCWViewController : UITableViewController

@end

@interface ZCWModel : NSObject

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath vc:(UIViewController *)vc;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) void(^selectedAction)();

@end
