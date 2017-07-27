import  Business_Header_SS,Business_Header, ut,did_add;

	BDID_Rec := record
		unsigned6	Bdid	     := 0;
		unsigned6   BDID_Score   := 0; 
		recordOf(Ingenix_NatlProf.File_Sanctions_Cleaned_DIDed_dates);
	end;
	
	BDID_Rec BDIDs(Ingenix_NatlProf.File_Sanctions_Cleaned_DIDed_dates l) := transform
		self.Bdid        := 0;
		self.BDID_Score  := 0;
		self.sanc_busnme := stringlib.StringToUppercase(trim(l.sanc_busnme,left,right));	
		self.SANC_TIN    := stringlib.stringfilter(l.SANC_TIN , '0123456789');
		self 			 := l;
	end;
	
	common_in := project(Ingenix_NatlProf.File_Sanctions_Cleaned_DIDed_dates, BDIDs(left));
	
	matchset := ['A', 'F','N'];

	Business_Header_SS.MAC_Add_BDID_FLEX(
				common_in, matchset,
				sanc_busnme, 
				ProvCo_Address_Clean_prim_range, ProvCo_Address_Clean_prim_name, ProvCo_Address_Clean_zip, 
				ProvCo_Address_Clean_sec_range,	ProvCo_Address_Clean_st,
				'',SANC_TIN,
				bdid,	
				BDID_Rec,
				true, BDID_Score, 
				postBDID)
	
export Sanctioned_providers_Bdid:= postBDID :persist('~thor_data400::base::Ingenix_Cleaned_Sanctioned_providers_BDID');

