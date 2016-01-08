//
//  eCDataCenter.h
//  eComm
//
//  Created by Imayaselvan on 24/06/15.
//  Copyright (c) 2015 Imayaselvan. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum {
    GetRequestType,
    PostRequestType,
    PutRequestType,
    DeleteRequestType
} RequestType;

typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSError *error);


@class AFHTTPRequestOperationManager;




@interface eCDataCenter : NSObject


+ (eCDataCenter *)sharedCenter;

- (void)getResponseWithUrlEndPoint:(NSString *)endPoint urlParameters:(NSDictionary *)parameters requestType:(RequestType)requestType successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;




@end
