#import <OpenGLES/ES1/gl.h>
#import <GLKit/GLKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Room.h"
#import "Face.h"
#import "NavBar.h"
#import "common.c"
#import "Geodesic.h"
//#import "lights.c"

// FACES
#import "Make.h"
#import "File.h"

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

@interface Stage : GLKViewController <NavBarDelegate, MakeDelegate, FileDelegate>//<AnimationDelegate>

@property (nonatomic) Geodesic *geodesic; // ROOMS   (3D ENVIRONMENTS)
@property (nonatomic) Face *face;         // SCREENS (ORTHOGRAPHIC LAYERS)
@property (nonatomic) NavBar *navBar;     // SCREENS (ORTHOGRAPHIC LAYERS)

@property (nonatomic) float *backgroundColor; // CLEAR SCREEN COLOR

//+(instancetype) StageWithRoom:(Room*)room Face:(Face*)face NavBar:(NavBar*)navBar;

-(void) update;     // automatically called before glkView:drawInRect
-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect;

@end
