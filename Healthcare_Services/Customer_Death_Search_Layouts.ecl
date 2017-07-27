Import Healthcare_Provider_Services,DEATH_MI;
EXPORT Customer_Death_Search_Layouts := MODULE

	export autokeyInput := record
	    Healthcare_Provider_Services.Layouts.autokeyInput-[prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,st,z5,zip4,fein,comp_name,
																												bdid,license_number,license_state,clianumber,homephone,workphone,dl,dlstate,vin,Plate,PlateState,searchType,max_results,score,MatchCode,
																												date,sic_code,filing_number,apn,fips_code,score_bdid,TaxID,UPIN,NPI,DEA,ProviderID,ProviderSrc,isReport,
																												isBatchService,isExactAddressMatch,BestOnly,ShowComplete,includeSanctions,doDeepDive,includeCustomerData,derivedinputrecord];
	end;
	Export AKLayoutOutput := Record
			DEATH_MI.Layouts.Base;
	end;
	Export LayoutOutput := Record
			string20 acctno := '';
			DEATH_MI.Layouts.Base;
			string MatchPercent := '';
			boolean isFirstNameMatch := false;
			boolean isLastNameMatch := false;
			boolean isDOBMatch := false;
	end;

	Export LayoutOutputBatch := Record
			string20 acctno := '';
			DEATH_MI.Layouts.Base -[clean_address,clean_name,dt_vendor_first_reported,dt_vendor_last_reported,raw_aid,ace_aid,did,bdid,customer_id];
			string25 customer_id;
			string8  dt_vendor_first_reported:= '';
			string8  dt_vendor_last_reported:= '';
			string20 raw_aid:= '';
			string20 ace_aid:= '';
			string14 did:= '';
			string14 bdid:= '';
			string10 clean_prim_range := '';
			string2  clean_predir	:= '';
			string28 clean_prim_name := '';
			string4  clean_addr_suffix := '';
			string2  clean_postdir := '';
			string10 clean_unit_desig := '';
			string8  clean_sec_range := '';
			string25 clean_p_city_name := '';
			string25 clean_v_city_name := '';
			string2  clean_st := '';
			string5  clean_zip := '';
			string4  clean_zip4 := '';
			string4  clean_cart := '';
			string1  clean_cr_sort_sz := '';
			string4  clean_lot := '';
			string1  clean_lot_order := '';
			string2  clean_dbpc := '';
			string1  clean_chk_digit := '';
			string2  clean_rec_type := '';
			string2  clean_fips_state := '';
			string3  clean_fips_county := '';
			string10 clean_geo_lat := '';
			string11 clean_geo_long := '';
			string4  clean_msa := '';
			string7  clean_geo_blk := '';
			string1  clean_geo_match := '';
			string4  clean_err_stat := '';
			string5  clean_title := '';
			string20 clean_fname := '';
			string20 clean_mname := '';
			string20 clean_lname := '';
			string5  clean_name_suffix := '';
			string3  clean_name_score := '';
			string3  MatchPercent := '';
			string5  isFirstNameMatch := '';
			string5  isLastNameMatch := '';
			string5  isDOBMatch := '';
	end;
End;