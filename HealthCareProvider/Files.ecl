import ut, IDL_Header;
EXPORT Files := MODULE
	EXPORT INGENIX_DID_DS := DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_providers_did',Layouts.INGENIX_DID,thor);	
	EXPORT DEA_DS 				:= DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_dea',Layouts.INGENIX_DEA,thor);
	EXPORT NPI_DS 				:= DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_npi',Layouts.INGENIX_NPI,thor);
	EXPORT LIC_DS 				:= DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_providerlicense',Layouts.INGENIX_LIC,thor);
	EXPORT UPIN_DS 				:= DATASET ('~foreign::10.241.20.205::thor_data400::base::ingenix_upin',Layouts.INGENIX_UPIN,thor);
	EXPORT DEA_DID_DS 		:= DATASET ('~foreign::10.241.20.205::thor_data400::base::dea',Layouts.DEA_DID,thor);	
	EXPORT AMS_DID_DS 		:= DATASET ('~foreign::10.241.20.205::thor_data400::base::ams::qa::main',Layouts.AMS_DID,thor);
	EXPORT AMS_LIC_DS 		:= DATASET ('~foreign::10.241.20.205::thor_data400::base::ams::qa::statelicense',Layouts.AMS_LIC,thor);
	EXPORT AMS_NPI_DS 		:= DATASET ('~foreign::10.241.20.205::thor_data400::base::ams::qa::idnumber',Layouts.AMS_NPI,thor);
	EXPORT NPPES_DID_DS		:= DATASET ('~foreign::10.241.20.205::thor_data400::base::nppes',Layouts.NPPES_DID,thor);
	EXPORT PROF_LIC_DS		:= DATASET ('~foreign::10.241.20.205::thor_data400::base::prolicv2::proflic_base::built',Layouts.PROF_LIC,thor);	
	EXPORT ABMS_DS				:= DATASET ('~foreign::10.241.20.205::thor_data400::base::abms::qa::main',Layouts.ABMS,thor);
	EXPORT Name_Count_DS	:= DATASET ('~foreign::10.194.12.1::thor::base::insuranceheader::name_count',IDL_Header.layout_name_count,thor);
	EXPORT Taxonomy_Code_DS		:= DATASET ('~thor::taxonomy::code::table',{string4 taxonomy_code, string40 classification},thor);
	
	EXPORT HealthCare_Prefix				:=	'~thor::base::healthcareprovider';
	
	EXPORT person_in_Suffix					:=	'person::salt::input';
	EXPORT person_out_Suffix				:=	'person::salt::output';
	EXPORT facility_in_Suffix				:=	'facility::salt::input';
	EXPORT facility_out_Suffix			:=	'facility::salt::output';	
	EXPORT Header_Suffix						:=	'header';
	
	EXPORT Person_Salt_Output				:=	'~thor::base::healthcare::person::salt::output::';
	EXPORT Person_PossibleMatches		:=	'~thor::base::healthcare::person::salt::possiblematches::';
	
	EXPORT Person_in_SF							:=	HealthCare_Prefix	+ '::qa::' + person_in_Suffix;
	EXPORT Person_in_Father_SF			:=	HealthCare_Prefix	+ '::father::' + person_in_Suffix;
	EXPORT Person_in_GrandFather_SF	:=	HealthCare_Prefix	+ '::grandfather::' + person_in_Suffix;
	EXPORT Person_in_Delete_SF			:=	HealthCare_Prefix	+ '::delete::' + person_in_Suffix;

	EXPORT Person_Out_SF							:=	HealthCare_Prefix	+ '::qa::' + person_out_Suffix;
	EXPORT Person_Out_Father_SF				:=	HealthCare_Prefix	+ '::father::' + person_out_Suffix;
	EXPORT Person_Out_GrandFather_SF	:=	HealthCare_Prefix	+ '::grandfather::' + person_out_Suffix;
	EXPORT Person_Out_Delete_SF				:=	HealthCare_Prefix	+ '::delete::' + person_out_Suffix;

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
	EXPORT Facility_Salt_Input_Header_DS	:= DATASET (Facility_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);		
	
	EXPORT Provider_Header_DS							:= DATASET (ProviderHeader_SF,HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header,THOR,OPT);	
	
END;