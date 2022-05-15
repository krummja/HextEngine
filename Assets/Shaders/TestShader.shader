// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TestShader"
{
	Properties
	{
		_Emission("Emission", Color) = (1,0.5615011,0,0)
		_Patterns("Patterns", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_RimPower("Rim Power", Range( 0 , 10)) = 1.189835
		_GridSpeed("Grid Speed", Float) = 0.01
		_DistortionLinePower("Distortion Line Power", Range( 0 , 0.05)) = 0.01
		_PlanetMap("Planet Map", 2D) = "white" {}
		_BackfaceOpacity("Backface Opacity", Float) = 0
		_OutlinePower("Outline Power", Float) = 0
		_PulseSpeedOutline("Pulse Speed Outline", Float) = 0
		_PulseSpeedGrid("Pulse Speed Grid", Float) = 0
		_GridPower("Grid Power", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Pass
		{
			ColorMask 0
			ZWrite On
		}

		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		ZWrite On
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcColor
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma surface surf Standard keepalpha 
		struct Input
		{
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float3 viewDir;
		};

		uniform float4 _Emission;
		uniform float _PulseSpeedGrid;
		uniform sampler2D _PlanetMap;
		uniform float _GridSpeed;
		uniform sampler2D _TextureSample0;
		uniform float _DistortionLinePower;
		uniform float _BackfaceOpacity;
		uniform float _GridPower;
		uniform float _OutlinePower;
		uniform float _PulseSpeedOutline;
		uniform sampler2D _Patterns;
		uniform float _RimPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Emission = _Emission.rgb;
			float2 panner38 = ( 1.0 * _Time.y * float2( 0,0 ) + i.uv_texcoord);
			float temp_output_43_0 = ( ( 1.0 - tex2D( _TextureSample0, panner38 ).r ) * _DistortionLinePower );
			float4 appendResult46 = (float4(( saturate( i.uv_texcoord.x ) + ( temp_output_43_0 * 0.0 ) ) , ( i.uv_texcoord.y + temp_output_43_0 ) , 0.0 , 0.0));
			float2 panner47 = ( ( _GridSpeed * _Time.x ) * float2( 0,0 ) + appendResult46.xy);
			float4 tex2DNode58 = tex2D( _PlanetMap, panner47 );
			float switchResult67 = (((i.ASEVFace>0)?(tex2DNode58.g):(( tex2DNode58.g * _BackfaceOpacity ))));
			float temp_output_93_0 = ( (0.95 + (sin( ( _Time.y * _PulseSpeedGrid ) ) - 0.0) * (1.0 - 0.95) / (1.0 - 0.0)) * switchResult67 );
			float4 tex2DNode61 = tex2D( _PlanetMap, panner47 );
			float switchResult68 = (((i.ASEVFace>0)?(tex2DNode61.b):(( tex2DNode61.b * _BackfaceOpacity ))));
			float lerpResult96 = lerp( ( temp_output_93_0 * 0.0 ) , temp_output_93_0 , ( 1.0 - switchResult68 ));
			float switchResult66 = (((i.ASEVFace>0)?(tex2DNode61.r):(( tex2DNode61.r * _BackfaceOpacity ))));
			float switchResult69 = (((i.ASEVFace>0)?(tex2DNode61.a):(( tex2DNode61.a * _BackfaceOpacity ))));
			float4 appendResult8 = (float4((float)-1 , (float)-1 , 0.0 , 0.0));
			float2 panner5 = ( ( _Time.x * 1.0 ) * appendResult8.xy + i.uv_texcoord);
			float4 color20 = IsGammaSpace() ? float4(0,0.07041359,1,0) : float4(0,0.006028665,1,0);
			float3 normalizeResult22 = normalize( i.viewDir );
			float dotResult23 = dot( color20 , float4( normalizeResult22 , 0.0 ) );
			float switchResult29 = (((i.ASEVFace>0)?(pow( ( 1.0 - saturate( dotResult23 ) ) , _RimPower )):(0)));
			o.Alpha = ( ( ( ( ( saturate( lerpResult96 ) * _GridPower ) + ( ( ( ( switchResult66 * _OutlinePower ) + ( switchResult69 * (0.0 + (sin( ( _Time.y * _PulseSpeedOutline ) ) - 0.0) * (0.5 - 0.0) / (1.0 - 0.0)) ) ) + ( ( switchResult68 * 0.0 ) + ( switchResult68 * ( 1.0 - tex2D( _Patterns, panner5 ).r ) * 0.8 ) ) ) + 1.0 ) ) + switchResult29 ) * (0.6 + (sin( ( 15.0 * ( i.uv_texcoord.y + ( _Time.x * 1.0 ) ) * 6.28318548202515 ) ) - 0.0) * (0.7 - 0.6) / (1.0 - 0.0)) ) * 1.2 );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
3840;528;1920;1017;-999.8248;-82.1001;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;76;-3968,128;Inherit;False;2003.077;668.7699;;18;48;39;47;57;46;36;41;42;55;53;52;43;37;56;44;50;38;34;Distortion;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-3920,416;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;38;-3616,416;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;50;-3408,416;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;44;-3088,448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-3392,624;Float;False;Property;_DistortionLinePower;Distortion Line Power;7;0;Create;True;0;0;0;False;0;False;0.01;0.0282;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-3328,256;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-2880,512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-2688,576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;52;-3024,256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-3328,176;Float;False;Property;_GridSpeed;Grid Speed;6;0;Create;True;0;0;0;False;0;False;0.01;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-2512,400;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-2512,304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;36;-3920,624;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-2528,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;-2352,304;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;100;-1201,-464;Inherit;False;1853.733;323.0676;;12;98;99;97;96;95;94;93;92;91;90;88;89;Lines;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;32;-1664,1168;Inherit;False;1365;630;;12;6;10;7;9;4;8;11;5;12;15;13;14;Pattern;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;7;-1616,1424;Inherit;False;Constant;_PatternV;Pattern V;1;0;Create;True;0;0;0;False;0;False;-1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;6;-1616,1344;Inherit;False;Constant;_PatternU;Pattern U;1;0;Create;True;0;0;0;False;0;False;-1;0;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-1153,-240;Inherit;False;Property;_PulseSpeedGrid;Pulse Speed Grid;12;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;88;-1153,-400;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;123;-1664,768;Inherit;False;950;277;;6;122;121;119;117;116;115;Glow Clock;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1616,1680;Inherit;False;Constant;_PatternScrollSpeed;Pattern Scroll Speed;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;47;-2176,240;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;60;-2176,-80;Inherit;True;Property;_PlanetMap;Planet Map;8;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TimeNode;9;-1616,1520;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1616,1216;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;58;-1872,144;Inherit;True;Property;_GridComponent;Grid Component;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;116;-1616,960;Inherit;False;Property;_PulseSpeedOutline;Pulse Speed Outline;11;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;75;-1408,32;Inherit;False;449;463;;8;65;69;64;68;63;67;66;62;Backface;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-1776,528;Inherit;False;Property;_BackfaceOpacity;Backface Opacity;9;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1360,1536;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-1424,1344;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;-897,-400;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;115;-1616,816;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-1360,176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-1872,336;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-1424,816;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;5;-1232,1216;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;33;-359.9998,-38.40002;Inherit;False;1346.928;422;;10;21;22;20;23;24;25;27;28;26;29;Rim;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;91;-737,-400;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-976,1216;Inherit;True;Property;_Patterns;Patterns;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;21;-304,208;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1360,368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;73;-256,448;Inherit;False;490;272;;2;72;71;World Outline;1,1,1,1;0;0
Node;AmplifyShaderEditor.SwitchByFaceNode;67;-1200,176;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;92;-609,-400;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.95;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1360,80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;119;-1296,816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-1360,272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;13;-688,1216;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;125;256,768;Inherit;False;750;320;;6;16;101;19;102;74;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-417,-400;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;68;-1200,272;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;87;-46.00035,1163.962;Inherit;False;1300;507.4246;;10;79;78;77;83;82;81;80;84;85;86;Glow Diff;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;20;-304,16;Inherit;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;0;False;0;False;0,0.07041359,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-976,1408;Inherit;False;Constant;_PatternPower;Pattern Power;1;0;Create;True;0;0;0;False;0;False;0.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-224,576;Inherit;False;Property;_OutlinePower;Outline Power;10;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;69;-1200,368;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;22;-112,208;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;121;-1184,816;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;66;-1200,80;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;23;96,16;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;78;1.999599,1403.962;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;79;1.999599,1547.962;Inherit;False;Constant;_Float3;Float 3;1;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;16,496;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-129,-400;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;304,944;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-512,1216;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-928,816;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;95;-129,-288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;464,816;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;77;1.999599,1275.962;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;102;464,944;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;24;240,16;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;225.9997,1403.962;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;96;47,-400;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;385.9995,1211.962;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;25;400,16;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;80;385.9995,1435.962;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;101;624,816;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;385.9995,1323.962;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;97;255,-400;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;239,-304;Inherit;False;Property;_GridPower;Grid Power;13;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;624,912;Inherit;False;Constant;_Opacity;Opacity;0;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;96,128;Inherit;False;Property;_RimPower;Rim Power;5;0;Create;True;0;0;0;False;0;False;1.189835;4.01;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;784,816;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;545.9995,1323.962;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;26;576,16;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;28;224,225;Inherit;False;Constant;_Backface;Backface;3;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;415,-400;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;29;752,16;Inherit;True;2;0;FLOAT;0;False;1;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;85;769.9997,1323.962;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;1648,208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;124;1776,320;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;86;961.9996,1323.962;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.6;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;1920,416;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;1920,544;Inherit;False;Constant;_EmissionPower;Emission Power;0;0;Create;True;0;0;0;False;0;False;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-3920,544;Float;False;Property;_DistortionScrollSpeed;Distortion Scroll Speed;4;0;Create;True;0;0;0;False;0;False;0.01;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-3616,544;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;2240,512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;2241,305;Inherit;False;Property;_Emission;Emission;1;0;Create;True;0;0;0;False;0;False;1,0.5615011,0,0;0,0.6366436,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;18;2560,240;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;TestShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;-1;0;False;-1;False;0;False;-1;0;False;-1;True;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;1;5;False;-1;6;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;34;0
WireConnection;50;1;38;0
WireConnection;44;0;50;1
WireConnection;43;0;44;0
WireConnection;43;1;56;0
WireConnection;53;0;43;0
WireConnection;52;0;37;1
WireConnection;42;0;52;0
WireConnection;42;1;53;0
WireConnection;41;0;37;2
WireConnection;41;1;43;0
WireConnection;57;0;55;0
WireConnection;57;1;36;1
WireConnection;46;0;42;0
WireConnection;46;1;41;0
WireConnection;47;0;46;0
WireConnection;47;1;57;0
WireConnection;58;0;60;0
WireConnection;58;1;47;0
WireConnection;11;0;9;1
WireConnection;11;1;10;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;90;0;88;2
WireConnection;90;1;89;0
WireConnection;63;0;58;2
WireConnection;63;1;70;0
WireConnection;61;0;60;0
WireConnection;61;1;47;0
WireConnection;117;0;115;2
WireConnection;117;1;116;0
WireConnection;5;0;4;0
WireConnection;5;2;8;0
WireConnection;5;1;11;0
WireConnection;91;0;90;0
WireConnection;12;1;5;0
WireConnection;65;0;61;4
WireConnection;65;1;70;0
WireConnection;67;0;58;2
WireConnection;67;1;63;0
WireConnection;92;0;91;0
WireConnection;62;0;61;1
WireConnection;62;1;70;0
WireConnection;119;0;117;0
WireConnection;64;0;61;3
WireConnection;64;1;70;0
WireConnection;13;0;12;1
WireConnection;93;0;92;0
WireConnection;93;1;67;0
WireConnection;68;0;61;3
WireConnection;68;1;64;0
WireConnection;69;0;61;4
WireConnection;69;1;65;0
WireConnection;22;0;21;0
WireConnection;121;0;119;0
WireConnection;66;0;61;1
WireConnection;66;1;62;0
WireConnection;23;0;20;0
WireConnection;23;1;22;0
WireConnection;72;0;66;0
WireConnection;72;1;71;0
WireConnection;94;0;93;0
WireConnection;103;0;68;0
WireConnection;14;0;68;0
WireConnection;14;1;13;0
WireConnection;14;2;15;0
WireConnection;122;0;69;0
WireConnection;122;1;121;0
WireConnection;95;0;68;0
WireConnection;74;0;72;0
WireConnection;74;1;122;0
WireConnection;102;0;103;0
WireConnection;102;1;14;0
WireConnection;24;0;23;0
WireConnection;83;0;78;1
WireConnection;83;1;79;0
WireConnection;96;0;94;0
WireConnection;96;1;93;0
WireConnection;96;2;95;0
WireConnection;25;0;24;0
WireConnection;101;0;74;0
WireConnection;101;1;102;0
WireConnection;82;0;77;2
WireConnection;82;1;83;0
WireConnection;97;0;96;0
WireConnection;16;0;101;0
WireConnection;16;1;19;0
WireConnection;84;0;81;0
WireConnection;84;1;82;0
WireConnection;84;2;80;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;98;0;97;0
WireConnection;98;1;99;0
WireConnection;29;0;26;0
WireConnection;29;1;28;0
WireConnection;85;0;84;0
WireConnection;30;0;98;0
WireConnection;30;1;16;0
WireConnection;124;0;30;0
WireConnection;124;1;29;0
WireConnection;86;0;85;0
WireConnection;31;0;124;0
WireConnection;31;1;86;0
WireConnection;39;0;48;0
WireConnection;39;1;36;2
WireConnection;3;0;31;0
WireConnection;3;1;2;0
WireConnection;18;2;1;0
WireConnection;18;9;3;0
ASEEND*/
//CHKSM=C63F69241472919EE3D3CC07846F8CD5C773F886