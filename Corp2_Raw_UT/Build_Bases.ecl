IMPORT tools, ut;

EXPORT Build_Bases(

	STRING																							pfiledate,
	STRING																							pversion,
	Boolean 																						pUseOtherEnvironment,
	DATASET(Corp2_Raw_UT.Layouts.BusentityLayoutIn)			pInBusentity   		    = Corp2_Raw_UT.Files(pfiledate,pUseOtherEnvironment).Input.Busentity.Logical,
	DATASET(Corp2_Raw_UT.Layouts.BusentityLayoutBase)		pBaseBusentity 		    = IF(Corp2_Raw_UT._Flags.Base.Busentity, Corp2_Raw_UT.Files(,pUseOtherEnvironment := FALSE).Base.Busentity.qa, DATASET([], Corp2_Raw_UT.Layouts.BusentityLayoutBase)),
	DATASET(Corp2_Raw_UT.Layouts.PrincipalsLayoutIn)		pInPrincipals   			= Corp2_Raw_UT.Files(pfiledate,pUseOtherEnvironment).Input.Principals.Logical,
	DATASET(Corp2_Raw_UT.Layouts.PrincipalsLayoutBase)	pBasePrincipals 			= IF(Corp2_Raw_UT._Flags.Base.Principals, Corp2_Raw_UT.Files(,pUseOtherEnvironment := FALSE).Base.Principals.qa, DATASET([], Corp2_Raw_UT.Layouts.PrincipalsLayoutBase)),
	DATASET(Corp2_Raw_UT.Layouts.BusinfoLayoutIn)				pInBusinfo   	   		  = Corp2_Raw_UT.Files(pfiledate,pUseOtherEnvironment).Input.Businfo.Logical,
	DATASET(Corp2_Raw_UT.Layouts.BusinfoLayoutBase)			pBaseBusinfo 	   			= IF(Corp2_Raw_UT._Flags.Base.Businfo, Corp2_Raw_UT.Files(,pUseOtherEnvironment := FALSE).Base.Businfo.qa, DATASET([], Corp2_Raw_UT.Layouts.BusinfoLayoutBase))
	
) := MODULE

	EXPORT full_build := sequential(	Corp2_Raw_UT.Build_Bases_Busentity(pfiledate,pversion,pUseOtherEnvironment,pInBusentity,pBaseBusentity).ALL,
																		Corp2_Raw_UT.Build_Bases_Principals(pfiledate,pversion,pUseOtherEnvironment,pInPrincipals,pBasePrincipals).ALL,
																		Corp2_Raw_UT.Build_Bases_Businfo(pfiledate,pversion,pUseOtherEnvironment,pInBusinfo,pBaseBusinfo).ALL,
																		Promote(pversion).buildfiles.New2Built,
																		Promote().BuildFiles.Built2QA
																 );

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
									 full_build,
									 OUTPUT('No Valid version  parameter passed, skipping Corp2_Raw_UT.Build_Bases attribute')
									 );

END;
