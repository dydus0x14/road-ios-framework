//
//  ESMainViewController.m
//  GitHubOAuth
//
//  Copyright (c) 2015 EPAM Systems, Inc. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this
//  list of conditions and the following disclaimer in the documentation and/or
//  other materials provided with the distribution.
//  Neither the name of the EPAM Systems, Inc.  nor the names of its contributors
//  may be used to endorse or promote products derived from this software without
//  specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  See the NOTICE file and the LICENSE file distributed with this work
//  for additional information regarding copyright ownership and licensing


#import "ESMainViewController.h"
#import "ESProvider.h"
#import "ESAvatarTableViewCell.h"
#import "ESPropertyTableViewCell.h"


@interface ESMainViewController ()

@property (weak, nonatomic) IBOutlet ESAvatarTableViewCell *avatarCell;
@property (weak, nonatomic) IBOutlet ESPropertyTableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet ESPropertyTableViewCell *loginCell;
@property (weak, nonatomic) IBOutlet ESPropertyTableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet ESPropertyTableViewCell *privCell;
@property (weak, nonatomic) IBOutlet ESPropertyTableViewCell *publCell;

@property (nonatomic) ESProvider *provider;
@property (nonatomic) ESUserInfo *userInfo;
@end

@implementation ESMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _provider = [[ESProvider alloc] init];
    [_provider gitHubUserInfoWithSuccess:^(ESUserInfo *userInfo) {
        self.userInfo = userInfo;
        [self setDataToCells];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                        message:[error localizedDescription]
                        delegate:nil
                        cancelButtonTitle:@"Ok"
                        otherButtonTitles:nil] show];
    }];
}

- (void) setDataToCells {
    if (self.userInfo.avatar != nil)
        [self loadAvatarByURL:[NSURL URLWithString:self.userInfo.avatar]];
    [self.nameCell.value setText:self.userInfo.name];
    [self.loginCell.value setText:self.userInfo.login];
    [self.emailCell.value setText:self.userInfo.email];
    [self.privCell.value setText:[[NSNumber numberWithInteger:self.userInfo.privateRepos] description]];
    [self.publCell.value setText:[[NSNumber numberWithInteger:self.userInfo.publicRepos] description]];
}

- (void) loadAvatarByURL:(NSURL *)url {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(){
        UIImage *avatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

        dispatch_async(dispatch_get_main_queue(), ^(){
            [self.avatarCell.avatar setImage:avatar];
            [self.tableView reloadData];
        });
    });
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userInfo == nil ? 0 : 6;
}

@end
