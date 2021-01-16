IMPORT Address, Business_Risk_BIP, BIPV2, BIPV2_Best, Risk_Indicators;

EXPORT BIP_Best_Append(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
												 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
												 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	BestInformationRaw := IF(Options.BIPBestAppend != Business_Risk_BIP.Constants.BIPBestAppend.Default, 
									BIPV2_Best.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																								Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																								0, /*ScoreThreshold --> 0 = Give me everything*/
																								linkingOptions,
																								true,
																								Business_Risk_BIP.Constants.Limit_Default,
																								Options.KeepLargeBusinesses));
	
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BestInformationRaw, Shell, BestInformationSeq);
	
	BestInformation := ROLLUP(SORT(BestInformationSeq, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT),
		SELF.Company_Name := LEFT.Company_Name + RIGHT.Company_Name;
		SELF.Company_Address := LEFT.Company_Address + RIGHT.Company_Address;
		SELF.Company_Phone := LEFT.Company_Phone + RIGHT.Company_Phone;
		SELF.Company_FEIN := LEFT.Company_FEIN + RIGHT.Company_FEIN;
		SELF.Company_URL := LEFT.Company_URL + RIGHT.Company_URL;
		SELF.SIC_Code := LEFT.SIC_Code + RIGHT.SIC_Code;
		SELF.NAICS_Code := LEFT.NAICS_Code + RIGHT.NAICS_Code;
		SELF := LEFT));
		
	Business_Risk_BIP.Layouts.Shell applyBestInformation(Business_Risk_BIP.Layouts.Shell le, BestInformation ri) := TRANSFORM
		bestCompanyName := SORT(ri.Company_Name, Company_Name_Method, Company_Name, -Dt_Last_Seen, -Dt_First_Seen)[1].Company_Name;
		bestCompanyAddress := SORT(ri.Company_Address, Company_Address_Method, Company_Prim_Range, Company_Predir, Company_Prim_Name, Company_Addr_Suffix, Company_Postdir, Company_Unit_Desig, Company_Sec_Range, Company_P_City_Name, Company_St, Company_Zip5, Company_Zip4)[1];
		bestCompanyAddressFull := Address.Addr1FromComponents(bestCompanyAddress.Company_Prim_Range, bestCompanyAddress.Company_Predir, bestCompanyAddress.Company_Prim_Name, bestCompanyAddress.Company_Addr_Suffix, bestCompanyAddress.Company_Postdir, bestCompanyAddress.Company_Unit_Desig, bestCompanyAddress.Company_Sec_Range);
		bestCompanyPhone := SORT(ri.Company_Phone, Company_Phone_Method, Company_Phone)[1].Company_Phone;
		bestCompanyFEIN := SORT(ri.Company_FEIN, Company_FEIN_Method, Company_FEIN)[1].Company_FEIN;
		bestCompanyURL := SORT(ri.Company_URL, Company_URL_Method, Company_URL)[1].Company_URL;
		bestCompanySICCode := SORT(ri.SIC_Code, Company_SIC_Code1_Method, Company_SIC_Code1)[1].Company_SIC_Code1;
		bestCompanyNAICSCode := SORT(ri.NAICS_Code, Company_NAICS_Code1_Method, Company_NAICS_Code1)[1].Company_NAICS_Code1;
	
		overwriteEverything := Options.BIPBestAppend = Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;
		appendMissing := Options.BIPBestAppend = Business_Risk_BIP.Constants.BIPBestAppend.AllBlankFields;
		
		SELF.Input_Echo.CompanyName := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.CompanyName = ''), bestCompanyName, le.Input_Echo.CompanyName);
		SELF.Input_Echo.StreetAddress1 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.StreetAddress1 = ''), 
																							Risk_Indicators.MOD_AddressClean.street_address('', bestCompanyAddress.Company_Prim_Range, bestCompanyAddress.Company_Predir, bestCompanyAddress.Company_Prim_Name, 
																											bestCompanyAddress.Company_Addr_Suffix, bestCompanyAddress.Company_Postdir, bestCompanyAddress.Company_Unit_Desig, bestCompanyAddress.Company_Sec_Range),
																					le.Input_Echo.StreetAddress1);
		SELF.Input_Echo.Prim_Range := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Prim_Range = ''), bestCompanyAddress.Company_Prim_Range, le.Input_Echo.Prim_Range);
		SELF.Input_Echo.Predir := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Predir = ''), bestCompanyAddress.Company_Predir, le.Input_Echo.Predir);
		SELF.Input_Echo.Prim_Name := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Prim_Name = ''), bestCompanyAddress.Company_Prim_Name, le.Input_Echo.Prim_Name);
		SELF.Input_Echo.Addr_Suffix := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Addr_Suffix = ''), bestCompanyAddress.Company_Addr_Suffix, le.Input_Echo.Addr_Suffix);
		SELF.Input_Echo.Postdir := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Postdir = ''), bestCompanyAddress.Company_Postdir, le.Input_Echo.Postdir);
		SELF.Input_Echo.Unit_Desig := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Unit_Desig = ''), bestCompanyAddress.Company_Unit_Desig, le.Input_Echo.Unit_Desig);
		SELF.Input_Echo.Sec_Range := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Sec_Range = ''), bestCompanyAddress.Company_Sec_Range, le.Input_Echo.Sec_Range);
		SELF.Input_Echo.City := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.City = ''), bestCompanyAddress.Company_P_City_Name, le.Input_Echo.City);
		SELF.Input_Echo.State := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.State = ''), bestCompanyAddress.Company_St, le.Input_Echo.State);
		SELF.Input_Echo.Zip := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Zip = ''), bestCompanyAddress.Company_Zip5 + bestCompanyAddress.Company_Zip4, le.Input_Echo.Zip);
		SELF.Input_Echo.Zip5 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Zip5 = ''), bestCompanyAddress.Company_Zip5, le.Input_Echo.Zip5);
		SELF.Input_Echo.Zip4 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Zip4 = ''), bestCompanyAddress.Company_Zip4, le.Input_Echo.Zip4);
		SELF.Input_Echo.Lat := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Lat = ''), '', le.Input_Echo.Lat);
		SELF.Input_Echo.Long := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Long = ''), '', le.Input_Echo.Long);
		SELF.Input_Echo.Addr_Type := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Addr_Type = ''), '', le.Input_Echo.Addr_Type);
		SELF.Input_Echo.Addr_Status := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Addr_Status = ''), '', le.Input_Echo.Addr_Status);
		SELF.Input_Echo.County := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.County = ''), '', le.Input_Echo.County);  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Input_Echo.Geo_Block := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Geo_Block = ''), '', le.Input_Echo.Geo_Block);
		SELF.Input_Echo.FEIN := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.FEIN = ''), bestCompanyFEIN, le.Input_Echo.FEIN);
		SELF.Input_Echo.Phone10 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.Phone10 = ''), bestCompanyPhone, le.Input_Echo.Phone10);
		SELF.Input_Echo.CompanyURL := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.CompanyURL = ''), bestCompanyURL, le.Input_Echo.CompanyURL);
		SELF.Input_Echo.SIC := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.SIC = ''), bestCompanySICCode, le.Input_Echo.SIC);
		SELF.Input_Echo.NAIC := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Input_Echo.NAIC = ''), bestCompanyNAICSCode, le.Input_Echo.NAIC);
	
		SELF.Clean_Input.CompanyName := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.CompanyName = ''), bestCompanyName, le.Clean_Input.CompanyName);
		companyCleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(bestCompanyAddressFull, bestCompanyAddress.Company_P_City_Name, bestCompanyAddress.Company_St, bestCompanyAddress.Company_Zip5);											
		cleanedCompanyAddress := Address.CleanFields(companyCleanAddr);
		SELF.Clean_Input.StreetAddress1 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.StreetAddress1 = ''), 
																							Risk_Indicators.MOD_AddressClean.street_address('', cleanedCompanyAddress.Prim_Range, cleanedCompanyAddress.Predir, cleanedCompanyAddress.Prim_Name, 
																											cleanedCompanyAddress.Addr_Suffix, cleanedCompanyAddress.Postdir, cleanedCompanyAddress.Unit_Desig, cleanedCompanyAddress.Sec_Range),
																					le.Clean_Input.StreetAddress1);
		SELF.Clean_Input.Prim_Range := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Prim_Range = ''), cleanedCompanyAddress.Prim_Range, le.Clean_Input.Prim_Range);
		SELF.Clean_Input.Predir := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Predir = ''), cleanedCompanyAddress.Predir, le.Clean_Input.Predir);
		SELF.Clean_Input.Prim_Name := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Prim_Name = ''), cleanedCompanyAddress.Prim_Name, le.Clean_Input.Prim_Name);
		SELF.Clean_Input.Addr_Suffix := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Addr_Suffix = ''), cleanedCompanyAddress.Addr_Suffix, le.Clean_Input.Addr_Suffix);
		SELF.Clean_Input.Postdir := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Postdir = ''), cleanedCompanyAddress.Postdir, le.Clean_Input.Postdir);
		SELF.Clean_Input.Unit_Desig := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Unit_Desig = ''), cleanedCompanyAddress.Unit_Desig, le.Clean_Input.Unit_Desig);
		SELF.Clean_Input.Sec_Range := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Sec_Range = ''), cleanedCompanyAddress.Sec_Range, le.Clean_Input.Sec_Range);
		SELF.Clean_Input.City := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.City = ''), cleanedCompanyAddress.V_City_Name, le.Clean_Input.City);  // use v_city_name 90..114 to match all other scoring products
		SELF.Clean_Input.State := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.State = ''), cleanedCompanyAddress.St, le.Clean_Input.State);
		SELF.Clean_Input.Zip := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Zip = ''), cleanedCompanyAddress.Zip + cleanedCompanyAddress.Zip4, le.Clean_Input.Zip);
		SELF.Clean_Input.Zip5 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Zip5 = ''), cleanedCompanyAddress.Zip, le.Clean_Input.Zip5);
		SELF.Clean_Input.Zip4 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Zip4 = ''), cleanedCompanyAddress.Zip4, le.Clean_Input.Zip4);
		SELF.Clean_Input.Lat := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Lat = ''), cleanedCompanyAddress.Geo_Lat, le.Clean_Input.Lat);
		SELF.Clean_Input.Long := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Long = ''), cleanedCompanyAddress.Geo_Long, le.Clean_Input.Long);
		SELF.Clean_Input.Addr_Type := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Addr_Type = ''), cleanedCompanyAddress.Rec_Type, le.Clean_Input.Addr_Type);
		SELF.Clean_Input.Addr_Status := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Addr_Status = ''), cleanedCompanyAddress.Err_Stat, le.Clean_Input.Addr_Status);
		SELF.Clean_Input.County := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.County = ''), companyCleanAddr[143..145], le.Clean_Input.County);  // Address.CleanFields(clean_addr).county returns the full 5 character fips, we only want the county fips
		SELF.Clean_Input.Geo_Block := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Geo_Block = ''), cleanedCompanyAddress.Geo_Blk, le.Clean_Input.Geo_Block);
		SELF.Clean_Input.FEIN := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.FEIN = ''), bestCompanyFEIN, le.Clean_Input.FEIN);
		SELF.Clean_Input.Phone10 := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.Phone10 = ''), bestCompanyPhone, le.Clean_Input.Phone10);
		SELF.Clean_Input.CompanyURL := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.CompanyURL = ''), bestCompanyURL, le.Clean_Input.CompanyURL);
		SELF.Clean_Input.SIC := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.SIC = ''), bestCompanySICCode, le.Clean_Input.SIC);
		SELF.Clean_Input.NAIC := IF(overwriteEverything = TRUE OR (appendMissing = TRUE AND le.Clean_Input.NAIC = ''), bestCompanyNAICSCode, le.Clean_Input.NAIC);
		
		SELF := le;
	END;
	
	informationAppended := JOIN(Shell, BestInformation, LEFT.Seq = RIGHT.Seq, applyBestInformation(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	RETURN informationAppended;
END;