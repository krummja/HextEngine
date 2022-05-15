using System;
using System.Text;
using System.Collections.Generic;

using UnityEngine;

namespace Simulacrum.Hext
{
	public enum FontType
	{
		BitMap,
		RexPaint,
	}

	[CreateAssetMenu(fileName = "Font Settings", menuName = "Hext/Settings/Font Settings")]
    public class FontSettings : ScriptableObject
    {
        public TextAsset FontMapping;
        public Material FontMaterial;
        public float HeightScale;

        public FontType FontType;

        [ConditionalHide("FontType", FontType.RexPaint)]
        public float TextureSize;
        [ConditionalHide("FontType", FontType.RexPaint)]
        public float GridSize;
        [ConditionalHide("FontType", FontType.RexPaint)]
        public float Bleed;

        [ConditionalHide("FontType", FontType.BitMap)]
        public float GlyphWidth;
        [ConditionalHide("FontType", FontType.BitMap)]
        public float GlyphHeight;

        public float GlyphSize { get; set; }

        private Dictionary<int, int> MapFont(TextAsset fontMapping)
        {
            Dictionary<int, int> mapping = new Dictionary<int, int>();
            string[] lines = FontMapping.ToString().Split('\n');
            foreach ( string line in lines )
            {
            	// skip comment line
            	if ( !line.StartsWith("#") && line.Trim().Length > 0 )
            	{
            		// spilt columns
            		string[] tabs = line.Split('	');
            		int cp437 = Convert.ToInt32(tabs[1], 16);
            		int unicode = Convert.ToInt32(tabs[0], 16);
            		mapping.Add(cp437, unicode);
            	}
            }
            return mapping;
        }

        private string CP437ToUnicode(int asciiCode, Dictionary<int, int> mapping)
        {
            string character = "";
            // null character
            if ( asciiCode == 0 )
            {
            	character = " ";
            }

            // get character using codepage 437 encoding
            else if ( !mapping.ContainsKey(asciiCode) )
            {
            	character = Encoding.GetEncoding(437).GetString(new byte[] { (byte) asciiCode });
            }

            // get character using ibmgraph mapping
            else
            {
            	character = char.ConvertFromUtf32(mapping[asciiCode]);
            }
            return character;
        }
    }
}
