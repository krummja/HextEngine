using UnityEngine;
using System.Collections;
using System.Collections.Generic;

using Simulacrum.Hext;
using Simulacrum.Hext.Geom;

namespace Game
{
    using Rect = Simulacrum.Hext.Geom.Rect;

    public class Entity
    {
        public string glyph;
        public float x;
        public float y;

        public Entity(string glyph, float x, float y)
        {
            this.glyph = glyph;
            this.x = x;
            this.y = y;
        }
    }

    public class Game : MonoBehaviour, IClickAction, IHoverAction
    {
        public void OnMouseDown()
        {

        }

        public void OnHoverEnter()
        {

        }

        public void OnHoverExit()
        {

        }

        private void Awake()
        {
            Cursor.visible = false;
        }

        private IEnumerator Start()
        {
            while ( !Console.IsInitialized )
            {
                yield return null;
            }

            int LAYER = 1;

            Console.Print("Hello, World!", LAYER, new Point(1, 10), Color.clear, Color.magenta);

            Rect r1 = Rect.CenteredAt(new Point(30, 30), new Size(8, 8));
            foreach ( Point p in r1.IterPoints() )
            {
                Cell cell = Console.CellAt(1, p.x, p.y);
                cell.SetContent("/", Color.clear, Color.green);
            }
        }

        public IEnumerator RandomGrid(){

            // fill random cells every frame on layer 1
            while (Application.isPlaying) {
                for (int i = 0; i < 50; i++) {
                    Cell cell = Console.CellAt(
                        1,
                        Random.Range(17, Console.DisplayWidth),
                        Random.Range(0, Console.DisplayHeight));

                    // random color and alpha
                    Color color = Color.Lerp(Color.yellow, Color.green, Random.Range(0f, 1f));
                    color = new Color(color.r, color.g, color.b, Random.Range(0f, 1f));

                    cell.SetContent(
                        Random.Range(0, 10) + "",
                        Color.clear,
                        color);
                }

                yield return null;
            }
        }
    }
}
