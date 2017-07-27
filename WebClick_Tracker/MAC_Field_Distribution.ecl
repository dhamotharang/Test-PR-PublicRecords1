export MAC_Field_Distribution(DSet, FieldName, Pat, I, OutAttr) := macro
		#uniquename(__New_Rec_XForm)
		#uniquename(__Reduced_Pat)
		#uniquename(__FD_RollXForm)
		#uniquename(__FD_RExp)

		WebClick_Tracker.MAC_Freq_Distribution_by_Pattern(DSet, FieldName, Pat, Pat_Z0rz);
		%__FD_RExp%:= WebClick_Tracker.DePatternify(WebClick_Tracker.Groupify(Pat));
		
		recordof(Pat_Z0rz) %__New_Rec_XForm%(Pat_Z0rz L):=transform
				self.FieldName:=regexfind(%__FD_RExp%, L.FieldName, I);
				self:=L;
		end;
		
		%__Reduced_Pat%:=project(Pat_Z0rz, %__New_Rec_XForm%(left));
		
		recordof(%__Reduced_Pat%) %__FD_RollXForm%(%__Reduced_Pat% L,%__Reduced_Pat%  R):=transform
				self.Frequency:=L.Frequency+R.Frequency;
				self:=L;
		end;
		
		OutAttr:=rollup(%__Reduced_Pat%,left.FieldName=right.FieldName,%__FD_RollXForm%(left,right));
		
endmacro;