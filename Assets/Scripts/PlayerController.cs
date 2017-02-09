using UnityEngine;
using System.Collections;
using DG.Tweening;
using System.Collections.Generic;

public class PlayerController : MonoBehaviour {

    public GameObject drill3D;
    public GameObject drillLights;
    public ParticleSystem burst;
    public ParticleSystem straffLeft;
    public ParticleSystem straffRight;
    public GameObject backRocket;
    public Parallax para;
    public float drillSpeed = 5f;
    public float initialSpeed = 5f;
    public float rotationSpeed = 5f;
    public float burstForce = 50f;
    public float strafeRange = 1f;
    public float strafeSpeed = 5f;
    public float insideLightValue;
    public float outsideLightValue;
    public float transitionLightValue;
    public float drillRotationSpeed;

    List<Light> listLight;
    Rigidbody2D rb2D;
    Vector2 direction;
    Vector2 velocity;
    bool drilling;
    bool straffing;

    void Start()
    {
        direction = Vector2.right;
        velocity = direction * initialSpeed;
        drilling = false;
        straffing = false;
        rb2D = GetComponent<Rigidbody2D>();

        listLight = new List<Light>();
        for(int i = 0; i< drillLights.transform.childCount; i++)
        {
            listLight.Add(drillLights.transform.GetChild(i).GetComponent<Light>());
        }
    }

    void FixedUpdate()
    {
        rb2D.MovePosition(rb2D.position + velocity * Time.fixedDeltaTime);
    }

    void Update()
    {
        drill3D.transform.Rotate(new Vector3(0, 0, drillRotationSpeed * Time.deltaTime));

        if (drilling)
        {
            velocity = direction * drillSpeed;
            para.SetDirection(direction, velocity.magnitude);
        }

        if (Input.GetAxis("Horizontal") != 0)
        {

            Quaternion rot = transform.rotation;

            float z = rot.eulerAngles.z;

            z -= Input.GetAxis("Horizontal") * rotationSpeed * Time.deltaTime;

            rot = Quaternion.Euler(0, 0, z);

            transform.rotation = rot;

            direction = transform.rotation * Vector2.up;
            
            backRocket.transform.DORotate(transform.rotation.eulerAngles, 0.6f);
        }

        if (Input.GetButtonDown("Burst"))
        {
            velocity = direction * burstForce;
            para.SetDirection(direction, velocity.magnitude);
            burst.Emit(30);
        }

        
        if(Input.GetButtonDown("Strafe Right") && !drilling && !straffing)
        {
            velocity += new Vector2 (direction.y, -direction.x) * strafeRange;
            straffRight.Emit(30);
            StartCoroutine(StraffCoroutine(false));
        }

        if(Input.GetButtonDown("Strafe Left") && !drilling && !straffing)
        {
            velocity += new Vector2(-direction.y, direction.x) * strafeRange;
            straffLeft.Emit(30);
            StartCoroutine(StraffCoroutine(true));
        }
        
    }

    void OnTriggerEnter2D(Collider2D col)
    {
        if (col.transform.name.Contains("Asteroid"))
        {
            drilling = true;
            foreach(Light l in listLight)
            {
                DOTween.To(() => l.intensity, (x) => l.intensity = x, insideLightValue, transitionLightValue);
            }
        }
    }

    void OnTriggerExit2D(Collider2D col)
    {
        if (col.transform.name.Contains("Asteroid"))
        {
            drilling = false;
            velocity = direction * initialSpeed;
        }
    }

    public void LightOn()
    {
            foreach (Light l in listLight)
            {
                DOTween.To(() => l.intensity, (x) => l.intensity = x, outsideLightValue, transitionLightValue);
            }
    }

    IEnumerator StraffCoroutine(bool left)
    {
        straffing = true;
        yield return new WaitForSeconds(strafeSpeed);
        if(!left)
            velocity -= new Vector2(direction.y, -direction.x) * strafeRange;
        else
            velocity -= new Vector2(-direction.y, direction.x) * strafeRange;
        straffing = false;
    }
}
