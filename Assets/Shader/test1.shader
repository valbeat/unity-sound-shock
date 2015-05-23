Shader "Custom/TestFixedFunctionShader" {
	Properties {
    _Color ("Main Color", Color) = (1,1,1,0)
    _SpecColor ("Spec Color", Color) = (1,1,1,1)
    _Emission ("Emmisive Color", Color) = (0,0,0,0)
    _Shininess ("Shininess", Range (0.01, 1)) = 0.5
    _MainTex ("Base (RGB)", 2D) = "gray" {}
	}
	SubShader {
		Pass {
			Material {
        // 方向を考えない環境光
        Ambient [_Color]
				// 拡散光 方向を考える (ベースカラー)
        Diffuse [_Color]
        // 反射 金属っぽい
        Specular [_SpecColor]
        // 発行する
        Emission [_Emission]
        // 反射面の大きさ
        Shininess [_Shininess]
			}
			Lighting On
			SeparateSpecular On
			SetTexture [_MainTex] {
				Combine texture * primary DOUBLE, texture * primary
			}
		}
	}
	FallBack "Diffuse"
}
