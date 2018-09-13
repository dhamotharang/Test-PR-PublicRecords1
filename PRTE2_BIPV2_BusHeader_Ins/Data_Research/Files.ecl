/* ************************************************************************************************
PRTE2_BIPV2_BusHeader_Ins.Data_Research.Files
************************************************************************************************ */

IMPORT Codes, ADDRESS, PRTE2_Common, PRTE2_BIPV2_BusHeader_Ins.Data_Research;

EXPORT Files := MODULE
		EXPORT Add_Foreign_prod		:= PRTE2_Common.Constants.Add_Foreign_prod;
		EXPORT PREFIX_BASE 				:= '~prct::research::bipv2::business_header::';

		// PRCT BIP Header key to review.
		EXPORT BIPHeaderLinkIDsPRCTName 		:= Add_Foreign_prod('~prte::key::bipv2::business_header::qa::linkids');
		EXPORT BIPHeaderKeyLinkIDsPRCTDS 		:= INDEX({Layouts.Boca_BIP_Header_Linkids_KeyIdx}, Layouts.Boca_BIP_Header_Linkids_Key, BIPHeaderLinkIDsPRCTName);
		EXPORT BIPHeaderKeyLinkIDsPRCTView	:= PROJECT( BIPHeaderKeyLinkIDsPRCTDS,
																						TRANSFORM(Layouts.BIP_Header_Key_Linkids_View,
																									SELF.AddressLine1 := ADDRESS.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range);
																									SELF.FEIN := LEFT.company_fein;
																									SELF.SIC_Code := LEFT.company_sic_code1;
																									SELF.NAICS_Code := LEFT.company_naics_code1;
																									SELF.incorporation_date := LEFT.company_incorporation_date;
																									SELF := LEFT
																						));

	
		// LIVE!  BIP Header key to review.  **** WARNING SHARE PII CAREFULLY *****
		EXPORT BIPHeaderLinkIDsLiveName 		:= Add_Foreign_prod('~thor_data400::key::bipv2::business_header::qa::linkids');
		EXPORT BIPHeaderKeyLinkIDsLiveDS 		:= INDEX({Layouts.Boca_BIP_Header_Linkids_KeyIdx}, Layouts.Boca_BIP_Header_Linkids_Key, BIPHeaderLinkIDsLiveName);
		EXPORT BIPHeaderKeyLinkIDsLiveView	:= PROJECT( BIPHeaderKeyLinkIDsLiveDS,
																						TRANSFORM(Layouts.BIP_Header_Key_Linkids_View,
																									SELF.AddressLine1 := ADDRESS.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range);
																									SELF.FEIN := LEFT.company_fein;
																									SELF.SIC_Code := LEFT.company_sic_code1;
																									SELF.NAICS_Code := LEFT.company_naics_code1;
																									SELF.incorporation_date := LEFT.company_incorporation_date;
																									SELF := LEFT
																						));

	
		EXPORT SIC4_Lookup_Base := Codes.File_SIC4_Codes;
		EXPORT NAICS_Base := Codes.File_NAICS_Codes;
		EXPORT SIC4_Lookup_Key := Codes.Key_SIC4;
		EXPORT NAICS_Lookup_Key := Codes.Key_NAICS;

		EXPORT sic_naics_Study_Name	:= PREFIX_BASE+'sic_naics_study';
		EXPORT sic_naics_Study_Name1	:= PREFIX_BASE+'sic_naics_study1';
		EXPORT sic_naics_StudyDS := DATASET(sic_naics_Study_Name, Layouts.Sic_NAICS_Layout,THOR);
		EXPORT sic_naics_StudyDS1 := DATASET(sic_naics_Study_Name1, Layouts.Sic_NAICS_Layout,THOR);

END;