//
//  eCDataCenter.m
//  eComm
//
//  eCeated by Imayaselvan on 24/06/15.
//  Copyright (c) 2015 Imayaselvan. All rights reserved.
//

#import "eCDataCenter.h"
#import "AppDelegate.h"
#import "AFNetworking.h"

#define eC_BASE_URL @""


@implementation eCDataCenter : NSObject


+ (eCDataCenter *)sharedCenter{
    static eCDataCenter *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

#pragma-mark public methods.

- (void)GET:(NSString *)endPoint urlParameters:(NSDictionary *)parameters withOperationManager:(AFHTTPRequestOperationManager *)manager successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    
    if (manager) {
        //Cancel the previous operations
        [manager.operationQueue cancelAllOperations];
        [manager GET:endPoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            successBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            failureBlock(error);
        }];
    }
    else {
        [self sendGetRequestWithUrlEndPoint:endPoint urlParameters:parameters successBlock:successBlock failureBlock:failureBlock];
    }
    
}

- (void)getResponseWithUrlEndPoint:(NSString *)endPoint urlParameters:(NSDictionary *)parameters requestType:(RequestType)requestType successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock {
    if (requestType == GetRequestType) {
        [self sendGetRequestWithUrlEndPoint:endPoint urlParameters:parameters successBlock:successBlock failureBlock:failureBlock];
    }
}

#pragma mark
- (BOOL)handleRequestFailureForOperation:(AFHTTPRequestOperation *)operation{
    return NO;
}

- (void)handleRequestSuccessForOperation:(AFHTTPRequestOperation *)operation{
    
}

#pragma-mark GET request

- (void)sendGetRequestWithUrlEndPoint:(NSString *)endPoint urlParameters:(NSDictionary *)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock  {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endPoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleRequestSuccessForOperation:operation];
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(![self handleRequestFailureForOperation:operation]){
            failureBlock(error);
        }
    }];
}

- (void)sendGetRequestWithUrl:(NSString *)endPoint urlParameters:(NSDictionary *)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock  {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:endPoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleRequestSuccessForOperation:operation];
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(![self handleRequestFailureForOperation:operation]){
            failureBlock(error);
        }
    }];
}

@end
