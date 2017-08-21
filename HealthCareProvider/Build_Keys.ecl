import Health_Provider_Services, RoxieKeyBuild;
EXPORT Build_Keys (STRING fileDate = thorlib.wuid () [2..9] + thorlib.wuid () [11..16]) := FUNCTION
	#WORKUNIT ('NAME','Health Care Provider - Build Salt Keys');
	#OPTION('multiplePersistInstances',FALSE);
	CreateKeys			:=	Health_Provider_Services.SuperFiles.create;
	SKey	 	:= Health_Provider_Services.Files.Key_Prefix_Name + '::';
	LKey 		:= Skey + fileDate + '::';
	HFiles 	:= Health_Provider_Services.Files;
		
	HealthCareProvider.Mac_SF_BuildProcess(HealthCareProvider.Files.Person_Salt_Output_DS,
																				 HealthCareProvider.Files.HealthCare_Prefix, 
																				 HealthCareProvider.Files.Header_Suffix, 
																				 fileDate, createHeader, 3, ,true, true);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Keys(Health_Provider_Services.Files.Provider_DS).Specificities_Key,
																							Health_Provider_Services.Files.FILE_Spec_SF,						Health_Provider_Services.Files.FILE_Spec,						KeyDebug);
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Process_xLNPID_Layouts.Key,
																							Health_Provider_Services.Files.FILE_Header_SF,					Health_Provider_Services.Files.FILE_Header,					KeyMeow);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_.Key,
																							Health_Provider_Services.Files.FILE_Header_Refs_SF,			Health_Provider_Services.Files.FILE_Header_Refs,		KeyRefs);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_.ValueKey,
																							Health_Provider_Services.Files.FILE_Header_Words_SF,		Health_Provider_Services.Files.FILE_Header_Words,		KeyWords);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_FNAME.Key,
																							Health_Provider_Services.Files.FILE_FName_SF,						Health_Provider_Services.Files.FILE_FName,					KeyFName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_MNAME.Key,
																							Health_Provider_Services.Files.FILE_MName_SF,						Health_Provider_Services.Files.FILE_MName,					KeyMName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_LNAME.Key,
																							Health_Provider_Services.Files.FILE_LName_SF,						Health_Provider_Services.Files.FILE_LName,					KeyLName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_NAMEL.Key,
																							Health_Provider_Services.Files.FILE_Name_ST_Lic_SF,			Health_Provider_Services.Files.FILE_Name_ST_Lic,		KeyNameStLic);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_NAMED.Key,
																							Health_Provider_Services.Files.FILE_Name_SF,						Health_Provider_Services.Files.FILE_Name,						KeyName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_ADDRESS.Key,
																							Health_Provider_Services.Files.FILE_Address_SF,					Health_Provider_Services.Files.FILE_Address,				KeyAddress);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_SSN_LP.Key,
																							Health_Provider_Services.Files.FILE_SSN_SF,							Health_Provider_Services.Files.FILE_SSN,						KeySSN);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_CNSMR_SSN_LP.Key,
																							Health_Provider_Services.Files.FILE_CNSMR_SSN_SF,				Health_Provider_Services.Files.FILE_CNSMR_SSN,			KeyCNSMRSSN);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_DOB_LP.Key,
																							Health_Provider_Services.Files.FILE_DOB_SF,							Health_Provider_Services.Files.FILE_DOB,						KeyDOB);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_CNSMR_DOB_LP.Key,
																							Health_Provider_Services.Files.FILE_CNSMR_DOB_SF,				Health_Provider_Services.Files.FILE_CNSMR_DOB,			KeyCNSMRDOB);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_PHONE_LP.Key,
																							Health_Provider_Services.Files.FILE_PHONE_SF,						Health_Provider_Services.Files.FILE_PHONE,					KeyPhone);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_ZIP_PR.Key,
																							Health_Provider_Services.Files.FILE_ZIP_SF,							Health_Provider_Services.Files.FILE_ZIP,						KeyZip);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_LIC.Key,
																							Health_Provider_Services.Files.FILE_LIC_SF,							Health_Provider_Services.Files.FILE_LIC,						KeyLIC);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_VEN.Key,
																							Health_Provider_Services.Files.FILE_VendorID_SF,				Health_Provider_Services.Files.FILE_VendorID,				KeyVendorID);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_TAX.Key,
																							Health_Provider_Services.Files.FILE_Tax_SF,							Health_Provider_Services.Files.FILE_Tax,						KeyTax);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_BILLING_TAX.Key,
																							Health_Provider_Services.Files.FILE_Billing_Tax_SF,			Health_Provider_Services.Files.FILE_Billing_Tax,		KeyBillingTax);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_DEA.Key,
																							Health_Provider_Services.Files.FILE_DEA_SF,							Health_Provider_Services.Files.FILE_DEA,						KeyDEA);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_NPI.Key,
																							Health_Provider_Services.Files.FILE_NPI_SF,							Health_Provider_Services.Files.FILE_NPI,						KeyNPI);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_BILLING_NPI.Key,
																							Health_Provider_Services.Files.FILE_Billing_NPI_SF,			Health_Provider_Services.Files.FILE_Billing_NPI,		KeyBillingNPI);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_UPN.Key,
																							Health_Provider_Services.Files.FILE_UPIN_SF,						Health_Provider_Services.Files.FILE_UPIN,						KeyUPIN);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_LEXID.Key,
																							Health_Provider_Services.Files.FILE_LexID_SF,		    		Health_Provider_Services.Files.FILE_LexID,					KeyLexID);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_BID.Key,
																							Health_Provider_Services.Files.FILE_BDID_SF,						Health_Provider_Services.Files.FILE_BDID,						KeyBDID);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_SRC_RID.Key,
																							Health_Provider_Services.Files.FILE_Source_RID_SF,			Health_Provider_Services.Files.FILE_Source_RID,			KeySourceRID);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Provider_Services.Key_HealthProvider_RID.Key,
																							Health_Provider_Services.Files.FILE_RID_SF,							Health_Provider_Services.Files.FILE_RID,						KeyRID);


	BuildKey := PARALLEL (keyDebug,keyMeow,keyRefs,keyWords,KeyFName,KeyMName,KeyLName,KeyNameStLic,KeyName,KeyAddress,KeySSN,KeyCNSMRSSN,KeyDOB,KeyCNSMRDOB,KeyPhone,KeyZip,KeyLIC,KeyVendorID,KeyTax,KeyBillingTax,KeyDEA,KeyNPI,KeyBillingNPI,KeyUPIN,KeyLexID,KeyBDID,KeySourceRID,KeyRID);
	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Specificities,		 		LKey+HFiles.Suffix_Name_Specificities,				moveDebug);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header,		 				 	LKey+HFiles.Suffix_Name_Header,								moveMeow);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Refs,		 		 	LKey+HFiles.Suffix_Name_Header_Refs,					moveRefs);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Words,			 	LKey+HFiles.Suffix_Name_Header_Words,					moveWords);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_FName,		 					 	LKey+HFiles.Suffix_Name_FName,								moveFName);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_MName,		 					 	LKey+HFiles.Suffix_Name_MName,								moveMName);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_LName,		 				 		LKey+HFiles.Suffix_Name_LName,								moveLName);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Name_ST_Lic,		 			LKey+HFiles.Suffix_Name_Name_ST_Lic,					moveNameStLic);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Name,		 				 		LKey+HFiles.Suffix_Name_Name,									moveName);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Address,		 				 	LKey+HFiles.Suffix_Name_Address,							moveAddress);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_SSN,		 				 			LKey+HFiles.Suffix_Name_SSN,									moveSSN);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_CNSMR_SSN,		 				LKey+HFiles.Suffix_Name_CNSMR_SSN,						moveCNSMRSSN);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_DOB,		 				 			LKey+HFiles.Suffix_Name_DOB,									moveDOB);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_CNSMR_DOB,		 				LKey+HFiles.Suffix_Name_CNSMR_DOB,						moveCNSMRDOB);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_PHONE,		 					 	LKey+HFiles.Suffix_Name_PHONE,								movePhone);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_ZIP,		 				 			LKey+HFiles.Suffix_Name_ZIP,									moveZip);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Lic,		 				 			LKey+HFiles.Suffix_Name_Lic,									moveLIC);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_VendorID,		 			 	LKey+HFiles.Suffix_Name_VendorID,							moveVendorID);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Tax,		 				 			LKey+HFiles.Suffix_Name_Tax,									moveTax);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Billing_Tax,		 			LKey+HFiles.Suffix_Name_Billing_Tax,					moveBillingTax);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_DEA,		 				 			LKey+HFiles.Suffix_Name_DEA,									moveDEA);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_NPI,		 				 			LKey+HFiles.Suffix_Name_NPI,									moveNPI);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Billing_NPI,		 			LKey+HFiles.Suffix_Name_Billing_NPI,					moveBillingNPI);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_UPIN,		 				 		LKey+HFiles.Suffix_Name_UPIN,									moveUPIN);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_LexID,		 					 	LKey+HFiles.Suffix_Name_LexID,								moveLexID);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_BDID,		 				 		LKey+HFiles.Suffix_Name_BDID,									moveBDID);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Source_RID,		 	 		LKey+HFiles.Suffix_Name_Source_RID,						moveSourceRID);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_RID,		 	 						LKey+HFiles.Suffix_Name_RID,									moveRID);
	
	MoveKey := PARALLEL (moveDebug,moveMeow,moveRefs,moveWords,moveFName,moveMName,moveLName,moveNameStLic,moveName,moveAddress,moveSSN,moveCNSMRSSN,moveDOB,moveCNSMRDOB,movePhone,moveZip,moveLIC,moveVendorID,moveTax,moveBillingTax,moveDEA,moveNPI,moveBillingNPI,moveUPIN,moveLexID,moveBDID,moveSourceRID,moveRID);

	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Specificities,		 	'Q',	moveDebug_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header,		 				 	'Q',	moveMeow_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Refs,		 		'Q',	moveRefs_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Words,			 	'Q',	moveWords_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_FName,		 					'Q',	moveFName_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_MName,		 					'Q',	moveMName_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_LName,		 				 	'Q',	moveLName_QA);	
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Name_ST_Lic,		 		'Q',	moveNameStLic_QA);	
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Name,		 				 		'Q',	moveName_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Address,		 				'Q',	moveAddress_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_SSN,		 				 		'Q',	moveSSN_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_CNSMR_SSN,		 			'Q',	moveCNSMRSSN_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_DOB,		 				 		'Q',	moveDOB_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_CNSMR_DOB,		 			'Q',	moveCNSMRDOB_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_PHONE,		 					'Q',	movePhone_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_ZIP,		 				 		'Q',	moveZip_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Lic,		 				 		'Q',	moveLIC_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_VendorID,		 			 	'Q',	moveVendorID_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Tax,		 				 		'Q',	moveTax_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Billing_Tax,		 		'Q',	moveBillingTax_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_DEA,		 				 		'Q',	moveDEA_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_NPI,		 				 		'Q',	moveNPI_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Billing_NPI,		 		'Q',	moveBillingNPI_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_UPIN,		 				 		'Q',	moveUPIN_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_LexID,		 					'Q',	moveLexID_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_BDID,		 				 		'Q',	moveBDID_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Source_RID,			 		'Q',	moveSourceRID_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_RID,			 					'Q',	moveRID_QA);

	MoveKeyQA := PARALLEL (moveDebug_QA,moveMeow_QA,moveRefs_QA,moveWords_QA,moveFName_QA,moveMName_QA,moveLName_QA,moveNameStLic_QA,moveName_QA,moveAddress_QA,moveSSN_QA,moveCNSMRSSN_QA,moveDOB_QA,moveCNSMRDOB_QA,movePhone_QA,moveZip_QA,moveLIC_QA,moveVendorID_QA,moveTax_QA,moveBillingTax_QA,moveDEA_QA,moveNPI_QA,moveBillingNPI_QA,moveUPIN_QA,moveLexID_QA,moveBDID_QA,moveSourceRID_QA,moveRID_QA);

	cleanFile := SEQUENTIAL(FileServices.StartSuperFileTransaction(),
													FileServices.ClearSuperFile(HealthCareProvider.Files.Person_in_SF,true),
													FileServices.ClearSuperFile(HealthCareProvider.Files.Person_in_Father_SF,true),
													FileServices.ClearSuperFile(HealthCareProvider.Files.Person_in_GrandFather_SF,true),
													FileServices.ClearSuperFile(HealthCareProvider.Files.Person_in_Delete_SF,true),
													FileServices.FinishSuperFileTransaction());
													
	// RETURN SEQUENTIAL (CreateKeys,createHeader,GenerateKeys,PromoteKeys,cleanFile);
	// RETURN SEQUENTIAL (createHeader,CreateKeys,BuildKey,MoveKey,MoveKeyQA);
	RETURN SEQUENTIAL (CreateKeys,createHeader,BuildKey,MoveKey,MoveKeyQA);
	// RETURN SEQUENTIAL (CreateKeys,BuildKey,MoveKey,MoveKeyQA);
END;
