using UnityEngine;
using System.Collections;
using DG.Tweening;

public class PlayerController : MonoBehaviour {

    public GameObject backRocket;
    public float drillSpeed = 5f;
    public float initialSpeed = 5f;
    public float rotationSpeed = 5f;
    public float burstForce = 50f;
    public float strafeRange = 1f;
    public float strafeSpeed = 5f;

    Rigidbody2D rb2D;
    Vector2 direction;
    Vector2 velocity;
    bool drilling;

    void Start()
    {
        direction = Vector2.right;
        velocity = direction * initialSpeed;
        drilling = false;
        rb2D = GetComponent<Rigidbody2D>();
    }

    void FixedUpdate()
    {
        rb2D.MovePosition(rb2D.position + velocity * Time.fixedDeltaTime);
    }

    void Update()
    {
        if (drilling)
            velocity = direction * drillSpeed;

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
        }

        /*
        if(Input.GetButtonDown("Strafe Right"))
        {
            velocity += new Vector2 (direction.y, -direction.x) * strafeRange;
            //delay = straffSpeed
            velocity -= new Vector2(direction.y, -direction.x) * strafeRange;
        }

        if(Input.GetButtonDown("Strafe Left"))
        {
            velocity += new Vector2(-direction.y, direction.x) * strafeRange;
            //delay = straffSpeed
            velocity -= new Vector2(-direction.y, direction.x) * strafeRange;
        }
        */
    }

    void OnTriggerEnter2D(Collider2D col)
    {
        if (col.transform.name.Contains("Asteroid"))
        {
            drilling = true;
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
}
