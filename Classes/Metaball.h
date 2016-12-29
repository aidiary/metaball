//
//  Metaball.h
//  Metaball
//
//  Created by mori on 09/02/19.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_PALETTE 256  // パレットの色数
#define RADIUS      70   // メタボールの半径
#define MAX_PIXELS  ((2*RADIUS)*(2*RADIUS))  // 円を囲む四角形のピクセル数

@class Pixel;
@class Palette;

@interface Metaball : NSObject {
    int x;
    int y;
    int vx;
    int vy;
    NSMutableArray *pixelArray;
    Palette *palette;
}

- (id)initPosX:(int)a posY:(int)b velX:(int)c velY:(int)d;
- (void)drawToBitmap:(unsigned char *)bitmap;
- (void)move;

@property int x;
@property int y;
@property int vx;
@property int vy;
@property (nonatomic, retain) NSMutableArray *pixelArray;
@property (nonatomic, retain) Palette *palette;

@end


// メタボールのピクセル情報
@interface Pixel : NSObject {
    int dx;  // ボールの中心からのX偏差
    int dy;  // ボールの中心からのY偏差
    int no;  // パレットの色番号
}

- (id)initWithDx:(int)x dy:(int)y no:(int)n;

@property int dx;
@property int dy;
@property int no;

@end


// パレット
@interface Palette : NSObject {
    NSMutableArray *red;
    NSMutableArray *green;
    NSMutableArray *blue;
}

- (id)init;

@property (nonatomic, retain) NSMutableArray *red;
@property (nonatomic, retain) NSMutableArray *green;
@property (nonatomic, retain) NSMutableArray *blue;

@end
