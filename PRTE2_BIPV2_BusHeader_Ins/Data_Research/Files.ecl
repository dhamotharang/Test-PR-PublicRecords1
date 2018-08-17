IMPORT ADDRESS, PRTE2_Common, PRTE2_BIPV2_BusHeader_Ins.Data_Research;

EXPORT Files := MODULE
		EXPORT Add_Foreign_prod		:= PRTE2_Common.Constants.Add_Foreign_prod;

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
END;