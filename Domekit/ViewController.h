//
//  ViewController.h
//  Domekit
//
//  Created by Robby on 1/28/13.
//  Copyright (c) 2013 Robby Kraft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DomeView.h"
#import "DiagramView.h"
#import "Point3D.h"
#import "InstructionsViewController.h"

@interface ViewController : UIViewController
{
    DiagramView *diagramView;
    DomeView *domeView;
    
    Point3D *touchPanRotate;  // last position in pan during rotate mode
    CGFloat touchPanEdit;     // last position in pan during splice mode
    //CGFloat touchPanSize;     // last position in pan during size mode
    CGFloat touchPinch;       // last position in pinch to scale
    BOOL icosahedron;
    int VNumber;
    
    //BOOL sizeToggle;
    //CGFloat domeSize;
    //CGFloat touchDomeSize;     // last position of domeSize during size mode
}

@property IBOutlet UIButton *instructionButton;
@property IBOutlet UILabel *domeVLabel;
@property IBOutlet UIButton *cropButton;
@property IBOutlet UILabel *VLabel;
@property IBOutlet UILabel *FractionLabel;
@property IBOutlet UILabel *SolidLabel;
@property IBOutlet UIButton *solidButton;
@property IBOutlet UIImageView *solidView;

//@property IBOutlet UIButton *sizeButton;
//@property IBOutlet UILabel *sizeLabel;
//@property IBOutlet UILabel *sizeFPartLabel;
//@property IBOutlet UIView *sizeView;




@end