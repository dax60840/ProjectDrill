using UnityEngine;
using System.Collections;
using DG.Tweening;

public class Enemy_Behavior_1 : MonoBehaviour {
    
    public Enemy_Forward_1 forward;
    public float moveSpeed;
    public float rotationTime;
    public float scaleAmplitude;
    public float scaleTime;
    bool waiting;
    bool scaleEnd;

	// Use this for initialization
	void Start () {
        waiting = false;
        scaleEnd = true;
	}
	
	// Update is called once per frame
	void Update () {

        if (forward.Out)
        {
            if (!waiting)
            {
                Vector3 direction = new Vector3(0f, 0f, Random.Range(transform.rotation.eulerAngles.z + 110f, transform.rotation.eulerAngles.z + 250f));
                waiting = true;
                transform.DORotate(direction, rotationTime).OnComplete(() => { waiting = false;});
            }
        }
        else
        {
            transform.position += transform.right * Time.deltaTime * moveSpeed;
        }

        if (scaleEnd)
        {
            scaleEnd = false;
            scaleMonster();
        }
	}

    void scaleMonster()
    {
        transform.DOScale(transform.localScale.x + scaleAmplitude, scaleTime).OnComplete(
            () => transform.DOScale(transform.localScale.x - scaleAmplitude, scaleTime).OnComplete(
                () => scaleEnd = true
                )
            );
    }

    void OnCollisionEnter2D(Collision2D col)
    {
        if(col.transform.tag == "Player")
        {
            waiting = true;
            scaleEnd = false;
            transform.DOScale(0f, 0.2f).OnComplete(() => Destroy(gameObject));
        }
    }
}
