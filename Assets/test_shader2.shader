Shader "Custom/test_shader2" {
	SubShader {
		Pass {
			// GLSLシェーダ
			GLSLPROGRAM

			#ifdef VERTEX
			void main()
			{
				gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
			}
			#endif

			#ifdef FRAGMENT
			uniform vec4 _SinTime;
			void main()
			{
				gl_FragColor = _SinTime;
			}
			#endif

			ENDGLSL
		}
	}
}

