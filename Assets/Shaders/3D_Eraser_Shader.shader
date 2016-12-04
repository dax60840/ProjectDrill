﻿Shader "Custom/3D_Eraser_Shader" {
	Properties{
		_Normal("Normal", 2D) = "bump" {}
		_AmbientOcclusion("Ambient Occlusion", 2D) = "white" {}
		_BaseColor("BaseColor", 2D) = "white" {}
		_emission("emission", 2D) = "white" {}
		_emissive("emissive ?", Range(0, 1)) = 0
		_metallic("metallic", Range(0, 1)) = 0
		_roughness("roughness", Range(0, 1)) = 1
		_Opacity("Opacity", Range(1, 0)) = 1
		_AlphaHole("Alpha Hole", 2D) = "gray" {}
		_SliceGuide("Slice Guide (RGB)", 2D) = "white" {}
		_SliceAmount("Slice Amount", Range(0.0, 1.0)) = 0.5
	[HideInInspector]_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
	}
		SubShader{
		Tags{
		"IgnoreProjector" = "True"
		"Queue" = "Transparent"
		"RenderType" = "Transparent"
	}
		Pass{
		Name "FORWARD"
		Tags{
		"LightMode" = "ForwardBase"
	}
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#define UNITY_PASS_FORWARDBASE
#define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
#define _GLOSSYENV 1
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"
#include "UnityStandardBRDF.cginc"
#pragma multi_compile_fwdbase
#pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
#pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
#pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
#pragma multi_compile_fog
#pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
#pragma target 3.0
		uniform sampler2D _AmbientOcclusion; uniform float4 _AmbientOcclusion_ST;
	uniform sampler2D _Normal; uniform float4 _Normal_ST;
	uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
	uniform sampler2D _emission; uniform float4 _emission_ST;
	uniform float _emissive;
	uniform float _metallic;
	uniform float _roughness;
	uniform float _Opacity;
	uniform sampler2D _AlphaHole; uniform float4 _AlphaHole_ST;
	struct VertexInput {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
		float4 tangent : TANGENT;
		float2 texcoord0 : TEXCOORD0;
		float2 texcoord1 : TEXCOORD1;
		float2 texcoord2 : TEXCOORD2;
	};
	struct VertexOutput {
		float4 pos : SV_POSITION;
		float2 uv0 : TEXCOORD0;
		float2 uv1 : TEXCOORD1;
		float2 uv2 : TEXCOORD2;
		float4 posWorld : TEXCOORD3;
		float3 normalDir : TEXCOORD4;
		float3 tangentDir : TEXCOORD5;
		float3 bitangentDir : TEXCOORD6;
		UNITY_FOG_COORDS(7)
#if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
			float4 ambientOrLightmapUV : TEXCOORD8;
#endif
	};
	VertexOutput vert(VertexInput v) {
		VertexOutput o = (VertexOutput)0;
		o.uv0 = v.texcoord0;
		o.uv1 = v.texcoord1;
		o.uv2 = v.texcoord2;
#ifdef LIGHTMAP_ON
		o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
		o.ambientOrLightmapUV.zw = 0;
#elif UNITY_SHOULD_SAMPLE_SH
#endif
#ifdef DYNAMICLIGHTMAP_ON
		o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
#endif
		o.normalDir = UnityObjectToWorldNormal(v.normal);
		o.tangentDir = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
		o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
		o.posWorld = mul(unity_ObjectToWorld, v.vertex);
		float3 lightColor = _LightColor0.rgb;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		UNITY_TRANSFER_FOG(o,o.pos);
		return o;
	}
	float4 frag(VertexOutput i) : COLOR{
		i.normalDir = normalize(i.normalDir);
	float3x3 tangentTransform = float3x3(i.tangentDir, i.bitangentDir, i.normalDir);
	float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
	float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
	float3 normalLocal = _Normal_var.rgb;
	float3 normalDirection = normalize(mul(normalLocal, tangentTransform)); // Perturbed normals
	float3 viewReflectDirection = reflect(-viewDirection, normalDirection);
	float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
	clip(_BaseColor_var.a - 0.5);
	float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
	float3 lightColor = _LightColor0.rgb;
	float3 halfDirection = normalize(viewDirection + lightDirection);
	////// Lighting:
	float attenuation = 1;
	float3 attenColor = attenuation * _LightColor0.xyz;
	float Pi = 3.141592654;
	float InvPi = 0.31830988618;
	///////// Gloss:
	float gloss = 1.0 - _roughness; // Convert roughness to gloss
	float specPow = exp2(gloss * 10.0 + 1.0);
	/////// GI Data:
	UnityLight light;
#ifdef LIGHTMAP_OFF
	light.color = lightColor;
	light.dir = lightDirection;
	light.ndotl = LambertTerm(normalDirection, light.dir);
#else
	light.color = half3(0.f, 0.f, 0.f);
	light.ndotl = 0.0f;
	light.dir = half3(0.f, 0.f, 0.f);
#endif
	UnityGIInput d;
	d.light = light;
	d.worldPos = i.posWorld.xyz;
	d.worldViewDir = viewDirection;
	d.atten = attenuation;
#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
	d.ambient = 0;
	d.lightmapUV = i.ambientOrLightmapUV;
#else
	d.ambient = i.ambientOrLightmapUV;
#endif
	d.boxMax[0] = unity_SpecCube0_BoxMax;
	d.boxMin[0] = unity_SpecCube0_BoxMin;
	d.probePosition[0] = unity_SpecCube0_ProbePosition;
	d.probeHDR[0] = unity_SpecCube0_HDR;
	d.boxMax[1] = unity_SpecCube1_BoxMax;
	d.boxMin[1] = unity_SpecCube1_BoxMin;
	d.probePosition[1] = unity_SpecCube1_ProbePosition;
	d.probeHDR[1] = unity_SpecCube1_HDR;
	Unity_GlossyEnvironmentData ugls_en_data;
	ugls_en_data.roughness = 1.0 - gloss;
	ugls_en_data.reflUVW = viewReflectDirection;
	UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data);
	lightDirection = gi.light.dir;
	lightColor = gi.light.color;
	////// Specular:
	float NdotL = max(0, dot(normalDirection, lightDirection));
	float LdotH = max(0.0,dot(lightDirection, halfDirection));
	float3 diffuseColor = _BaseColor_var.rgb; // Need this for specular when using metallic
	float specularMonochrome;
	float3 specularColor;
	diffuseColor = DiffuseAndSpecularFromMetallic(diffuseColor, _metallic, specularColor, specularMonochrome);
	specularMonochrome = 1 - specularMonochrome;
	float NdotV = max(0.0,dot(normalDirection, viewDirection));
	float NdotH = max(0.0,dot(normalDirection, halfDirection));
	float VdotH = max(0.0,dot(viewDirection, halfDirection));
	float visTerm = SmithBeckmannVisibilityTerm(NdotL, NdotV, 1.0 - gloss);
	float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0 - gloss)));
	float specularPBL = max(0, (NdotL*visTerm*normTerm) * (UNITY_PI / 4));
	float3 directSpecular = 1 * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
	half grazingTerm = saturate(gloss + specularMonochrome);
	float3 indirectSpecular = (gi.indirect.specular);
	indirectSpecular *= FresnelLerp(specularColor, grazingTerm, NdotV);
	float3 specular = (directSpecular + indirectSpecular);
	/////// Diffuse:
	NdotL = max(0.0,dot(normalDirection, lightDirection));
	half fd90 = 0.5 + 2 * LdotH * LdotH * (1 - gloss);
	float3 directDiffuse = ((1 + (fd90 - 1)*pow((1.00001 - NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001 - NdotV), 5)) * NdotL) * attenColor;
	float3 indirectDiffuse = float3(0,0,0);
	indirectDiffuse += gi.indirect.diffuse;
	float4 _AmbientOcclusion_var = tex2D(_AmbientOcclusion,TRANSFORM_TEX(i.uv0, _AmbientOcclusion));
	indirectDiffuse *= _AmbientOcclusion_var.r; // Diffuse AO
	float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
	////// Emissive:
	float4 node_4380 = tex2D(_emission,TRANSFORM_TEX(i.uv0, _emission));
	float3 emissive = (node_4380.rgb*_emissive);
	/// Final Color:
	float3 finalColor = diffuse + specular + emissive;
	float4 _AlphaHole_var = tex2D(_AlphaHole,TRANSFORM_TEX(i.uv0, _AlphaHole));
	fixed4 finalRGBA = fixed4(finalColor,lerp(_AlphaHole_var.r,1.0,_Opacity));
	UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
	return finalRGBA;
	}
		ENDCG
	}
		Pass{
		Name "FORWARD_DELTA"
		Tags{
		"LightMode" = "ForwardAdd"
	}
		Blend One One
		ZWrite Off

		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#define UNITY_PASS_FORWARDADD
#define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
#define _GLOSSYENV 1
#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"
#include "UnityStandardBRDF.cginc"
#pragma multi_compile_fwdadd
#pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
#pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
#pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
#pragma multi_compile_fog
#pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
#pragma target 3.0
		uniform sampler2D _Normal; uniform float4 _Normal_ST;
	uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
	uniform sampler2D _emission; uniform float4 _emission_ST;
	uniform float _emissive;
	uniform float _metallic;
	uniform float _roughness;
	uniform float _Opacity;
	uniform sampler2D _AlphaHole; uniform float4 _AlphaHole_ST;
	struct VertexInput {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
		float4 tangent : TANGENT;
		float2 texcoord0 : TEXCOORD0;
		float2 texcoord1 : TEXCOORD1;
		float2 texcoord2 : TEXCOORD2;
	};
	struct VertexOutput {
		float4 pos : SV_POSITION;
		float2 uv0 : TEXCOORD0;
		float2 uv1 : TEXCOORD1;
		float2 uv2 : TEXCOORD2;
		float4 posWorld : TEXCOORD3;
		float3 normalDir : TEXCOORD4;
		float3 tangentDir : TEXCOORD5;
		float3 bitangentDir : TEXCOORD6;
		LIGHTING_COORDS(7,8)
			UNITY_FOG_COORDS(9)
	};
	VertexOutput vert(VertexInput v) {
		VertexOutput o = (VertexOutput)0;
		o.uv0 = v.texcoord0;
		o.uv1 = v.texcoord1;
		o.uv2 = v.texcoord2;
		o.normalDir = UnityObjectToWorldNormal(v.normal);
		o.tangentDir = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
		o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
		o.posWorld = mul(unity_ObjectToWorld, v.vertex);
		float3 lightColor = _LightColor0.rgb;
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		UNITY_TRANSFER_FOG(o,o.pos);
		TRANSFER_VERTEX_TO_FRAGMENT(o)
			return o;
	}
	float4 frag(VertexOutput i) : COLOR{
		i.normalDir = normalize(i.normalDir);
	float3x3 tangentTransform = float3x3(i.tangentDir, i.bitangentDir, i.normalDir);
	float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
	float3 _Normal_var = UnpackNormal(tex2D(_Normal,TRANSFORM_TEX(i.uv0, _Normal)));
	float3 normalLocal = _Normal_var.rgb;
	float3 normalDirection = normalize(mul(normalLocal, tangentTransform)); // Perturbed normals
	float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
	clip(_BaseColor_var.a - 0.5);
	float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
	float3 lightColor = _LightColor0.rgb;
	float3 halfDirection = normalize(viewDirection + lightDirection);
	////// Lighting:
	float attenuation = LIGHT_ATTENUATION(i);
	float3 attenColor = attenuation * _LightColor0.xyz;
	float Pi = 3.141592654;
	float InvPi = 0.31830988618;
	///////// Gloss:
	float gloss = 1.0 - _roughness; // Convert roughness to gloss
	float specPow = exp2(gloss * 10.0 + 1.0);
	////// Specular:
	float NdotL = max(0, dot(normalDirection, lightDirection));
	float LdotH = max(0.0,dot(lightDirection, halfDirection));
	float3 diffuseColor = _BaseColor_var.rgb; // Need this for specular when using metallic
	float specularMonochrome;
	float3 specularColor;
	diffuseColor = DiffuseAndSpecularFromMetallic(diffuseColor, _metallic, specularColor, specularMonochrome);
	specularMonochrome = 1 - specularMonochrome;
	float NdotV = max(0.0,dot(normalDirection, viewDirection));
	float NdotH = max(0.0,dot(normalDirection, halfDirection));
	float VdotH = max(0.0,dot(viewDirection, halfDirection));
	float visTerm = SmithBeckmannVisibilityTerm(NdotL, NdotV, 1.0 - gloss);
	float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0 - gloss)));
	float specularPBL = max(0, (NdotL*visTerm*normTerm) * (UNITY_PI / 4));
	float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
	float3 specular = directSpecular;
	/////// Diffuse:
	NdotL = max(0.0,dot(normalDirection, lightDirection));
	half fd90 = 0.5 + 2 * LdotH * LdotH * (1 - gloss);
	float3 directDiffuse = ((1 + (fd90 - 1)*pow((1.00001 - NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001 - NdotV), 5)) * NdotL) * attenColor;
	float3 diffuse = directDiffuse * diffuseColor;
	/// Final Color:
	float3 finalColor = diffuse + specular;
	float4 _AlphaHole_var = tex2D(_AlphaHole,TRANSFORM_TEX(i.uv0, _AlphaHole));
	fixed4 finalRGBA = fixed4(finalColor * lerp(_AlphaHole_var.r,1.0,_Opacity),0);
	UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
	return finalRGBA;
	}
		ENDCG
	}
		Pass{
		Name "ShadowCaster"
		Tags{
		"LightMode" = "ShadowCaster"
	}
		Offset 1, 1

		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#define UNITY_PASS_SHADOWCASTER
#define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
#define _GLOSSYENV 1
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"
#include "UnityStandardBRDF.cginc"
#pragma fragmentoption ARB_precision_hint_fastest
#pragma multi_compile_shadowcaster
#pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
#pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
#pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
#pragma multi_compile_fog
#pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
#pragma target 3.0
		uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
	struct VertexInput {
		float4 vertex : POSITION;
		float2 texcoord0 : TEXCOORD0;
		float2 texcoord1 : TEXCOORD1;
		float2 texcoord2 : TEXCOORD2;
	};
	struct VertexOutput {
		V2F_SHADOW_CASTER;
		float2 uv0 : TEXCOORD1;
		float2 uv1 : TEXCOORD2;
		float2 uv2 : TEXCOORD3;
		float4 posWorld : TEXCOORD4;
	};
	VertexOutput vert(VertexInput v) {
		VertexOutput o = (VertexOutput)0;
		o.uv0 = v.texcoord0;
		o.uv1 = v.texcoord1;
		o.uv2 = v.texcoord2;
		o.posWorld = mul(unity_ObjectToWorld, v.vertex);
		o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
		TRANSFER_SHADOW_CASTER(o)
			return o;
	}
	float4 frag(VertexOutput i) : COLOR{
		float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
		float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
		clip(_BaseColor_var.a - 0.5);
		SHADOW_CASTER_FRAGMENT(i)
	}
		ENDCG
	}
		Pass{
			Name "Meta"
			Tags{
			"LightMode" = "Meta"
		}
			Cull Off

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#define UNITY_PASS_META 1
#define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
#define _GLOSSYENV 1
#include "UnityCG.cginc"
#include "Lighting.cginc"
#include "UnityPBSLighting.cginc"
#include "UnityStandardBRDF.cginc"
#include "UnityMetaPass.cginc"
#pragma fragmentoption ARB_precision_hint_fastest
#pragma multi_compile_shadowcaster
#pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
#pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
#pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
#pragma multi_compile_fog
#pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
#pragma target 3.0
			uniform sampler2D _BaseColor; uniform float4 _BaseColor_ST;
		uniform sampler2D _emission; uniform float4 _emission_ST;
		uniform float _emissive;
		uniform float _metallic;
		uniform float _roughness;
		struct VertexInput {
			float4 vertex : POSITION;
			float2 texcoord0 : TEXCOORD0;
			float2 texcoord1 : TEXCOORD1;
			float2 texcoord2 : TEXCOORD2;
		};
		struct VertexOutput {
			float4 pos : SV_POSITION;
			float2 uv0 : TEXCOORD0;
			float2 uv1 : TEXCOORD1;
			float2 uv2 : TEXCOORD2;
			float4 posWorld : TEXCOORD3;
		};
		VertexOutput vert(VertexInput v) {
			VertexOutput o = (VertexOutput)0;
			o.uv0 = v.texcoord0;
			o.uv1 = v.texcoord1;
			o.uv2 = v.texcoord2;
			o.posWorld = mul(unity_ObjectToWorld, v.vertex);
			o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST);
			return o;
		}
		float4 frag(VertexOutput i) : SV_Target{
			float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
			UnityMetaInput o;
			UNITY_INITIALIZE_OUTPUT(UnityMetaInput, o);

			float4 node_4380 = tex2D(_emission,TRANSFORM_TEX(i.uv0, _emission));
			o.Emission = (node_4380.rgb*_emissive);

			float4 _BaseColor_var = tex2D(_BaseColor,TRANSFORM_TEX(i.uv0, _BaseColor));
			float3 diffColor = _BaseColor_var.rgb;
			float specularMonochrome;
			float3 specColor;
			diffColor = DiffuseAndSpecularFromMetallic(diffColor, _metallic, specColor, specularMonochrome);
			float roughness = _roughness;
			o.Albedo = diffColor + specColor * roughness * roughness * 0.5;

			return UnityMetaFragment(o);
		}
			ENDCG
		}
			Pass{
				Name "Eraser" 
				Tags{ "RenderType" = "Transparent" }
			Cull Off
			CGPROGRAM
			//if you're not planning on using shadows, remove "addshadow" for better performance
			#pragma surface surf Lambert 
			//addshadow
			struct Input {
			float2 uv_BaseColor;
			float2 uv_SliceGuide;
			float _SliceAmount;
		};
		sampler2D _BaseColor;
		sampler2D _SliceGuide;
		float _SliceAmount;

		void surf(Input IN, inout SurfaceOutput o) {
			clip(tex2D(_SliceGuide, IN.uv_SliceGuide).rgb - _SliceAmount);
			o.Albedo = tex2D(_BaseColor, IN.uv_BaseColor).rgb;
		}
		ENDCG
		}
	}
		FallBack "Diffuse"
			CustomEditor "ShaderForgeMaterialInspector"
}
