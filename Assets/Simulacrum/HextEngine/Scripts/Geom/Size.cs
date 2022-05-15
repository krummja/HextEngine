using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Simulacrum.Hext.Geom
{
    public class Size : Shape
    {
        public static Size operator +(Size a, int n) => new Size(a.Width + n, a.Width + n);
        public static float operator +(Size a, Size b) => a.Area + b.Area;

        public static Size operator -(Size a, int n) => new Size(a.Width - n, a.Width - n);
        public static float operator -(Size a, Size b) => a.Area - b.Area;

        public Size(float width, float height)
        {
            this.Width = width;
            this.Height = height;

            this.x = 0;
            this.y = 0;
        }

        public float Width { get; private set; }

        public float Height { get; private set; }

        public float Area => this.Width * this.Height;

        public Size Floored
        {
            get
            {
                Size _floored = new Size(
                    Mathf.Floor(this.Width),
                    Mathf.Floor(this.Height)
                );

                return _floored;
            }
        }

        public override IEnumerator GetEnumerator()
        {
            foreach ( Point p in _points )
            {
                yield return p;
            }
        }
    }
}
