import BIPV2_Build, business_Risk_BIP, BIPV2;
EXPORT PD_High_Risk_Industries := module	


export Phone(dataset(business_Risk_BIP.Layouts.Shell) input) := function 

	cmpyPhone := project(input, transform(BIPV2_Build.key_high_risk_industries.PhoneSearchLayout, 
																										self.company_phone := left.Clean_Input.Phone10, 
																										self.UniqueId := Counter));

	FindPhoneHighRiskCodes := BIPV2_Build.key_high_risk_industries.Phone_Search(cmpyPhone);
	
				 return FindPhoneHighRiskCodes;
	end;
	
export Address(dataset(business_Risk_BIP.Layouts.Shell) input) := function 

	cmpyAddress := project(input, transform(BIPV2_Build.key_high_risk_industries.AddrSearchLayout, 
																										self.prim_range := left.Clean_Input.Prim_Range, 
																										self.predir := left.Clean_Input.Predir, 
																										self.prim_name := left.Clean_Input.Prim_Name, 
																										self.postdir := left.Clean_Input.Postdir, 
																										self.addr_suffix := left.Clean_Input.Addr_Suffix, 
																										self.sec_range := left.Clean_Input.Sec_Range, 
																										self.v_city_name := left.Clean_Input.City, 
																										self.st := left.Clean_Input.State, 
																										self.zip5 := left.Clean_Input.Zip5, 
																										self.UniqueId := Counter));
	FindAddrHighRiskCodes  := BIPV2_Build.key_high_risk_industries.Address_Search_Roxie(cmpyAddress);
	
				 return FindAddrHighRiskCodes;
	end;	
	
	export Industries(dataset(BIPV2.IDlayouts.l_xlink_ids2) linkids) := function 

		key_high_risk_industries := 
			JOIN(linkids, BIPV2_Build.key_high_risk_industries.Key_Code, 
				KEYED(LEFT.SeleID = RIGHT.SeleID),
				TRANSFORM(RECORDOF(BIPV2_Build.key_high_risk_industries.Key_Code),
				SELF := RIGHT, 
					SELF := LEFT,
					SELF := []), 
				ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
				 return key_high_risk_industries;
	end;	
	
	end;