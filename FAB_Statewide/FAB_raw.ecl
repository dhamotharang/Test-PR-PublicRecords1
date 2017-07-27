
IMPORT Statewide_Services,
       Corp2_services,
			 FBNV2_services,
			 CALBUS_services,
			 TXBUSV2_services
			 ,FAP_StateWide
			 ;

/* NOTE: many of the functions that FAB_Statewide service calls are found in FAP_Statewide.FAP_raw, 
	 since they are common to both FAB_ and FAP_Statewide. */
	 
EXPORT FAB_raw := MODULE
		
	EXPORT Search := MODULE
		
				// *******************************  MEMBERS  *******************************
		
				SHARED DOC_TYPE := Statewide_Services.Constants;
				
				// ******************************* FUNCTIONS *******************************

				//****** CORP SEARCH ******
				EXPORT FAB_SearchCorpData() := FUNCTION

					// Perform CorpV2 records search. *** NOTE: PERSIST is for development only !!!!! ***
					ds_corpV2_recs := Corp2_services.CorpSearch(); // : PERSIST('FAB_Statewide_CorpV2_Records');
		
					// Effectively filter out all non-Current records.
					ds_corpv2_current_recs := PROJECT(ds_corpV2_recs(EXISTS(corp_hist(record_type='C'))),
						                                  TRANSFORM( RECORDOF(ds_corpV2_recs), SELF.corp_hist := LEFT.corp_hist(record_type='C'),
																							                                     SELF           := LEFT));					
	       	// For output purposes concerning Corp info, we'll display the information from mostly the 
					// history section of the report, where the record is 'current.'
					layout_FAB_Statewide_out xfm_convert_CorpV2_to_output_format(ds_corpV2_recs l) := TRANSFORM
						SELF.source_doc_type := StateWide_Services.constants.constant('CO');
						SELF.record_id       := l.corp_key;
						SELF.jurisdiction    := l.corp_state_origin;
						SELF.id              := (UNSIGNED6)l.corp_hist[1].bdid;
						SELF.is_bdid         := TRUE;
						p := PROJECT(l.contacts,corp2_services.layout_contact_search);
						cont := FAP_StateWide.PenaltyI.get_CorpCont_info(p);
						p1 := PROJECT(l.corp_hist,corp2_services.layout_corp_search);
						corp_hist := FAP_StateWide.PenaltyI.get_CorpHist_info(p1);
						res_1 := cont+corp_hist;
						res := CHOOSEN(SORT(res_1,penalt),1);
						SELF := res[1];
   					SELF                 := l;
					END; 
													
					RETURN PROJECT(ds_corpV2_current_recs, xfm_convert_CorpV2_to_output_format(LEFT));	
					
				END;				
			
				//*****  Fictitious Business Names Search *****
				EXPORT FAB_SearchFBN() := FUNCTION
					
					// Perform FBN records search. *** NOTE: PERSIST is for development only !!!!! ***
					ds_fbn_recs := FBNV2_services.FBNV2_records; // : PERSIST('FAB_Statewide_FBN_Records');
													
					// Slim down the recordset to only what we need.
					layout_FAB_Statewide_out xfm_convert_FBNs_to_output_format(ds_fbn_recs l) := TRANSFORM
						SELF.source_doc_type := StateWide_Services.constants.constant('FB');
						SELF.record_id       := l.tmsid;
						SELF.jurisdiction    := l.filing_jurisdiction[1..2];
						SELF.full_name       := '';
		        SELF.id              := l.bdid;
            SELF.is_bdid         := TRUE;  
						best_party := Fap_Statewide.PenaltyI.get_FBNParty_info(l);
						SELF                 := best_party;
						SELF                 := l;
					END; 
					RETURN PROJECT(ds_fbn_recs, xfm_convert_FBNs_to_output_format(LEFT));
					
		    END;	
				
				//*****  California Business Search
				EXPORT FAB_SearchCALBUS() := FUNCTION
					
					// Perform California Business records search. *** NOTE: PERSIST is for development only !!!!! ***
					ds_calbus_recs := PROJECT(CALBUS_services.search_records,CALBUS_Services.layouts.SearchOutput); // : PERSIST('FAB_Statewide_CALBUS_Records');
													
					// Slim down the recordset to only what we need.
					layout_FAB_Statewide_out xfm_convert_CALBUSs_to_output_format(CALBUS_Services.layouts.SearchOutput l) := TRANSFORM
						SELF.source_doc_type := StateWide_Services.constants.constant('CB');
						calbus_res := FAP_StateWide.PenaltyI.get_CALBUS_info(l);
						SELF.jurisdiction    := 'CA';
						SELF.is_bdid := TRUE;
						SELF := calbus_res;						
						SELF                 := l;
					END; 
					
					RETURN PROJECT(ds_calbus_recs, xfm_convert_CALBUSs_to_output_format(LEFT));		
					
		    END;					
				
				//*****  Texas Business Search
				EXPORT FAB_SearchTXBUS() := FUNCTION
				
					TXBUS_search_params := MODULE(TxbusV2_services.Interfaces.search_params)
					 EXPORT BOOLEAN is_search := TRUE;
					END;
								
					// Perform Texas Business records search. *** NOTE: PERSIST is for development only !!!!! ***
					ds_txbus_recs := TXBUSV2_services.TxBusSearch(TXBUS_search_params); // : PERSIST('FAB_Statewide_TXBUS_Records');
													
					// Slim down the recordset to only what we need.
					layout_FAB_Statewide_out xfm_convert_TXBUSs_to_output_format(ds_txbus_recs l) := TRANSFORM
						SELF.source_doc_type := StateWide_Services.constants.constant('TB');
						SELF.record_id       := l.taxpayer_number;
						SELF.jurisdiction    := 'TX';
						best_party := Fap_Statewide.PenaltyI.get_TxBusParty_info(l);
						SELF                 := best_party;						
						SELF                 := l;
					END; 
					RETURN PROJECT(ds_txbus_recs, xfm_convert_TXBUSs_to_output_format(LEFT));						
					
		    END;	
	

	END; // Search() module

	
END;