//
//  BitmapView.m
//  Metaball
//
//  Created by mori on 09/02/19.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BitmapView.h"
#import "Metaball.h"

#define WIDTH 320
#define HEIGHT 480

@implementation BitmapView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        metaballArray = [[NSMutableArray array] retain];
        [metaballArray addObject:[[Metaball alloc] initPosX:WIDTH/2 posY:HEIGHT/2 velX:5 velY:4]];
        [metaballArray addObject:[[Metaball alloc] initPosX:WIDTH/2 posY:HEIGHT/2 velX:-3 velY:-6]];
        [metaballArray addObject:[[Metaball alloc] initPosX:WIDTH/2 posY:HEIGHT/2 velX:-4 velY:7]];
        
        timer = [[NSTimer scheduledTimerWithTimeInterval:0.1
            target:self selector:@selector(onTick)
            userInfo:nil repeats:YES] retain];
    }
    return self;
}

- (void)onTick {
    for (int i = 0; i < [metaballArray count]; i++) {
        [[metaballArray objectAtIndex:i] move];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // ビューのサイズを持つビットマップコンテキストを作成
    unsigned char *data = malloc(WIDTH * HEIGHT * 4);
    
    CGContextRef bitmapContext =
        CGBitmapContextCreate(data, WIDTH, HEIGHT, 8, WIDTH*4,
                              CGColorSpaceCreateDeviceRGB(),
                              kCGImageAlphaPremultipliedLast);
    
    // ビットマップコンテキストを黒で塗りつぶす
    CGContextSetRGBFillColor(bitmapContext, 0.0f, 0.0f, 0.0f, 1.0f);
    CGContextFillRect(bitmapContext, CGRectMake(0.0f, 0.0f, WIDTH, HEIGHT));
    
    // ビットマップコンテキストからビットマップ配列を取得
    unsigned char *bitmap = CGBitmapContextGetData(bitmapContext);

    // メタボールをビットマップ配列に描画
    for (int i = 0; i < [metaballArray count]; i++) {
        [[metaballArray objectAtIndex:i] drawToBitmap:bitmap];
    }
    
    // ビットマップ配列からイメージを再構築
    CGDataProviderRef dataProviderRef;
    dataProviderRef = CGDataProviderCreateWithData(NULL, bitmap, WIDTH*HEIGHT*4, NULL);
    CGImageRef image = CGImageCreate(WIDTH, HEIGHT,
        8, 32, WIDTH * 4,
        CGColorSpaceCreateDeviceRGB(),
        kCGImageAlphaLast,
        dataProviderRef,
        NULL,
        0,
        kCGRenderingIntentDefault);
    
    // ビューに再構築したイメージを描画
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, image);
    
    // データ構造を解放
    free(data);
    CGDataProviderRelease(dataProviderRef);
}


- (void)dealloc {
    [metaballArray release];
    [timer release];
    
    [super dealloc];
}


@end
