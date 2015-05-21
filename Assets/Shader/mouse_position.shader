Shader "Custom/mouse_position" {
  Properties {
    _MainTex ("Texture", 2D) = "white" {}
  }
  SubShader {
    Tags { "RenderType" = "Opaque" }
    CGPROGRAM
    #pragma surface surf Lambert vertex:vert
    struct Input {
        float2 uv_MainTex;
    };
    float4 _MousePosition;
    void vert (inout appdata_full v) {
        v.vertex.x += _SinTime.w * _MousePosition.x * 0.02;
    }
    sampler2D _MainTex;
    void surf (Input IN, inout SurfaceOutput o) {
        o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
    }
    ENDCG
	}
}

