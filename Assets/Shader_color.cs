using UnityEngine;
using System.Collections;



public class Shader_color : MonoBehaviour {
  public Material mat;
  public Color color = new Color (1.0f,1.0f,0.0f,1.0f);
	// Use this for initialization
	void Start () {
	}

	// Update is called once per frame
	void Update () {
		if (Input.GetKey(KeyCode.Space)) {
    	// renderer.material.SetColor("_MyColor", Color (1,1,1,1));
      mat.SetColor("_MyColor", color);
		}
	}
}
