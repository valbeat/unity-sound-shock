using UnityEngine;
using System.Collections;

public class Shader_color : MonoBehaviour {
  // 色を指定
  public Color color = new Color (1.0f,1.0f,1.0f,1.0f);
	Material mat;
  // Use this for initialization
  void Start () {
    mat = GetComponent<Renderer>().material;
	}

	// Update is called once per frame
	void Update () {
    mat.SetColor("_MyColor", color);
  }
}
