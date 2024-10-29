//
//  shaders.metal
//  shaders
//
//  Created by Juan Hurtado on 17/10/24.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float3 position [[attribute(0)]];
};

typedef struct {
    float4 position [[position]] ;
    float3 color;
} VertexOut;

struct Uniforms {
    float4x4 modelMatrix;
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

vertex VertexOut vertex_shader(VertexIn in [[stage_in]], constant Uniforms& uniforms [[buffer(10)]], constant float3& color [[buffer(11)]])
{
    VertexOut out {
        .position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * float4(in.position, 1),
        .color = color
    };
    return out;
}

fragment float4 fragment_shader(VertexOut out [[stage_in]]) {
    return float4(out.color, 1);
}
