// シェーダーの名前
Shader "Custom/test_shader" {
	// Unity側からシェーダーに渡したい値を宣言
	Properties {
		// 変数名 ("inspectorに表示される名前", 型) = 初期値
		_Rabge( "Range", Range(0.0, 1.0) ) = 0.5
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
    _Tex ("2D", 2D) = "white" {}
    _TexRect ("Rect", Rect) = "white" {}
    _TexCube ("Cube", Cube) = "white" {}
    _Float("Float", Float) = 20.0
    _Vector("Vector", Vector) = (0, 0, 0, 0)
	}
	// シェーダ本体を記述
	SubShader {
		Pass {
			CGPROGRAM
			// vertexシェーダ用関数
			#pragma vertex vert
			// fragmentシェーダ関数
			#pragma fragment frag

			uniform float4 _Color;

			// 入力用構造体
			struct VertexInput{
				float4 vertex : POSITION;
			};

			// 出力用構造体
			struct VertexOutput {
				float4 pos : SV_POSITION;
			};

			// 出力用構造体を返す関数
			VertexOutput vert(VertexInput v) {
				VertexOutput o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}

			// flagmentシェーダ
			float4 flag(VertexOutput i) : COLOR {
				return _Color;
			}
			ENDCG
		}
	}
	// 全てのシェーダが動かない時、確実に動くようにする
	FallBack "Diffuse"
}
