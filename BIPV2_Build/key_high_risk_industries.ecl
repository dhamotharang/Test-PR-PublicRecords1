import tools, LocationID, LocationID_xLink, BIPV2_Build;

export key_high_risk_industries := module	
	shared atmost_limit := 2000;
	
  export Key_Phone      := BIPV2_Build.HighRiskIndustries.phoneIndexDef();
  export Key_Addr       := BIPV2_Build.HighRiskIndustries.addrIndexDef();
  export Key_Code       := BIPV2_Build.HighRiskIndustries.codeIndexDef();
  
  // -- ensure easy access to different logical and super versions of the key
  export keyvs_phone(string pversion = '',boolean penvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('Key_Phone' ,keynames(pversion,penvironment).highRiskIndustriesPhone);
  export keybuilt_phone       := keyvs_phone().built      ;
  export keyQA_phone          := keyvs_phone().qa         ;
  export keyfather_phone      := keyvs_phone().father     ;
  export keygrandfather_phone := keyvs_phone().grandfather;
	
  export keyvs_addr(string pversion = '',boolean penvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('Key_Addr' ,keynames(pversion,penvironment).highRiskIndustriesAddr);
  export keybuilt_addr       := keyvs_addr().built      ;
  export keyQA_addr          := keyvs_addr().qa         ;
  export keyfather_addr      := keyvs_addr().father     ;
  export keygrandfather_addr := keyvs_addr().grandfather;
	
  export keyvs_code(string pversion = '',boolean penvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('Key_Code' ,keynames(pversion,penvironment).highRiskIndustriesCodes);
  export keybuilt_code       := keyvs_code().built      ;
  export keyQA_code          := keyvs_code().qa         ;
  export keyfather_code      := keyvs_code().father     ;
  export keygrandfather_code := keyvs_code().grandfather;
	
	export AddrSearchLayout := record
		 string prim_range;
	  string predir;
	  string prim_name;
	  string postdir;
	  string addr_suffix;
	  string sec_range;
	  string v_city_name;
	  string st;
	  string zip5;
		 unsigned6 UniqueId;
	end;

	export PhoneSearchLayout := record
		Key_Phone.company_phone;
		unsigned6 UniqueId;
	end;
	
	export Address_Search_Roxie(dataset(AddrSearchLayout) addrSearchDs) := function 

   LocIDInput := project(addrSearchDs,
			                      transform(LocationID.IdAppendLayouts.AppendInput, self := left, self.request_id := left.UniqueId, self := []));
																									
      locid_results := LocationID.IdAppendRoxi(LocIDInput);
											 
	  outputRec := record
					addrSearchDs.UniqueId;
					locid_results.locid;
			  Key_Addr;
			end;

	  finalRec := record
			    addrSearchDs.UniqueId;
       locid_results.locid;
			    Key_Code;
			end;
			 
	  getSeleIds := join(locid_results, Key_Addr,
			                   left.locid = right.locid,
									             transform(outputRec, self.uniqueID := left.request_id, self := right, self := left), atmost(atmost_limit)); 
													
	  getCodes   := join(getSeleIds, Key_Code,
		                    left.seleid = right.seleid,
													         transform(finalRec, self := right, self := left), atmost(atmost_limit)); 
       
			return getCodes;
	end;

	export Address_Search(dataset(AddrSearchLayout) addrSearchDs) := function 

   LocationID_xLink.Append(addrSearchDs
                          ,prim_range
                          ,predir
                          ,prim_name
                          ,addr_suffix
                          ,postdir
                          ,sec_range
                          ,v_city_name
                          ,st
                          ,zip5
											    ,locid_results
                       );
											 
	     outputRec := record
					locid_results.UniqueId;
					locid_results.locid;
			    Key_Addr;
			 end;

	     finalRec := record
			    locid_results.UniqueId;
          locid_results.locid;
			    Key_Code;
			 end;
			 
	     getSeleIds := join(locid_results, Key_Addr,
			                    left.locid = right.locid,
													transform(outputRec, self := right, self := left), atmost(atmost_limit)); 
													
	     getCodes   := join(getSeleIds, Key_Code,
			                    left.seleid = right.seleid,
													transform(finalRec, self := right, self := left), atmost(atmost_limit)); 
       
			 return getCodes;
	end;
	
	
	export Phone_Search(dataset(PhoneSearchLayout) phoneSearchDs) := function 

	     outputRec := record
			 		phoneSearchDs.UniqueId;
					phoneSearchDs.company_phone;
			    Key_Phone;
			 end;

	     finalRec := record
			 		phoneSearchDs.UniqueId;
					phoneSearchDs.company_phone;
			    Key_Code;
			 end;
			 
	     getSeleIds := join(phoneSearchDs, Key_Phone,
			                    left.company_phone = right.company_phone,
													transform(outputRec, self := right, self := left), atmost(atmost_limit)); 
													
	     getCodes   := join(getSeleIds, Key_Code,
			                    left.seleid = right.seleid,
													transform(finalRec, self := right, self := left), atmost(atmost_limit)); 
       
			 return getCodes;
	end;
	
end;