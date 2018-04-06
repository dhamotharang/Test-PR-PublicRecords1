IMPORT Address, Business_Risk_BIP, BIPV2, BIPV2_Best;

EXPORT getBusBestInfoRaw(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	DDBestInformationRaw := IF(Options.BIPBestAppend != Business_Risk_BIP.Constants.BIPBestAppend.Default, 
									BIPV2_Best.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																								Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								Business_Risk_BIP.Constants.Limit_Default,
																								Options.KeepLargeBusinesses));
	
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(DDBestInformationRaw, Shell, DDBestInformationSeq);
	
	DDBestInformation := ROLLUP(SORT(DDBestInformationSeq, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT),
		SELF.Company_Name    := LEFT.Company_Name + RIGHT.Company_Name;
		SELF.Company_Address := LEFT.Company_Address + RIGHT.Company_Address;
		SELF.Company_Phone   := LEFT.Company_Phone + RIGHT.Company_Phone;
		SELF.Company_FEIN    := LEFT.Company_FEIN + RIGHT.Company_FEIN;
		SELF.Company_URL     := LEFT.Company_URL + RIGHT.Company_URL;
		SELF.SIC_Code        := LEFT.SIC_Code + RIGHT.SIC_Code;
		SELF.NAICS_Code      := LEFT.NAICS_Code + RIGHT.NAICS_Code;
		SELF                 := LEFT));
		
	
 // output(DDBestInformationRaw, NAMED('DDBestInformationRaw'));  
 // output(DDBestInformation, NAMED('DDBestInformation'));  
  
	RETURN DDBestInformation;
END;