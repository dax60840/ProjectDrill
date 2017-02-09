using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrillTop : MonoBehaviour {

    PlayerController pc;

    void Start()
    {
        pc = transform.parent.GetComponent<PlayerController>();
    }

    void OnTriggerExit2D(Collider2D col)
    {
        pc.LightOn();
    }
}
