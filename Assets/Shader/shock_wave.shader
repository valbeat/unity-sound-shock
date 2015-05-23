Shader "Custom/shock_wave" {
	Properties {
	}
	SubShader {
		Pass {
			// GLSLシェーダ
			GLSLPROGRAM

			#ifdef VERTEX
			void main()
			{
				//頂点の設定
				// gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
				gl_Position = ftransform();
				gl_TexCoord[0] = gl_MultiTexCoord0;
			}
			#endif

			#ifdef FRAGMENT
			uniform sampler2D sceneTex;
			uniform vec2 center;
			uniform float time;
			uniform vec3 shockParams;
			void main()
			{
				vec2 uv = gl_TexCoord[0].xy;
				vec2 texCoord = uv;
				float distance = distance(uv, center);
				if ((distance <= (time + shockParams.z)) && (distance >= (time - shockParams.z))) {
					float diff = (distance - time);
					float powDiff = 1.0 - pow(abs(diff * shockParams.x), shockParams.y);
					float diffTime = diff * powDiff;
					vec2 diffUV = normalize(uv - center);
					texCoord = uv + (diffUV * diffTime);
				}
				gl_FlagColor = texture2D(sceneTex, texCoord);
			}
			#endif

			ENDGLSL
		}
	}
}

