Shader "Custom/test2" {
	Properties {
		// インスペクタに表示される
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		// レンダリングの指定
		Tags { "RenderType" = "Opaque"}
		CGPROGRAM
		// surfaceシェーダを指定 SurfaceFanction LightModel alphaブレンディング
		#pragma surface surf Lambert alpha
		// UV(テクスチャ)座標が渡ってくる
		struct Input {
			// uvプレフィックスをつけた変数を宣言
			float2 uv_MainTex;
		};
		// Propertiesで指定した値を取得
		sampler2D _MainTex;
		// エントリポイント
		void surf (Input IN, inout SurfaceOutput o) {
			// 反射の割合 青と緑は半分反射
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
			// 半透明
			o.Alpha = 0.5;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
