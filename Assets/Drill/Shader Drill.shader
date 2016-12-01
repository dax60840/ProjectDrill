// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:4013,x:32991,y:32708,varname:node_4013,prsc:2|diff-1304-RGB,normal-4340-OUT,clip-2082-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:32443,y:32712,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1304,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:6467,x:31887,y:32509,ptovrint:False,ptlb:Normal1,ptin:_Normal1,varname:node_6467,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:12ad774804a8b3446be60d32d9265eff,ntxv:3,isnm:True|UVIN-2395-OUT;n:type:ShaderForge.SFN_Tex2d,id:2529,x:31981,y:32729,ptovrint:False,ptlb:Normal2,ptin:_Normal2,varname:node_2529,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:28469bccddc587348b01f528dbfdd5b5,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:3014,x:32107,y:32433,varname:node_3014,prsc:2,tex:21a2107215e4f8249abef1df340e97a9,ntxv:0,isnm:False|TEX-478-TEX;n:type:ShaderForge.SFN_Multiply,id:4340,x:32224,y:32687,varname:node_4340,prsc:2|A-6467-RGB,B-2529-RGB;n:type:ShaderForge.SFN_TexCoord,id:3056,x:30536,y:32341,varname:node_3056,prsc:2,uv:0;n:type:ShaderForge.SFN_Time,id:7392,x:29779,y:32536,varname:node_7392,prsc:2;n:type:ShaderForge.SFN_Add,id:8291,x:31566,y:32628,varname:node_8291,prsc:2|A-3056-V,B-7057-OUT;n:type:ShaderForge.SFN_Append,id:2395,x:31645,y:32458,varname:node_2395,prsc:2|A-3056-U,B-8291-OUT;n:type:ShaderForge.SFN_Multiply,id:7057,x:30103,y:32615,varname:node_7057,prsc:2|A-7392-T,B-5080-OUT;n:type:ShaderForge.SFN_Slider,id:5080,x:29716,y:32734,ptovrint:False,ptlb:Vitesse,ptin:_Vitesse,varname:node_5080,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-10,cur:-2.649572,max:0;n:type:ShaderForge.SFN_Tex2d,id:7847,x:32046,y:32086,varname:node_7847,prsc:2,tex:21a2107215e4f8249abef1df340e97a9,ntxv:0,isnm:False|UVIN-2395-OUT,TEX-478-TEX;n:type:ShaderForge.SFN_Tex2d,id:5200,x:32059,y:32259,varname:node_5200,prsc:2,tex:21a2107215e4f8249abef1df340e97a9,ntxv:0,isnm:False|TEX-478-TEX;n:type:ShaderForge.SFN_Multiply,id:8808,x:32476,y:32211,varname:node_8808,prsc:2|A-2304-OUT,B-5200-G;n:type:ShaderForge.SFN_Vector1,id:9151,x:32063,y:31977,varname:node_9151,prsc:2,v1:0.3;n:type:ShaderForge.SFN_Add,id:2304,x:32303,y:32061,varname:node_2304,prsc:2|A-7847-B,B-9151-OUT;n:type:ShaderForge.SFN_Step,id:4269,x:32703,y:32382,varname:node_4269,prsc:2|A-6913-OUT,B-8808-OUT;n:type:ShaderForge.SFN_Vector1,id:6913,x:32541,y:32111,varname:node_6913,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:2082,x:32655,y:32553,varname:node_2082,prsc:2|A-4269-OUT,B-3014-R;n:type:ShaderForge.SFN_Tex2dAsset,id:478,x:31722,y:32066,ptovrint:False,ptlb:DrillMask,ptin:_DrillMask,varname:node_478,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:21a2107215e4f8249abef1df340e97a9,ntxv:0,isnm:False;proporder:1304-6467-2529-5080-478;pass:END;sub:END;*/

Shader "Shader Forge/Shader Drill" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _Normal1 ("Normal1", 2D) = "bump" {}
        _Normal2 ("Normal2", 2D) = "bump" {}
        _Vitesse ("Vitesse", Range(-10, 0)) = -2.649572
        _DrillMask ("DrillMask", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _Normal1; uniform float4 _Normal1_ST;
            uniform sampler2D _Normal2; uniform float4 _Normal2_ST;
            uniform float _Vitesse;
            uniform sampler2D _DrillMask; uniform float4 _DrillMask_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_7392 = _Time + _TimeEditor;
                float2 node_2395 = float2(i.uv0.r,(i.uv0.g+(node_7392.g*_Vitesse)));
                float3 _Normal1_var = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_2395, _Normal1)));
                float3 _Normal2_var = UnpackNormal(tex2D(_Normal2,TRANSFORM_TEX(i.uv0, _Normal2)));
                float3 normalLocal = (_Normal1_var.rgb*_Normal2_var.rgb);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 node_7847 = tex2D(_DrillMask,TRANSFORM_TEX(node_2395, _DrillMask));
                float4 node_5200 = tex2D(_DrillMask,TRANSFORM_TEX(i.uv0, _DrillMask));
                float4 node_3014 = tex2D(_DrillMask,TRANSFORM_TEX(i.uv0, _DrillMask));
                clip((step(0.1,((node_7847.b+0.3)*node_5200.g))*node_3014.r) - 0.5);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float3 diffuseColor = _Color.rgb;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _TimeEditor;
            uniform float4 _Color;
            uniform sampler2D _Normal1; uniform float4 _Normal1_ST;
            uniform sampler2D _Normal2; uniform float4 _Normal2_ST;
            uniform float _Vitesse;
            uniform sampler2D _DrillMask; uniform float4 _DrillMask_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_7392 = _Time + _TimeEditor;
                float2 node_2395 = float2(i.uv0.r,(i.uv0.g+(node_7392.g*_Vitesse)));
                float3 _Normal1_var = UnpackNormal(tex2D(_Normal1,TRANSFORM_TEX(node_2395, _Normal1)));
                float3 _Normal2_var = UnpackNormal(tex2D(_Normal2,TRANSFORM_TEX(i.uv0, _Normal2)));
                float3 normalLocal = (_Normal1_var.rgb*_Normal2_var.rgb);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float4 node_7847 = tex2D(_DrillMask,TRANSFORM_TEX(node_2395, _DrillMask));
                float4 node_5200 = tex2D(_DrillMask,TRANSFORM_TEX(i.uv0, _DrillMask));
                float4 node_3014 = tex2D(_DrillMask,TRANSFORM_TEX(i.uv0, _DrillMask));
                clip((step(0.1,((node_7847.b+0.3)*node_5200.g))*node_3014.r) - 0.5);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 diffuseColor = _Color.rgb;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform float _Vitesse;
            uniform sampler2D _DrillMask; uniform float4 _DrillMask_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 node_7392 = _Time + _TimeEditor;
                float2 node_2395 = float2(i.uv0.r,(i.uv0.g+(node_7392.g*_Vitesse)));
                float4 node_7847 = tex2D(_DrillMask,TRANSFORM_TEX(node_2395, _DrillMask));
                float4 node_5200 = tex2D(_DrillMask,TRANSFORM_TEX(i.uv0, _DrillMask));
                float4 node_3014 = tex2D(_DrillMask,TRANSFORM_TEX(i.uv0, _DrillMask));
                clip((step(0.1,((node_7847.b+0.3)*node_5200.g))*node_3014.r) - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
