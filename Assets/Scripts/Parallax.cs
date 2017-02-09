using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class Parallax : MonoBehaviour {

    public List<Transform> bgLayers;
    public float layerOffset;
    public float parallaxSpeed;

    public void SetDirection(Vector3 v, float playerSpeed)
    {
        for(int i = 0; i< bgLayers.Count; i++)
        {
            bgLayers[i].DOLocalMove(-(layerOffset * i * v), parallaxSpeed * playerSpeed);
        }
    }
}
