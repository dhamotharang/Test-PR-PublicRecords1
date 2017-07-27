Import Healthcare_Provider_Services,MMCP;
EXPORT Customer_License_Search_Layouts := MODULE

	export autokeyInput := record
	    Healthcare_Provider_Services.Layouts.autokeyInput-[ssn,dob,homephone,workphone,dl,dlstate,vin,Plate,PlateState,searchType,max_results,score,MatchCode,
																												date,sic_code,filing_number,apn,fips_code,score_bdid,TaxID,UPIN,NPI,DEA,ProviderID,ProviderSrc,isReport,
																												isBatchService,isExactAddressMatch,BestOnly,ShowComplete,includeSanctions,doDeepDive,includeCustomerData];
	end;
	Export AKLayoutOutput := Record
			MMCP.Layouts.Base;
	end;
	Export LayoutOutput := Record
			string20 acctno := '';
			boolean isAutoKeyResults := false;	
			unsigned2 penalt := 0;
			unsigned2 sortid := 0;
			MMCP.Layouts.Base;
	end;

	Export LayoutOutput_batch := Record
			string20 acctno := '';
			boolean isAutoKeyResults := false;	
			unsigned2 penalt := 0;
			MMCP.Layouts.Base-[clean_company_address,clean_name];
			string20 cln_fname :='';
			string20 cln_mname :='';
			string20 cln_lname :='';
			string5  cln_name_suffix :='';
			string10 cln_prim_range :='';
			string2  cln_predir :='';	
			string28 cln_prim_name :='';
			string4  cln_addr_suffix :='';
			string2  cln_postdir :='';
			string10 cln_unit_desig :='';	
			string8  cln_sec_range :='';
			string25 cln_city_name :='';	
			string2  cln_st :='';	
			string5  cln_zip :='';
	end;
End;