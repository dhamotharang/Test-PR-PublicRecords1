import InsuranceHeader_PostProcess,PRTE,_control;
 
EXPORT CustTest_Proc_GoExternal(STRING fileVersion) := FUNCTION
	modCustTestFile := custTest_Files(fileVersion);
	buildSpec := specificities(File_InsuranceHeader).Build;
	
	BaseK := 	if(~fileservices.fileexists(modCustTestFile.header_logical)  ,BUILDINDEX(Process_xIDL_Layouts().Key,			modCustTestFile.header_logical,	 OVERWRITE));	
	BK0 	:= 	if(~fileservices.fileexists(modCustTestFile.name_logical)    ,BUILDINDEX(Key_InsuranceHeader_NAME().Key,		modCustTestFile.name_logical,	 OVERWRITE));
	BK1 	:= 	if(~fileservices.fileexists(modCustTestFile.address_logical) ,BUILDINDEX(Key_InsuranceHeader_ADDRESS().Key,	modCustTestFile.address_logical, OVERWRITE));
	BK2 	:= 	if(~fileservices.fileexists(modCustTestFile.ssn_logical)     ,BUILDINDEX(Key_InsuranceHeader_SSN().Key,		modCustTestFile.ssn_logical,	 OVERWRITE));
	BK3 	:= 	if(~fileservices.fileexists(modCustTestFile.ssn4_logical)    ,BUILDINDEX(Key_InsuranceHeader_SSN4().Key, 		modCustTestFile.ssn4_logical, 	 OVERWRITE));
	BK4 	:= 	if(~fileservices.fileexists(modCustTestFile.dob_logical)     ,BUILDINDEX(Key_InsuranceHeader_DOB().Key,		modCustTestFile.dob_logical,	 OVERWRITE));
	BK5 	:= 	if(~fileservices.fileexists(modCustTestFile.zip_pr_logical)   ,BUILDINDEX(Key_InsuranceHeader_ZIP_PR().Key,	modCustTestFile.zip_pr_logical,	 OVERWRITE));	
	BK6 	:= 	if(~fileservices.fileexists(modCustTestFile.src_logical)     ,BUILDINDEX(Key_InsuranceHeader_SRC_RID().Key,	modCustTestFile.src_logical,	 OVERWRITE));
	BK7 	:= 	if(~fileservices.fileexists(modCustTestFile.dln_logical)     ,BUILDINDEX(Key_InsuranceHeader_DLN().Key,		modCustTestFile.dln_logical,	 OVERWRITE));
	BK8 	:= 	if(~fileservices.fileexists(modCustTestFile.ph_logical)      ,BUILDINDEX(Key_InsuranceHeader_PH().Key, 		modCustTestFile.ph_logical, 	 OVERWRITE));
	BK9 	:= 	if(~fileservices.fileexists(modCustTestFile.lfz_logical)     ,BUILDINDEX(Key_InsuranceHeader_LFZ().Key, 		modCustTestFile.lfz_logical, 	 OVERWRITE));
	BK10    := 	if(~fileservices.fileexists(modCustTestFile.relative_logical),BUILDINDEX(Key_InsuranceHeader_RELATIVE().Key, 	modCustTestFile.relative_logical,OVERWRITE));
	segmentationKey := InsuranceHeader_PostProcess.segmentation_keys.key_did_ind;
	BK11    := 	if(~fileservices.fileexists(modCustTestFile.seg_logical)     ,BUILDINDEX(segmentationKey, 					modCustTestFile.seg_logical, 	 OVERWRITE));
	BK12 :=  if(~fileservices.fileexists(modCustTestFile.id_history_logical) ,BUILDINDEX(Process_xIDL_Layouts().KeyIDHistory,modCustTestFile.id_history_logical,OVERWRITE));
	BK13    := 	if(~fileservices.fileexists(modCustTestFile.dobf_logical),		BUILDINDEX(Key_InsuranceHeader_DOBF().Key, 	modCustTestFile.dobf_logical,OVERWRITE));
	RETURN SEQUENTIAL(buildSpec,
										PARALLEL(BaseK,BK0,BK1,BK2,BK3,BK4,BK5,
										BK6,BK7,BK8,BK9,BK10,BK11,BK12,BK13)
                    
                   // ,PRTE.UpdateVersion('PersonLABKeys',											//	Package name
                                         // fileVersion,												//	Package version
                                       // _control.MyInfo.EmailAddressNormal,	//	Whom to email with specifics
                                       // 'B',																	//	B = Boca, A = Alpharetta
                                       // 'N',																	//	N = Non-FCRA, F = FCRA
                                       // 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
                                      // )															
  );
END;

