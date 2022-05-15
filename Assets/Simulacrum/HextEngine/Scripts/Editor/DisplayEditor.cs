using UnityEngine;
using UnityEditor;
using System.Collections.Generic;

namespace Simulacrum.Hext
{
	[CustomEditor(typeof(Display))]
	public class DisplayEditor : Editor
	{

		public override void OnInspectorGUI()
		{
			base.OnInspectorGUI();

			if ( !Application.isPlaying )
			{
				Console display = (Console) target;

				// force display height to 0 if auto calculating
				if ( display.autoDisplayHeight && display.displayHeight != 0 )
				{
					display.displayHeight = 0;
				}
			}
		}
	}
}
