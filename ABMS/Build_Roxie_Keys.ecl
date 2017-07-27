IMPORT tools;

EXPORT Build_Roxie_Keys(
  STRING pversion = '',
	DATASET(Layouts.Base.Main) 					 pBaseMainBuilt 					= Files(pversion).Base.Main.Built,
	DATASET(Layouts.Base.Career) 				 pBaseCareerBuilt 				= Files(pversion).Base.Career.Built,
	DATASET(Layouts.Base.Cert) 					 pBaseCertBuilt 					= Files(pversion).Base.Cert.Built,
	DATASET(Layouts.Base.Education) 		 pBaseEducationBuilt 			= Files(pversion).Base.Education.Built,
	DATASET(Layouts.Base.Membership) 		 pBaseMembershipBuilt 		= Files(pversion).Base.Membership.Built,
	DATASET(Layouts.Base.TypeOfPractice) pBaseTypeOfPracticeBuilt = Files(pversion).Base.TypeOfPractice.Built) := MODULE

	SHARED TheKeys := Keys(pversion,
	                       pBaseMainBuilt,
												 pBaseCareerBuilt,
												 pBaseCertBuilt,
												 pBaseEducationBuilt,
	                       pBaseMembershipBuilt,
												 pBaseTypeOfPracticeBuilt);

	tools.mac_WriteIndex('TheKeys.Main.BIOGNumber.New'						,BuildMainBIOGNumberKey);
	tools.mac_WriteIndex('TheKeys.Main.DID.New'										,BuildDidKey);
	tools.mac_WriteIndex('TheKeys.Main.BDID.New'									,BuildBdidKey);
	tools.mac_WriteIndex('TheKeys.Main.NPI.New'										,BuildNpiKey);
	tools.mac_WriteIndex('TheKeys.Main.LNameSpecialtyFName.New'		,BuildLNameSpecialtyFNameKey);
	tools.mac_WriteIndex('TheKeys.Main.LNameCertFName.New'				,BuildLNameCertFNameKey);
	tools.mac_WriteIndex('TheKeys.Career.BIOGNumber.New'					,BuildCareerBIOGNumberKey);
	tools.mac_WriteIndex('TheKeys.Cert.BIOGNumber.New'						,BuildCertBIOGNumberKey);
	tools.mac_WriteIndex('TheKeys.Education.BIOGNumber.New'				,BuildEducationBIOGNumberKey);
	tools.mac_WriteIndex('TheKeys.Membership.BIOGNumber.New'			,BuildMembershipBIOGNumberKey);
	tools.mac_WriteIndex('TheKeys.TypeOfPractice.BIOGNumber.New' 	,BuildTypeOfPracticeBIOGNumberKey);

	EXPORT full_build := SEQUENTIAL(PARALLEL(BuildMainBIOGNumberKey,
			                                     BuildDidKey,
			                                     BuildBdidKey,
			                                     BuildNpiKey,
			                                     BuildLNameSpecialtyFNameKey,
			                                     BuildLNameCertFNameKey,
			                                     BuildCareerBIOGNumberKey,
			                                     BuildCertBIOGNumberKey,
			                                     BuildEducationBIOGNumberKey,
			                                     BuildMembershipBIOGNumberKey,
			                                     BuildTypeOfPracticeBIOGNumberKey),
		                              Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_Roxie_Keys atribute'));

END;