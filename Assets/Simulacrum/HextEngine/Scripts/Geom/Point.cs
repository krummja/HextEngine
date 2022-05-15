using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Simulacrum.Hext.Geom
{
    public class Point : Shape
    {
        // ADDITION
        public static Point operator +(Point a, int n) => new Point(a.x + n, a.y + n);
        public static Point operator +(Point a, Point b) => new Point(a.x + b.x, a.y + b.y);
        public static Point operator +(Point a, Size b) => new Point(a.x + b.Width, a.y + b.Height);

        // SUBTRACTION
        public static Point operator -(Point a, int n) => new Point(a.x - n, a.y - n);
        public static Point operator -(Point a, Point b) => new Point(a.x - b.x, a.y - b.y);
        public static Point operator -(Point a, Size b) => new Point(a.x - b.Width, a.y - b.Height);

        // MULTIPLICATION
        public static Point operator *(Point a, Point b) => new Point(a.x * b.x, a.y * b.y);

        // DIVISION
        public static Point operator /(Point a, Point b)
        {
            if ( b.x == 0 || b.y == 0 )
            {
                throw new DivideByZeroException();
            }

            int _a = Mathf.RoundToInt(a.x / b.x);
            int _b = Mathf.RoundToInt(a.y / b.y);
            return new Point(_a, _b);
        }

        // COMPARISON
        public static bool operator <(Point a, Point b) =>  a.x < b.x & a.y < b.y;
        public static bool operator >(Point a, Point b) => a.x > b.x & a.y > b.y;

        public static bool operator <=(Point a, Point b) => a.x <= b.x & a.y <= b.y;
        public static bool operator >=(Point a, Point b) => a.x >= b.x & a.y >= b.y;

        /// <summary>
        /// A representation of a Point.
        /// </summary>
        /// <param name="x">The x coordinate of the Point.</param>
        /// <param name="y">The y coordinate of the Point.</param>
        public Point(float x, float y)
        {
            this.x = x;
            this.y = y;
            _points = new [] { this };
        }

        /// <summary>
        /// A representation of a Point.
        /// </summary>
        /// <param name="position">The Point's coordinates as a Vector2.</param>
        public Point(Vector2 position)
        {
            this.x = position.x;
            this.y = position.y;
            _points = new [] { this };
        }

        new public float w => 1;

        new public float h => 1;

        /// <summary>
        /// Access the Cartesian x, y components of this Point as a Vector2.
        /// </summary>
        public Vector2 xy => new Vector2(this.x, this.y);

        /// <summary>
        /// Access the coordinates of this Point in row-major order.
        /// </summary>
        public Vector2 ij => new Vector2(this.y, this.x);

        /// <summary>
        /// Return an IEnumerable of Points corresponding to each of the
        /// positions directly neighboring this one.
        /// </summary>
        public IEnumerable<Point> Neighbors => from Vector2 dir in Direction.All select new Point(xy + dir);

        /// <summary>
        /// Return the current Point with its x and y coordinates floored.
        /// </summary>
        public Point Floored => new Point(Mathf.Floor(this.x), Mathf.Floor(this.y));

        /// <summary>
        /// Return the origin point of the coordinate plane.
        /// </summary>
        public Point Origin => new Point(0, 0);

        public override IEnumerator GetEnumerator()
        {
            yield return this;
        }

        private static (float, float) _CompareMagnitude(Point a, Point b)
        {
            float magnitudeA = Mathf.Sqrt((a.x * a.x) + (a.y * a.y));
            float magnitudeB = Mathf.Sqrt((b.x * b.x) + (b.y * b.y));
            return (magnitudeA, magnitudeB);
        }
    }
}
