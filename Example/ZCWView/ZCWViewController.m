//
//  ZCWViewController.m
//  ZCWView
//
//  Created by zhaochangwu on 04/24/2017.
//  Copyright (c) 2017 zhaochangwu. All rights reserved.
//

#import "ZCWViewController.h"
#import <ZCWView/ZCWLoadingView.h>
#import <ZCWView/ZCWToastView.h>
#import <ZCWTool/ZCWTool.h>

@interface ZCWViewController ()

@end

@implementation ZCWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	ZCWDebugLog(@"%@", [[NSBundle mainBundle] bundlePath]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellReuseIdentifier = @"cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
	ZCWModel *model = [[ZCWModel alloc] initWithIndexPath:indexPath vc:self];
	cell.textLabel.text = model.text;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ZCWModel *model = [[ZCWModel alloc] initWithIndexPath:indexPath vc:self];
	model.selectedAction();
}

@end

@implementation ZCWModel

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath vc:(UIViewController *)vc{
	self = [super init];
	if (self) {
		switch (indexPath.row) {
			case 0:
				[self setupLoadingModel:vc];
				break;
			case 1:
				[self setupInfoToastModel:vc];
				break;
			case 2:
				[self setupSuccessToastModel:vc];
				break;
			case 3:
				[self setupMessageSuccessToastModel:vc];
				break;
			case 4:
				[self setupFailToastModel:vc];
				break;
			case 5:
				[self setupMessageFailToastModel:vc];
				break;
			case 6:
				[self setupOfflineToastModel:vc];
				break;
			case 7:
				[self setupMessageOfflineToastModel:vc];
				break;
			default:
				break;
		}
	}
	return self;
}

- (void)setupLoadingModel:(UIViewController *)vc {
	self.text = @"loading";
	self.selectedAction = ^(){
		__block ZCWLoadingView *loading = [ZCWLoadingView view];
		[vc.view addSubview:loading];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[loading removeFromSuperview];
		});
	};
}

- (void)setupInfoToastModel:(UIViewController *)vc {
	self.text = @"info toast";
	self.selectedAction = ^(){
		[vc.view addSubview:[ZCWToastView successToast]];
	};
}

- (void)setupSuccessToastModel:(UIViewController *)vc {
	self.text = @"success toast";
	self.selectedAction = ^(){
		[vc.view addSubview:[ZCWToastView successToast]];
	};
}

- (void)setupMessageSuccessToastModel:(UIViewController *)vc {
	self.text = @"success toast with message";
	self.selectedAction = ^(){
		[vc.view addSubview:[ZCWToastView successToastWithMessage:@"这是一个代表成功的提示框"]];
	};
}

- (void)setupFailToastModel:(UIViewController *)vc {
	self.text = @"fail toast";
	self.selectedAction = ^(){
		[vc.view addSubview:[ZCWToastView failToast]];
	};
}

- (void)setupMessageFailToastModel:(UIViewController *)vc {
	self.text = @"fail toast with message";
	self.selectedAction = ^(){
		[vc.view addSubview:[ZCWToastView failToastWithMessage:@"这是一个代表失败的提示框"]];
	};
}

- (void)setupOfflineToastModel:(UIViewController *)vc {
	self.text = @"offline toast";
	self.selectedAction = ^(){
		[vc.view addSubview:[ZCWToastView offlineToast]];
	};
}
- (void)setupMessageOfflineToastModel:(UIViewController *)vc {
	self.text = @"offline toast with message";
	self.selectedAction = ^(){
		[vc.view addSubview:[ZCWToastView offlineToastWithMessage:@"这是一个代表离线的提示框"]];
	};
}

@end
