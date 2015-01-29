//
//  ESProvider.m
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


#import "ESProvider.h"
#import "NXOAuth2.h"
#import "RFServiceProvider+ESGitHubClient.h"
#import "ESOAuthAuthentificationProvider.h"


@interface ESProvider ()

@property BOOL successFlag;
@property (nonatomic) NSString *clientID;
@property (nonatomic) NSString *secret;
@property (nonatomic) NSURL *authorizationURL;
@property (nonatomic) NSURL *tokenURL;
@property (nonatomic) NSURL *redirectURL;
@property (nonatomic) NSString *accountType;

@end

@implementation ESProvider

- (instancetype)init
{
    self = [super init];
    if (self) {
        // TODO: Register your application here: https://github.com/settings/applications
        _clientID = @"MyClientID";
        _secret = @"MySecret";
        _authorizationURL = [NSURL URLWithString:@"https:github.com/login/oauth/authorize"];
        _tokenURL = [NSURL URLWithString:@"https:github.com/login/oauth/access_token"];
        _redirectURL = [NSURL URLWithString:@"roadexamplescheme://road"];
        _accountType = @"GitHub";
    }
    return self;
}

- (void) gitHubUserInfoWithSuccess:(void(^)(ESUserInfo *userInfo))successBlock failure:(void(^)(NSError *error))failureBlock {

    [self settingOfClient];

    ESOAuthAuthentificationProvider *authProvider = [[ESOAuthAuthentificationProvider alloc] init];
    authProvider.authRequest = ^(NSString **accessToken){
        *accessToken = [self getAccessToken];
    };

    ESGitHubClient *client = [RFServiceProvider gitHubClient];
    [client setAuthenticationProvider:authProvider];

    [client gitHubUserInfoWithSuccess:^(id result) {
        successBlock(result);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

+ (BOOL) handleRedirectURL: (NSURL *)url {
    return url == nil ? NO : [[NXOAuth2AccountStore sharedStore] handleRedirectURL:url];
}

#pragma private methods
- (void) settingOfClient {

    [[NXOAuth2AccountStore sharedStore] setClientID:_clientID
                                             secret:_secret
                                   authorizationURL:_authorizationURL
                                           tokenURL:_tokenURL
                                        redirectURL:_redirectURL
                                     forAccountType:_accountType];

    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreAccountsDidChangeNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      _successFlag = true;
                                                  }];

    [[NSNotificationCenter defaultCenter] addObserverForName:NXOAuth2AccountStoreDidFailToRequestAccessNotification
                                                      object:[NXOAuth2AccountStore sharedStore]
                                                       queue:nil
                                                  usingBlock:^(NSNotification *aNotification){
                                                      _successFlag = true;
                                                  }];
}

- (NSString *) getAccessToken  {
    _successFlag = false;
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:self.accountType];

    while (!self.successFlag) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:[NXOAuth2AccountStore sharedStore]];
    NXOAuth2Account* account = ([[NXOAuth2AccountStore sharedStore] accountsWithAccountType:self.accountType])[0];

    return (account == nil) ? nil : account.accessToken.accessToken;
}

@end
