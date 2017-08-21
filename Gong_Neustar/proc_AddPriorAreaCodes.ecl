import Risk_Indicators;

EXPORT proc_AddPriorAreaCodes(dataset(layout_gongMaster) infile) := FUNCTION
	acChange := Risk_Indicators.File_AreaCode_Change;
	layout_gongMaster tChange(infile L, acChange R) := transform
				self.prior_area_code 	:= map(L.phone10[1..6] = R.new_npa+R.new_nxx
								and GetDate < 
								if(R.permissive_end[5]='9','19'+R.permissive_end[5..6]+R.permissive_end[1..4],'20'+R.permissive_end[5..6]+R.permissive_end[1..4])
								=> R.old_npa,'');								
			self 					:= L;
		end;

		j_acChange := join(infile,acChange,left.phone10[1..6]=right.new_npa+right.new_nxx,tChange(left,right),left outer,lookup);
		return j_acChange;
END;