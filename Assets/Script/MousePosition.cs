using UnityEngine;
using System.Collections;

public class MousePosition : MonoBehaviour {
  Material mat;
	// Use this for initialization
	void Start () {
    mat = GetComponent<Renderer>().material;
	}

	// Update is called once per frame
	void Update () {
    Vector3 mpos = Input.mousePosition;
    mat.SetVector("_MousePosition", mpos);
	}
}
