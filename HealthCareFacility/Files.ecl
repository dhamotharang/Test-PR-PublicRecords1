import ut, healthcarefacility, HealthCareProvider, Enclarity;
EXPORT Files := MODULE
	
	EXPORT DEA_DID_DS 				:= DATASET ('~thor::dea',HealthCareProvider.Layouts.DEA_DID,thor);	//DATASET ('~' + ut.foreign_prod_boca + 'thor_data400::base::dea',healthcarefacility.Layouts.DEA_DID,thor);	
	EXPORT NPPES_DID_DS				:= DATASET ('~thor::nppes',HealthCareProvider.Layouts.NPPES_DID,thor); //DATASET ('~' + ut.foreign_prod_boca + 'thor_data400::base::nppes',healthcarefacility.Layouts.NPPES_DID,thor);
	EXPORT PROF_LIC_DS				:= DATASET ('~thor::proflic',HealthCareProvider.Layouts.PROF_LIC,thor); //DATASET ('~' + ut.foreign_prod_boca + 'thor_data400::base::prolicv2::proflic_base::built',healthcarefacility.Layouts.PROF_LIC,thor);	
	EXPORT Enclarity_Fac_DS		:= DATASET ('~thor::enclarity',Layouts.Enclarity_REC,thor);	 //DATASET ('~' + ut.foreign_prod_boca + 'thor_data400::base::enclarity::facility::qa',Layouts.Enclarity_REC,thor);	
	EXPORT Enclarity_ASSOC_DS	:= DATASET ('~thor::enclarity::assoc',Layouts.Enclarity_ASSOC_REC,thor);	 //DATASET ('~' + ut.foreign_prod_boca + 'thor_data400::base::enclarity::associate::qa',Layouts.Enclarity_ASSOC_REC,thor);		
	EXPORT CLIA_DS				 		:= DATASET ('~thor::clia',Layouts.CLIA_REC,thor);	 //DATASET ('~' + ut.foreign_prod_boca + 'thor_data400::base::clia::built::data',Layouts.CLIA_REC,thor);	
	EXPORT NCPDP_DS				 		:= DATASET ('~thor::ncpdp',Layouts.NCPDP_REC,thor);	 //DATASET ('~' + ut.foreign_prod_boca + 'thor_data400::base::ncpdp::combined_file::qa::data',Layouts.NCPDP_REC,thor);	

	// EXPORT Facility_Header_DS	:= DATASET ('~temp::lnpid::healthcarefacilityheader::it37',HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR);
	
	EXPORT HealthCare_Prefix					:=	'~thor::base::healthcarefacility';
	
	EXPORT facility_in_Suffix					:=	'facility::salt::input';
	EXPORT facility_out_Suffix				:=	'facility::salt::output';
	EXPORT possible_match_Suffix			:=	'facility::salt::possiblematch';
	EXPORT facility_deleted_Suffix		:=	'facility::deleted::rid';
	
	EXPORT Header_Suffix							:=	'header';
	
	EXPORT facility_Salt_Output				:=	'~thor::base::healthcarefacility::facility::salt::iter::';
	EXPORT facility_PossibleMatches		:=	'~thor::base::healthcarefacility::facility::salt::possiblematches::';
	EXPORT facility_DeletedData				:=	'~thor::base::healthcarefacility::facility::salt::deleted::rid::';
	
	EXPORT facility_in_SF							:=	HealthCare_Prefix	+ '::qa::' + facility_in_Suffix;
	EXPORT facility_in_Father_SF			:=	HealthCare_Prefix	+ '::father::' + facility_in_Suffix;
	EXPORT facility_in_GrandFather_SF	:=	HealthCare_Prefix	+ '::grandfather::' + facility_in_Suffix;
	EXPORT facility_in_Delete_SF			:=	HealthCare_Prefix	+ '::delete::' + facility_in_Suffix;

	EXPORT facility_Out_SF							:=	HealthCare_Prefix	+ '::qa::' + facility_out_Suffix;
	EXPORT facility_Out_Father_SF				:=	HealthCare_Prefix	+ '::father::' + facility_out_Suffix;
	EXPORT facility_Out_GrandFather_SF	:=	HealthCare_Prefix	+ '::grandfather::' + facility_out_Suffix;
	EXPORT facility_Out_Delete_SF				:=	HealthCare_Prefix	+ '::delete::' + facility_out_Suffix;

	EXPORT PossibleMatch_SF							:=	HealthCare_Prefix	+ '::' + possible_match_Suffix;

	EXPORT facility_Deleted_SF					:=	HealthCare_Prefix	+ '::' + facility_deleted_Suffix;

	EXPORT Facility_SF									:=	HealthCare_Prefix	+ '::qa::' + facility_in_Suffix;
	EXPORT Facility_Father_SF						:=	HealthCare_Prefix	+ '::father::' + facility_in_Suffix;
	EXPORT Facility_GrandFather_SF			:=	HealthCare_Prefix	+ '::grandfather::' + facility_in_Suffix;
	EXPORT Facility_Delete_SF						:=	HealthCare_Prefix	+ '::delete::' + facility_in_Suffix;

	EXPORT facility_Salt_Input_DS								:= DATASET (facility_in_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	EXPORT facility_Salt_Output_DS							:= DATASET (facility_Out_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	EXPORT facility_Salt_Output_Father_DS				:= DATASET (facility_Out_Father_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	EXPORT facility_Salt_Output_GrandFather_DS	:= DATASET (facility_Out_GrandFather_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	EXPORT Facility_Salt_Input_Header_DS				:= DATASET (Facility_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	
	EXPORT Possible_Match_DS										:= DATASET (PossibleMatch_SF,HealthCareProvider.Layouts.Possible_Match_REC,THOR,OPT);		
	EXPORT facility_Deleted_DS									:= DATASET (Facility_Deleted_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);			
	
	EXPORT Facility_Header_DS										:= DATASET (Facility_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);	
END;

