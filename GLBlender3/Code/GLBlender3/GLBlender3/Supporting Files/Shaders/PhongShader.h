//
//  PhongShader.h
//  GLBlender3
//
//  Created by YOSHI on 2018/01/08.
//  Copyright © 2018年 YOSHI. All rights reserved.
//

#import "Shader.h"

@interface PhongShader : Shader

// Program Handle
@property (readwrite) GLint program;

// Attribute Handles
@property (readwrite) GLint aPosition;
@property (readwrite) GLint aNormal;

// Uniform Handles
@property (readwrite) GLint uProjectionMatrix;
@property (readwrite) GLint uModelViewMatrix;
@property (readwrite) GLint uNormalMatrix;
@property (readwrite) GLint uDiffuse;
@property (readwrite) GLint uSpecular;

@end
