using UnityEngine;
using System.Collections;

public class Eraser : MonoBehaviour
{
    Texture2D texture;
    Renderer render;
    Vector2 scale;
    int res;

    void Start()
    {
        scale = new Vector2(Mathf.Round(16 * transform.parent.localScale.x), Mathf.Round(16 * transform.parent.localScale.y));
        render = GetComponent<Renderer>();
        texture = new Texture2D((int)scale.x, (int)scale.y);
        // set texture in the inspector slot
        render.material.SetTexture("_SliceGuide", texture);

        // Fill the texture with white (you could also paint it black, then draw with white)
        for (int y = 0; y < texture.height; ++y)
        {
            for (int x = 0; x < texture.width; ++x)
            {
               texture.SetPixel(x, y, Color.white);
            }
        }
        // Apply all SetPixel calls
        texture.Apply();

    }

    public void Erase(GameObject player)
    {
        RaycastHit hit;
        Physics.Raycast(player.transform.position, Vector3.forward, out hit);
        Texture2D tex = texture;
        var pixelUV = hit.textureCoord;
        pixelUV.x *= tex.width;
        pixelUV.y *= tex.height;
        
        tex.SetPixel((int)pixelUV.x, (int)pixelUV.y, Color.black);
        tex.Apply();
    }
}


    /*
    // Update is called once per frame
    void Update()
    {

        if (Input.touchCount == 0 && !Input.anyKey) return;

        // Only if we hit something, do we continue
        RaycastHit hit;
        if (!Physics.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector3.forward, out hit)) return;

        // Just in case, also make sure the collider also has a renderer
        // material and texture. Also we should ignore primitive colliders.
        Renderer rend = hit.collider.GetComponent<Renderer>();
        var meshCollider = hit.collider as MeshCollider;
        if (rend == null || rend.sharedMaterial == null || texture == null || meshCollider == null) return;

        // Now draw a pixel where we hit the object
        Texture2D tex = texture;
        var pixelUV = hit.textureCoord;
        pixelUV.x *= tex.width;
        pixelUV.y *= tex.height;

        // add black spot, which is then transparent in the shader
        tex.SetPixel((int)pixelUV.x, (int)pixelUV.y, Color.black);
        tex.Apply();
    }*/