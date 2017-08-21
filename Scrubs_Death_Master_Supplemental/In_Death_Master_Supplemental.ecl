IMPORT	Header,	ut, Death_Master, Data_Services;
// File_in := Header.File_Death_Master_Supplemental_SSA;
// EXPORT In_Death_Master_Supplemental := File_in;

EXPORT	In_Death_Master_Supplemental(STRING	VersionDate) := FUNCTION
	dNewStateRecords
	 := 
			Death_Master.Mapping_CA
		+	Death_Master.Mapping_CT
		+	Death_Master.Mapping_GA
		+	Death_Master.Mapping_FL
		+	Death_Master.Mapping_KY
		+	Death_Master.Mapping_MA
		+	Death_Master.Mapping_MI
		+	Death_Master.Mapping_MN
		+	Death_Master.Mapping_MT
		+	Death_Master.Mapping_NC
		+	Death_Master.Mapping_NV
		+	Death_Master.Mapping_OH
		+	Death_Master.Mapping_VA;

	UNSIGNED	vMaxRecordID	:=	0;

	dCleanName			:=	Death_Master.fn_cleanName(dNewStateRecords);
	dCleanAddress		:=	Death_Master.fn_cleanAddress(dCleanName);
	dNewSuppRecords	:=	Death_Master.fn_fillSupplementalFields(dCleanAddress, VersionDate, vMaxRecordID):PERSIST('~thor_data400::persist::death_master::ScrubsDeathMasterSupplemental');
	dOutSupp				:=	PROJECT(dNewSuppRecords,TRANSFORM(Scrubs_Death_Master_Supplemental.Layout_Death_Master_Supplemental,SELF:=LEFT));

	RETURN	dOutSupp;
	// RETURN	DATASET(ut.foreign_prod+Death_Master.Files.vStatesFileName,Scrubs_Death_Master_Supplemental.Layout_Death_Master_Supplemental ,THOR);
END;