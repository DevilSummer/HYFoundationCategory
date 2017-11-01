//
//  ViewController.m
//  HYFoundationCategory
//
//  Created by ocean on 2017/10/30.
//  Copyright © 2017年 ocean. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+HYCategory.h"
#import "NSObject+HYCategory.h"
#import "NSData+HYCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //todo NSNull 和 nil 
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNull null] forKey:@"key"];

//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNull null] forKey:@"key"];
//
//    id value = [dict objectForKey:@"key"];
//    if (![NSObject hy_isNull:value]) {
//        NSLog(@"不为空");
//    } else {
//        NSLog(@"为空");
//    }
//
//    id value2 = [dict objectForKey:@"key2"];
//    if (![NSObject hy_isNull:value2]) {
//        NSLog(@"不为空");
//    } else {
//        NSLog(@"为空");
//    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"null" forKey:@"key"];
    [dict setObject:@"<null>" forKey:@"key1"];
    [dict setObject:[NSNull null] forKey:@"key2"];
    
    NSMutableDictionary *subDict = [NSMutableDictionary dictionary];
    [subDict setObject:[NSNull null] forKey:@"subkey1"];
    [subDict setObject:@"null" forKey:@"subkey2"];
    [subDict setObject:@"<null>" forKey:@"subkey3"];
    [subDict setObject:@"<NULL>" forKey:@"subkey4"];
    [subDict setObject:@"NULL" forKey:@"subkey5"];
    [subDict setObject:@"hello" forKey:@"subkey6"];
    [subDict setObject:@40 forKey:@"subkey7"];
   
    [dict setObject:subDict forKey:@"key4"];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        [array addObject:subDict];
    }

    [dict setObject:array forKey:@"key5"];

    
    NSDictionary *result = [dict hy_removesKeysWithNullValues];
    
    NSLog(@"%@", dict);
    NSLog(@"--------");
    NSLog(@"%@", result);
    NSLog(@"--------");

    
//    NSData *data = [NSData hy_dataFromObject:dict];
//
//    NSDictionary *object = [NSData hy_objectFromData:data];
//    NSLog(@"%@", data);
//    NSLog(@"--------------");
//    NSLog(@"%@", object);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
