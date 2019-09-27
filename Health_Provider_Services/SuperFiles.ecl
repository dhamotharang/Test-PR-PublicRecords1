EXPORT SuperFiles := MODULE

	EXPORT create := 
	
		SEQUENTIAL (
			IF (~FileServices.FileExists (Files.FILE_Spec_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Spec_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Spec_SF),
					FileServices.CreateSuperFile (Files.FILE_Spec_SF)),
			IF (~FileServices.FileExists (Files.FILE_Spec_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Spec_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Spec_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Spec_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Header_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Header_Refs_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Refs_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_Refs_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Refs_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_Refs_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Refs_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_Refs_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Refs_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Header_Words_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Words_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_Words_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Words_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_Words_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Words_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Header_Words_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Header_Words_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_FName_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_FName_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_FName_SF),
					FileServices.CreateSuperFile (Files.FILE_FName_SF)),
			IF (~FileServices.FileExists (Files.FILE_FName_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_FName_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_FName_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_FName_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_LName_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_LName_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_LName_SF),
					FileServices.CreateSuperFile (Files.FILE_LName_SF)),
			IF (~FileServices.FileExists (Files.FILE_LName_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_LName_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_LName_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_LName_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Name_ST_Lic_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_ST_Lic_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Name_ST_Lic_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_ST_Lic_SF)),
			IF (~FileServices.FileExists (Files.FILE_Name_ST_Lic_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_ST_Lic_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Name_ST_Lic_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_ST_Lic_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Name_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Name_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_SF)),
			IF (~FileServices.FileExists (Files.FILE_Name_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Name_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Name_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Address_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Address_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_SF)),
			IF (~FileServices.FileExists (Files.FILE_Address_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Address_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_SSN_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_SSN_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_SSN_SF),
					FileServices.CreateSuperFile (Files.FILE_SSN_SF)),
			IF (~FileServices.FileExists (Files.FILE_SSN_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_SSN_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_SSN_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_SSN_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_DOB_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_DOB_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_DOB_SF),
					FileServices.CreateSuperFile (Files.FILE_DOB_SF)),
			IF (~FileServices.FileExists (Files.FILE_DOB_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_DOB_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_DOB_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_DOB_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_PHONE_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_PHONE_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_SF)),
			IF (~FileServices.FileExists (Files.FILE_PHONE_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_PHONE_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_ZIP_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_ZIP_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_ZIP_SF),
					FileServices.CreateSuperFile (Files.FILE_ZIP_SF)),
			IF (~FileServices.FileExists (Files.FILE_ZIP_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_ZIP_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_ZIP_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_ZIP_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_LIC_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_LIC_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_LIC_SF),
					FileServices.CreateSuperFile (Files.FILE_LIC_SF)),
			IF (~FileServices.FileExists (Files.FILE_LIC_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_LIC_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_LIC_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_LIC_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_VendorID_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_VendorID_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_VendorID_SF),
					FileServices.CreateSuperFile (Files.FILE_VendorID_SF)),
			IF (~FileServices.FileExists (Files.FILE_VendorID_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_VendorID_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_VendorID_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_VendorID_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Tax_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Tax_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Tax_SF),
					FileServices.CreateSuperFile (Files.FILE_Tax_SF)),
			IF (~FileServices.FileExists (Files.FILE_Tax_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Tax_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Tax_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Tax_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_DEA_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_DEA_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_DEA_SF),
					FileServices.CreateSuperFile (Files.FILE_DEA_SF)),
			IF (~FileServices.FileExists (Files.FILE_DEA_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_DEA_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_DEA_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_DEA_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_NPI_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_NPI_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_NPI_SF),
					FileServices.CreateSuperFile (Files.FILE_NPI_SF)),
			IF (~FileServices.FileExists (Files.FILE_NPI_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_NPI_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_NPI_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_NPI_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_UPIN_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_UPIN_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_UPIN_SF),
					FileServices.CreateSuperFile (Files.FILE_UPIN_SF)),
			IF (~FileServices.FileExists (Files.FILE_UPIN_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_UPIN_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_UPIN_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_UPIN_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_LexID_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_LexID_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_LexID_SF),
					FileServices.CreateSuperFile (Files.FILE_LexID_SF)),
			IF (~FileServices.FileExists (Files.FILE_LexID_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_LexID_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_LexID_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_LexID_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_BDID_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_BDID_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_BDID_SF),
					FileServices.CreateSuperFile (Files.FILE_BDID_SF)),
			IF (~FileServices.FileExists (Files.FILE_BDID_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_BDID_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_BDID_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_BDID_GrandFather_SF)),
		);
	
	EXPORT clearFiles () := FUNCTION
		action := SEQUENTIAL(
								FileServices.StartSuperFileTransaction (),
								FileServices.ClearSuperFile (Files.FILE_Spec_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Spec_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Spec_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Spec_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_Header_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_Header_Refs_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_Refs_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_Refs_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_Refs_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_Header_Words_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_Words_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_Words_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Header_Words_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_FName_Built_SF,true),								
								FileServices.ClearSuperFile (Files.FILE_FName_SF,true),
								FileServices.ClearSuperFile (Files.FILE_FName_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_FName_GrandFather_SF,true),

								FileServices.ClearSuperFile (Files.FILE_LName_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LName_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LName_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LName_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_Name_ST_Lic_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Name_ST_Lic_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Name_ST_Lic_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Name_ST_Lic_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_Name_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Name_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Name_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Name_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_Address_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Address_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Address_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Address_GrandFather_SF,true),								
								
								FileServices.ClearSuperFile (Files.FILE_SSN_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_SSN_SF,true),
								FileServices.ClearSuperFile (Files.FILE_SSN_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_SSN_GrandFather_SF,true),								
								
								FileServices.ClearSuperFile (Files.FILE_DOB_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DOB_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DOB_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DOB_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_PHONE_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_PHONE_SF,true),
								FileServices.ClearSuperFile (Files.FILE_PHONE_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_PHONE_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_ZIP_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_ZIP_SF,true),
								FileServices.ClearSuperFile (Files.FILE_ZIP_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_ZIP_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_LIC_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LIC_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LIC_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LIC_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_VendorID_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_VendorID_SF,true),
								FileServices.ClearSuperFile (Files.FILE_VendorID_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_VendorID_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_Tax_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Tax_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Tax_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Tax_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_DEA_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DEA_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DEA_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DEA_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_NPI_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NPI_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NPI_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NPI_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_UPIN_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_UPIN_SF,true),
								FileServices.ClearSuperFile (Files.FILE_UPIN_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_UPIN_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_LexID_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LexID_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LexID_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_LexID_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_BDID_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BDID_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BDID_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BDID_GrandFather_SF,true),								
								FileServices.FinishSuperFileTransaction ()																					 																					 
						);
		return action;
	END;

	EXPORT PromoteFiles () := FUNCTION
		action := SEQUENTIAL(	
					FileServices.PromoteSuperFileList ([Files.FILE_Spec_SF,					Files.FILE_Spec_Father_SF],					Files.FILE_Spec,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Header_SF,				Files.FILE_Header_Father_SF],				Files.FILE_Header,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Header_Refs_SF,	Files.FILE_Header_Refs_Father_SF],	Files.FILE_Header_Refs,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Header_Words_SF,	Files.FILE_Header_Words_Father_SF],	Files.FILE_Header_Words,true);
					FileServices.PromoteSuperFileList ([Files.FILE_FName_SF,				Files.FILE_FName_Father_SF],				Files.FILE_FName,true);
					FileServices.PromoteSuperFileList ([Files.FILE_LName_SF,				Files.FILE_LName_Father_SF],				Files.FILE_LName,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Name_ST_Lic_SF,	Files.FILE_Name_ST_Lic_Father_SF],	Files.FILE_Name_St_LIC,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Name_SF,					Files.FILE_Name_Father_SF],					Files.FILE_Name,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Address_SF,			Files.FILE_Address_Father_SF],			Files.FILE_Address,true);
					FileServices.PromoteSuperFileList ([Files.FILE_SSN_SF,					Files.FILE_SSN_Father_SF],					Files.FILE_SSN,true);
					FileServices.PromoteSuperFileList ([Files.FILE_DOB_SF,					Files.FILE_DOB_Father_SF],					Files.FILE_DOB,true);					
					FileServices.PromoteSuperFileList ([Files.FILE_PHONE_SF,				Files.FILE_PHONE_Father_SF],				Files.FILE_PHONE,true);										
					FileServices.PromoteSuperFileList ([Files.FILE_ZIP_SF,					Files.FILE_ZIP_Father_SF],					Files.FILE_ZIP,true);
					FileServices.PromoteSuperFileList ([Files.FILE_LIC_SF,					Files.FILE_LIC_Father_SF],					Files.FILE_LIC,true);
					FileServices.PromoteSuperFileList ([Files.FILE_VendorID_SF,			Files.FILE_VendorID_Father_SF],			Files.FILE_VendorID,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Tax_SF,					Files.FILE_Tax_Father_SF],					Files.FILE_Tax,true);
					FileServices.PromoteSuperFileList ([Files.FILE_DEA_SF,					Files.FILE_DEA_Father_SF],					Files.FILE_DEA,true);
					FileServices.PromoteSuperFileList ([Files.FILE_NPI_SF,					Files.FILE_NPI_Father_SF],					Files.FILE_NPI,true);
					FileServices.PromoteSuperFileList ([Files.FILE_UPIN_SF,					Files.FILE_UPIN_Father_SF],					Files.FILE_UPIN,true);
					FileServices.PromoteSuperFileList ([Files.FILE_LexID_SF,				Files.FILE_LexID_Father_SF],				Files.FILE_LexID,true);
					FileServices.PromoteSuperFileList ([Files.FILE_BDID_SF,					Files.FILE_BDID_Father_SF],					Files.FILE_BDID,true);					
		);
		
		RETURN action;
	END;
END;
