using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Simulacrum.Hext.Geom
{

    public class Rect : Shape
    {
        public static Rect FromEdges(float top, float bottom, float left, float right)
        {
            return new Rect(
                new Point(left, top),
                new Size(right - left + 1f, bottom - top + 1f)
            );
        }

        public static Rect FromSpans(Span vertical, Span horizontal)
        {
            return Rect.FromEdges(
                vertical.Start.y, vertical.End.y,
                horizontal.Start.x, horizontal.End.x
            );
        }

        public static Rect CenteredAt(Point center, Size size)
        {
            float left = center.x - size.Width / 2;
            float top = center.y - size.Height / 2;
            return new Rect(
                new Point(left, top),
                size
            );
        }

        public Rect(Point origin, Size size)
        {
            this.Origin = origin;
            this.Size = size;

            this.x = origin.x;
            this.y = origin.y;
            this.w = size.Width;
            this.h = size.Height;
        }

        public Point Origin { get; private set; }

        public Size Size { get; private set; }

        public float Top => this.Origin.y;
        public float Bottom => this.Origin.y + this.Size.Height;
        public float Left => this.Origin.x;
        public float Right => this.Origin.x + this.Size.Width;

        public float Width => this.Size.Width;
        public float Height => this.Size.Height;

        public float x2 => this.Origin.x + this.Size.Width - 1;
        public float y2 => this.Origin.y + this.Size.Height - 1;

        public float Area => this.Size.Area;

        public Rect Floored => new Rect(this.Origin.Floored, this.Size.Floored);

        public IEnumerable<Point> PointsTop()
        {
            int start = Mathf.RoundToInt(this.Origin.x + 1);
            int end = Mathf.RoundToInt(this.Origin.x + this.Size.Width - 1);
            for ( int x = start; x < end; x++ )
            {
                Point p = new Point(x, this.Origin.y);
                yield return p;
            }
        }

        public IEnumerable<Point> PointsBottom()
        {
            int start = Mathf.RoundToInt(this.Origin.x + 1);
            int end = Mathf.RoundToInt(this.Origin.x + this.Size.Width - 1);
            for (int x = start; x < end; x++)
            {
                yield return new Point(x, Mathf.RoundToInt(this.Bottom - 1));
            }
        }

        public IEnumerable<Point> PointsLeft()
        {
            int start = Mathf.RoundToInt(this.Origin.y + 1);
            int end = Mathf.RoundToInt(this.Origin.y + this.Size.Height - 1);
            for (int y = start; y < end; y++)
            {
                yield return new Point(this.Origin.x, y);
            }
        }

        public IEnumerable<Point> PointsRight()
        {
            int start = Mathf.RoundToInt(this.Origin.y + 1);
            int end = Mathf.RoundToInt(this.Origin.y + this.Size.Height - 1);
            for (int y = start; y < end; y++)
            {
                yield return new Point(Mathf.RoundToInt(this.Right - 1), y);
            }
        }

        public IEnumerable<Point> PointsCorners()
        {
            yield return this.Origin;
            yield return new Point(this.Origin.x + this.Size.Width - 1, this.Origin.y);
            yield return this.Origin + this.Size - new Point(1, 1);
            yield return new Point(this.Origin.x, Mathf.RoundToInt(this.Origin.y + this.Size.Height - 1));
        }

        public IEnumerable<Point> IterPoints()
        {
            foreach ( Point p in this.PointsTop() ) yield return p;
            foreach ( Point p in this.PointsBottom() ) yield return p;
            foreach ( Point p in this.PointsLeft() ) yield return p;
            foreach ( Point p in this.PointsRight() ) yield return p;
            foreach ( Point p in this.PointsCorners() ) yield return p;
        }

        public override IEnumerator GetEnumerator()
        {
            foreach ( Point p in _points )
            {
                yield return p;
            }
        }

        public Rect WithOrigin(Point newOrigin)
        {
            return new Rect(newOrigin, this.Size);
        }

        public Rect WithSize(Size newSize)
        {
            return new Rect(this.Origin, newSize);
        }
    }
}
