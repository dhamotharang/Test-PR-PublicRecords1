IMPORT Autokey_batch, AutoStandardI, BatchServices, AutokeyB2, Doxie, ut;

// Local layouts.
rec_keybuild_plus_acctno := RECORD
	STRING20 acctno         := '0';
	STRING8  lookup_type    := '';
	UNSIGNED2 penalty_value :=  0;
	NaturalDisaster_Readiness.Layouts.KeyBuild;
END;

strip_punctuation(STRING inString) := 
	FUNCTION
		STRING punct := ';-!?.,:\"\'()';
		RETURN (StringLib.StringFilterOut(inString,punct));
				
	END;
		
penalize_nonclean_address(NaturalDisaster_Readiness.Layouts.batch_in input_addr, rec_keybuild_plus_acctno matched_addr) := 
	FUNCTION
			// Convert 2 char or 3 char country to full name
	    country_prep := TRIM(strip_punctuation(input_addr.country));
			country_decoded := IF(LENGTH(country_prep) =2 AND ut.Country_ISO2_To_Name(country_prep) != '',ut.Country_ISO2_To_Name(country_prep),
												 IF(LENGTH(country_prep) =3 AND ut.Country_ISO3_To_Name(country_prep) != '',ut.Country_ISO3_To_Name(country_prep),country_prep));
			
			concat_input_street := StringLib.StringCleanSpaces(strip_punctuation(input_addr.prim_range + input_addr.predir + 
																												 input_addr.prim_name + input_addr.addr_suffix + 
																												 input_addr.postdir + input_addr.sec_range));
			concat_matched_street := StringLib.StringCleanSpaces(strip_punctuation(matched_addr.business_address1 + matched_addr.clean_business_address2));
		
			/* The penalty is calculated by using the percentage alike result and integer dividing by 10. Using the
				DIV operation will only return whole integer from the equation, I.E. 74 DIV 10 will return 7.
        Ten is used since the maximum match percentage is 100. */
			country_penalty := IF(country_decoded != '',10 - (ut.StringSimilar3Gram(country_decoded, strip_punctuation(matched_addr.business_country)) DIV 10),5);
			city_penalty := IF(input_addr.p_city_name != '',10 - (ut.StringSimilar3Gram(strip_punctuation(input_addr.p_city_name), strip_punctuation(matched_addr.clean_business_city)) DIV 10),5);
			street_penalty := IF(concat_input_street != '',10 - (ut.StringSimilar3Gram(concat_input_street, concat_matched_street) DIV 10),0);
			
			RETURN(country_penalty + city_penalty + street_penalty);
	END;
	
get_penalty_value(NaturalDisaster_Readiness.Layouts.batch_in le, rec_keybuild_plus_acctno ri) :=
	FUNCTION

		mod_input_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := le.prim_range;  
			EXPORT predir      := le.predir;      
			EXPORT prim_name   := le.prim_name;  
			EXPORT addr_suffix := le.addr_suffix;
			EXPORT postdir     := le.postdir;     
			EXPORT sec_range   := le.sec_range;   
			EXPORT p_city_name := le.p_city_name; 
			EXPORT st          := le.st;          
			EXPORT z5          := le.z5;          
		END;
				
		mod_matched_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := ri.m_prim_range;  
			EXPORT predir      := ri.m_predir;      
			EXPORT prim_name   := ri.m_prim_name;  
			EXPORT addr_suffix := ri.m_addr_suffix;
			EXPORT postdir     := ri.m_postdir;     
			EXPORT sec_range   := ri.m_sec_range;   
			EXPORT p_city_name := ri.m_p_city_name; 
			EXPORT st          := ri.m_st;          
			EXPORT z5          := ri.m_zip;          
		END;
		STRING matched_clean_addrFields := ri.m_prim_range + ri.m_predir + ri.m_prim_name +
																				ri.m_addr_suffix + ri.m_postdir + ri.m_sec_range +
																				ri.m_p_city_name + ri.m_st + ri.m_zip;
		BOOLEAN has_cleanAddr := matched_clean_addrFields != '';
		
		// If there is a clean matched address the generic utility is used to penalize the address, however if 
		// there isn't a clean matched address, the service specific penalization routine is used. 
		penalized_address := IF(has_cleanAddr,ut.mod_penalize.address(mod_input_address, mod_matched_address),penalize_nonclean_address(le,ri));
		penalized_companyname := ut.mod_penalize.company_name(le.comp_name, ri.Business_Name);

		RETURN penalized_companyname + penalized_address;
	END;
	
// EXPORT NaturalDis_Readiness_BatchService_Records(BOOLEAN useCannedRecs = FALSE) := FUNCTION
EXPORT Batch_Service_records( DATASET(NaturalDisaster_Readiness.Layouts.batch_in) ds_batch_in_parm = DATASET([], NaturalDisaster_Readiness.Layouts.batch_in) ) :=
		FUNCTION

		UNSIGNED8 MaxResultsPerAcct := 2000 : STORED('max_results_per_acct');
		
		NaturalDisaster_Readiness.Layouts.batch_in capitalize_input(NaturalDisaster_Readiness.Layouts.batch_in l) := TRANSFORM
			SELF.prim_range  := StringLib.StringToUpperCase(l.prim_range);	
			SELF.predir      := StringLib.StringToUpperCase(l.predir);	
			SELF.prim_name   := StringLib.StringToUpperCase(l.prim_name);	
			SELF.addr_suffix := StringLib.StringToUpperCase(l.addr_suffix);	
			SELF.postdir     := StringLib.StringToUpperCase(l.postdir);	
			SELF.unit_desig  := StringLib.StringToUpperCase(l.unit_desig);	
			SELF.sec_range   := StringLib.StringToUpperCase(l.sec_range);	
			SELF.p_city_name := StringLib.StringToUpperCase(l.p_city_name);	
			SELF.st          := StringLib.StringToUpperCase(l.st);	
			SELF.country     := StringLib.StringToUpperCase(l.country);
			SELF.comp_name   := StringLib.StringToUpperCase(l.comp_name);
			SELF             := l;
		END;
		
		// 1. Do project with  transform to convert any lower case input to upper case.
    ds_batch_in := PROJECT(ds_batch_in_parm,capitalize_input(LEFT));
				
		// 2. Define values for obtaining autokeys and payloads.	
		cons := NaturalDisaster_Readiness.constants();
		SHARED ak_keyname := cons.ak_qa_keyname;
		SHARED ak_dataset := cons.ak_dataset;
		SHARED ak_typeStr := cons.ak_typeStr;
		
		// 3. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT workHard        := TRUE; 
			EXPORT useAllLookups   := TRUE; 
			EXPORT PenaltThreshold := 20;
			EXPORT skip_set        := cons.ak_skipSet;
		END;
		
		// 4. Get autokey 'fake' ids (fids) based on batch input.
		ds_fids := Autokey_batch.get_fids(PROJECT(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster), ak_keyname, ak_config_data);
				
		// 5. Get autokey payloads, and project to common layout.
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, by_Autokey_temp, did, bdid, ak_typeStr )
		by_Autokey := PROJECT(by_Autokey_temp,TRANSFORM(rec_keybuild_plus_acctno,
																										SELF.lookup_type := 'autokey',
																										SELF 						 := LEFT));
		
		// 6. Search by bdid
		by_BDID := 
			JOIN(
				ds_batch_in(bdid != 0),
				NaturalDisaster_Readiness.Key_BDID,
				KEYED(LEFT.bdid = RIGHT.bdid),
				TRANSFORM( rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'bdid',
					SELF        := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
			
		// Union; penalize.
		by_all := by_Autokey + by_BDID;
		by_all_dedup := DEDUP(by_all,EXCEPT lookup_type, ALL);
		
		by_all_penalized := 
			JOIN(
				ds_batch_in,
				by_all_dedup,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( rec_keybuild_plus_acctno,
					SELF.penalty_value := get_penalty_value(LEFT,RIGHT),
					SELF               := RIGHT
				),
				RIGHT OUTER
			);
		
		by_all_sorted := DEDUP(SORT(by_all_penalized(penalty_value <= ak_config_data.PenaltThreshold), acctno, penalty_value, -Date_Updated, -Date_Added),acctno,KEEP MaxResultsPerAcct);
		
		results := PROJECT( by_all_sorted, NaturalDisaster_Readiness.Layouts.batch_out);
		RETURN(results);
END;