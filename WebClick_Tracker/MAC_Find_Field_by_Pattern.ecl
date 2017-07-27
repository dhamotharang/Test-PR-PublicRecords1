export MAC_Find_Field_by_Pattern(DSet, FieldName,Pat,OutAttr):= macro
		OutAttr:=DSet(regexfind(WebClick_Tracker.DePatternify(Pat),FieldName));
endmacro;