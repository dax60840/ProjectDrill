using UnityEngine;
using System.Collections;

public class Eraser : MonoBehaviour
{
    Texture2D texture;
    Renderer render;
    Vector2 scale;
    Rigidbody2D rb2D;
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
        if (rb2D == null)
            SetRB(player);

        RaycastHit hit;
        Physics.Raycast(rb2D.position, Vector3.forward, out hit);
        Texture2D tex = texture;
        var pixelUV = hit.textureCoord;
        pixelUV.x *= tex.width;
        pixelUV.y *= tex.height;
        
        tex.SetPixel((int)pixelUV.x, (int)pixelUV.y, Color.black);
        tex.Apply();
    }

    void SetRB(GameObject player)
    {
        rb2D = player.GetComponent<Rigidbody2D>();
    }
}