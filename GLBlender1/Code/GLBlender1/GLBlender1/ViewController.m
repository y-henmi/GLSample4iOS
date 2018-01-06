//
//  ViewController.m
//  GLBlender1
//
//  Created by YOSHI on 2018/01/05.
//  Copyright © 2018年 YOSHI. All rights reserved.
//

#import "ViewController.h"
#import "sphere.h"
//#import "cube.h"

@interface ViewController () {
    float _rotate;
}

@property (strong, nonatomic) GLKBaseEffect* effect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Variables
    _rotate = 0.0f;
    
    // Set up context
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
    
    // Set up view
    GLKView* glkview = (GLKView *)self.view;
    glkview.context = context;
    
    // OpenGL ES Settings
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glEnable(GL_CULL_FACE);
    
    // Create effect
    [self createEffect];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Set matrices
    [self setMatrices];
    
    // Positions
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, spherePositions);
    
//    // Texels
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, cubeTexels);
    
    // Normals
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 0, sphereNormals);
    
    // Set material
    self.effect.material.diffuseColor = GLKVector4Make(0.8f, 0.0f, 0.0f, 1.0f);
    self.effect.material.specularColor = GLKVector4Make(0.0f, 0.0f, 0.2f, 1.0f);
    
    // Prepare effect
    [self.effect prepareToDraw];
    
    // Draw Model
    glDrawArrays(GL_TRIANGLES, 0, sphereVertices/2);
    
    
    // Change material
    self.effect.material.diffuseColor = GLKVector4Make(0.0f, 0.9f, 0.0f, 1.0f);
    self.effect.material.specularColor = GLKVector4Make(0.1f, 0.1f, 0.1f, 1.0f);
    
    // Prepare effect again
    [self.effect prepareToDraw];
    
    // Draw 2nd half of model
    glDrawArrays(GL_TRIANGLES, sphereVertices/2, sphereVertices/2);
}

- (void)createEffect {
    // Initialize
    self.effect = [[GLKBaseEffect alloc] init];
    
//    // Texture
//    NSDictionary* options = @{ GLKTextureLoaderOriginBottomLeft: @YES };
//    NSError* error;
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"cube.png" ofType:nil];
//    GLKTextureInfo* texture = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
//
//    if(texture == nil) {
//        NSLog(@"Error loading file: %@", [error localizedDescription]);
//        return;
//    }
//
//    self.effect.texture2d0.name = texture.name;
//    self.effect.texture2d0.enabled = true;

    // Light
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.position = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    self.effect.light0.specularColor = GLKVector4Make(0.25f, 0.25f, 0.25f, 1.0f);
    self.effect.light0.diffuseColor = GLKVector4Make(0.75f, 0.75f, 0.75f, 1.0f);
    self.effect.lightingType = GLKLightingTypePerPixel;
}

- (void)setMatrices {
    // Projection Matrix
    const GLfloat aspectRatio = (GLfloat)(self.view.bounds.size.width) / (GLfloat)(self.view.bounds.size.height);
    const GLfloat fieldView = GLKMathDegreesToRadians(90.0f);
    const GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(fieldView, aspectRatio, 0.1f, 10.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    // ModelView Matrix
    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, 0.0f, 0.0f, -5.0f);
    modelViewMatrix = GLKMatrix4RotateX(modelViewMatrix, GLKMathDegreesToRadians(45.0f));
    modelViewMatrix = GLKMatrix4RotateY(modelViewMatrix, GLKMathDegreesToRadians(_rotate));
    modelViewMatrix = GLKMatrix4RotateZ(modelViewMatrix, GLKMathDegreesToRadians(_rotate));
    self.effect.transform.modelviewMatrix = modelViewMatrix;
}

- (void)update {
    _rotate += 1.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
