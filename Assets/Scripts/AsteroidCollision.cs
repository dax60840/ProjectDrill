using UnityEngine;
using System.Collections;
using DG.Tweening;

public class AsteroidCollision : MonoBehaviour
{
    public GameObject exitParticleSystem;
    public float FadeTime = 0.2f;
    GameObject TopLayer;
    GameObject InnerLayer;
    Eraser eraser;
    MeshRenderer rend;
    float opacity = 1.0f;

    void Start()
    {
        TopLayer = transform.GetChild(0).gameObject;
        rend = TopLayer.GetComponent<MeshRenderer>();
        InnerLayer = transform.GetChild(1).gameObject;
        eraser = InnerLayer.GetComponent<Eraser>();
    }

    void Update()
    {

    }

    void OnTriggerEnter2D(Collider2D col)
    {
        DOTween.To(value => opacity = value, 1, 0, FadeTime).OnUpdate(() => { rend.material.SetFloat("_Opacity", opacity); });
    }

    void OnTriggerStay2D(Collider2D col)
    {
        eraser.Erase(col.gameObject);
    }

    void OnTriggerExit2D(Collider2D col)
    {
        Vector3 direction = col.transform.position - transform.position;
        Instantiate(exitParticleSystem, col.transform.position, Quaternion.LookRotation(direction));

        DOTween.To(value => opacity = value, 0, 1, FadeTime).OnUpdate(() => { rend.material.SetFloat("_Opacity", opacity); });
    }
}
