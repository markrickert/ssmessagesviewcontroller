//
//  MDDemoViewController.m
//  Messages Demo
//
//  Created by Sam Soffes on 11/7/10.
//  Copyright 2010 Sam Soffes. All rights reserved.
//

#import "MDDemoViewController.h"
#import "SSMessageTableViewCell.h"

@implementation MDDemoViewController

NSString *lorem[] = {
	@"Hi",
	@"This is a work in progress",
	@"Ya I know",
	@"Fine then\nI see how it is",
	@"Do you? Do you really?",
    @"Do you? Do you really? Do you? Do you really? Do you? Do you really?",
	@"Yes"
};

#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Messages";
    self.userImage = [UIImage imageNamed:@"SSMessagesViewControllerSendButtonBackground"];
    self.buddyImage = [UIImage imageNamed:@"SSMessagesViewControllerSendButtonBackground"];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}


#pragma mark SSMessagesViewController

- (SSMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row % 2) {
		return SSMessageStyleRight;
	}
	return SSMessageStyleLeft;
}


- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return lorem[indexPath.row];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return sizeof(lorem) / sizeof(NSString *);
}


@end
