Shader "Custom/test2" {
	Properties {
		// インスペクタに表示される
		_MainColor ("color", Color) = (1,1,1)
	}
	SubShader {
		// レンダリングの指定
		Tags { "RenderType" = "Opaque"}
		CGPROGRAM
		// surfaceシェーダを指定 SurfaceFanction LightModel alphaブレンディング
		#pragma surface surf Lambert alpha
		// UV(テクスチャ)座標が渡ってくる
		struct Input {
			float4 color : COLOR;
		};
		// Propertiesで指定した値を取得
		float4 _MainColor;
		// エントリポイント
		void surf (Input IN, inout SurfaceOutput o) {
			// 反射の割合 青と緑は半分反射
			o.Albedo = _MainColor.rgb * half3(1, 0.5, 0.5);
			// 半透明
			o.Alpha = 0.5;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
