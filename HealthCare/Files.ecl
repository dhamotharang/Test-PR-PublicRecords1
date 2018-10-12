EXPORT Files := MODULE
	IMPORT HealthCare;
	EXPORT Speciality_Taxonomy_DS := DATASET ('~thor::base::speciality_taxonomy_crosswalk_reference_data',HealthCare.Layouts.Speciality_Taxonomy_Rec,thor);
	EXPORT Speciality_Code_DS := DATASET ('~thor::pilgrim::speciality::code',HealthCare.Layouts.Spec_Cd_Rec,CSV(SEPARATOR([',']),QUOTE(['']),MAXLENGTH(200),HEADING(1)),OPT);
	EXPORT NPI_DS := DATASET ('~thor::npi::data',HealthCare.Layouts.NPI_REC,THOR);
	EXPORT NPI_DATE_DS := DATASET ('~thor::npi::deactivation::date',{STRING10 NPI_NUMBER, STRING8 ENUMERATION_DATE, STRING8 DEACTIVATION_DATE, STRING8 REACTIVATION_DATE, STRING1 NPI_FLAG},THOR);
	EXPORT Hospital_Exclusion_DS := DATASET ('~thor::hospital::exclustion::list',HealthCare.Layouts.Hospital_Exclusion_Rec,THOR);
	EXPORT LNPID_ASSOCIATION_DS := DATASET ('~thor::temp::lnpid::to::lnpid::20160707',HealthCare.Layouts.LNPID_TO_LNPID_REC,THOR);
END;
