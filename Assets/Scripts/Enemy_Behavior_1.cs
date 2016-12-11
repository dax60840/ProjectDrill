using UnityEngine;
using System.Collections;
using DG.Tweening;

public class Enemy_Behavior_1 : MonoBehaviour {
    
    public Enemy_Forward_1 forward;
    public float moveSpeed;
    public float rotationSpeed;
    bool waiting;

	// Use this for initialization
	void Start () {
        waiting = false;
	}
	
	// Update is called once per frame
	void Update () {

        if (forward.Out)
        {
            if (!waiting)
            {
                Vector3 direction = new Vector3(0f, 0f, Random.Range(transform.rotation.eulerAngles.z + 110f, transform.rotation.eulerAngles.z + 250f));
                waiting = true;
                transform.DORotate(direction, rotationSpeed).OnComplete(() => { waiting = false;});
            }
        }
        else
        {
            transform.position += transform.right * Time.deltaTime * moveSpeed;
        }

	    
	}
}
