Shader "Custom/test_shader2" {
   Properties {
      _MyColor ("Color", Color) = (1.0, 0.0, 0.0, 1.0)
   }
	SubShader {
		Pass {
			// GLSLシェーダ
			GLSLPROGRAM

			#ifdef VERTEX
			void main()
			{
				//頂点の設定
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
			}
			#endif

			#ifdef FRAGMENT
			uniform vec4 _SinTime;
			uniform vec4 _MyColor;
			void main()
			{
				// gl_FragColor = _SinTime;
				gl_FragColor = _MyColor;
			}
			#endif

			ENDGLSL
		}
	}
}

