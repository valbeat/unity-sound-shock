using UnityEngine;
using System.Collections;

public class Shader_color : MonoBehaviour {
  // 色を指定
  public Color color1 = new Color (0.0f,0.0f,1.0f,1.0f);
  public Color color2 = new Color (1.0f,0.0f,0.0f,1.0f);

  Material mat;
  // Use this for initialization
  void Start () {
    mat = GetComponent<Renderer>().material;
    StartCoroutine(BlinkerCoroutine());
  }

	// Update is called once per frame
	void Update () {
  }

  IEnumerator BlinkerCoroutine() {
    var original_mat = new Material(mat);
    for(;;){
      mat.EnableKeyword("_EMISSION");
      mat.SetColor("_EmissionColor", color1);
      yield return new WaitForSeconds(1.0f);
      mat.SetColor("_EmissionColor", color2);
      yield return new WaitForSeconds(1.0f);
    }
  }
}
