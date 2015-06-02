//
//  ViewController.m
//  BlobExample
//
//  Created by Simform Solutions on 15/03/13.
//  Copyright (c) 2013 umar chhipa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    credential = [AuthenticationCredential credentialWithAzureServiceAccount:@"container name" accessKey:@"access key"];
    client = [CloudStorageClient storageClientWithCredential:credential];
    client.delegate=self;
    
    // get all blob containers
    [client getBlobContainersWithBlock:^(NSArray *containers, NSError *error)
    {
        if (error)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
        
        else
        {
            NSLog(@"%i containers were found…",[containers count]);
            if([containers count]!=0)
            {
            container=[[NSArray alloc]initWithArray:containers];
            }
        }
        
    }];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(IBAction)getBlob:(id)sender
{
    // get all blobs within a container
    [client getBlobs:[container objectAtIndex:0] withBlock:^(NSArray *blobs, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@",[error localizedDescription]);
         }
         else
         {
             NSLog(@"%i blobs were found in the images container…",[blobs count]);
             if([blobs count]!=0)
             {
                 blobArray=[[NSArray alloc]initWithArray:blobs];
             }
             
             for (int i=0; i<[blobArray count]; i++)
             {
                 NSLog(@"%@",[blobArray objectAtIndex:i]);

             }
             
         }
     }];
}

-(IBAction)addBlob:(id)sender
{
    UIImage *image=[UIImage imageNamed:@"image.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *boundary = @"random string of your choosing";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [client addBlobToContainer:[container objectAtIndex:0] blobName:@"image1.png" contentData:imageData contentType:contentType ];
}

-(IBAction)deleteBlob:(id)sender
{
    [client deleteBlob:[blobArray  objectAtIndex:[blobArray count]-3] withBlock:^(NSError * error)
     {
        if (error)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
        else
        {
            NSLog(@"Delete Sucessfully...");
        }
     }];
}

- (void)storageClient:(CloudStorageClient *)client didAddBlobToContainer:(BlobContainer *)container blobName:(NSString *)blobName;
{
    NSString *imageUrl=[NSString stringWithFormat:@"http://container_name.blob.core.windows.net/table_name/%@",blobName];
    NSLog(@"blob %@",imageUrl);

}


@end
