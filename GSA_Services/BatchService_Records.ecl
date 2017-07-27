IMPORT AutokeyB2, Autokey_batch, doxie,gsa, gsa_services,batchservices;
doxie.MAC_Header_Field_Declare()

EXPORT BatchService_Records( DATASET(Layouts.gsa_rec_inBatchMaster) ds_batch_in 
                                    = DATASET([],Layouts.gsa_rec_inBatchMaster),unsigned2 penaltyOverride = 0,
																		STRING8 ActionStartDate = '', STRING8 ActionEndDate = '') := MODULE
																		
																		
		//autokey information
		shared c := GSA.Constants('');
		SHARED ak_keyname	:= c.ak_keyname;   
		SHARED ak_dataset	:= c.ak_dataset;   
		SHARED ak_typeStr	:= c.ak_typeStr;   
	
		//configure the autokey search.		
		SHARED ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export workHard        := TRUE; // for Autokey_batch.Fetch_Address_Batch to run at all.
			export useAllLookups   := FALSE; // for Autokey_batch.Fetch_SSN_Batch to run SSN2 key. SSN key is empty.
			export isTestHarness   := FALSE;
			export skip_set        := c.ak_skipSet; 
		END;
		
		// get autokey ids based on batch input.
		ds_gsa_ids := Autokey_batch.get_fids(project(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster), c.str_autokeyname, ak_config_data);
		
		// get autokey payloads 
		AutokeyB2.mac_get_payload( UNGROUP(ds_gsa_ids), c.str_autokeyname, ak_dataset, SHARED outpl, zero, zero, ak_typeStr )
		
		// keep the gsa_id and acctno etc. only.
		ds_gsa_ids_by_autokey := DEDUP(SORT( PROJECT(outpl, Layouts.autokey_fetch_gsa_id), 
																								acctno, gsa_id ), acctno, gsa_id);
		
		// join by GSA_id to get payload data
		ds_gsa_ids_all := Raw.joinByGSAId(ds_gsa_ids_by_autokey);
		
		// Apply date restriction
		ds_gsa_ids_filt := if(ActionStartDate !='' or ActionEndDate !='', Raw.filterByDate(ds_gsa_ids_all,ActionStartDate,ActionEndDate), ds_gsa_ids_all);
		
		//Apply logic to get primary record with actions, references and addresses.
		ds_primary_recs := Raw.getPrimaryRecords(ds_gsa_ids_filt, ds_batch_in);
		
		//filter hits to return exact matches only or the set penalty threshold.
		pen:=if(penaltyOverride>0,penaltyOverride,penalt_threshold_value);
		ds_exact_matches := ds_primary_recs(_penalty <= pen);
		
		//return output as standard flat output of a record per hit on acctno.
		export ds_outRecs := ds_exact_matches;

END;

