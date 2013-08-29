//
//  SFSerializationAssistant.m
//  SparkSerialization
//
//  Created by Igor Chesnokov on 8/29/13.
//  Copyright (c) 2013 Epam Systems. All rights reserved.
//

#import "SFSerializationAssistant.h"
#import "SFSerializable.h"
#import "SFSerializableCollection.h"

@implementation SFSerializationAssistant

+ (NSString *)serializationKeyForProperty:(SFPropertyInfo *)propertyInfo {
    NSArray *propertySerializableAttributes = [propertyInfo.attributeClass attributesForProperty:propertyInfo.propertyName withAttributeType:[SFSerializable class]];
    
    if ([propertySerializableAttributes count] == 0) {
        return propertyInfo.propertyName;
    }
    
    SFSerializable *propertySerializableAttribute = [propertySerializableAttributes lastObject];
    
    if ([propertySerializableAttribute.serializedName length] == 0) {
        return propertyInfo.propertyName;
    }
    
    return propertySerializableAttribute.serializedName;
}

+ (NSString *)collectionItemClassNameForProperty:(SFPropertyInfo *)propertyInfo {
    SFSerializableCollection *collectionAttribute = (SFSerializableCollection *)[propertyInfo.attributeClass lastAttributeForProperty:propertyInfo.propertyName withAttributeType:[SFSerializableCollection class]];
    return (collectionAttribute == nil || collectionAttribute.classOfItem == nil) ? nil : NSStringFromClass(collectionAttribute.classOfItem);
}

@end
