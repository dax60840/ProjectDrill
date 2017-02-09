using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Resource : MonoBehaviour {

	void OnTriggerEnter2D(Collider2D col)
    {
        if(col.tag == "Player")
        {
            transform.DOScale(0f, 0.2f).OnComplete(()=> Destroy(gameObject));
        }
    }
}
