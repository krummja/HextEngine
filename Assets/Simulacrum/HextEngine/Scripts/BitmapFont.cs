using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Xml;
using System.IO;
using System.Text;
using System;

namespace Simulacrum.Hext
{
	public sealed class BitmapFont : MonoBehaviour
	{
		public FontSettings FontSettings;

		[HideInInspector]
		public float textureSize;

		[HideInInspector]
		public bool fontLoaded = false;

		private Dictionary<string, BitmapFontGlyph> glyphs = new Dictionary<string, BitmapFontGlyph>();

		public void Start()
		{
			switch ( FontSettings.FontType )
			{
				case FontType.BitMap:
				{
					string fontXmlText = FontSettings.FontMapping.text;
					XmlReader reader = XmlReader.Create(new StringReader(fontXmlText));
					while ( reader.Read() )
					{
						// parse texture size
						if ( reader.LocalName == "common" )
						{
							textureSize = float.Parse(reader.GetAttribute("scaleW"));
						}

						// parse glyph
						else if ( reader.LocalName == "char" )
						{
							string glyphString = char.ConvertFromUtf32(int.Parse(reader.GetAttribute("id")));

							// new glyph
							if ( !glyphs.ContainsKey(glyphString) )
							{
								BitmapFontGlyph glyph = new BitmapFontGlyph();
								glyph.glyphString = glyphString;
								glyph.x = float.Parse(reader.GetAttribute("x"));
								glyph.y = float.Parse(reader.GetAttribute("y"));
								glyph.xOffset = float.Parse(reader.GetAttribute("xoffset"));
								glyph.yOffset = float.Parse(reader.GetAttribute("yoffset"));
								glyph.width = float.Parse(reader.GetAttribute("width"));
								glyph.height = float.Parse(reader.GetAttribute("height"));
								glyphs.Add(glyphString, glyph);
								glyph.RecalculateGlyphMetrics(
									FontSettings.GlyphWidth,
									FontSettings.GlyphHeight,
									textureSize,
									0f
								);
							}
						}
					}

					break;
				}

				case FontType.RexPaint:
				{
					// get ibmgraph mapping
					Dictionary<int, int> ibmGraphMapping = BitmapFont.GetIBMGRAPHMapping(FontSettings.FontMapping);

					// set glyph size
					FontSettings.GlyphSize = FontSettings.TextureSize / (float) FontSettings.GridSize;

					// set texture size
					textureSize = FontSettings.TextureSize;

					// add glyphs
					for ( int y = 0; y < FontSettings.GridSize; y++ )
					{
						for ( int x = 0; x < FontSettings.GridSize; x++ )
						{
							string glyphString = CP437ToUnicode(
								Mathf.RoundToInt(y * FontSettings.GridSize + x), ibmGraphMapping
							);

							// new glyph
							if ( !glyphs.ContainsKey(glyphString) )
							{
								BitmapFontGlyph glyph = new BitmapFontGlyph();

								glyph.glyphString = glyphString;
								glyph.x = x * FontSettings.GlyphSize;
								glyph.y = y * FontSettings.GlyphSize;

								glyph.xOffset = 0f;
								glyph.yOffset = 0f;

								glyph.width = FontSettings.GlyphSize;
								glyph.height = FontSettings.GlyphSize;

								glyphs.Add(glyph.glyphString, glyph);

								glyph.RecalculateGlyphMetrics(
									FontSettings.GlyphSize,
									FontSettings.GlyphSize,
									textureSize,
									FontSettings.Bleed);
							}
						}
					}

					break;
				}
			}

			fontLoaded = true;
			Debug.Log("FONT TEXTURE SIZE: " + FontSettings.TextureSize);
			Debug.Log(glyphs.Count + "  GLYPHS LOADED!");
		}

		public Material GetFontMaterial()
		{
			return FontSettings.FontMaterial;
		}

		public float GetGlyphWidth()
		{
			float width = 0f;
			switch ( FontSettings.FontType )
			{
				case FontType.BitMap:
					width = FontSettings.GlyphWidth;
					break;
				case FontType.RexPaint:
					width = FontSettings.GlyphSize;
					break;
			}

			return width;
		}

		public float GetGlyphHeight()
		{
			float height = 0f;
			switch ( FontSettings.FontType )
			{
				case FontType.BitMap:
					height = FontSettings.GlyphHeight;
					break;
				case FontType.RexPaint:
					height = FontSettings.GlyphSize;
					break;
			}

			return height;
		}

		public BitmapFontGlyph GetGlyph(string glyphString)
		{
			BitmapFontGlyph glyph;

			// return specified glyph
			if ( glyphs.TryGetValue(glyphString, out glyph) )
			{
				return glyph;
			}

			// glyph not found
			else
			{
				return glyphs["?"];
			}
		}

		public static Dictionary<int, int> GetIBMGRAPHMapping(TextAsset IBMGRAPH)
		{
			// parse ibmgraph mapping
			Dictionary<int, int> ibmGraphMapping = new Dictionary<int, int>();
			string[] lines = IBMGRAPH.ToString().Split('\n');
			foreach ( string line in lines )
			{
				// skip comment line
				if ( !line.StartsWith("#") && line.Trim().Length > 0 )
				{

					// spilt columns
					string[] tabs = line.Split('	');
					int cp437 = Convert.ToInt32(tabs[1], 16);
					int unicode = Convert.ToInt32(tabs[0], 16);
					ibmGraphMapping.Add(cp437, unicode);
				}
			}

			return ibmGraphMapping;
		}

		public static string CP437ToUnicode(int asciiCode, Dictionary<int, int> ibmGraphMapping)
		{
			string character = "";

			// null character
			if ( asciiCode == 0 )
			{
				character = " ";
			}

			// get character using codepage 437 encoding
			else if ( !ibmGraphMapping.ContainsKey(asciiCode) )
			{
				character = Encoding.GetEncoding(437).GetString(new byte[] { (byte) asciiCode });
			}

			// get character using ibmgraph mapping
			else
			{
				character = char.ConvertFromUtf32(ibmGraphMapping[asciiCode]);
			}

			return character;
		}
	}
}
