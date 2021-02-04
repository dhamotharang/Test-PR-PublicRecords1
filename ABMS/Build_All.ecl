﻿IMPORT _Control, RoxieKeyBuild, tools, Orbit3;

EXPORT Build_All(
 STRING																	pversion,
	STRING																	pDirectory									= '/data/hds_3/ABMS/build',
	STRING																	pServerIP										= _Control.IPAddress.bctlpedata11,
	BOOLEAN																	pIsTesting									= FALSE,
	BOOLEAN																	pOverwrite									= FALSE,
	BOOLEAN																	pReplicate									=	FALSE,
	STRING																	pFilenameAddress						= 'address*.txt',
	STRING																	pFilenameBIOG			 					= 'biog*.txt',
	STRING																	pFilenameCareer		 					= 'career*.txt',
	STRING																	pFilenameCert			 					= 'cert*.txt',
	STRING																	pFilenameContact	 					= 'contact*.txt',
	STRING																	pFilenameDeceased	 					= 'deceased*.txt',
	STRING																	pFilenameEducation 					= 'education*.txt',
	STRING																	pFilenameMembership					= 'membership*.txt',
	STRING																	pFilenameMOCParticipation		= 'mocpart*.txt',
	STRING																	pFilenameTypeOfPractice			= 'typeofprac*.txt',
	STRING																	pFilenameSchools						= 'zschoolspi*.txt',
	STRING																	pFilenameSpecialty					= 'zspecialtypi*.txt',
	STRING																	pFilenameRaw_input					= 'ABMS_Data.txt',
	STRING																	pGroupName									= _Dataset().groupname,
	DATASET(Layouts.Base.Main)							pBaseMainFile								=	IF(_Flags.Update.Main, Files().Base.Main.QA, DATASET([], Layouts.Base.Main)),
	DATASET(Layouts.Base.Career)						pBaseCareerFile							=	IF(_Flags.Update.Career, Files().Base.Career.QA, DATASET([], Layouts.Base.Career)),
	DATASET(Layouts.Base.Cert)							pBaseCertFile								=	IF(_Flags.Update.Cert, Files().Base.Cert.QA, DATASET([], Layouts.Base.Cert)),
	DATASET(Layouts.Base.Education)					pBaseEducationFile					=	IF(_Flags.Update.Education, Files().Base.Education.QA, DATASET([], Layouts.Base.Education)),
	DATASET(Layouts.Base.Membership)				pBaseMembershipFile					=	IF(_Flags.Update.Membership, Files().Base.Membership.QA, DATASET([], Layouts.Base.Membership)),
	DATASET(Layouts.Base.TypeOfPractice)		pBaseTypeOfPracticeFile			=	IF(_Flags.Update.TypeOfPractice, Files().Base.TypeOfPractice.QA, DATASET([], Layouts.Base.TypeOfPractice)),
	DATASET(Layouts.Input.BIOG)							pUpdateBIOGFile							=	Files().Input.BIOG.Sprayed,
	DATASET(Layouts.Input.Address)					pUpdateAddressFile					=	Files().Input.Address.Sprayed,
	DATASET(Layouts.Input.Contact)					pUpdateContactFile					=	Files().Input.Contact.Sprayed,
	DATASET(Layouts.Input.Deceased)					pUpdateDeceasedFile					=	Files().Input.Deceased.Sprayed,
	DATASET(Layouts.Input.MOCParticipation)	pUpdateMOCParticipationFile	=	Files().Input.MOCParticipation.Sprayed,
	DATASET(Layouts.Input.Career)						pUpdateCareerFile						=	Files().Input.Career.Sprayed,
	DATASET(Layouts.Input.Cert)							pUpdateCertFile							=	Files().Input.Cert.Sprayed,
	DATASET(Layouts.Input.Education)				pUpdateEducationFile				=	Files().Input.Education.Sprayed,
	DATASET(Layouts.Input.Membership)				pUpdateMembershipFile				=	Files().Input.Membership.Sprayed,
	DATASET(Layouts.Input.TypeOfPractice)		pUpdateTypeOfPracticeFile		=	Files().Input.TypeOfPractice.Sprayed,
	DATASET(Layouts.Input.Schools)					pUpdateSchoolsFile					=	Files().Input.Schools.Sprayed,
	DATASET(Layouts.Input.Raw_input)				pUpdateAll									= Files().Input.Raw_input.Sprayed,
	DATASET(Layouts.Base.Main)							pBaseMainBuilt							= Files(pversion).Base.Main.Built,
	DATASET(Layouts.Base.Career)						pBaseCareerBuilt						= Files(pversion).Base.Career.Built,
	DATASET(Layouts.Base.Cert)							pBaseCertBuilt							= Files(pversion).Base.Cert.Built,
	DATASET(Layouts.Base.Education)					pBaseEducationBuilt					= Files(pversion).Base.Education.Built,
	DATASET(Layouts.Base.Membership)				pBaseMembershipBuilt				= Files(pversion).Base.Membership.Built,
	DATASET(Layouts.Base.TypeOfPractice)		pBaseTypeOfPracticeBuilt		= Files(pversion).Base.TypeOfPractice.Built) := MODULE

	EXPORT spray_files := SprayFiles(pServerIP,
		                               pDirectory,
		                               // pFilenameAddress,
		                               // pFilenameBIOG,
		                               // pFilenameCareer,
		                               // pFilenameCert,
		                               // pFilenameContact,
		                               // pFilenameDeceased,
		                               // pFilenameEducation,
																	 // pFilenameMembership,
		                               // pFilenameMOCParticipation,
		                               // pFilenameTypeOfPractice,
		                               // pFilenameSchools,
		                               // pFilenameSpecialty,
																	 pFilenameRaw_input,
		                               pversion,
		                               pGroupName,
		                               pIsTesting,
		                               pOverwrite,
		                               pReplicate);
	
	EXPORT create_input_files	:= ABMS.Preprocess_rawfile(pversion, puseprod := false);
	//Added ;michael.gould@lexisnexisrisk.com
	EXPORT dops_update := RoxieKeyBuild.updateversion('ABMSKeys', pversion, _Control.MyInfo.EmailAddressNotify + ';michael.gould@lexisnexisrisk.com;darren.knowles@lexisnexisrisk.com', , 'N'); 															

	EXPORT orbitUpdate := Orbit3.proc_Orbit3_CreateBuild('ABMS',pversion,'N');

	EXPORT full_build := SEQUENTIAL(Create_Supers,
																	spray_files,
																	create_input_files,
																	Build_Base(pversion,
																						 pBaseMainFile,
																						 pBaseCareerFile,
																						 pBaseCertFile,
																						 pBaseEducationFile,
																						 pBaseMembershipFile,
																						 pBaseTypeOfPracticeFile,
																						 pUpdateBIOGFile,
																						 pUpdateAddressFile,
																						 pUpdateContactFile,
																						 pUpdateDeceasedFile,
																						 pUpdateMOCParticipationFile,
																						 pUpdateCareerFile,
																						 pUpdateCertFile,
																						 pUpdateEducationFile,
																						 pUpdateMembershipFile,
																						 pUpdateTypeOfPracticeFile,
																						 pUpdateSchoolsFile).All,
																	Build_AutoKeys(pversion,
																								 pBaseMainBuilt),
																	Build_Roxie_Keys(pversion,
																									 pBaseMainBuilt,
																									 pBaseCareerBuilt,
																									 pBaseCertBuilt,
																									 pBaseEducationBuilt,
																									 pBaseMembershipBuilt,
																									 pBaseTypeOfPracticeBuilt).All,
																	Promote(pDelete := TRUE).buildfiles.Built2QA,
																	Promote(pDelete := TRUE).Inputfiles.Using2Used,
																	QA_Records(),
																	dops_update,
																	Strata_Population_Stats(pversion,
																													pIsTesting,
																													pOverwrite,
																													pBaseMainBuilt,
																													pBaseCareerBuilt,
																													pBaseCertBuilt,
																													pBaseEducationBuilt,
																													pBaseMembershipBuilt,
																													pBaseTypeOfPracticeBuilt).All,
																	orbitUpdate		
																 ) : SUCCESS(Send_Emails(pversion).Roxie),
																		FAILURE(Send_Emails(pversion).BuildFailure);
	
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_All'));

END;