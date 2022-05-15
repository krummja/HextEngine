using System.Collections;

namespace Simulacrum.Hext.Geom
{
    public abstract class Shape : IEnumerable
    {
        protected Point[] _points;

        /// <summary>
        /// x coordinate of the Shape.
        /// </summary>
        public float x { get; protected set; }

        /// <summary>
        /// y coordinate of the Shape.
        /// </summary>
        public float y { get; protected set; }

        /// <summary>
        /// Width of the Shape.
        /// </summary>
        public float w { get; protected set; }

        /// <summary>
        /// Height of the Shape.
        /// </summary>
        public float h { get; protected set; }

        public abstract IEnumerator GetEnumerator();
    }
}
