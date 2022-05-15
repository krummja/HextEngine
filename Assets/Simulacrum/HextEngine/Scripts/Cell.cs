using UnityEngine;
using System.Collections;

namespace Simulacrum.Hext
{
	using System;
	using Random = UnityEngine.Random;

	public class CellFades
	{
		public static string DEFAULT_REVERSE = "░▒▓█";
		public static string DEFAULT = "█▓▒░";
	}

	public class Cell
	{
		public int layer;
		public Vector2 position;
		public string content = "";
		public Color backgroundColor;
		public Color color;

		public IHoverAction hoverAction;
		public IClickAction clickAction;
		public IDragAction dragAction;
		public IScrollAction scrollAction;

		private string targetContent = "";
		private Color targetColor;

		private float fadeLeft = 0f;
		private float fadeMax = 0f;
		private Color fadeColor;
		private string fades = "";
		private bool fadeFinished = true;

		public void Clear(float fadeTime = 0f, Color? fadeColor = null)
		{
			SetContent("", Color.clear, Color.clear, fadeTime, fadeColor, CellFades.DEFAULT_REVERSE);
		}

		/// <summary>
		/// Set the content of the cell.
		/// </summary>
		/// <param name="content">The display string</param>
		/// <param name="backgroundColor">Unity Color for the Cell background</param>
		/// <param name="color">Unity Color for the Cell foreground (the displayed glyph)</param>
		/// <param name="fadeMax"></param>
		/// <param name="fadeColor"></param>
		/// <param name="fades"></param>
		public void SetContent(
			string content,
			Color? backgroundColor = null,
			Color? color = null,
			float fadeMax = 0f,
			Color? fadeColor = null,
			string fades = ""
		)
		{
			// set target content and color
			targetContent = content;

			this.backgroundColor = backgroundColor is null ? Color.clear : (Color) backgroundColor;
			targetColor = color is null ? Color.white : (Color) color;

			// fade
			if ( fadeMax > 0f )
			{
				this.fadeLeft = this.fadeMax = Random.Range(0f, fadeMax);

				this.color = this.fadeColor = fadeColor ?? (Color) color;

				this.fades = fades;
				fadeFinished = false;
			}

			// instant
			else
			{
				this.fadeLeft = 0f;
				this.fadeMax = 0f;
				fadeFinished = false;
			}

			// add cell to top layer
			if ( targetContent != "" )
			{
				Console.Instance.AddCellAsTopLayer(this);
			}
		}

		public void Update()
		{
			// display initialized
			if ( Console.Instance.initialized )
			{
				// fade
				if ( fadeLeft > 0f )
				{
					if ( targetContent.Trim().Length > 0 || content.Trim().Length > 0 )
					{
						int index = Mathf.RoundToInt((fadeLeft / fadeMax) * (fades.Length - 1));
						content = fades.Substring(index, 1);
					}
					else
					{
						content = targetContent;
					}

					color = Color.Lerp(
						targetColor,
						fadeColor,
						Console.Instance.colorLerpCurve.Evaluate(fadeLeft / fadeMax));
					fadeLeft -= Time.deltaTime;
				}

				// fade finished
				else
				{

					// remove cell from top layer
					if ( !fadeFinished && targetContent == "" )
					{
						Console.Instance.RemoveCellAsTopLayer(this);
					}

					fadeFinished = true;
					fadeLeft = 0f;
					content = targetContent;
					color = targetColor;
				}
			}
		}
	}
}
