import NID, Address;

export Update_Organizations(

	 string																pversion
	,dataset(Layouts.Input.Sprayed			)	pUpdateFile	= Files().input.using
	,dataset(Layouts.Base.Organizations	)	pBaseFile		= Files().base.Organizations.qa

) :=
function

	dpreprocess							:= Parse_Input.PreProcess					(pUpdateFile		);
	dorgs										:= Parse_Input.Organizations			(dpreprocess		);
	dStandardizedInputFile	:= Standardize_Organizations.fAll	(pversion,dOrgs	);

	dupdate_combined				:= map(_Flags.Update.Organizations =>	dStandardizedInputFile + pBaseFile,
																																dStandardizedInputFile
																 );
		
	dStandardize_Addr				:= Martindale_Hubbell.Standardize_Organizations_AID (dupdate_combined			);																	 
	drollup									:= Rollup_Organizations						(dStandardize_Addr);
	
  // Add Clean Name fields to the Base file
	NID.Mac_CleanFullNames(drollup, dcleaned_names, rawfields.name_display_name);	

	nid_dcleaned_names := dcleaned_names;	
	
  Layouts.Base.Organizations add_clean_name(nid_dcleaned_names L) := TRANSFORM
	  SELF.Clean_Name.title    		:= L.cln_title;  
	  SELF.Clean_Name.fname       := L.cln_fname;
	  SELF.Clean_Name.mname       := L.cln_mname;
	  SELF.Clean_Name.lname       := L.cln_lname;
	  SELF.Clean_Name.name_suffix := L.cln_suffix;
	  SELF := L;
	END;
	
	cleaned_output := PROJECT(nid_dcleaned_names, add_clean_name(LEFT));

	dAppend_Ids							:= Append_Ids.fAppendBdid	(cleaned_output);

	return dAppend_Ids;

end;