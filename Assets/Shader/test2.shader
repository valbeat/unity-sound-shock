Shader "Custom/test2" {
	Properties {
		// インスペクタに表示される
		_WaveNum ("WaveNum", Range (0.0, 100)) = 10
		_WaveScale ("WaveScale", Range (0.0, 10.0)) = 0.5
		_Opacity ("Opacity", Range (0.0, 1.0)) = 1.0
		_Color ("Color", Color) = (1.0,1.0,1.0)
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
		float _WaveNum, _WaveScale, _Opacity;
		float4 _Color, _MousePosition;

		// エントリポイント
		void surf (Input IN, inout SurfaceOutput o) {
			// 反射の割合 青と緑は半分反射
			o.Albedo = _Color.rgb;
			// 半透明
			o.Alpha = _Opacity;
		}
		// vertexシェーダ （頂点）
		void vert (inout appdata_full v) {
			// 波を打つ
			v.vertex.x += _WaveScale * _SinTime.w * v.normal.x * sin(v.vertex.y * 3.14 * _WaveNum);
			v.vertex.z += _WaveScale * _SinTime.w * v.normal.z * sin(v.vertex.x * 3.14 * _WaveNum);
			v.vertex.y += _WaveScale * _SinTime.w * v.normal.y * sin(v.vertex.z * 3.14 * _WaveNum);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
