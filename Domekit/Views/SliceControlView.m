//
//  SliceControlView.m
//  Domekit
//
//  Created by Robby on 5/8/15.
//  Copyright (c) 2015 Robby. All rights reserved.
//

#import "SliceControlView.h"

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad


@implementation SliceControlView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self = [super init];
    if(self)
        [self initUI:UIScreen.mainScreen.bounds];
    return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self)
        [self initUI:UIScreen.mainScreen.bounds];
    return self;
}
-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
        [self initUI:frame];
    return self;
}

-(void) initUI:(CGRect)frame{
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(frame.size.width*.1, frame.size.height*.33, frame.size.width*.8, frame.size.height*.33)];
    if(IPAD){
        [_slider setFrame:CGRectMake(frame.size.width*.1, frame.size.height*.5, frame.size.width*.8, frame.size.height*.33)];
    }
    [_slider setValue:1.0];
	_slider.accessibilityLabel = @"adjust slice";
    [self addSubview:_slider];
}

@end
