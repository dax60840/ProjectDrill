using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ProceduralField : MonoBehaviour {

    public List<GameObject> AsteroidList;

    public int width;
    public int height;
    public float xOrg;
    public float yOrg;
    public float scale = 1.0F;
    public float ceil = 0.8f;
    public float scaleRange = 0.1f;

    void Start()
    {
        Generate();
    }

    void Generate()
    {
        float y = 0.0F;
        while (y < height)
        {
            float x = 0.0F;
            while (x < width)
            {
                float xCoord = xOrg + x / width * scale;
                float yCoord = yOrg + y / height * scale;
                float sample = Mathf.PerlinNoise(xCoord, yCoord);
                if(sample > ceil)
                {
                    int index = (int)Mathf.Round(Random.Range(0, AsteroidList.Count));
                    GameObject temp = Instantiate(AsteroidList[index].gameObject);
                    temp.transform.parent = transform;
                    temp.transform.position = new Vector3(x, y, 0.1f);
                    float rand = Random.Range(-scaleRange, scaleRange);
                    temp.transform.localScale = new Vector3(temp.transform.localScale.x + rand, temp.transform.localScale.y + rand, temp.transform.localScale.z);
                }
                x++;
            }
            y++;
        }
    }

    void Update()
    {

    }
}
