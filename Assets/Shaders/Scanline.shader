// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Scanline"
{
	Properties
	{
		_MinOpacity("Min Opacity", Float) = 0
		_MinSecondaryOpacity("Min Secondary Opacity", Float) = 0
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
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

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
			o.Alpha = ( (_MinOpacity + (sin( ( _ScanlineCount * ( i.uv_texcoord.y + ( _Time.x * _PanSpeed ) ) * 6.28318548202515 ) ) - 0.0) * (_MaxOpacity - _MinOpacity) / (1.0 - 0.0)) * (_MinSecondaryOpacity + (sin( ( _SecondaryScanCount * ( i.uv_texcoord.y + ( _Time.x * _SecondarySpeed ) ) * 6.28318548202515 ) ) - 0.0) * (_MaxSecondaryOpacity - _MinSecondaryOpacity) / (1.0 - 0.0)) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;61;1920;998;713.4858;-419.6813;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;25;-1232,162;Inherit;False;1513.589;690.932;;12;24;30;29;23;22;21;15;20;19;18;16;17;Scanline;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;44;-1216.306,966.6749;Inherit;False;1496.61;772.8231;;12;40;35;38;34;37;33;36;39;42;41;31;32;Secondary Scanline;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;31;-1163.632,1300.464;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;-1163.631,1450.964;Inherit;False;Property;_SecondarySpeed;Secondary Speed;8;0;Create;True;0;0;0;False;0;False;-10.92;-10.92;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;17;-1184,450;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-1184,594;Inherit;False;Property;_PanSpeed;Pan Speed;7;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1184,322;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-928,450;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-907.7813,1300.747;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-1158.153,1157.078;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TauNode;38;-712.0369,1293.802;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;15;-734.7,426.1004;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;-736,322;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-716.4321,1184.059;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1155.705,1038.366;Inherit;False;Property;_SecondaryScanCount;Secondary Scan Count;6;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1185.331,208.6869;Inherit;False;Property;_ScanlineCount;Scanline Count;5;0;Create;True;0;0;0;False;0;False;15;150;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-528.9964,211.4164;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-445.283,1040.708;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;35;-226.5677,1042.8;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1155.76,1549.316;Inherit;False;Property;_MinSecondaryOpacity;Min Secondary Opacity;1;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-1186,751;Inherit;False;Property;_MaxOpacity;Max Opacity;3;0;Create;True;0;0;0;False;0;False;1;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-1186,671;Inherit;False;Property;_MinOpacity;Min Opacity;0;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;23;-256,210;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1155.76,1629.316;Inherit;False;Property;_MaxSecondaryOpacity;Max Secondary Opacity;4;0;Create;True;0;0;0;False;0;False;0.23;0.75;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;24;-22.08554,624.1036;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.6;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;40;-35.38272,1501.637;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.6;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;418.8313,1008.466;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;421.8561,778.6632;Inherit;False;Property;_ScanlineColor;Scanline Color;2;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.2830189,0.2830189,0.2830189,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;27;709.8281,740.9996;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;Scanline;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;3;1;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;17;1
WireConnection;19;1;16;0
WireConnection;33;0;31;1
WireConnection;33;1;32;0
WireConnection;20;0;18;2
WireConnection;20;1;19;0
WireConnection;37;0;39;2
WireConnection;37;1;33;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;22;2;15;0
WireConnection;34;0;36;0
WireConnection;34;1;37;0
WireConnection;34;2;38;0
WireConnection;35;0;34;0
WireConnection;23;0;22;0
WireConnection;24;0;23;0
WireConnection;24;3;29;0
WireConnection;24;4;30;0
WireConnection;40;0;35;0
WireConnection;40;3;41;0
WireConnection;40;4;42;0
WireConnection;43;0;24;0
WireConnection;43;1;40;0
WireConnection;27;9;43;0
ASEEND*/
//CHKSM=BCFC0D99EAE6F837814BE1065C9F1B9B0AE370F4