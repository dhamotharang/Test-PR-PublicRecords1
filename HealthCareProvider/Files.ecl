import ut, IDL_Header, Ingenix_NatlProf, DEA, AMS, NPPES, Prof_LicenseV2, ABMS, HealthCareFacility;
EXPORT Files := MODULE
	EXPORT INGENIX_DID_DS 		:= DATASET ('~thor_data400::base::ingenix_providers_did',ingenix_natlprof.Layout_provider_base_rid,thor);	
	EXPORT INGENIX_DEA_DS 		:= Ingenix_NatlProf.Basefile_ProviderAddressDEANumber; 	//DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_dea',Layouts.INGENIX_DEA,thor);
	EXPORT INGENIX_NPI_DS 		:= Ingenix_NatlProf.Basefile_ProviderNPI; 							//DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_npi',Layouts.INGENIX_NPI,thor);
	EXPORT INGENIX_LIC_DS 		:= Ingenix_NatlProf.Basefile_ProviderLicense; 					//DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_providerlicense',Layouts.INGENIX_LIC,thor);
	EXPORT INGENIX_UPIN_DS		:= Ingenix_NatlProf.Basefile_ProviderUPIN; 							//DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_upin',Layouts.INGENIX_UPIN,thor);
	EXPORT DEA_DID_DS 				:= DATASET ('~thor_data400::base::dea',Layouts.DEA_DID,thor);	
	// EXPORT DEA_DID_DS 				:= DEA.File_DEA_Modified; 															//DATASET ('~foreign::10.241.20.205::thor_data400::base::dea',Layouts.DEA_DID,thor);	
	EXPORT AMS_DID_DS 				:= DATASET ('~thor_data400::base::ams::qa::main',AMS.Layouts.Base.Main,thor);
	EXPORT AMS_LIC_DS 				:= DATASET ('~thor_data400::base::ams::qa::statelicense',AMS.Layouts.Base.StateLicense,thor);
	EXPORT AMS_NPI_DS 				:= DATASET ('~thor_data400::base::ams::qa::idnumber',AMS.Layouts.Base.IDNumber,thor);
	EXPORT NPPES_DID_DS				:= NPPES.File_NPPES_Base;																//DATASET ('~foreign::10.241.20.205::thor_data400::base::nppes',Layouts.NPPES_DID,thor);
	EXPORT PROF_LIC_DS				:= DATASET ('~thor_data400::base::prolicv2::proflic_base::built',Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers,thor);	
	EXPORT ABMS_DS						:= ABMS.Files('QA').Base.Main; 													//DATASET ('~foreign::10.241.20.205::thor_data400::base::abms::qa::main',Layouts.ABMS,thor);
	EXPORT Enclarity_DS				:= DATASET ('~thor_data400::base::enclarity::individual::qa',HealthCareProvider.Layouts.Enclarity_Individual_REC,thor); 
	EXPORT Enclarity_ASSOC_DS	:= DATASET ('~thor_data400::base::enclarity::associate::qa',HealthCareFacility.Layouts.Enclarity_ASSOC_REC,thor);		
	EXPORT Enclarity_NPI			:= DATASET ('~thor_data400::base::enclarity::npi::qa',HealthCareFacility.Layouts.Enclarity_NPI_REC,thor);		
	EXPORT Enclarity_Sanc_DS	:= DATASET ('~thor_data400::base::enclarity::sanction::qa',HealthCareProvider.Layouts.Enclarity_Sanction_REC,thor);		
	EXPORT Enclarity_Sanc_Cd	:= DATASET ('~thor_data400::base::enclarity::sanc_codes::qa',HealthCareProvider.Layouts.Enclarity_Sanction_Code_Rec,thor);
	EXPORT Enclarity_Prov_Typ := DATASET ('~thor_data400::base::enclarity::sanc_prov_type::qa',HealthCareProvider.Layouts.Enclarity_Prov_Type_Rec,thor);
	EXPORT WATCH_DOG_DS				:= PROJECT(DATASET ('~thor_data400::base::watchdog_best_nonglb',HealthCareProvider.Layouts.WatchDog_REC,THOR),{UNSIGNED8 DID, STRING9 SSN, UNSIGNED4 DOB, STRING1 VALID_SSN});
	EXPORT Taxonomy_Code_DS		:= DATASET ('~thor::taxonomy::code::table',{string4 taxonomy_code, string40 classification},thor);
	
	EXPORT Name_Count_DS	:= DATASET ('~thor::base::insuranceheader::name_count',IDL_Header.layout_name_count,thor);
	EXPORT LIC_TYPE_DS		:= DATASET ('~thor::lictype',Layouts.LIC_TYPE_REC,thor);
	
	EXPORT HealthCare_Prefix				:=	'~thor::base::healthcareprovider';
	
	EXPORT person_in_Suffix					:=	'person::salt::input';
	EXPORT person_out_Suffix				:=	'person::salt::output';
	EXPORT possible_match_Suffix		:=	'person::salt::possiblematch';
	EXPORT person_deleted_Suffix		:=	'person::deleted::rid';
	
	EXPORT facility_in_Suffix				:=	'facility::salt::input';
	EXPORT facility_out_Suffix			:=	'facility::salt::output';	
	EXPORT Header_Suffix						:=	'header';
	
	EXPORT Person_Salt_Output				:=	'~thor::base::healthcareprovider::person::salt::iter::';
	EXPORT Person_PossibleMatches		:=	'~thor::base::healthcareprovider::person::salt::possiblematches::';
	EXPORT Person_DeletedData				:=	'~thor::base::healthcareprovider::person::salt::deleted::rid::';

	
	EXPORT Person_in_SF							:=	HealthCare_Prefix	+ '::qa::' + person_in_Suffix;
	EXPORT Person_in_Father_SF			:=	HealthCare_Prefix	+ '::father::' + person_in_Suffix;
	EXPORT Person_in_GrandFather_SF	:=	HealthCare_Prefix	+ '::grandfather::' + person_in_Suffix;
	EXPORT Person_in_Delete_SF			:=	HealthCare_Prefix	+ '::delete::' + person_in_Suffix;

	EXPORT Person_Out_SF							:=	HealthCare_Prefix	+ '::qa::' + person_out_Suffix;
	EXPORT Person_Out_Father_SF				:=	HealthCare_Prefix	+ '::father::' + person_out_Suffix;
	EXPORT Person_Out_GrandFather_SF	:=	HealthCare_Prefix	+ '::grandfather::' + person_out_Suffix;
	EXPORT Person_Out_Delete_SF				:=	HealthCare_Prefix	+ '::delete::' + person_out_Suffix;

	EXPORT PossibleMatch_SF						:=	HealthCare_Prefix	+ '::' + possible_match_Suffix;

	EXPORT Person_Deleted_SF					:=	HealthCare_Prefix	+ '::' + person_deleted_Suffix;

	EXPORT Facility_SF								:=	HealthCare_Prefix	+ '::qa::' + facility_in_Suffix;
	EXPORT Facility_Father_SF					:=	HealthCare_Prefix	+ '::father::' + facility_in_Suffix;
	EXPORT Facility_GrandFather_SF		:=	HealthCare_Prefix	+ '::grandfather::' + facility_in_Suffix;
	EXPORT Facility_Delete_SF					:=	HealthCare_Prefix	+ '::delete::' + facility_in_Suffix;

	EXPORT ProviderHeader_SF								:=	HealthCare_Prefix	+ '::qa::' + Header_Suffix;
	EXPORT ProviderHeader_Father_SF					:=	HealthCare_Prefix	+ '::father::' + Header_Suffix;
	EXPORT ProviderHeader_GrandFather_SF		:=	HealthCare_Prefix	+ '::grandfather::' + Header_Suffix;
	EXPORT ProviderHeader_Delete_SF					:=	HealthCare_Prefix	+ '::delete::' + Header_Suffix;

	EXPORT Person_Salt_Input_DS						:= DATASET (Person_in_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	EXPORT Person_Salt_Output_DS					:= DATASET (Person_Out_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	EXPORT Person_Salt_Output_Father_DS		:= DATASET (Person_Out_Father_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
		
	EXPORT Facility_Salt_Input_Header_DS	:= DATASET (Facility_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		

	EXPORT Possible_Match_DS							:= DATASET (PossibleMatch_SF,HealthCareProvider.Layouts.Possible_Match_REC,THOR,OPT);		
	EXPORT Person_Deleted_DS							:= DATASET (Person_Deleted_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);			
	
	EXPORT Provider_Header_DS							:= DATASET (ProviderHeader_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);	
	
END;