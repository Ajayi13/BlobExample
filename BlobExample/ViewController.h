//
//  ViewController.h
//  BlobExample
//
//  Created by Simform Solutions on 15/03/13.
//  Copyright (c) 2013 umar chhipa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthenticationCredential.h"
#import "CloudStorageClient.h"
#import "BlobContainer.h"
#import "Blob.h"
#import "TableEntity.h"
#import "TableFetchRequest.h"

@interface ViewController : UIViewController<CloudStorageClientDelegate>
{
    AuthenticationCredential *credential;
    CloudStorageClient *client;
    NSArray *container;
    NSArray *blobArray;
}
@end
