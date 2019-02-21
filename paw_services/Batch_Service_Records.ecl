
IMPORT Autokey_batch, AutokeyB2, BatchServices, Doxie, PAW, paw_services, AutokeyB2_batch, NID, BatchShare, Suppress;

EXPORT Batch_Service_Records( DATASET(Autokey_batch.Layouts.rec_inBatchMaster) ds_batch_in = DATASET([],Autokey_batch.Layouts.rec_inBatchMaster),
                              BOOLEAN return_current_only = FALSE ) := 
	FUNCTION
	
	  // constants:
		
		TOO_MANY_MATCHES := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;

		// ** did,bdid,cid and Acctno
		id_rec :=  RECORD
		 doxie.layout_inBatchMaster.acctno;
		 unsigned integer6 contact_id;
		 UNSIGNED6 		bdid 			:= 0;
		 UNSIGNED6 		did 			:= 0;      
		END;		

		// 1. ak input; derive person and company input
		ak_input  := ds_batch_in;
		ak_pinput := ds_batch_in(comp_name=''); // does not account for address-only input
		ak_cinput := ds_batch_in(comp_name<>'');
		ak_person := ds_batch_in(TRIM(name_last) != '');

		// 2. Configure Autokey search
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
				export set of string1 get_skip_set := [];
				export boolean useAllLookups := true;
		END;
							
		ak_key    := PAW.Constant('').ak_QAname;
		ak_out    := Autokey_batch.get_fids(ak_input, ak_key, ak_config_data);
		outpl_rec := PAW.file_SearchAutokey(PAW.File_Base);
		typestr   := PAW.Constant('').ak_typeStr;
		AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec,outPLfat,did,bdid,typestr);
		outpl     := UNGROUP(outplfat); 
		
		ds_batch_in_capitalized := project(ds_batch_in, batchservices.transforms.xfm_capitalize_input(left));
		
		 nameMatch_value := ak_config_data.MatchName;
		 StreetAddressMatch_value := ak_config_data.MatchStrAddr;
		 cityMatch_value := ak_config_data.MatchCity;
		 stateMatch_value := ak_config_data.MatchState;
		 zipMatch_value := ak_config_data.MatchZip;
		 dobMatch_value := ak_config_data.MatchDOB;
		 ssnMatch_value := ak_config_data.MatchSSN;
		 didMatch_value := ak_config_data.MatchDID;
		 
   
		// 3. Obtain contact_ids...:
		
		// .. for input persons.
		p_outpl      := JOIN(ak_pinput, outpl, LEFT.acctno = RIGHT.acctno, TRANSFORM(RIGHT));
		p_ids_acctno := DEDUP(SORT(PROJECT(p_outpl, id_rec), acctno, contact_id), acctno, contact_id);
		
		// .. for input companies.  20100720-Added KEEP to c_cids join 
		c_outpl      := JOIN(ak_cinput, outpl, LEFT.acctno = RIGHT.acctno, TRANSFORM(RIGHT));
		c_did        := DEDUP(SORT(PROJECT(c_outpl,TRANSFORM(id_rec, SELF.bdid := 0, SELF := LEFT)),acctno,did),acctno,did);
		c_cids       := JOIN(c_did, PAW.Key_Did, 
		                     KEYED(LEFT.did = RIGHT.did), 
		                     TRANSFORM(id_rec, SELF := RIGHT, SELF := LEFT), 
												 KEEP(1000), LIMIT(0));	
												 
		c_ids_acctno := DEDUP(SORT(c_cids, acctno, contact_id), acctno, contact_id);
		
		ids_acctno   := p_ids_acctno + c_ids_acctno + PROJECT(c_did(did=0), id_rec);
		
		// 4. Get matching PAW records.
		recs_pre := join(ids_acctno, paw.Key_contactID,
		                 LEFT.contact_id = RIGHT.contact_id,
								     TRANSFORM(paw_services.Layouts.batch_in, 
															self.MATCHCODES := '', SELF.ERROR_CODE := 0, SELF := RIGHT, SELF := LEFT),
											ATMOST(ut.limits.PAW_PER_CONTACTID)); //currently is upto 25 recs per contactId in index
		
		// 5. Filter out non-current records, if selected.
		recs_no_penalty := recs_pre((return_current_only AND record_type = PAW_Services.Constants.IS_CURRENT_RECORD) OR NOT return_current_only);

		// 6. Apply penalty. Note that this is not the most efficient place to perform penalization, since there is
		// a sort-dedup below. But, it seems to be the most appropriate place.
		
		ds_batch_in_undrscr := PROJECT(ds_batch_in, paw_services.functions.BATCH_VIEW.xfm_prepend_underscore(LEFT));
		// ..prepending input fields with an underscore often prevents name collisions during penalty assessment.
						
		recs_penalized := JOIN(ds_batch_in_undrscr, recs_no_penalty, 
		                       LEFT._acctno = RIGHT.acctno,
													 TRANSFORM(paw_services.Layouts.batch_in,
													           SELF.penalt := paw_services.functions.BATCH_VIEW.fn_apply_penalty(LEFT,RIGHT),
		                                 SELF        := RIGHT));

		// 7. Sort, dedup, roll up.
		recs_bdid0 := DEDUP(SORT(recs_penalized(bdid = 0 and did <> 0)
														,acctno,did,-lname,-fname,-company_name,-score,-dt_last_seen)
												,acctno,did,score,dt_last_seen,company_name,company_title);
												
		recs_rest := DEDUP(SORT(recs_penalized(bdid <> 0 and did <> 0)
														,acctno,did,bdid,-score,-dt_last_seen,record)
											,acctno,did,bdid,score,dt_last_seen,company_title);
											
		recs_srt := SORT( recs_bdid0 + recs_rest, acctno, did, -dt_last_seen, record);		
											     	 
		temp_layout := 	RECORD
			BOOLEAN match_name;
			BOOLEAN match_street_address;
			BOOLEAN match_city;
			BOOLEAN match_state;
			BOOLEAN match_zip;
			BOOLEAN match_ssn;
			BOOLEAN match_dob;
			BOOLEAN match_did;
			boolean matches;
			paw_services.Layouts.batch_in;							 
		END;				
		
		all_recs_match_codes := join(recs_srt, ds_batch_in_capitalized,
              LEFT.acctno = RIGHT.acctno,													
							TRANSFORM(temp_layout,							
							 tmpMatch_Name :=        ((trim(LEFT.fname, left, right) = trim(RIGHT.name_first, left, right) AND RIGHT.name_first <> '') OR
							                         (NID.mod_PFirstTools.PFLeqPFR(trim(LEFT.fname, left, right),trim(RIGHT.name_first, left, right)) AND RIGHT.name_first <> '')) 
																				AND
										                    (trim(LEFT.lname, left, right) = trim(RIGHT.name_last, left, right) AND RIGHT.name_last <> '');
								SELF.match_name := tmpMatch_name;								
								tmpMatch_Street_Address :=  ((LEFT.prim_range = RIGHT.prim_range AND RIGHT.prim_range <> '') AND
																						(LEFT.prim_name = RIGHT.prim_name AND RIGHT.prim_name <> '') AND
																						(LEFT.addr_suffix = RIGHT.addr_suffix AND RIGHT.addr_suffix <> '') AND
																						(LEFT.predir = RIGHT.predir) AND
																						(LEFT.postdir = RIGHT.postdir));																						
                SELF.match_street_address := tmpMatch_street_address;																														
							  tmpMatch_city  := (LEFT.city = RIGHT.p_city_name AND RIGHT.p_city_name <> '');
								SELF.match_city  := tmpMatch_city;															  
								tmpMatch_state :=  (LEFT.state = RIGHT.st AND RIGHT.st<> '');
							  SELF.match_state := tmpMatch_state;																
								tmpMatch_zip  :=  (LEFT.zip = RIGHT.z5 AND RIGHT.z5 <> '') ;
								SELF.match_zip := tmpMatch_zip;								
								tmpMatch_ssn   := (LEFT.ssn = RIGHT.ssn AND RIGHT.ssn <> '');
								SELF.match_ssn := tmpMatch_ssn;																
								tmpMatch_did :=  LEFT.did = RIGHT.did AND RIGHT.did <> 0;
								SELF.match_did   :=	tmpMatch_did;								                
								SELF.acctno      := LEFT.acctno; // sets acctno
								
								matches :=  ((~(nameMatch_value)) OR (TmpMatch_name))
								            AND 
												   ((~(streetAddressMatch_value)) OR (tmpMatch_Street_Address))
													  AND
														((~(cityMatch_value)) OR (TmpMatch_city))
														AND
														((~(stateMatch_value)) OR (TmpMatch_state))
														AND
														((~(zipMatch_value))  OR (TmpMatch_zip))
														AND
														((~(ssnMatch_value)) OR (tmpMatch_ssn))														
														AND
														((~(didMatch_value))  OR (TmpMatch_did));
								SELF.matches := matches;
								
								tmp_match_codes_string := batchservices.functions.match_code_result(
								                        TmpMatch_name, tmpMatch_Street_Address,
																				TmpMatch_city, TmpMatch_state, TmpMatch_zip, 
																				tmpMatch_ssn, FALSE, TmpMatch_did);
								SELF.matchcodes := tmp_match_codes_string;
								SELF := left,
								SELF := []));
				
    all_recs_match_codes_keep := all_recs_match_codes(matches = true);				

										
	 	all_recs := project(all_recs_match_codes_keep, TRANSFORM(paw_services.Layouts.batch_in,		                      
		                       SELF := LEFT));
													 
    too_many := ak_out(search_status = TOO_MANY_MATCHES);
		
		too_many_w_error_code := project(too_many, TRANSFORM(paw_services.Layouts.batch_in,
		                                   SELF.error_code := LEFT.search_status,
																			 SELF := LEFT,
																			 SELF := []
																			 ));
				
		to_suppress := all_recs + too_many_w_error_code;
				
		//Suppress by SSN and DID.
		base_params := BatchShare.IParam.getBatchParams();
		Suppress.MAC_Suppress(to_suppress, ssn_suppressed, base_params.applicationType, Suppress.Constants.LinkTypes.SSN, ssn);
		Suppress.MAC_Suppress(ssn_suppressed, did_suppressed, base_params.applicationType, Suppress.Constants.LinkTypes.DID, did);
			
  all_recsTmp := DEDUP(GROUP(did_suppressed, acctno, did), true, keep(5));
		all_recs_rolled := ROLLUP(all_recsTmp, GROUP, paw_services.Functions.Batch_view.format_batch_out(LEFT,rows(LEFT)));
		
		// 8. Business rule: the system must return only one matching row (having the lowest penalty) for  
		// those input records denoting a person (whether there's a comp_name or not). The system may return  
		// all matching rows for those input records that denote a business.
		 person_recs := JOIN(all_recs_rolled, ak_person,
		                    LEFT.acctno = RIGHT.acctno,
		                    TRANSFORM(LEFT), 
		                    INNER);
		
		person_recs_grpd := GROUP(SORT(person_recs, acctno, penalt), acctno);
		person_recs_tppd := TOPN(person_recs_grpd, 1, acctno);
		
		business_recs := JOIN(all_recs_rolled, ak_person,
		                      LEFT.acctno = RIGHT.acctno,
		                      TRANSFORM(LEFT), 
		                      LEFT ONLY);
		
		res := UNGROUP(person_recs_tppd) + business_recs;
				
		res_srt := SORT(res, acctno, -pawk_1_first_seen);
		
		// 9. Slim off 'penalt' and return.
		results := PROJECT( res_srt, {paw_services.Layouts.batch_out AND NOT penalt} );
				
		 // output(ak_person, named('ak_person'));
		 // output(nameMatch_value, named('nameMatch_value'));
		 // output(ds_batch_in, named('ds_batch_in'));		
		 // output(recs_srt, named('recs_srt'));
		 // output(all_recs_match_codes, named('all_recs_match_codes'));
		 // output(all_recs_match_codes_keep, named('all_recs_match_codes_keep'));
		 // output(all_recs, named('all_recs'));
		 // output(all_recsTmp, named('all_recsTmp'));
		 // output(all_recs_rolled, named('all_recs_rolled'));
		 // output(all_recs, named('all_recs'));
		  // output(ak_out, named('ak_out'));
			// output(too_many, named('too_many'));
      // output(person_recs, named('person_recs'));     		
		 // output(person_recs_grpd, named('person_recs_grpd'));
		  // output(person_recs_tppd, named('person_recs_tppd'));
		  // output(business_recs, named('business_recs'));
			 // output(res_srt, named('res_srt'));	
		//
		RETURN results;
		
	END;	