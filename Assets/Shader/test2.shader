Shader "Custom/test2" {
	Properties {
		// インスペクタに表示される
		_WaveNum ("WaveNum", Range (0.0, 100)) = 10
		_WaveScale ("WaveScale", Range (0.0, 10)) = 0.6
		_Opacity ("Opacity", Range (0.0, 1.0)) = 1.0
		_Color ("Color", Color) = (1.0, 0.6, 0.6, 1.0)
		_Loudness ("Loudness", Float) = 0.1
	}
	SubShader {
		// レンダリングの指定
		Tags { "RenderType" = "Opaque"}
		CGPROGRAM
		// surfaceシェーダを指定 SurfaceFanction LightModel alphaブレンディング
		#pragma surface surf Lambert vertex:vert alpha
		// #pragma fragment frag
		// #pragma target 3.0
		// UV(テクスチャ)座標が渡ってくる
		struct Input {
			float4 color : COLOR;
			float4 pos : SV_POSITION;
      float2 uv_MainTex;
			float3 worldPos;
			float3 customColor;
		};
		// Propertiesで指定した値を取得
		float _WaveNum, _WaveScale, _Opacity, _Loudness,
		      _LowSpectrum, _MidSpectrum, _HighSpectrum;
		float4 _Color;
		//
		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = float4(_LowSpectrum, _MidSpectrum, _HighSpectrum, 1.0);
			// o.Albedo *= IN.customColor * 10;
			// 半透明
			o.Alpha = _Opacity;
			// clip (frac((IN.worldPos.x * _SinTime.x + IN.worldPos.y * _SinTime.y + IN.worldPos.z * _SinTime.z) * _SinTime.y * 100) -0.5);
		}
		// vertexシェーダ （頂点）
		void vert (inout appdata_full v, out Input o) {
			// 波を打つ
			UNITY_INITIALIZE_OUTPUT(Input,o);
			v.vertex.x += _WaveScale * _Loudness * v.normal.x * sin(v.vertex.y * 3.14 * _WaveNum);
			v.vertex.z += _WaveScale * _Loudness * v.normal.z * sin(v.vertex.x * 3.14 * _WaveNum);
			v.vertex.y += _WaveScale * _Loudness * v.normal.y * sin(v.vertex.z * 3.14 * _WaveNum);
			o.customColor = abs(v.vertex);
      o.pos = mul( UNITY_MATRIX_MVP, v.vertex );
      // calculate binormal
      float3 binormal = cross( v.normal, v.tangent.xyz ) * v.tangent.w;
      o.color.xyz = binormal * 0.5 + 0.5;
      o.color.w = 1.0;
		}
		fixed4 frag () : SV_Target {
				return _Color;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
