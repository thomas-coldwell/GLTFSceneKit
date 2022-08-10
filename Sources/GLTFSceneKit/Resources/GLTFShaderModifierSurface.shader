//
//  GLTFShaderModifierSurface.shader
//  GLTFSceneKit
//
//  Created by magicien on 2017/08/29.
//

#pragma arguments

float baseColorFactorR;
float baseColorFactorG;
float baseColorFactorB;
float baseColorFactorA;
float metallicFactor;
float roughnessFactor;
float emissiveFactorR;
float emissiveFactorG;
float emissiveFactorB;

#pragma body

_surface.diffuse *= float4(baseColorFactorR, baseColorFactorG, baseColorFactorB, baseColorFactorA);
_surface.metalness *= metallicFactor;
_surface.roughness *= roughnessFactor;
_surface.emission *= float4(emissiveFactorR, emissiveFactorG, emissiveFactorB, 1.0);
