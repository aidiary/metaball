//
//  Metaball.m
//  Metaball
//
//  Created by mori on 09/02/19.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Metaball.h"

#define WIDTH 320
#define HEIGHT 480

// メタボールクラスの実装
@implementation Metaball

@synthesize x, y, vx, vy, pixelArray, palette;

- (id)initPosX:(int)a posY:(int)b velX:(int)c velY:(int)d {
    self = [super init];
    if (self != nil) {
        x = a;
        y = b;
        vx = c;
        vy = d;
        
        pixelArray = [[NSMutableArray array] retain];
        palette = [[Palette alloc] init];
        
        // ピクセルの色をセット
        int no = 0;
        for (int i = -RADIUS; i < RADIUS; i++) {
            for (int j = -RADIUS; j < RADIUS; j++) {
                // 円の内側か判定
                double z = RADIUS * RADIUS - i * i - j * j;
                if (z < 0) {  // 円の外側
                    no = 0;
                } else {      // 円の内側
                    // パレット番号を計算
                    z = sqrt(z);
                    double t = z / RADIUS;
                    no = MAX_PALETTE * (t * t * t * t);
                    if (no > 255) no = 255;
                    if (no < 0) no = 0;
                }
                [pixelArray addObject:[[Pixel alloc] initWithDx:i dy:j no:no]];
            }
        }
    }
    return self;
}

- (void)drawToBitmap:(unsigned char *)bitmap {
    for (int i = 0; i < MAX_PIXELS; i++) {
        // 現在計算中のピクセル座標
        int sx = self.x + [[pixelArray objectAtIndex:i] dx];
        if (sx < 0 || sx > WIDTH) continue;
        int sy = self.y + [[pixelArray objectAtIndex:i] dy];
        if (sy < 0 || sy > HEIGHT) continue;
        
        // ボールの色をイメージのRGBへ加算
        int no = [[pixelArray objectAtIndex:i] no];
        int r = [[[palette red] objectAtIndex:no] intValue];
        int g = [[[palette green] objectAtIndex:no] intValue];
        int b = [[[palette blue] objectAtIndex:no] intValue];
        
        // スクリーンの色を取り出す
        int startByte = ((sy * WIDTH) + sx) * 4;
        int destR = (unsigned char)bitmap[startByte];
        int destG = (unsigned char)bitmap[startByte+1];
        int destB = (unsigned char)bitmap[startByte+2];
        
        // スクリーンの色にボールの色を加算
        destR += r;
        destG += g;
        destB += b;
        
        if (destR > 255) destR = 255;
        if (destG > 255) destG = 255;
        if (destB > 255) destB = 255;
        
        // 加算した色を書き込む
        bitmap[startByte] = destR;
        bitmap[startByte+1] = destG;
        bitmap[startByte+2] = destB;
    }
}

- (void)move {
    x += vx;
    y += vy;
    
    // 壁とあたったら反転
    if (x < RADIUS) {
        x = RADIUS;
        vx = -vx;
    }
    if (y < RADIUS) {
        y = RADIUS;
        vy = -vy;
    }
    if (x > WIDTH - RADIUS) {
        x = WIDTH - RADIUS;
        vx = -vx;
    }
    if (y > HEIGHT - RADIUS) {
        y = HEIGHT - RADIUS;
        vy = -vy;
    }
}

- (void)dealloc {
    // インスタンス変数を解放
    [pixelArray release];
    [palette release];
    
    [super dealloc];
}

@end

// ピクセルの実装
@implementation Pixel

@synthesize dx, dy, no;

- (id)initWithDx:(int)x dy:(int)y no:(int)n {
    self = [super init];
    if (self != nil) {
        self.dx = x;
        self.dy = y;
        self.no = n;
    }
    return self;
}

@end

// パレットクラスの実装
@implementation Palette

@synthesize red, green, blue;

- (id)init {
    self = [super init];
    if (self != nil) {
        // 空の配列を作成
        red = [[NSMutableArray array] retain];
        green = [[NSMutableArray array] retain];
        blue = [[NSMutableArray array] retain];
    
        // 各パレット番号にRGBをセット
        int r, g, b;
        for (int i = 0; i < MAX_PALETTE; i++) {
            r = g = b = 0;
            if (i >= 0) r = 4 * i;
            if (i >= 2) g = 4 * (i / 2);
            if (i >= 4) b = 4 * (i / 4);
        
            if (r > 255) r = 255;
            if (g > 255) g = 255;
            if (b > 255) b = 255;
        
            [red addObject:[NSNumber numberWithInt:r]];
            [green addObject:[NSNumber numberWithInt:g]];
            [blue addObject:[NSNumber numberWithInt:b]];
        }
    }
    return self;
}

@end
