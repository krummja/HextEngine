using UnityEngine;
using System.Collections;

namespace Simulacrum.Hext.Geom
{
    public class Span : Shape
    {
        public static Span operator +(Span a, int n)
        {
            Point start = a.Start + n;
            Point end = a.End + n;
            return new Span(start, end);
        }

        public static Span operator -(Span a, int n)
        {
            Point start = a.Start - n;
            Point end = a.End - n;
            return new Span(start, end);
        }

        public Span(Point start, Point end)
        {
            this.x = Mathf.Floor((start.x + end.x) / 2);
            this.y = Mathf.Floor((start.y + end.y) / 2);
            this.w = Mathf.Abs(end.x - start.x);
            this.h = Mathf.Abs(end.y - start.y);

            if ( this.w > this.h )
            {
                this.Start = new Point(start.x, this.y);
                this.End = new Point(end.x, this.y);
                this.Length = this.End.x - this.Start.x;
            }
            else
            {
                this.Start = new Point(this.x, start.y);
                this.End = new Point(this.x, end.y);
                this.Length = this.End.y - this.Start.y;
            }

            _points = new Point[Mathf.FloorToInt(this.Length)];

            for ( int i = 0; i < this.Length; i++ )
            {
                if ( this.w > this.h ) _points[i] = new Point(this.Start.x + i, this.Start.y);
                else _points[i] = new Point(this.Start.x, this.Start.y + i);
            }
        }

        public Point Start { get; private set; }

        public Point End { get; private set; }

        public Span Floored => new Span(this.Start.Floored, this.End.Floored);

        public float Length { get; private set; }

        public bool Overlaps(Span other)
        {
            return this.Start <= other.End & this.End >= other.Start;
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
