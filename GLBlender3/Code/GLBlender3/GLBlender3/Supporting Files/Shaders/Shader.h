//
//  Shader.h
//  GLBlender3
//
//  Created by YOSHI on 2018/01/08.
//  Copyright © 2018年 YOSHI. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface Shader : NSObject

- (GLuint)BuildProgram:(const char*)vertexShaderSource with:(const char*)fragmentShaderSource;

@end
