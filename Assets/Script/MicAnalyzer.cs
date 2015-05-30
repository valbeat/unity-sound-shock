using UnityEngine;
using System.Collections;

// 空のAudio Sourceをアタッチ
[RequireComponent (typeof (AudioSource))]
public class MicAnalyzer : MonoBehaviour {
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

	// レンジでコントロールできるようにする
	[Range(0,0.95f)]
	public float lastLoudnessInfluence;

	private AudioSource audio;

	// マテリアル
	private Material mat;

	public int resolution = 1024;
	public float lowFreqThreshold = 14700, midFreqThreshold = 29400, highFreqThreshold = 44100;
	public float lowEnhance = 1f, midEnhance = 10f, highEnhance = 100f;

	// Use this for initialization
	void Start () {
		// マテリアルの作成
		mat = GetComponent<Renderer>().material;
		// 空のAudio Sourceを取得
		audio = GetComponent<AudioSource>();
		// Audio Source の Audio Clipをマイク入力に設定
		audio.clip = Microphone.Start(null, true, 10, 44100);

		// 無音状態でずっと再生しておく
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
		AnalyzeSpectrum();
	}
	// 現フレームの音量を計算
	void CalcLoudness() {
		lastLoudness = loudness;
		loudness = GetAveragedVolume() * sensitivity * (1 - lastLoudnessInfluence ) + lastLoudness * lastLoudnessInfluence;

		// ボリューム
		mat.SetFloat("_Loudness", loudness);
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
	void AnalyzeSpectrum() {
		var spectrum = audio.GetSpectrumData(resolution, 0, FFTWindow.BlackmanHarris);
		var deltaFreq = AudioSettings.outputSampleRate / resolution;
		float low = 0f, mid = 0f, high = 0f;

		for (var i = 0; i < resolution; ++i) {
			var freq = deltaFreq * i;
			if (freq <= lowFreqThreshold) {
				low += spectrum[i];
			}
			else if (freq <= midFreqThreshold) {
				mid += spectrum[i];
			}
			else if (freq <= highFreqThreshold) {
				high += spectrum[i];
			}
		}

		low  *= lowEnhance;
		mid  *= midEnhance;
		high *= highEnhance;
		// ボリューム
		mat.SetFloat("_LowSpectrum", low);
		mat.SetFloat("_MidSpectrum", mid);
		mat.SetFloat("_HighSpectrum", high);
	}
}
