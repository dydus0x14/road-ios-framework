//
//  SparkLogger.h
//  SparkLogger
//
//  Copyright (c) 2013 Epam Systems. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without 
// modification, are permitted provided that the following conditions are met:
// 
//  Redistributions of source code must retain the above copyright notice, this 
// list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this 
// list of conditions and the following disclaimer in the documentation and/or 
// other materials provided with the distribution.
//  Neither the name of the EPAM Systems, Inc.  nor the names of its contributors 
// may be used to endorse or promote products derived from this software without 
// specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#ifndef SparkLogger_SparkLogger_h
#define SparkLogger_SparkLogger_h

#import "SFLogging.h"
#import "SFLogger.h"
#import "SFLogMessage.h"
#import "SFLogWriter.h"
#import "SFConsoleLogWriter.h"
#import "SFFileLogWriter.h"
#import "SFNetLogWriter.h"
#import "SFLogFormatter.h"
#import "SFLogBlockFormatter.h"
#import "SFLogPlainFormatter.h"
#import "SFLogFilter.h"
#import "SFLoggerWebServicePath.h"
#import "SFLogMessageWrapper.h"

#pragma warning Need to be restored after completion of migration

#define SFLogInternalError(...)
#define SFLogInfo(...)
#define SFLogDebug(...)
#define SFLogWarning(...)
#define SFLogError(...)
#define SFLogTypedInfo(__type__, ...)
#define SFLogTypedDebug(__type__, ...)
#define SFLogTypedWarning(__type__, ...)
#define SFLogTypedError(__type__, ...)

//#define SFLogInternalError(...) \
//    [[[SFServiceProvider sharedProvider] logger] logInternalErrorMessage:[[NSString alloc] initWithFormat:__VA_ARGS__]]
//
//
//#define SFLogInfo(...) \
//        [[[SFServiceProvider sharedProvider] logger] logInfoMessage:[[NSString alloc] initWithFormat:__VA_ARGS__]];
//#define SFLogDebug(...) \
//        [[[SFServiceProvider sharedProvider] logger] logDebugMessage:[[NSString alloc] initWithFormat:__VA_ARGS__]]
//#define SFLogWarning(...) \
//        [[[SFServiceProvider sharedProvider] logger] logWarningMessage:[[NSString alloc] initWithFormat:__VA_ARGS__]]
//#define SFLogError(...) \
//        [[[SFServiceProvider sharedProvider] logger] logErrorMessage:[[NSString alloc] initWithFormat:__VA_ARGS__]]
//
//#define SFLogTypedInfo(__type__, ...) \
//        [[[SFServiceProvider sharedProvider] logger] logInfoMessage:[[NSString alloc] initWithFormat:__VA_ARGS__] type:__type__]
//#define SFLogTypedDebug(__type__, ...) \
//        [[[SFServiceProvider sharedProvider] logger] logDebugMessage:[[NSString alloc] initWithFormat:__VA_ARGS__] type:__type__]
//#define SFLogTypedWarning(__type__, ...) \
//        [[[SFServiceProvider sharedProvider] logger] logWarningMessage:[[NSString alloc] initWithFormat:__VA_ARGS__] type:__type__]
//#define SFLogTypedError(__type__, ...) \
//        [[[SFServiceProvider sharedProvider] logger] logErrorMessage:[[NSString alloc] initWithFormat:__VA_ARGS__] type:__type__]

#endif
