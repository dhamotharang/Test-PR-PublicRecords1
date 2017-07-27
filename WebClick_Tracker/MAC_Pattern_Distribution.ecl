export MAC_Pattern_Distribution(DSet, FieldName, OutAttr):= macro
    #uniquename(__PD_InterRecord)
    #uniquename(__PD_Patterns)
    #uniquename(__PD_SortedPatterns)
    #uniquename(__PD_RollXForm)
	
		WebClick_Tracker.MAC_Freq_Distribution(DSet, FieldName, %__PD_InterRecord%);
		
		recordof(%__PD_InterRecord%) PatternXForm(%__PD_InterRecord% L):=transform
				self.orig_field:=WebClick_Tracker.Patternify(L.orig_field);
				self:=L;
		end;

		%__PD_Patterns%:=project(%__PD_InterRecord%, PatternXForm(left));
		%__PD_SortedPatterns%:=sort(%__PD_Patterns%,orig_field);
		
		recordof(%__PD_SortedPatterns%) %__PD_RollXForm%(%__PD_SortedPatterns% L, %__PD_SortedPatterns% R):=transform
				self.Frequency:=L.Frequency+R.Frequency;
				self:=L;
		end;
		
		OutAttr:=rollup(%__PD_SortedPatterns%,left.orig_field=right.orig_field,%__PD_RollXForm%(left,right));

endmacro;
