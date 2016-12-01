using UnityEngine;
using System.Collections;

public class LevelManager : MonoBehaviour {

    public GameObject Asteroid;

	// Use this for initialization
	void Start () {
        GameObject temp = Instantiate(Asteroid);
        temp.transform.position = Vector3.zero;
    }
	
	// Update is called once per frame
	void Update () {
	
	}
}
