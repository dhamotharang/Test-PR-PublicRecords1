import Health_Facility_Services, RoxieKeyBuild, HealthCareFacilityHeader,HealthCareProvider;
EXPORT Build_Keys (STRING fileDate = thorlib.wuid () [2..9] + thorlib.wuid () [11..16]) := FUNCTION
	#WORKUNIT ('NAME','Health Care Facility - Build Salt Keys');
	CreateKeys			:=	Health_Facility_Services.SuperFiles.create;
	SKey	 	:= Health_Facility_Services.Files.Key_Prefix_Name + '::';
	LKey 		:= Skey + fileDate + '::';
	HFiles 	:= Health_Facility_Services.Files;
	
	HealthCareProvider.Mac_SF_BuildProcess(HealthCareFacility.Files.facility_Salt_Output_DS,
																				 HealthCareFacility.Files.HealthCare_Prefix, 
																				 HealthCareFacility.Files.Header_Suffix, 
																				 fileDate, createHeader, 3, ,true, true);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Keys(Health_Facility_Services.Files.Facility_Header_DS).Specificities_Key,
																							Health_Facility_Services.Files.FILE_Spec_SF,						Health_Facility_Services.Files.FILE_Spec,						KeyDebug);
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Process_xLNPID_Layouts.Key,
																							Health_Facility_Services.Files.FILE_Header_SF,					Health_Facility_Services.Files.FILE_Header,					KeyMeow);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_.Key,
																							Health_Facility_Services.Files.FILE_Header_Refs_SF,			Health_Facility_Services.Files.FILE_Header_Refs,		KeyRefs);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_.ValueKey,
																							Health_Facility_Services.Files.FILE_Header_Words_SF,		Health_Facility_Services.Files.FILE_Header_Words,		KeyWords);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_BNAME.Key,
																							Health_Facility_Services.Files.FILE_BName_SF,						Health_Facility_Services.Files.FILE_BName,					KeyBName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.specificities(HealthCareFacility.Files.Facility_Header_DS).CNP_NAME_values_key,
																							Health_Facility_Services.Files.FILE_BName_Values_SF,		Health_Facility_Services.Files.FILE_BName_Values,		KeyBVName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_SBNAME.Key,
																							Health_Facility_Services.Files.FILE_BName_St_SF,				Health_Facility_Services.Files.FILE_BName_St,				KeySBName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_ZBNAME.Key,
																							Health_Facility_Services.Files.FILE_BName_Zip_SF,				Health_Facility_Services.Files.FILE_BName_Zip,			KeyZBName);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_ADDRESS.Key,
																							Health_Facility_Services.Files.FILE_Address_SF,					Health_Facility_Services.Files.FILE_Address,				KeyAddress);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_ZIP_LP.Key,
																							Health_Facility_Services.Files.FILE_ZIP_SF,							Health_Facility_Services.Files.FILE_Zip,						KeyZip);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_City_LP.Key,
																							Health_Facility_Services.Files.FILE_City_SF,						Health_Facility_Services.Files.FILE_City,						KeyCity);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_PHONE_LP.Key,
																							Health_Facility_Services.Files.FILE_PHONE_SF,						Health_Facility_Services.Files.FILE_PHONE,					KeyPhone);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_FAX_LP.Key,
																							Health_Facility_Services.Files.FILE_FAX_SF,							Health_Facility_Services.Files.FILE_FAX,						KeyFax);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_LIC.Key,
																							Health_Facility_Services.Files.FILE_LIC_SF,							Health_Facility_Services.Files.FILE_LIC,						KeyLIC);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_VEN.Key,
																							Health_Facility_Services.Files.FILE_VendorID_SF,				Health_Facility_Services.Files.FILE_VendorID,				KeyVendorID);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_TAX.Key,
																							Health_Facility_Services.Files.FILE_Tax_SF,							Health_Facility_Services.Files.FILE_Tax,						KeyTax);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_FEN.Key,
																							Health_Facility_Services.Files.FILE_Fein_SF,						Health_Facility_Services.Files.FILE_FEIN,						KeyFein);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_DEA.Key,
																							Health_Facility_Services.Files.FILE_DEA_SF,							Health_Facility_Services.Files.FILE_DEA,						KeyDEA);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_NPI.Key,
																							Health_Facility_Services.Files.FILE_NPI_SF,							Health_Facility_Services.Files.FILE_NPI,						KeyNPI);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_ADDR_NPI.Key,
																							Health_Facility_Services.Files.FILE_ADDR_NPI_SF,				Health_Facility_Services.Files.FILE_ADDR_NPI,				KeyADDRNPI);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_CLIA.Key,
																							Health_Facility_Services.Files.FILE_CLIA_SF,						Health_Facility_Services.Files.FILE_CLIA,						KeyCLIA);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_MEDICARE.Key,
																							Health_Facility_Services.Files.FILE_MEDICARE_SF,				Health_Facility_Services.Files.FILE_MEDICARE,				KeyMEDICARE);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_MEDICAID.Key,
																							Health_Facility_Services.Files.FILE_MEDICAID_SF,				Health_Facility_Services.Files.FILE_MEDICAID,				KeyMEDICAID);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_NCPDP.Key,
																							Health_Facility_Services.Files.FILE_NCPDP_SF,						Health_Facility_Services.Files.FILE_NCPDP,					KeyNCPDP);

	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local (Health_Facility_Services.Key_HealthFacility_BID.Key,
																							Health_Facility_Services.Files.FILE_BDID_SF,						Health_Facility_Services.Files.FILE_BDID,						KeyBDID);

	BuildKey := PARALLEL (keyDebug,keyMeow,keyRefs,keyWords,KeyBName,KeyBVName,KeySBName,KeyZBName,KeyAddress,KeyZip,KeyCity,KeyPhone,KeyFax,KeyLIC,KeyVendorID,KeyTax,KeyFein,KeyDEA,KeyNPI,KeyADDRNPI,KeyCLIA,KeyMEDICARE,KeyMEDICAID,KeyNCPDP,KeyBDID);
	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Specificities,		 		LKey+HFiles.Suffix_Name_Specificities,				moveDebug);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header,		 				 	LKey+HFiles.Suffix_Name_Header,								moveMeow);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Refs,		 		 	LKey+HFiles.Suffix_Name_Header_Refs,					moveRefs);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Words,			 	LKey+HFiles.Suffix_Name_Header_Words,					moveWords);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName,		 					 	LKey+HFiles.Suffix_Name_BName,								moveBName);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName_Values,			 	LKey+HFiles.Suffix_Name_BName_Values,					moveBVName);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName_St,		 				LKey+HFiles.Suffix_Name_BName_St,							moveSBName);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName_Zip,		 				LKey+HFiles.Suffix_Name_BName_Zip,						moveZBName);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Address,		 				 	LKey+HFiles.Suffix_Name_Address,							moveAddress);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Zip,		 				 			LKey+HFiles.Suffix_Name_Zip,									moveZip);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_City,		 				 		LKey+HFiles.Suffix_Name_City,									moveCity);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_PHONE,		 					 	LKey+HFiles.Suffix_Name_PHONE,								movePhone);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_FAX,			 					 	LKey+HFiles.Suffix_Name_FAX,									moveFax);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Lic,		 				 			LKey+HFiles.Suffix_Name_Lic,									moveLIC);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_VendorID,		 			 	LKey+HFiles.Suffix_Name_VendorID,							moveVendorID);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Tax,		 				 			LKey+HFiles.Suffix_Name_Tax,									moveTax);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_Fein,	 				 			LKey+HFiles.Suffix_Name_Fein,									moveFein);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_DEA,		 				 			LKey+HFiles.Suffix_Name_DEA,									moveDEA);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_NPI,		 				 			LKey+HFiles.Suffix_Name_NPI,									moveNPI);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_ADDR_NPI,		 				LKey+HFiles.Suffix_Name_ADDR_NPI,							moveADDRNPI);	
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_CLIA,		 				 		LKey+HFiles.Suffix_Name_CLIA,									moveCLIA);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_MEDICARE,		 				LKey+HFiles.Suffix_Name_MEDICARE,							moveMEDICARE);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_MEDICAID,		 				LKey+HFiles.Suffix_Name_MEDICAID,							moveMEDICAID);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_NCPDP,		 				 		LKey+HFiles.Suffix_Name_NCPDP,								moveNCPDP);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Skey +'@version@::' + HFiles.Suffix_Name_BDID,		 				 		LKey+HFiles.Suffix_Name_BDID,									moveBDID);

	MoveKey := PARALLEL (moveDebug,moveMeow,moveRefs,moveWords,moveBName,moveBVName,moveSBName,moveZBName,moveAddress,moveZip,moveCity,movePhone,moveFax,moveLIC,moveVendorID,moveTax,moveFein,moveDEA,moveNPI,moveADDRNPI,moveCLIA,moveMEDICARE,moveMEDICAID,moveNCPDP,moveBDID);

	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Specificities,		 	'Q',	moveDebug_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header,		 				 	'Q',	moveMeow_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Refs,		 		'Q',	moveRefs_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Header_Words,			 	'Q',	moveWords_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName,		 					'Q',	moveBName_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName_Values,				'Q',	moveBVName_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName_St,		 			 	'Q',	moveSBName_QA);	
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_BName_Zip,		 			'Q',	moveZBName_QA);	
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Address,		 				'Q',	moveAddress_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Zip,		 				 		'Q',	moveZip_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_City,		 				 		'Q',	moveCity_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_PHONE,		 					'Q',	movePhone_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_FAX,			 					'Q',	moveFax_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Lic,		 				 		'Q',	moveLIC_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_VendorID,		 			 	'Q',	moveVendorID_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Tax,		 				 		'Q',	moveTax_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_Fein,		 				 		'Q',	moveFein_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_DEA,		 				 		'Q',	moveDEA_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_NPI,		 				 		'Q',	moveNPI_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_ADDR_NPI,				 		'Q',	moveADDRNPI_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_CLIA,		 				 		'Q',	moveCLIA_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_MEDICARE,		 		 		'Q',	moveMEDICARE_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_MEDICAID,		 		 		'Q',	moveMEDICAID_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_NCPDP,		 			 		'Q',	moveNCPDP_QA);
	RoxieKeyBuild.MAC_SK_Move_V2(Skey +'@version@::' + HFiles.Suffix_Name_BDID,		 				 		'Q',	moveBDID_QA);

	MoveKeyQA := PARALLEL (moveDebug_QA,moveMeow_QA,moveRefs_QA,moveWords_QA,moveBName_QA,moveBVName_QA,moveSBName_QA,moveZBName_QA,moveAddress_QA,moveZip_QA,moveCity_QA,movePhone_QA,moveFax_QA,moveLIC_QA,moveVendorID_QA,moveTax_QA,moveFein_QA,moveDEA_QA,moveNPI_QA,moveADDRNPI_QA,moveCLIA_QA,moveMEDICARE_QA,moveMEDICAID_QA,moveNCPDP_QA,moveBDID_QA);

	cleanFile := SEQUENTIAL(FileServices.StartSuperFileTransaction(),
													FileServices.ClearSuperFile(HealthCareFacility.Files.Facility_in_SF,true),
													FileServices.ClearSuperFile(HealthCareFacility.Files.Facility_in_Father_SF,true),
													FileServices.ClearSuperFile(HealthCareFacility.Files.Facility_in_GrandFather_SF,true),
													FileServices.ClearSuperFile(HealthCareFacility.Files.Facility_in_Delete_SF,true),
													FileServices.FinishSuperFileTransaction());
													
	// RETURN SEQUENTIAL (CreateKeys,createHeader,GenerateKeys,PromoteKeys,cleanFile);
	// RETURN SEQUENTIAL (createHeader,CreateKeys,BuildKey,MoveKey,MoveKeyQA);
	RETURN SEQUENTIAL (createHeader,CreateKeys,BuildKey,MoveKey,MoveKeyQA);
END;
