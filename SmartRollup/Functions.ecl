IMPORT ut, AML, iesp;

EXPORT Functions := MODULE
		 
	EXPORT dedup_businesses(ds_recs_in,date_sort_flds='dt_last_seen',best_limit=250) := FUNCTIONMACRO
		 IMPORT BIPV2_Best, BIPV2;
		 
			// For records without a seleid, dedup on company name and address and keep the most recent rec
			non_sele_recs_sorted := SORT(ds_recs_in(BusinessIds.seleid = 0),CompanyName,Address.StreetNumber,Address.StreetPreDirection,
																			Address.StreetName,Address.UnitDesignation,Address.UnitNumber,Address.City,Address.State,
																			Address.Zip5,-date_sort_flds,record);
      non_sele_recs_dedup := DEDUP(non_sele_recs_sorted,CompanyName,Address.StreetNumber,Address.StreetPreDirection,
																			Address.StreetName,Address.UnitDesignation,Address.UnitNumber,Address.City,Address.State,
																			Address.Zip5);
																			
			sele_recs_sorted := SORT(ds_recs_in(BusinessIds.seleid != 0),BusinessIds.ultid,BusinessIds.orgid,BusinessIds.seleid,-date_sort_flds,record);
			sele_recs_dedup := DEDUP(sele_recs_sorted,BusinessIds.ultid,BusinessIds.orgid,BusinessIds.seleid);
			sele_best_keys := PROJECT(sele_recs_dedup,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																									 SELF.ultid := LEFT.BusinessIds.ultid,
																									 SELF.orgid := LEFT.BusinessIds.orgid,
																									 SELF.seleid := LEFT.BusinessIds.seleid,
																									 SELF := []));
			
			// Hit the best key, and keep only the records with a proxid value of zero, records with a
			// proxid of zero are the best sele records for a set of ult/org/sele
			sele_best_info := BIPV2_Best.Key_LinkIds.kFetch(sele_best_keys,BIPV2.IDconstants.Fetch_Level_SeleID,,,false,best_limit)(proxid=0);
      			
			sele_best_comb := JOIN(sele_recs_dedup,sele_best_info,
															LEFT.BusinessIds.ultid = RIGHT.ultid AND
															LEFT.BusinessIds.orgid = RIGHT.orgid AND
															LEFT.BusinessIds.seleid = RIGHT.seleid,
															TRANSFORM(RECORDOF(ds_recs_in),
																		SELF.CompanyName := RIGHT.company_name[1].company_name,
																		SELF.Address.StreetNumber := RIGHT.company_address[1].company_prim_range,
																		SELF.Address.StreetPreDirection := RIGHT.company_address[1].company_predir,
																		SELF.Address.StreetName := RIGHT.company_address[1].company_prim_name,
																		SELF.Address.StreetSuffix := RIGHT.company_address[1].company_addr_suffix,
																		SELF.Address.StreetPostDirection := RIGHT.company_address[1].company_postdir,
																		SELF.Address.UnitDesignation := RIGHT.company_address[1].company_unit_desig,
																		SELF.Address.UnitNumber := RIGHT.company_address[1].company_sec_range,
																		SELF.Address.City := RIGHT.company_address[1].company_p_city_name,
																		SELF.Address.State := RIGHT.company_address[1].company_st,
																		SELF.Address.Zip5 := RIGHT.company_address[1].company_zip5,
																		SELF.Address.Zip4 := RIGHT.company_address[1].company_zip4,
																		SELF.Address.County := RIGHT.company_address[1].county_name,
																		SELF.Address := [],
																		SELF := LEFT));
			results := sele_best_comb+non_sele_recs_dedup;
			RETURN(results);
		ENDMACRO;
		
		//NOTE make params state and county
		// Function to calculate the high intensity drug trafficking area by county 
		EXPORT CalcHidta(String inFipsStCounty = '', String inState = '', String inFipsCounty = '') := FUNCTION
			
			// Prepend zeroes if county length less than 2.
			FipsCounty := CASE(LENGTH(inFipsCounty), 1 => '00' + inFipsCounty,
																							 2 => '0' + inFipsCounty,
																								inFipsCounty);
																								
			FipsAddrtoUse :=  IF(inFipsStCounty != '',inFipsStCounty,
																	ut.st2FipsCode(StringLib.StringToUpperCase(inState)) + FipsCounty);
			Hidta := FipsAddrtoUse in AML.AMLConstants.setHIDTA;
			RETURN(Hidta);
		END;
		
		// Function to calculate the high intensity financial crime area by county
		EXPORT CalcHifca(String inFipsStCounty = '', String inState = '', String inFipsCounty = '') := FUNCTION
			
			// Prepend zeroes if county length less than 2.
			FipsCounty := CASE(LENGTH(inFipsCounty), 1 => '00' + inFipsCounty,
																							 2 => '0' + inFipsCounty,
																								inFipsCounty);
			FipsAddrtoUse :=  IF(inFipsStCounty != '',inFipsStCounty,
																	ut.st2FipsCode(StringLib.StringToUpperCase(inState)) + FipsCounty);
			Hifca := FipsAddrtoUse in AML.AMLConstants.setHIFCA;
			RETURN(Hifca);
		END;
END;