IMPORT  PRTE2_Prof_LicenseV2,PromoteSupers;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

	df :=   PRTE2_Prof_LicenseV2.files.DS_prolicv2_IN;
  dfbase:=project(df,Layouts.Layout_Base_With_Tiers);

	PromoteSupers.MAC_SF_BuildProcess(dfbase,constants.prolicv2_base, writefile)
	
	Return writefile;

END;