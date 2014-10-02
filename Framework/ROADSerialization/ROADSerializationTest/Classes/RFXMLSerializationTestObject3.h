//
//  RFXMLSerializationTestObject3.h
//  ROADSerialization
//
//  Copyright (c) 2014 EPAM Systems, Inc. All rights reserved.
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
#import <Foundation/Foundation.h>
#import "RFXMLSerializableCollection.h"
#import "RFXMLSerializable.h"
#import "RFItemTestObject.h"

@interface RFXMLSerializationTestObject3 : NSObject

RF_ATTRIBUTE(RFXMLSerializable, serializationKey = @"xmlns:nm", isTagAttribute = YES);
@property (assign, nonatomic) NSString *nm;

RF_ATTRIBUTE(RFXMLSerializable, serializationKey = @"nm2:city",isTagAttribute = YES);
@property (copy, nonatomic) NSString *city;

RF_ATTRIBUTE(RFXMLSerializable, serializationKey = @"nm:age", isTagAttribute = YES);
@property (assign, nonatomic) int age;

RF_ATTRIBUTE(RFXMLSerializable);
@property RFItemTestObject *item;

RF_ATTRIBUTE(RFXMLSerializable, serializationKey = @"xmlns:nm2", isTagAttribute = YES);
@property (assign, nonatomic) NSString *nm2;

RF_ATTRIBUTE(RFXMLSerializable);
@property (copy, nonatomic) NSString *name;

+ (id)sampleObject;
- (BOOL)isContentEqual:(id)object;

@end
