import doxie;

doxie.MAC_Header_Field_Declare()

export input := module

	// DL Keys
	export unsigned6	dl_seq							:= 0 : stored('DLSeq');
	export unsigned6	did									:= (unsigned6)did_value;
	export qstring14	dl_num							:= (qstring14)dl_value;
	
	//XML Direct
	shared string1	needToUpperIncludeHistory	:= 'A' : stored('IncludeHistory'); 
	export string1	IncludeHistory 						:= stringlib.stringtouppercase(needToUpperIncludeHistory); 
	shared string2	needToUpperDLState				:= '' :stored('DLState');
	export string2  DLState 									:= stringlib.stringtouppercase(needToUpperDLState); 

	
	// DL Tuning
	export unsigned2	pThresh							:= 10 : stored('PenaltThreshold');
	export boolean		incDeepDive					:= not noDeepDive;
	
	// Privacy
	export string6		ssn_mask						:= ssn_mask_value;
	export boolean		dl_mask							:= dl_mask_value;
	export string6		dob_mask						:= dob_mask_val; // not used
	export unsigned1	dppa_purpose				:= global(DPPA_Purpose);
	export unsigned1	glb_purpose					:= global(GLB_Purpose);
	export string32 	applicationType		  := application_type_value;
	
	// Breadth
	shared boolean		iEverything					:= false : stored('IncludeEverything');
	shared boolean		iAccidents					:= false : stored('IncludeAccidents');
	shared boolean		iConvictions				:= false : stored('IncludeConvictions');
	shared boolean		iDRInfo							:= false : stored('IncludeDRInfo');
	shared boolean		iFRAInsurance				:= false : stored('IncludeFRAInsurance');
	shared boolean		iSuspensions				:= false : stored('IncludeSuspensions');
	export boolean		incAccidents				:= iEverything or iAccidents;
	export boolean		incConvictions			:= iEverything or iConvictions;
	export boolean		incDRInfo						:= iEverything or iDRInfo;
	export boolean		incFRAInsurance			:= iEverything or iFRAInsurance;
	export boolean		incSuspensions			:= iEverything or iSuspensions;
	export boolean		incNonDMV						:= false : stored('IncludeNonDMVSources');

end;