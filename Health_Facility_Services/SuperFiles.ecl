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

			IF (~FileServices.FileExists (Files.FILE_BName_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_BName_Values_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Values_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_Values_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Values_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_Values_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Values_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_Values_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Values_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_BName_St_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_St_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_St_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_St_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_St_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_St_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_St_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_St_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_BName_Zip_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Zip_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_Zip_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Zip_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_Zip_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Zip_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_BName_Zip_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_BName_Zip_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Address_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Address_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_SF)),
			IF (~FileServices.FileExists (Files.FILE_Address_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Address_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Address_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_Zip_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Zip_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Zip_SF),
					FileServices.CreateSuperFile (Files.FILE_Zip_SF)),
			IF (~FileServices.FileExists (Files.FILE_Zip_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Zip_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Zip_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Zip_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_City_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_City_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_City_SF),
					FileServices.CreateSuperFile (Files.FILE_City_SF)),
			IF (~FileServices.FileExists (Files.FILE_City_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_City_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_City_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_City_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_PHONE_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_PHONE_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_SF)),
			IF (~FileServices.FileExists (Files.FILE_PHONE_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_PHONE_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_PHONE_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_FAX_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_FAX_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_FAX_SF),
					FileServices.CreateSuperFile (Files.FILE_FAX_SF)),
			IF (~FileServices.FileExists (Files.FILE_FAX_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_FAX_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_FAX_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_FAX_GrandFather_SF)),

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

			IF (~FileServices.FileExists (Files.FILE_Fein_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_Fein_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_Fein_SF),
					FileServices.CreateSuperFile (Files.FILE_Fein_SF)),
			IF (~FileServices.FileExists (Files.FILE_Fein_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_Fein_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_Fein_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_Fein_GrandFather_SF)),

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

			IF (~FileServices.FileExists (Files.FILE_ADDR_NPI_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_ADDR_NPI_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_ADDR_NPI_SF),
					FileServices.CreateSuperFile (Files.FILE_ADDR_NPI_SF)),
			IF (~FileServices.FileExists (Files.FILE_ADDR_NPI_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_ADDR_NPI_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_ADDR_NPI_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_ADDR_NPI_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_CLIA_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_CLIA_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_CLIA_SF),
					FileServices.CreateSuperFile (Files.FILE_CLIA_SF)),
			IF (~FileServices.FileExists (Files.FILE_CLIA_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_CLIA_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_CLIA_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_CLIA_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_MEDICARE_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICARE_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_MEDICARE_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICARE_SF)),
			IF (~FileServices.FileExists (Files.FILE_MEDICARE_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICARE_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_MEDICARE_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICARE_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_MEDICAID_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICAID_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_MEDICAID_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICAID_SF)),
			IF (~FileServices.FileExists (Files.FILE_MEDICAID_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICAID_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_MEDICAID_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_MEDICAID_GrandFather_SF)),

			IF (~FileServices.FileExists (Files.FILE_NCPDP_Built_SF),
					FileServices.CreateSuperFile (Files.FILE_NCPDP_Built_SF)),
			IF (~FileServices.FileExists (Files.FILE_NCPDP_SF),
					FileServices.CreateSuperFile (Files.FILE_NCPDP_SF)),
			IF (~FileServices.FileExists (Files.FILE_NCPDP_Father_SF),
					FileServices.CreateSuperFile (Files.FILE_NCPDP_Father_SF)),
			IF (~FileServices.FileExists (Files.FILE_NCPDP_GrandFather_SF),
					FileServices.CreateSuperFile (Files.FILE_NCPDP_GrandFather_SF)),

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
								
								FileServices.ClearSuperFile (Files.FILE_BName_Built_SF,true),								
								FileServices.ClearSuperFile (Files.FILE_BName_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_GrandFather_SF,true),

								FileServices.ClearSuperFile (Files.FILE_BName_Values_Built_SF,true),								
								FileServices.ClearSuperFile (Files.FILE_BName_Values_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_Values_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_Values_GrandFather_SF,true),

								FileServices.ClearSuperFile (Files.FILE_BName_St_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_St_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_St_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_St_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_BName_Zip_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_Zip_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_Zip_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_BName_Zip_GrandFather_SF,true),

								FileServices.ClearSuperFile (Files.FILE_Address_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Address_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Address_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Address_GrandFather_SF,true),								
								
								FileServices.ClearSuperFile (Files.FILE_Zip_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Zip_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Zip_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Zip_GrandFather_SF,true),								
								
								FileServices.ClearSuperFile (Files.FILE_City_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_City_SF,true),
								FileServices.ClearSuperFile (Files.FILE_City_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_City_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_PHONE_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_PHONE_SF,true),
								FileServices.ClearSuperFile (Files.FILE_PHONE_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_PHONE_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_FAX_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_FAX_SF,true),
								FileServices.ClearSuperFile (Files.FILE_FAX_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_FAX_GrandFather_SF,true),

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
								
								FileServices.ClearSuperFile (Files.FILE_Fein_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Fein_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Fein_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_Fein_GrandFather_SF,true),

								FileServices.ClearSuperFile (Files.FILE_DEA_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DEA_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DEA_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_DEA_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_NPI_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NPI_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NPI_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NPI_GrandFather_SF,true),
								
								FileServices.ClearSuperFile (Files.FILE_ADDR_NPI_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_ADDR_NPI_SF,true),
								FileServices.ClearSuperFile (Files.FILE_ADDR_NPI_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_ADDR_NPI_GrandFather_SF,true),

								FileServices.ClearSuperFile (Files.FILE_CLIA_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_CLIA_SF,true),
								FileServices.ClearSuperFile (Files.FILE_CLIA_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_CLIA_GrandFather_SF,true),								

								FileServices.ClearSuperFile (Files.FILE_MEDICARE_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_MEDICARE_SF,true),
								FileServices.ClearSuperFile (Files.FILE_MEDICARE_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_MEDICARE_GrandFather_SF,true),								

								FileServices.ClearSuperFile (Files.FILE_MEDICAID_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_MEDICAID_SF,true),
								FileServices.ClearSuperFile (Files.FILE_MEDICAID_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_MEDICAID_GrandFather_SF,true),								

								FileServices.ClearSuperFile (Files.FILE_NCPDP_Built_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NCPDP_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NCPDP_Father_SF,true),
								FileServices.ClearSuperFile (Files.FILE_NCPDP_GrandFather_SF,true),								

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
					FileServices.PromoteSuperFileList ([Files.FILE_BName_SF,				Files.FILE_BName_Father_SF],				Files.FILE_BName,true);
					FileServices.PromoteSuperFileList ([Files.FILE_BName_Values_SF,	Files.FILE_BName_Values_Father_SF],	Files.FILE_BName_Values,true);
					FileServices.PromoteSuperFileList ([Files.FILE_BName_St_SF,			Files.FILE_BName_St_Father_SF],			Files.FILE_BName_St,true);
					FileServices.PromoteSuperFileList ([Files.FILE_BName_Zip_SF,		Files.FILE_BName_Zip_Father_SF],		Files.FILE_BName_Zip,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Address_SF,			Files.FILE_Address_Father_SF],			Files.FILE_Address,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Zip_SF,					Files.FILE_Zip_Father_SF],					Files.FILE_Zip,true);
					FileServices.PromoteSuperFileList ([Files.FILE_City_SF,					Files.FILE_City_Father_SF],					Files.FILE_City,true);					
					FileServices.PromoteSuperFileList ([Files.FILE_PHONE_SF,				Files.FILE_PHONE_Father_SF],				Files.FILE_PHONE,true);										
					FileServices.PromoteSuperFileList ([Files.FILE_FAX_SF,					Files.FILE_FAX_Father_SF],					Files.FILE_FAX,true);															
					FileServices.PromoteSuperFileList ([Files.FILE_LIC_SF,					Files.FILE_LIC_Father_SF],					Files.FILE_LIC,true);
					FileServices.PromoteSuperFileList ([Files.FILE_VendorID_SF,			Files.FILE_VendorID_Father_SF],			Files.FILE_VendorID,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Tax_SF,					Files.FILE_Tax_Father_SF],					Files.FILE_Tax,true);
					FileServices.PromoteSuperFileList ([Files.FILE_Fein_SF,					Files.FILE_Fein_Father_SF],					Files.FILE_Fein,true);					
					FileServices.PromoteSuperFileList ([Files.FILE_DEA_SF,					Files.FILE_DEA_Father_SF],					Files.FILE_DEA,true);
					FileServices.PromoteSuperFileList ([Files.FILE_NPI_SF,					Files.FILE_NPI_Father_SF],					Files.FILE_NPI,true);
					FileServices.PromoteSuperFileList ([Files.FILE_ADDR_NPI_SF,			Files.FILE_ADDR_NPI_Father_SF],			Files.FILE_ADDR_NPI,true);
					FileServices.PromoteSuperFileList ([Files.FILE_CLIA_SF,					Files.FILE_CLIA_Father_SF],					Files.FILE_CLIA,true);					
					FileServices.PromoteSuperFileList ([Files.FILE_MEDICARE_SF,			Files.FILE_MEDICARE_Father_SF],			Files.FILE_MEDICARE,true);					
					FileServices.PromoteSuperFileList ([Files.FILE_MEDICAID_SF,			Files.FILE_MEDICAID_Father_SF],			Files.FILE_MEDICAID,true);					
					FileServices.PromoteSuperFileList ([Files.FILE_NCPDP_SF,				Files.FILE_NCPDP_Father_SF],				Files.FILE_NCPDP,true);										
					FileServices.PromoteSuperFileList ([Files.FILE_BDID_SF,					Files.FILE_BDID_Father_SF],					Files.FILE_BDID,true);					
		);
		
		RETURN action;
	END;
END;
