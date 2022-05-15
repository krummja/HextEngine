// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CRTCurve"
{
	Properties
	{
		_WarpStrength("Warp Strength", Float) = 2
		_MinOpacity("Min Opacity", Float) = 0
		_RectWidth("RectWidth", Float) = 1
		_RectHeight("RectHeight", Float) = 1
		_CornerRadius("CornerRadius", Float) = 0.1
		_Offset("Offset", Vector) = (0,0,0,0)
		_Center("Center", Vector) = (0.5,0.5,0,0)
		_MinSecondaryOpacity("Min Secondary Opacity", Float) = 0
		_ScanlineColor("Scanline Color", Color) = (1,1,1,0)
		_MaxOpacity("Max Opacity", Float) = 1
		_MaxSecondaryOpacity("Max Secondary Opacity", Float) = 0.23
		_ScanlineCount("Scanline Count", Float) = 15
		_SecondaryScanCount("Secondary Scan Count", Float) = 1
		_PanSpeed("Pan Speed", Float) = 1
		_SecondarySpeed("Secondary Speed", Float) = -10.92
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float2 _Center;
		uniform float _WarpStrength;
		uniform float2 _Offset;
		uniform float _RectWidth;
		uniform float _RectHeight;
		uniform float _CornerRadius;
		uniform float4 _ScanlineColor;
		uniform float _ScanlineCount;
		uniform float _PanSpeed;
		uniform float _MinOpacity;
		uniform float _MaxOpacity;
		uniform float _SecondaryScanCount;
		uniform float _SecondarySpeed;
		uniform float _MinSecondaryOpacity;
		uniform float _MaxSecondaryOpacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_output_2_0_g1 = i.uv_texcoord;
			float2 temp_output_11_0_g1 = ( temp_output_2_0_g1 - _Center );
			float dotResult12_g1 = dot( temp_output_11_0_g1 , temp_output_11_0_g1 );
			float2 temp_cast_0 = (_WarpStrength).xx;
			float temp_output_2_0_g4 = _RectWidth;
			float temp_output_3_0_g4 = 0;
			float2 appendResult21_g4 = (float2(temp_output_2_0_g4 , temp_output_3_0_g4));
			float Radius25_g4 = max( min( min( abs( ( 0 * 2 ) ) , abs( temp_output_2_0_g4 ) ) , abs( temp_output_3_0_g4 ) ) , 1E-05 );
			float2 temp_cast_3 = (0.0).xx;
			float temp_output_30_0_g4 = ( length( max( ( ( abs( (( temp_output_2_0_g1 + ( temp_output_11_0_g1 * ( dotResult12_g1 * dotResult12_g1 * temp_cast_0 ) ) + _Offset )*2.0 + -1.0) ) - appendResult21_g4 ) + Radius25_g4 ) , temp_cast_3 ) ) / Radius25_g4 );
			float3 temp_cast_4 = (saturate( ( ( 1.0 - temp_output_30_0_g4 ) / fwidth( temp_output_30_0_g4 ) ) )).xxx;
			o.Emission = temp_cast_4;
			o.Alpha = ( _ScanlineColor * ( (_MinOpacity + (sin( ( _ScanlineCount * ( i.uv_texcoord.y + ( _Time.x * _PanSpeed ) ) * 6.28318548202515 ) ) - 0.0) * (_MaxOpacity - _MinOpacity) / (1.0 - 0.0)) * (_MinSecondaryOpacity + (sin( ( _SecondaryScanCount * ( i.uv_texcoord.y + ( _Time.x * _SecondarySpeed ) ) * 6.28318548202515 ) ) - 0.0) * (_MaxSecondaryOpacity - _MinSecondaryOpacity) / (1.0 - 0.0)) ) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1920;395;1920;998;2223.17;2345.843;1.66509;True;False
Node;AmplifyShaderEditor.CommentaryNode;20;-2104.682,-1732.004;Inherit;False;1513.589;690.932;;12;44;42;41;40;36;34;31;30;27;26;25;24;Scanline;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;21;-2088.988,-923.8828;Inherit;False;1496.61;772.8231;;12;45;43;39;38;37;35;33;32;29;28;23;22;Secondary Scanline;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;22;-2036.314,-590.0925;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-2036.313,-439.5925;Inherit;False;Property;_SecondarySpeed;Secondary Speed;14;0;Create;True;0;0;0;False;0;False;-10.92;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;24;-2056.682,-1444.004;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-2056.682,-1300.004;Inherit;False;Property;_PanSpeed;Pan Speed;13;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;29;-2030.835,-733.4789;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1780.464,-589.8096;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-2056.682,-1572.004;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1800.682,-1444.004;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;32;-1584.719,-596.7546;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2028.387,-852.1914;Inherit;False;Property;_SecondaryScanCount;Secondary Scan Count;12;0;Create;True;0;0;0;False;0;False;1;15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;31;-1607.382,-1467.904;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-2058.013,-1685.317;Inherit;False;Property;_ScanlineCount;Scanline Count;11;0;Create;True;0;0;0;False;0;False;15;15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-1589.114,-706.4979;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1608.682,-1572.004;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1401.679,-1682.587;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1317.966,-849.8493;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;38;-1099.25,-847.7573;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2028.442,-261.2406;Inherit;False;Property;_MaxSecondaryOpacity;Max Secondary Opacity;10;0;Create;True;0;0;0;False;0;False;0.23;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-2028.442,-341.2406;Inherit;False;Property;_MinSecondaryOpacity;Min Secondary Opacity;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;48;-2093.47,-2569.988;Inherit;False;1513.589;690.932;;8;16;19;18;17;2;3;5;4;CRT Screen;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-2058.682,-1223.004;Inherit;False;Property;_MinOpacity;Min Opacity;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;42;-1128.683,-1684.004;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-2058.682,-1143.004;Inherit;False;Property;_MaxOpacity;Max Opacity;9;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;45;-908.0662,-388.9196;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.6;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;44;-894.769,-1269.9;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.6;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;5;-2018.321,-2303.305;Inherit;False;Property;_Offset;Offset;5;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;4;-2018.321,-2512.305;Inherit;False;Property;_Center;Center;6;0;Create;True;0;0;0;False;0;False;0.5,0.5;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;3;-2017.321,-2383.305;Inherit;False;Property;_WarpStrength;Warp Strength;0;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;46;-453.827,-1147.895;Inherit;False;Property;_ScanlineColor;Scanline Color;8;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-1430.386,-2155.751;Inherit;False;Property;_RectWidth;RectWidth;2;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1434.386,-2076.752;Inherit;False;Property;_RectHeight;RectHeight;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1444.386,-1983.751;Inherit;False;Property;_CornerRadius;CornerRadius;4;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2;-1435.386,-2428.751;Inherit;True;Spherize;-1;;1;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-453.8519,-882.0914;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;16;-1074.386,-2235.751;Inherit;True;Rounded Rectangle;-1;;4;8679f72f5be758f47babb3ba1d5f51d3;0;4;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-123.4902,-1491.652;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;355.6056,-1656.598;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;CRTCurve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;22;1
WireConnection;28;1;23;0
WireConnection;27;0;24;1
WireConnection;27;1;25;0
WireConnection;33;0;29;2
WireConnection;33;1;28;0
WireConnection;30;0;26;2
WireConnection;30;1;27;0
WireConnection;36;0;34;0
WireConnection;36;1;30;0
WireConnection;36;2;31;0
WireConnection;37;0;35;0
WireConnection;37;1;33;0
WireConnection;37;2;32;0
WireConnection;38;0;37;0
WireConnection;42;0;36;0
WireConnection;45;0;38;0
WireConnection;45;3;39;0
WireConnection;45;4;43;0
WireConnection;44;0;42;0
WireConnection;44;3;41;0
WireConnection;44;4;40;0
WireConnection;2;3;4;0
WireConnection;2;4;3;0
WireConnection;2;5;5;0
WireConnection;47;0;44;0
WireConnection;47;1;45;0
WireConnection;16;1;2;0
WireConnection;16;2;17;0
WireConnection;49;0;46;0
WireConnection;49;1;47;0
WireConnection;0;2;16;0
WireConnection;0;9;49;0
ASEEND*/
//CHKSM=20DC33F274795F7E1E6E5F6F8924EA601E6C1D52