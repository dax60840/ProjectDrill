using UnityEngine;
using System.Collections;

public class CameraController : MonoBehaviour {

    public Transform myTarget;
    public float smoothTime = 0.3F;
    private Vector3 velocity = Vector3.zero;

    // Update is called once per frame
    void FixedUpdate()
    {
        if (myTarget != null)
        {
            Vector3 targPos = myTarget.position;
            targPos.z = transform.position.z;
            
            transform.position = Vector3.SmoothDamp(transform.position, targPos, ref velocity, smoothTime);
        }
    }
}
