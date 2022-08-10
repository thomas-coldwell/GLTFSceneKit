//
//  GLTFShaderModifierFragment_transmission.shader
//  GLTFSceneKit
//
//  Created by Thomas Coldwell on 22/06/2022.
//  Based off the last comment on this thread: https://developer.apple.com/forums/thread/111236

#pragma arguments

float transmissionFactor;
int alphaBlend;

#pragma transparent
#pragma body

float reflectivity = 0.5;
float minAlpha = 0.1;

// If opaque set the min alpha v high
if (alphaBlend == 0) {
  minAlpha = 2.0;
}

float3 light = _lightingContribution.specular;
float alpha = reflectivity * min(1.0, 0.33 * light.r + 0.33 * light.g + 0.33 * light.b);
_output.color.rgb *= min(1.0, (1.5 + 2 * minAlpha) * alpha);

if (alphaBlend == 1) {
  _output.color.a = (0.75 + 0.25 * minAlpha) * alpha;
  //  Have to manually premultiply the alpha https://github.com/google-ar/arcore-ios-sdk/blob/2a21e31ed240fe6f8a5c389f3dead9bb18009cc7/Examples/AugmentedFacesExample/AugmentedFacesExample/FacesViewController.swift#L132
  _output.color.rgb *= _output.color.a;
}
