//
//  ViewController.m
//  GLBlender3
//
//  Created by YOSHI on 2018/01/06.
//  Copyright © 2018年 YOSHI. All rights reserved.
//

#import "ViewController.h"
#import "PhongShader.h"
#import "starship.h"
#import "cube.h"

@interface ViewController () {
    float _rotate;
}

@property (strong, nonatomic) PhongShader* phongShader;

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
    
    // Load shader
    [self loadShader];
}

- (void)loadShader {
    self.phongShader = [[PhongShader alloc] init];
    glUseProgram(self.phongShader.program);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClear(GL_COLOR_BUFFER_BIT);
    
    // Set matrices
    [self setMatrices];
    
    // Positions
    glEnableVertexAttribArray(self.phongShader.aPosition);
    glVertexAttribPointer(self.phongShader.aPosition, 3, GL_FLOAT, GL_FALSE, 0, starshipPositions);
    
    // Normals
    glEnableVertexAttribArray(self.phongShader.aNormal);
    glVertexAttribPointer(self.phongShader.aNormal, 3, GL_FLOAT, GL_FALSE, 0, starshipNormals);
    
    // Render by parts
    for(int i = 0; i < cubeMaterials; i++) {
        // Set material
        glUniform3f(self.phongShader.uDiffuse, starshipDiffuses[i][0], starshipDiffuses[i][1], starshipDiffuses[i][2]);
        glUniform3f(self.phongShader.uSpecular, starshipSpeculars[i][0], starshipSpeculars[i][1], starshipSpeculars[i][2]);
        
        // Draw vertices
        glDrawArrays(GL_TRIANGLES, cubeFirsts[i], cubeCounts[i]);
    }
}

- (void)setMatrices {
    // Projection Matrix
    const GLfloat aspectRatio = (GLfloat)(self.view.bounds.size.width) / (GLfloat)(self.view.bounds.size.height);
    const GLfloat fieldView = GLKMathDegreesToRadians(90.0f);
    const GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(fieldView, aspectRatio, 0.1f, 10.0f);
    glUniformMatrix4fv(self.phongShader.uProjectionMatrix, 1, 0, projectionMatrix.m);
    
    // ModelView Matrix
    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, 0.0f, 0.0f, -2.5f);
    modelViewMatrix = GLKMatrix4RotateX(modelViewMatrix, GLKMathDegreesToRadians(45.0f));
    modelViewMatrix = GLKMatrix4RotateY(modelViewMatrix, GLKMathDegreesToRadians(_rotate));
    modelViewMatrix = GLKMatrix4RotateZ(modelViewMatrix, GLKMathDegreesToRadians(_rotate));
    glUniformMatrix4fv(self.phongShader.uModelViewMatrix, 1, 0, modelViewMatrix.m);
}

- (void)update {
    _rotate += 1.0f;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

