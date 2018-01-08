//
//  PhongShader.m
//  GLBlender3
//
//  Created by YOSHI on 2018/01/08.
//  Copyright © 2018年 YOSHI. All rights reserved.
//

#import "PhongShader.h"

// Shaders
#define STRINGIFY(A) #A
#include "Phong.vsh"
#include "Phong.fsh"

@implementation PhongShader

- (id)init {
    if(self = [super init]) {
        // Program
        self.program = [self BuildProgram:PhongVSH with:PhongFSH];
        
        // Attributes
        self.aPosition = glGetAttribLocation(self.program, "aPosition");
        self.aNormal = glGetAttribLocation(self.program, "aNormal");
        self.aTexel = glGetAttribLocation(self.program, "aTexel");
        
        // Uniforms
        self.uProjectionMatrix = glGetUniformLocation(self.program, "uProjectionMatrix");
        self.uModelViewMatrix = glGetUniformLocation(self.program, "uModelViewMatrix");
        self.uNormalMatrix = glGetUniformLocation(self.program, "uNormalMatrix");
        self.uDiffuse = glGetUniformLocation(self.program, "uDiffuse");
        self.uSpecular = glGetUniformLocation(self.program, "uSpecular");
        self.uTexture = glGetUniformLocation(self.program, "uTexture");
    }
    return self;
}

@end
