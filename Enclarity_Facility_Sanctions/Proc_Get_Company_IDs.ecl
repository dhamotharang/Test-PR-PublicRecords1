IMPORT lib_fileservices, _control, lib_STRINGlib, _Validate, did_add, ut, business_header_ss, business_header,
Health_Facility_Services, HealthCareFacility, Enclarity_Facility_Sanctions ;

// #STORED('did_add_force','thor'); // remove or set to 'roxi' to put recs through roxi

TrimUpper(STRING s) := FUNCTION
			RETURN TRIM(Stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  
	
EXPORT Proc_Get_Company_IDs 	:= MODULE

	EXPORT facility_sanctions(DATASET(Enclarity_Facility_Sanctions.Layouts.Base.facility_sanctions)	pBaseFile) := FUNCTION
	
		temp_expand_base := RECORD
			Enclarity_Facility_Sanctions.Layouts.Base.facility_sanctions;
			string10 clean_phone	:= '';
			string10 clean_fax		:= '';
			Enclarity_facility_sanctions.Layouts.Appended.temp_address;
			unsigned8 lnpid;
		END;

		temp_expand_base tNormalizeCompany(pBaseFile L) := TRANSFORM   
			SELF.clean_phone					:= map(L.normed_company_type = 1 => L.clean_prac_phone1
																			,L.normed_company_type = 2 => L.clean_prac_phone1
																			,L.normed_company_type = 3 => L.clean_bill_phone1
																			,L.clean_prac_phone1);
			SELF.clean_fax						:= map(L.normed_company_type = 1 =>	L.clean_prac_fax1
																			,L.normed_company_type = 2 =>	L.clean_prac_fax1
																			,L.normed_company_type = 3 => L.clean_bill_fax1
																			,L.clean_prac_fax1);
			SELF.prim_range						:= map(L.normed_company_type = 1 =>	L.clean_prac1_prim_range
																			,L.normed_company_type = 2 =>	L.clean_prac1_prim_range
																			,L.normed_company_type = 3 =>	L.clean_bill1_prim_range
																			,L.clean_prac1_prim_range);
			SELF.prim_name						:= map(L.normed_company_type = 1 =>	L.clean_prac1_prim_name
																			,L.normed_company_type = 2 =>	L.clean_prac1_prim_name
																			,L.normed_company_type = 3 => L.clean_bill1_prim_name
																			,L.clean_prac1_prim_name);
			SELF.zip									:= map(L.normed_company_type = 1 =>	L.clean_prac1_zip
																			,L.normed_company_type = 2 =>	L.clean_prac1_zip
																			,L.normed_company_type = 3 => L.clean_bill1_zip
																			,L.clean_prac1_zip);
			SELF.sec_range						:= map(L.normed_company_type = 1 =>	L.clean_prac1_sec_range
																			,L.normed_company_type = 2 => L.clean_prac1_sec_range
																			,L.normed_company_type = 3 =>	L.clean_bill1_sec_range
																			,L.clean_prac1_sec_range);
			SELF.st										:= map(L.normed_company_type = 1 =>	L.clean_prac1_st
																			,L.normed_company_type = 2 =>	L.clean_prac1_st
																			,L.normed_company_type = 3 =>	L.clean_bill1_st
																			,L.clean_prac1_st);
			SELF 											:= L;
			SELF 											:= [];
		END;
   
		dBdidPrep	:= PROJECT(pBaseFile,tNormalizeCompany(LEFT));
			
		//BDID
		matchset 	:= ['A','F','P'];
		Business_Header_SS.MAC_Add_BDID_FLEX(
			dBdidPrep
			,matchset
			,clean_company_name
			,prim_range
			,prim_name
			,zip
			,sec_range
			,st
			,clean_phone
			,tin1
			,bdid
			,temp_expand_base 
			,TRUE
			,bdid_score
			,dBdidAppended
			,
			,
			,
			,BIPV2.xlink_version_set
			,
			,
			,p_city_name
			,
			,
			,
			,
			,src
			,
			,
			);
		
		//get lnfid
		Health_Facility_Services.mac_get_best_lnpid_on_thor(
			dBdidAppended
			,lnpid 							// currently using original facility header, but moving this field to lnfid field, below. Will switch to new lnfid macro, when available
			,clean_company_name
			,prim_range
			,prim_name
			,sec_range
			,p_city_name
			,st
			,zip
			,tin1
			,//Input_FEIN = ''
			,//Input_PHONE = ''
			,//Input_FAX = ''
			,lic1_state
			,lic1_num
			,//Input_DEA_NUMBER = ''
			,//group_key
			,npi_num
			,clia_num
			,medicare_fac_num
			,medicaid_fac_num
			,//Input_NCPDP_NUMBER = ''
			,taxonomy
			,bdid
			,//Input_SRC = ''
			,//Input_SOURCE_RID = ''
			,result
			,FALSE
			,32);//30); 20180726 per Senthil - change to 32
											         
		final_file	:= PROJECT(result, transform(Enclarity_facility_sanctions.layouts.base.facility_sanctions,
													self.lnfid := left.lnpid, self := left));
		RETURN final_file;
	END;
END;
