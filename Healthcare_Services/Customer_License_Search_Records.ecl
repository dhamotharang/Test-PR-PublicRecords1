
 Import healthcare_shared,MMCP,BatchServices,Autokey_batch,AutokeyB2,AutoStandardI,Codes;

EXPORT Customer_License_Search_Records := module
	Shared myLayouts := Healthcare_Services.Customer_License_Search_Layouts;
	Shared myConst := Healthcare_Services.Customer_License_Search_Constants;
	shared gm:=AutoStandardI.GlobalModule();

	//Verify Company #
	Export verify_Company (string companyid):= function
		doLookup := Codes.Key_Codes_V3(file_name = Customer_License_Search_Constants.CUST_LIC_CODESV3_FILENAME and field_name = Customer_License_Search_Constants.CUST_LIC_CODESV3_FIELDNAME);
		filterLookup := doLookup(code = companyid);
		validCompany := exists(filterLookup);//Verify only valid State requesting information
		return validCompany;
	end;
	//Ak Penalty
	export setPenalty (string inFirst, string inMiddle, string inLast, string inNumber, string inPredir, string inStreet, string inPostDir, string inSuffix, string inSecRange, string inCity, string inState, string inZip, 
										 string rawFirst, string rawMiddle, string rawLast, string rawNumber, string rawPredir, string rawStreet, string rawPostDir, string rawSuffix, string rawSecRange, string rawCity, string rawState, string rawZip):=function
			tempIndvMod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export fname_field := rawFirst;
				export lname_field := rawLast;
				export mname_field := rawMiddle;
				export ssn_field := '';  
				export pname_field := rawStreet;
				export postdir_field := rawPostDir;
				export prange_field := rawNumber;
				export predir_field := rawPredir;
				export state_field := rawState;
				export suffix_field := rawSuffix;
				export sec_range_field := rawSecRange;
				export city_field := rawCity;
				export zip_field := rawZip;
				// Empty non input.
				export did_field := '';
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
				export phone_field := '';
				export bdid_field := '';
				export cname_field := '';
				export fein_field := '';
				export agehigh := 0;
				export agelow := 0;
				// Input fields
				export companyname := '';
				export lastname   := inLast;       
				export middlename := inMiddle;     
				export firstname  := inFirst;            				
				export prim_range := inNumber;
				export predir := inPredir;
				export prim_name := inStreet;
				export addr_suffix := inSuffix;
				export postdir := inPostDir;
				export unit_desig := '';
				export sec_range := inSecRange;
				export city := inCity;
				export state := inState;
				export zip := inZip;
				export bdid := '';
			END;
						
			return AutoStandardI.LIBCALL_PenaltyI.val(tempIndvMod);
	end;
	export setLicSearchPenalty (string inFirst, string inMiddle, string inLast, string rawFirst, string rawMiddle, string rawLast):=function
			tempIndvMod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
				export allow_wildcard := false;
				export fname_field := rawFirst;
				export lname_field := rawLast;
				export mname_field := rawMiddle;
				// Input fields
				export lastname   := inLast;       
				export middlename := inMiddle;     
				export firstname  := inFirst;            				
			END;
						
			return AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(tempIndvMod);
	end;
	//Search By License or License+State and apply a name only penalty as the addresses are likely out of date.
	Export get_recs_by_License (dataset(myLayouts.autokeyInput) input):= function
    		rawData:= dedup(sort(join(input, MMCP.Keys().LicenseNumber.qa,
																	 Keyed( left.License_Number =right.License_Number) and 
																	 (integer)left.CustomerID=right.customer_id,
																	 transform(myLayouts.LayoutOutput,self.acctno:=left.acctno;self:=right,self:=[]),
																	 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record);
		
		applyPenalty:= join(input,rawData, left.acctno=right.acctno and left.License_Number=right.License_Number,
															transform(myLayouts.LayoutOutput,self.acctno:=left.acctno;
																				self.penalt := setLicSearchPenalty (left.name_first, left.name_middle, left.name_last, 
																																		right.clean_name.fname, right.clean_name.mname, right.clean_name.lname);
																				self:=right,self:=[]),
															keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return applyPenalty;
	end;
	//Search by standard autokeys
	Export get_recs_by_ak (dataset(myLayouts.autokeyInput) input):= function
		ak_config := MODULE(BatchServices.Interfaces.i_AK_Config)
				export UseAllLookUps := TRUE;
				export workHard := TRUE;
				export nofail := TRUE;
				export skip_set := MMCP._Constants().AUTOKEY_SKIP_SET;
		END;
			
		//**** GET FAKEIDS - FLAPD SEARCH
		ak_key := MMCP._Constants().ak_qa_keyname;
		ak_in := PROJECT(input,Autokey_batch.Layouts.rec_inBatchMaster);
		ak_out := Autokey_batch.get_fids(ak_in, ak_key, ak_config);
		out_rec := dataset([],myLayouts.akLayoutOutput);
		typ_str := MMCP._Constants().TYPE_STR;
		AutokeyB2.mac_get_payload(ak_out,ak_key,out_rec,autokeysResults,did,bdid,typ_str);

		results:=dedup(sort(autokeysResults,record),record);
		//Very important that we do not show one customer another customers data...
		results_remove_restricted:=join(input,results,
																		left.acctno=right.acctno and (integer)left.CustomerID=right.customer_id,
																		transform(myLayouts.LayoutOutput,
																				self.isAutoKeyResults := true;
																				self.penalt := setPenalty (left.name_first, left.name_middle, left.name_last, 
																																		left.prim_range, left.predir, left.prim_name, 
																																		left.postdir, left.addr_suffix, left.sec_range, 
																																		left.p_city_name, left.st, left.z5, 
																																		right.clean_name.fname, right.clean_name.mname, right.clean_name.lname, 
																																		right.clean_company_address.prim_range, right.clean_company_address.predir, right.clean_company_address.prim_name, 
																																		right.clean_company_address.postdir, right.clean_company_address.addr_suffix, right.clean_company_address.sec_range, 
																																		right.clean_company_address.p_city_name, right.clean_company_address.st, right.clean_company_address.zip);
																				self:=right),
																		keep(myConst.MAX_RECS_ON_JOIN), limit(0));
		//Very important that we do not show one customer another customers data...
		return sort(results_remove_restricted,acctno,penalt);
	end;
	Export getSortid(string customerID, string licenseType) := function
		//MI specific sort sequencing
		returnVal := map(customerID = myConst.MI_CUSTOMER and licenseType = 'R' => myConst.MI_LicenseType_R,
										 customerID = myConst.MI_CUSTOMER and licenseType = 'E' => myConst.MI_LicenseType_E,
										 customerID = myConst.MI_CUSTOMER and licenseType = 'L' => myConst.MI_LicenseType_L,
										 customerID = myConst.MI_CUSTOMER and licenseType = 'A' => myConst.MI_LicenseType_A,
										 customerID = myConst.MI_CUSTOMER and licenseType = 'N' => myConst.MI_LicenseType_N,
										 99);
		return returnVal;
	end;
	Export Records_Custom_Logic (dataset(myLayouts.LayoutOutput) rawRecs) := function
		//MI Specific sort sequencing
		myLayouts.LayoutOutput assignSortValues (myLayouts.LayoutOutput l) := transform
			self.sortid := getSortid((string)l.customer_id,l.bull_license_type);
			self := l;
		end;
		appendSortSeq := project(rawRecs,assignSortValues(left));
		myLayouts.LayoutOutput backfillFullName (myLayouts.LayoutOutput l) := transform
			backfillName := if(l.hasoptout=false,Trim(Trim(Trim(l.name_first_middle,right) +' '+ Trim(l.clean_name.lname,right),right) +' '+ trim(l.name_suffix,right),right),''); 
			FullName := if(trim(l.full_name,all)<>''and l.hasoptout=false,l.full_name,backfillname);
			BusName := if(l.hasoptout=false,trim(l.company_name,right),'');
			self.full_name := trim(FullName+' '+BusName,right);
			self.hasoptout:=l.hasoptout;
			self.license_number:=if(l.hasoptout=false,l.license_number,'');
	  self.bull_license_type:=if(l.hasoptout=false,l.bull_license_type,'');
		self.sec_license_status:=if(l.hasoptout=false,l.sec_license_status,'');;
		self.license_status:=if(l.hasoptout=false,l.license_status,'');     
		self.license_status_date:=if(l.hasoptout=false,l.license_status_date,'');
		self.expiration_date:=if(l.hasoptout=false,l.expiration_date,'');
		self.audit_number:=if(l.hasoptout=false,l.audit_number,'');
	  self.bull_specialty:=if(l.hasoptout=false,l.bull_specialty,'');
		self.license_mask:=if(l.hasoptout=false,l.license_mask,'');
		self.issue_date:=if(l.hasoptout=false,l.issue_date,'');
		self.dea_number:=if(l.hasoptout=false,l.dea_number,'');
		self.discipline_ind:=if(l.hasoptout=false,l.discipline_ind,'');     
		self.last_update_date:=if(l.hasoptout=false,l.last_update_date,'');   
		//self.status_change_date; // added
		self.name_prefix:=if(l.hasoptout=false,l.name_prefix,'');
		  // adjusted for IL use
		self.name_first:=if(l.hasoptout=false,l.name_first,'');
		self.name_middle:=if(l.hasoptout=false,l.name_middle,'');
		self.name_last:=if(l.hasoptout=false,l.name_last,'');
		self.name_suffix:=if(l.hasoptout=false,l.name_suffix,'');
		self.dob:=if(l.hasoptout=false,l.dob,'');
		self.ssn:=if(l.hasoptout=false,l.ssn,'');
		self.company_name:=if(l.hasoptout=false,l.company_name,'');       
		self.address1:=if(l.hasoptout=false,l.address1,'');          
		self.address2:=if(l.hasoptout=false,l.address2,'');           
		self.address3:=if(l.hasoptout=false,l.address3,'');           
		self.city:=if(l.hasoptout=false,l.city,'');
	  self.state:=if(l.hasoptout=false,l.state,'');
	  self.full_zip:=if(l.hasoptout=false,l.full_zip,'');
		self.county_code:=if(l.hasoptout=false,l.county_code,'');
		self.clean_company_address.prim_range:=if(l.hasoptout=false,l.clean_company_address.prim_range,'');
		self.clean_company_address.predir:=if(l.hasoptout=false,l.clean_company_address.predir,'');
		self.clean_company_address.prim_name:=if(l.hasoptout=false,l.clean_company_address.prim_name,'');
		self.clean_company_address.addr_suffix:=if(l.hasoptout=false,l.clean_company_address.addr_suffix,'');
		self.license_board_code_desc:=if(l.hasoptout=false,l.license_board_code_desc,'');
		self.bull_lic_type_desc:=if(l.hasoptout=false,l.bull_lic_type_desc,'');
	  self.license_status_desc:=if(l.hasoptout=false,l.license_status_desc,'');
		self := l;
		end;
		fixFullName := project(appendSortSeq,backfillFullName(left));
		final := dedup(sort(fixFullName,acctno,license_number,sortid,-expiration_date),acctno,license_number);
		return final;
	end;
	Export Records(dataset(myLayouts.autokeyInput) inRecs, unsigned2 maxPenalty) := function
		//Query the data and get back the results.
		byLic := get_recs_by_License(inRecs)(record_type='C');
		getRestByAK := join(inRecs,byLic,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);
		byAk := get_recs_by_ak(inRecs(name_last<>'' and ((p_city_name <> '' and st <> '') or z5 <>'')))(record_type='C');
		keepOnlyFoundinAK := join(byAK,getRestByAK,left.acctno=right.acctno,transform(myLayouts.LayoutOutput, self := left));
		combineLicandAK := byLic+keepOnlyFoundinAK;
		searchResults := combineLicandAK(penalt<=maxPenalty);//Only use autokeys if you cannot find hit by license number
		dedupBestRecords := Records_Custom_Logic(searchResults);
		final := sort(dedupBestRecords,(integer)acctno,penalt,License_Number);
		return final;
	End;
	
	
	EXPORT NonAlphaNumChar	:= '[^A-Za-z0-9]';
	EXPORT setBogusLicense := ['390200000X','WC1','35NULL','34NULL','LARN00000',
	                           'INPROCESS','NOTAPPLICABLE','APPLIEDFOR','PENDING',
	                           '0','00','000','0000','00000','000000','0000000','00000000','000000000',
														 'NOLICNUMBER','NR','NULL','NA','NONE',
														 'TEMPORARY','STUDENT','UNKNOWN','TEMP','RESIDENT','OPT'];
														 
EXPORT CleanLicenseNumber(STRING lic_in) := FUNCTION
		toUpper						:= TRIM(StringLib.StringToUpperCase(lic_in), ALL);
		removeNonAlphaNum := REGEXREPLACE(NonAlphaNumChar, toUpper, '');
		RETURN IF(removeNonAlphaNum IN setBogusLicense, '', removeNonAlphaNum);
	END;
	
	Export RecordsBatch(dataset(myLayouts.autokeyInput) inRecs, unsigned2 maxPenalty) := function
   	clean_in_recs:=	project(inRecs,transform(myLayouts.autokeyInput,

		                                    self.license_number:=healthcare_shared.functions.CleanLicenseNumber
																				(left.license_number);
																				self:=left;));

		                                    


		recs := Records(clean_in_recs,maxPenalty);
		recs_fmt := project(recs,transform(myLayouts.LayoutOutput_batch, 
															self.cln_fname:=left.clean_name.fname;
															self.cln_mname:=left.clean_name.mname;
															self.cln_lname:=left.clean_name.lname;
															self.cln_name_suffix:=left.clean_name.name_suffix;
															self.cln_prim_range:=left.clean_company_address.prim_range;
															self.cln_predir:=left.clean_company_address.predir;
															self.cln_prim_name:=left.clean_company_address.prim_name;
															self.cln_addr_suffix:=left.clean_company_address.addr_suffix;
															self.cln_postdir:=left.clean_company_address.postdir;
															self.cln_unit_desig:=left.clean_company_address.unit_desig;
															self.cln_sec_range:=left.clean_company_address.sec_range;
															self.cln_city_name:=left.clean_company_address.p_city_name;
															self.cln_st:=left.clean_company_address.st;
															self.cln_zip:=left.clean_company_address.zip;
															self:=left;));
 	return recs_fmt;
	End;
end;
