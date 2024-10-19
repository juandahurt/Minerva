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

vertex VertexOut vertex_shader(VertexIn in [[stage_in]])
{
    VertexOut out {
        .position = float4(in.position, 1),
        .color = 0
    };
    return out;
}

fragment float4 fragment_shader(VertexOut out [[stage_in]]) {
    return float4(0, 1, 1, 1);
}
