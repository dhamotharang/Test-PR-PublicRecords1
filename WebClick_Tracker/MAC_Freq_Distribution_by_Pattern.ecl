export MAC_Freq_Distribution_by_Pattern(DSet, FieldName, Pat,OutAttr):= macro
		#uniquename(__FDbP_InterRecord)

	  WebClick_Tracker.MAC_Freq_Distribution(DSet, FieldName, %__FDbP_InterRecord%);
		OutAttr:=%__FDbP_InterRecord%(regexfind(WebClick_Tracker.DePatternify(Pat),FieldName));
endmacro;
