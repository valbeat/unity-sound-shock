Shader "Custom/TextureCoordinates/UV" {
    SubShader {
        Pass {
            CGPROGRAM
            // UnityCG.cgincで定義された頂点シェーダ
            #pragma vertex vert_img
            #pragma fragment frag

            #include "UnityCG.cginc"
            // vert_imgから渡ってきたv2f_img
            float4 frag(v2f_img i) : COLOR {
                return float4(1.0,i.uv, 1.0);
            }
            ENDCG
        }
    }
}
