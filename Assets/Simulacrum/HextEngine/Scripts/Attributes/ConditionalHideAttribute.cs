using System;
using System.Collections;
using UnityEngine;

namespace Simulacrum.Hext
{
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property |
                    AttributeTargets.Class | AttributeTargets.Struct )]
    public class ConditionalHideAttribute : PropertyAttribute
    {
        public string SourceField;
        public bool HideInInspector;
        public bool Inverse;
        public object CompareValue;

        public ConditionalHideAttribute(string sourceField, object compareObject , bool inverse=false, bool hideInInspector = true)
        {
            this.SourceField = sourceField;
            this.HideInInspector = hideInInspector;
            this.Inverse = inverse;
            this.CompareValue = compareObject==null?true : compareObject;
        }

        public ConditionalHideAttribute(string sourceField, bool compareValue = true, bool inverse = false, bool hideInInspector = true)
        {
            this.SourceField = sourceField;
            this.HideInInspector = hideInInspector;
            this.Inverse = inverse;
            this.CompareValue = compareValue;
        }
    }
}
