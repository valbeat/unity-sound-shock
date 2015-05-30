Shader "Custom/test2" {
	Properties {
		// インスペクタに表示される
		_WaveNum ("WaveNum", Range (0.0, 100)) = 10
		_WaveScale ("WaveScale", Range (0.0, 10)) = 0.6
		_Opacity ("Opacity", Range (0.0, 1.0)) = 1.0
		_Color ("Color", Color) = (1.0,1.0,1.0)
		_Loudness ("Loudness", Float) = 0.1
	}
	SubShader {
		// レンダリングの指定
		Tags { "RenderType" = "Opaque"}
		CGPROGRAM
		// surfaceシェーダを指定 SurfaceFanction LightModel alphaブレンディング
		#pragma surface surf Lambert vertex:vert alpha
		// UV(テクスチャ)座標が渡ってくる
		struct Input {
			float4 color : COLOR;
		};
		// Propertiesで指定した値を取得
		float _WaveNum, _WaveScale, _Opacity, _Loudness,
		      _LowSpectrum, _MidSpectrum, _HighSpectrum;
		float4 _Color;

		//
		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = float4(_LowSpectrum, _MidSpectrum, _HighSpectrum, 0.1);
			// 半透明
			o.Alpha = _Opacity;
		}
		// vertexシェーダ （頂点）
		void vert (inout appdata_full v) {
			// 波を打つ
			v.vertex.x += _WaveScale * _Loudness * v.normal.x * sin(v.vertex.y * 3.14 * _WaveNum);
			v.vertex.z += _WaveScale * _Loudness * v.normal.z * sin(v.vertex.x * 3.14 * _WaveNum);
			v.vertex.y += _WaveScale * _Loudness * v.normal.y * sin(v.vertex.z * 3.14 * _WaveNum);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
