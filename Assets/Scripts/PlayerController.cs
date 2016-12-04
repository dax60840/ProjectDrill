using UnityEngine;
using System.Collections;

public class PlayerController : MonoBehaviour {

    public float drillSpeed = 5f;
    public float initialSpeed = 5f;
    public float rotationSpeed = 5f;
    public float burstForce = 50f;

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
        rb2D.MovePosition(rb2D.position + velocity);
    }

    void Update()
    {
        if (drilling)
            velocity = direction * drillSpeed;

        transform.position = (rb2D.position + velocity * Time.smoothDeltaTime);

        //if (!Input.anyKey) return;

        Quaternion rot = transform.rotation;
        
        float z = rot.eulerAngles.z;
        
        z -= Input.GetAxis("Horizontal") * rotationSpeed * Time.deltaTime;
        
        rot = Quaternion.Euler(0, 0, z);
        
        transform.rotation = rot;

        direction = transform.rotation * Vector2.up;

        if (Input.GetKeyDown(KeyCode.Space) || Input.GetButtonDown("Fire1"))
        {
            velocity = direction * burstForce;
        }
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
