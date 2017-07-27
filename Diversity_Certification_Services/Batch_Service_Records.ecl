IMPORT Autokey_batch, AutoStandardI, BatchServices, Diversity_Certification, AutokeyB2, Doxie, ut;

// Local layouts.
rec_keybuild_plus_acctno := RECORD
	STRING20 acctno         := '0';
	STRING8  lookup_type    := '';
	UNSIGNED2 penalty_value :=  0;
	Diversity_Certification.Layouts.KeyBuild;
END;

get_penalty_value(Autokey_batch.Layouts.rec_inBatchMaster le, rec_keybuild_plus_acctno ri) :=
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
		
		mod_matched_mail_address := MODULE(ut.mod_penalize.IGenericAddress)
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

	  mod_matched_prop_address := MODULE(ut.mod_penalize.IGenericAddress)
			EXPORT prim_range  := ri.p_prim_range;  
			EXPORT predir      := ri.p_predir;      
			EXPORT prim_name   := ri.p_prim_name;  
			EXPORT addr_suffix := ri.p_addr_suffix;
			EXPORT postdir     := ri.p_postdir;     
			EXPORT sec_range   := ri.p_sec_range;   
			EXPORT p_city_name := ri.p_p_city_name; 
			EXPORT st          := ri.p_st;          
			EXPORT z5          := ri.p_zip;          
		END;
		
		mod_input_name := MODULE(ut.mod_penalize.IGenericPersonName)
			EXPORT STRING name_last   := le.name_last;
			EXPORT STRING name_first  := le.name_first;
			EXPORT STRING name_middle := le.name_middle;
		END;
		
		mod_matched_name := MODULE(ut.mod_penalize.IGenericPersonName)
			EXPORT STRING name_last   := ri.LNAME;
			EXPORT STRING name_first  := ri.FNAME;
			EXPORT STRING name_middle := ri.MNAME;
		END;
		
		penalized_companyname := ut.mod_penalize.company_name(le.comp_name, ri.BusinessName);
		// A property and mailing address exist for each record, score and take the best(lowest) penalty value
		penalized_address := MIN(ut.mod_penalize.address(mod_input_address, mod_matched_mail_address), 
														 ut.mod_penalize.address(mod_input_address, mod_matched_prop_address));
		penalized_personname := ut.mod_penalize.person_name(mod_input_name, mod_matched_name);
	
		RETURN penalized_companyname + penalized_address + penalized_personname;
	END;
	
EXPORT Batch_Service_records( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in_parm = DATASET([], Autokey_batch.Layouts.rec_inBatchMaster) ) :=
		FUNCTION
		
		UNSIGNED8 MaxResultsPerAcct := 2000 : STORED('max_results_per_acct');

		// 1. Do project with  transform to convert any lower case input to upper case.
    ds_batch_in := project(ds_batch_in_parm,BatchServices.transforms.xfm_capitalize_input(LEFT));
		
		// 2. Define values for obtaining autokeys and payloads.	
		// constants  := constants();
		SHARED ak_keyname := Diversity_Certification.constants().autokey_qa_name;
		SHARED ak_dataset := Diversity_Certification.File_Base_Payload();
		SHARED ak_typeStr := Diversity_Certification.constants().ak_typeStr;
				
		// 3. Configure the autokey search.		
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			EXPORT workHard        := TRUE; 
			EXPORT useAllLookups   := TRUE; 
			EXPORT PenaltThreshold := 20;
			EXPORT skip_set        := Diversity_Certification.constants().autokey_buildskipset;
		END;
		
		// 4. Get autokey 'fake' ids (fids) based on batch input.
		SHARED ds_fids := Autokey_batch.get_fids(ds_batch_in, ak_keyname, ak_config_data);
					
		// 5. Get autokey payloads, most importantly the unique id.
		AutokeyB2.mac_get_payload( UNGROUP(ds_fids), ak_keyname, ak_dataset, SHARED by_Autokey, did, bdid, ak_typeStr )
				
		// 6. Retrieve the by unique id that was derived from the payload file
		by_Unique :=
		  JOIN(
				by_Autokey(unique_id != 0),
				Diversity_Certification.Key_UniqueID,
				KEYED(LEFT.unique_id = RIGHT.unique_id),
				TRANSFORM( rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'unique_id',
					SELF        := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
				
		// 7. Search by bdid
		by_BDID := 
			JOIN(
				ds_batch_in(bdid != 0),
				Diversity_Certification.Key_DiversityCert_BDID,
				KEYED(LEFT.bdid = RIGHT.bdid),
				TRANSFORM( rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'bdid',
					SELF        := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
	
		// 6. Search by did		
		by_DID := 
			JOIN(
				ds_batch_in(did != 0),
				Diversity_Certification.Key_DiversityCert_DID,			
				KEYED(LEFT.did = RIGHT.did),
				TRANSFORM( rec_keybuild_plus_acctno,
					SELF.acctno := LEFT.acctno,
					SELF.lookup_type := 'did',
					SELF        := RIGHT
				),
				INNER,
				limit(ut.limits.default, skip)
			);
			
		// Union; penalize.
		by_all := SORT(by_unique + by_BDID + by_DID,acctno,bdid,did,-dt_last_seen,-dateadded);
		
		// Dedup records that have bdids 
		by_all_dedup := DEDUP(by_all(bdid != 0),acctno,bdid,did) + by_all(bdid = 0);
		
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
		
		by_all_sorted := DEDUP(SORT(by_all_penalized(penalty_value <= ak_config_data.PenaltThreshold), acctno, penalty_value, -DateUpdated, -DateAdded),acctno, KEEP MaxResultsPerAcct);
		
		results := PROJECT( by_all_sorted, Diversity_Certification_Services.layouts_batch.Batch_out);
			
		RETURN(results);
END;
