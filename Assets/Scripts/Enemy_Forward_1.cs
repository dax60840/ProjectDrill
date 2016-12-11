using UnityEngine;
using System.Collections;

public class Enemy_Forward_1 : MonoBehaviour {

    public bool Out;

	// Use this for initialization
	void Start () {
	    
	}

    void Update()
    {

    }

    void OnTriggerEnter2D(Collider2D col)
    {
        if(col.gameObject.name.Contains("Asteroid"))
            Out = false;
    }

    void OnTriggerExit2D(Collider2D col)
    {
        if (col.gameObject.name.Contains("Asteroid"))
            Out = true;
    }
}