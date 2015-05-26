using UnityEngine;
using System.Collections;

// 空のAudio Sourceを作成
[RequireComponent (typeof (AudioSource))]
public class MicrophoneSource : MonoBehaviour {
  // 現在の音量を読み取る
  public float GetLoundness() {
    return loudness;
  }
  // 感度
  public float sensitivity = 100;
  // 音量
  float loudness;
  // 前フレームの音量
  float lastLoudness;

  [Range(0,0.95f)]
  public float lastLoudnessInfluence;

	// Use this for initialization
	void Start () {
    // 空のAudio Sourceを取得
    var audio = GetComponent<AudioSource>();
    // Audio Source の Audio Clipをマイク入力に設定
    audio.clip = Microphone.Start(null, false, 10, 44100);

    audio.loop = true;
    audio.mute = true;

    // マイクがReady状態になるまで待機
    while (Microphone.GetPosition(null) <= 0) {}
    // 再生開始
    audio.Play();
	}

	// Update is called once per frame
	void Update () {
    CalcLoudness();
	}
  // 現フレームの音量を計算
  void CalcLoudness() {
    lastLoudness = loudness;
    loudness = GetAveragedVolume() * sensitivity * (1 - lastLoudnessInfluence ) + lastLoudness * lastLoudnessInfluence;
  }
  // 現フレームのAudioClipから平均的な音量を取得
  float GetAveragedVolume() {
    int sampleData = 256;
    float[] data = new float[sampleData];
    float _audio = 0;
    GetComponent<AudioSource>().GetOutputData(data, 0);
    foreach( float d in data) {
      _audio += Mathf.Abs(d);
    }
    return _audio / sampleData;
  }
}
