using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Simulacrum.Hext.Geom
{
    public struct Direction
    {
        public static Vector2 UP = Vector2.up;
        public static Vector2 UP_RIGHT = Vector2.up + Vector2.right;
        public static Vector2 RIGHT = Vector2.right;
        public static Vector2 DOWN_RIGHT = Vector2.down + Vector2.right;
        public static Vector2 DOWN = Vector2.down;
        public static Vector2 DOWN_LEFT = Vector2.down + Vector2.left;
        public static Vector2 LEFT = Vector2.left;
        public static Vector2 UP_LEFT = Vector2.up + Vector2.left;

        public static List<Vector2> All => new List<Vector2>() { UP, UP_RIGHT, RIGHT, DOWN_RIGHT, DOWN, DOWN_LEFT, LEFT, UP_LEFT };

        public static List<Vector2> Orthogonals => new List<Vector2>() { UP, DOWN, LEFT, RIGHT };

        public static List<Vector2> Diagonals => new List<Vector2>() { UP_LEFT, UP_RIGHT, DOWN_LEFT, DOWN_RIGHT };
    }
}
