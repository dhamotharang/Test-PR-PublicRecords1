/*2012-09-07T21:02:25Z (Tina Gonsiewski)
For reference only
*/
/*2012-08-29T03:33:30Z (Tina Gonsiewski)
Checked in for review before roxie release bug is created.
*/
IMPORT AMS, Autokey_batch, autokeyb2, AutoKeyI, AutoStandardI, BatchServices, 
       doxie, doxie_files, Prof_licensev2_services, ut;

/* 
AMS - Advantage Medical Services

Available functions:
 o funtions that return a table of ams_ids:
   - get_ams_pids_by_bdid ( STRING input_bdid )
   - get_ams_pids_by_bdids ( DATASET( AMS.Layouts.layout_references.ams_bdid_rec ) ds_bdids )
   - get_ams_pids_by_did ( STRING input_did )
   - get_ams_pids_by_dids( DATASET( AMS.Layouts.layout_references.ams_did_rec ) ds_dids )
   - get_ams_pids_by_fdids( DATASET( {unsigned6 ID, boolean isDID, boolean isBDID, boolean IsFake}  ) ams_fdids )
   - get_ams_pids_by_ING_pid( UNSIGNED6 in_ING_providerid )
   - get_ams_pids_by_ING_pids( DATASET(prof_LicenseV2_Services.Layout_Prov_Id) in_ING_providerids )
   - get_ams_pids_by_lic( STRING20 in_licenseNumber, STRING2 in_state )
   - get_ams_pids_by_npi( STRING20 in_npi )
   - get_ams_pids_by_taxid( AMS._Constants.params aInputData )

 o functions that return a table containing the specified payloads: 
   - get_ams_affiliationPayload_by_pids ( DATASET( ams_id_rec ) ams_pids ) 
   - get_ams_deaNpiPayload_by_pids ( DATASET( ams_id_rec ) ams_pids )
   - get_ams_degreePayload_by_pids ( DATASET( ams_id_rec ) ams_pids )
   - get_ams_mainPayload_by_pids ( DATASET( ams_id_rec ) ams_pids ) 
   - get_ams_specialtyPayload_by_pids ( DATASET( ams_id_rec ) ams_pids ) 
   - get_ams_stateLicense_by_pids ( DATASET( ams_id_rec ) ams_pids )
	 - get_ams_credentialPayload_by_pids ( DATASET( ams_id_rec ) ams_pids )

 o Autokey payload
   - get_autokey_payload ()

 o Batch
   - get_AMS_autokey_data( DATASET( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.pl_rec ) ak_input )
   - get_AMS_prov_ids_from_taxid( DATASET( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.pl_rec ) tx_input )
   - get_AMS_prov_ids_from_licnum( DATASET( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.pl_rec ) lic_input)
   - get_AMS_payload_by_ams_ids( DATASET( prof_licensev2_services.Layout_Search_Ids_Prov ) ams_pids )
*/

EXPORT raw := 
   MODULE


      /* ******************************************
         *
         *            Get AMS Payloads
         * 
         ****************************************** */


      // get ams Affiliation payload by ams provider IDs
      EXPORT get_ams_affiliationPayload_by_pids ( DATASET( AMS.Layouts.ams_id_rec ) ams_pids ) :=
         FUNCTION
            ams_affiliationPayload := 
               JOIN( ams_pids, ams.keys().Affiliation.AMSID.qa, 
                     KEYED( LEFT.ams_id = RIGHT.ams_id),
				             TRANSFORM( RIGHT ),
                     INNER
                   );
         RETURN ams_affiliationPayload;
      END;
      

      // get ams DEA and NPI payload by ams provider IDs
      EXPORT get_ams_deaNpiPayload_by_pids ( DATASET( AMS.Layouts.ams_id_rec ) ams_pids ) :=
         FUNCTION
            ams_deaNpiPayload := 
               JOIN( ams_pids, ams.keys().IDNumber.AMSID.qa, 
                     KEYED( LEFT.ams_id = RIGHT.ams_id),
				             TRANSFORM( RIGHT ),
                     INNER
                   );
         RETURN ams_deaNpiPayload;
      END;


      // get ams Degree payload by ams provider IDs
      EXPORT get_ams_degreePayload_by_pids ( DATASET( AMS.Layouts.ams_id_rec ) ams_pids ) :=
         FUNCTION
            ams_degreePayload := 
               JOIN( ams_pids, ams.keys().Degree.amsid.qa, 
                     KEYED( LEFT.ams_id = RIGHT.ams_id),
				             TRANSFORM( RIGHT ),
                     INNER
                   );
         RETURN ams_degreePayload;
      END;
     
      // get ams payload by ams provider IDs
      EXPORT get_ams_mainPayload_by_pids ( DATASET( AMS.Layouts.ams_id_rec ) ams_pids ) :=
         FUNCTION
            ams_payload := 
               JOIN( ams_pids, ams.keys().main.amsid.qa, 
                     KEYED( LEFT.ams_id = RIGHT.ams_id),
							TRANSFORM( RIGHT ),
                     INNER
                   );
         RETURN ams_payload;
      END;


      // get the main payload from pids filtered also by input data
      EXPORT get_ams_mainPayload_by_pids_filtered( DATASET( AMS.Layouts.ams_id_rec) ams_fdids, AMS.Interfaces.params aInputData  )  := 
        FUNCTION
			
			   doxie.MAC_Header_Field_Declare()
				 UCase := StringLib.StringToUpperCase;
				 // filter autokey results by additional input data		             
				 ams_main := 
               JOIN( ams_fdids,
                     ams.keys().main.amsid.qa,
                     KEYED( LEFT.ams_id = RIGHT.ams_id ),
							       TRANSFORM(RIGHT),
                     INNER, KEEP( AMS._Constants().AMS_JOIN_TAXID_LIMIT )
                   );
        
				
        // Not using NNEQ in the join statement above becasue we are getting false positive hits when the user inputs
				// search criteria and the key file is blank.  For example: Taxid: 341449116 Miamisburg OH 45342.  We have no
				// records with a taxid of 341449116, but have over 1300 records with miamisburg OH and no taxid.
        ams_main_check_taxid := IF( aInputData.TaxID != '', ams_main( rawdemographicsfields.tax_id = UCase( TRIM( aInputData.TaxID, LEFT, RIGHT) )), ams_main);  
				ams_main_check_lname := IF( lname_val        != '', ams_main_check_taxid( clean_name.lname = UCase( TRIM( lname_val, LEFT) ) ), ams_main_check_taxid );
				ams_main_check_city  := IF( city_val         != '', ams_main_check_lname( rawaddressfields.ams_city = UCase( TRIM( city_val, LEFT) ) ), ams_main_check_lname );
				ams_main_check_state := IF( state_val        != '', ams_main_check_city( rawaddressfields.ams_state = UCase( TRIM( state_val, LEFT) ) ), ams_main_check_city );
				ams_main_check_zip   := IF( zip_val          != '', ams_main_check_state( rawaddressfields.ams_zip5[1..3] =  TRIM( zip_val, LEFT)  )[1..3], ams_main_check_state );
				
				// because taxid tends to generate OOM errors we will post filter the records coming back from the 
       // pids join against the main key.  Otherwise we will use the penalization at the end of the service to
       // filter the output
       ams_return_recs := IF( aInputData.TaxID != '', 
                              ams_main_check_zip,
                              ams_main );
       
 			 RETURN ams_return_recs;
     END;   
			
			
      // get ams Specialty payload by ams provider IDs
      EXPORT get_ams_specialtyPayload_by_pids ( DATASET( AMS.Layouts.ams_id_rec ) ams_pids ) :=
         FUNCTION
            ams_specialtyPayload := 
               JOIN( ams_pids, ams.keys().specialty.amsid.qa, 
                     KEYED( LEFT.ams_id = RIGHT.ams_id),
				             TRANSFORM( RIGHT ),
                     INNER
                   );
         RETURN ams_specialtyPayload;
      END;
      

      // get ams State License payload by ams provider IDs
      EXPORT get_ams_stateLicense_by_pids ( DATASET( AMS.Layouts.ams_id_rec ) ams_pids ) :=
         FUNCTION
            ams_LicensePayload := 
               JOIN( ams_pids, ams.keys().StateLicense.amsid.qa, 
                     KEYED( LEFT.ams_id = RIGHT.ams_id),
				             TRANSFORM( RIGHT ),
                     INNER
                  );
         RETURN ams_LicensePayload;
      END;

      // get ams Credentials payload by ams provider IDs
      EXPORT get_ams_credentialPayload_by_pids ( DATASET( AMS.Layouts.ams_id_rec ) ams_pids ) :=
         FUNCTION
            ams_credentialPayload := 
               JOIN( ams_pids, ams.keys().credential.amsid.qa, 
                     KEYED( LEFT.ams_id = RIGHT.ams_id),
				             TRANSFORM( RIGHT ),
                     INNER
                  );
         RETURN ams_credentialPayload;
      END;
			
      
      /* ******************************************
         *
         *         Get AMS Provider IDs
         * 
         ****************************************** */

       // get ams_ids by bdid from header key lookup
       SHARED get_ams_pids_by_bdids( DATASET( AMS.Layouts.layout_references.ams_bdid_rec ) ds_bdids ) := 
         FUNCTION
            ams_ids := 
               TABLE( 
                      JOIN( ds_bdids, 
                            ams.keys().main.bdid.qa, 
                            KEYED(LEFT.bdid = RIGHT.bdid),
                            TRANSFORM(RIGHT),
                            INNER
                          ),
                      {ams_id}
                    );
            RETURN ams_ids;
         END;
                                                
      // get ams_ids by single input bdid
      EXPORT get_ams_pids_by_bdid ( UNSIGNED6 input_bdid ) :=
         FUNCTION
            RETURN get_ams_pids_by_bdids( DATASET([{input_bdid}],AMS.Layouts.layout_references.ams_bdid_rec) );
         END;

      // get ams_ids by dataset of dids from header key lookup (AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do)
      EXPORT get_ams_pids_by_dids( DATASET( AMS.Layouts.layout_references.ams_did_rec ) ds_dids ) := 
         FUNCTION
            ams_ids := 
               TABLE(
                      JOIN( ds_dids, 
                            ams.keys().main.did.qa, 
                            KEYED( LEFT.did = RIGHT.did),
                            TRANSFORM(RIGHT),
                            INNER
                          ),
                      {ams_id}
                    );
                   
            RETURN ams_ids;
         END;
 
      // get ams_ids from user input did (single did)
      EXPORT get_ams_pids_by_did ( UNSIGNED6 input_did ) :=
         FUNCTION
            RETURN get_ams_pids_by_dids( DATASET([{input_did}],AMS.Layouts.layout_references.ams_did_rec) );
         END;
				
      // get ams_ids by autokey fake dids (fdids)
      EXPORT get_ams_pids_by_fdids( DATASET( {unsigned6 ID, boolean isDID, boolean isBDID, boolean IsFake}  ) ams_fdids  )  := 
         FUNCTION
            ams_ids := 
               TABLE(  JOIN( ams_fdids,
                             AMS.Key_Autokey_Payload,
                             KEYED( LEFT.id = RIGHT.fakeid ),
							        TRANSFORM(RIGHT),
                             INNER
                          ),
                      {ams_id} 
						);

				RETURN ams_ids;
         END;   



    // get ams_ids by Ingenix Provider_ID...:
    EXPORT get_ams_pids_by_ING_pid( UNSIGNED6 in_ING_providerid ) := 
         FUNCTION
            provider_recs         := doxie_files.key_provider_id( KEYED( l_providerid = in_ING_providerid ) );
            provider_recs_deduped := DEDUP( SORT( provider_recs( (UNSIGNED)did != 0 ), did, -did_score ), did );
            ams_ids :=
               TABLE(
                      JOIN( provider_recs_deduped,
                            ams.keys().main.did.qa,
                            KEYED((UNSIGNED6)LEFT.did = RIGHT.did),
                            TRANSFORM(RIGHT),
                            INNER
                          ),
                      {ams_id}
                    );
            RETURN ams_ids;
         END;
 
     EXPORT get_ams_pids_by_ING_pids( DATASET(prof_LicenseV2_Services.Layout_Prov_Id) in_ING_providerids ) := 
         FUNCTION
            provider_recs := 
							JOIN(
								in_ING_providerids,
								doxie_files.key_provider_id,
								KEYED( LEFT.ProviderId = RIGHT.l_providerid ),
								TRANSFORM(RIGHT),
								INNER
							);
            provider_recs_deduped := DEDUP( SORT( provider_recs( did != '' ), did, -did_score ), did );
            ams_ids :=
               TABLE(
                      JOIN( provider_recs_deduped,
                            ams.keys().main.did.qa,
                            KEYED((UNSIGNED6)LEFT.did = RIGHT.did),
                            TRANSFORM(RIGHT),
                            INNER
                          ),
                      {ams_id}
                    );
            RETURN ams_ids;
         END;

      //get ams_ids by st + license number or just license number
      EXPORT get_ams_pids_by_lic( STRING20 in_licenseNumber, STRING2 in_state ):= 
         FUNCTION
            ams_ids := 
               TABLE( ams.keys().main.LicenseNumberState.qa( KEYED( st_lic_num  = in_licenseNumber AND 
                                                                    ( in_state = '' OR st_lic_state = in_state ) 
                                                                  ) 
                                                           ),
                      {ams_id} );
           RETURN ams_ids;                 
         END;                     


      //get ams_ids by npi
      EXPORT get_ams_pids_by_npi( STRING20 in_npi ) := 
         FUNCTION
				 
            ams_ids := TABLE( ams.keys().main.npi.qa( KEYED(npi = in_npi) ), {ams_id} );
            RETURN ams_ids;
         END;
     

      //get ams_ids by taxid
      EXPORT get_ams_pids_by_taxid( AMS.Interfaces.params aInputData ) := 
         FUNCTION
			      doxie.MAC_Header_Field_Declare()    
						UCase := StringLib.StringToUpperCase;
				    ams_taxids_all := ams.keys().main.taxid.qa( KEYED(tax_id = aInputData.taxid) );
        
						ams_main_check_dob   := IF( dob_val          !=  0, ams_taxids_all( rawdemographicsfields.dob_date = (STRING)dob_val), ams_taxids_all);
						ams_main_check_fname := IF( fname_val        != '', ams_main_check_dob( clean_name.fname = UCase( TRIM( fname_val, LEFT) ) ), ams_main_check_dob);
						ams_main_check_mname := IF( mname_val        != '', ams_main_check_fname( clean_name.mname = UCase( TRIM( mname_val, LEFT) ) ), ams_main_check_fname );
						ams_main_check_lname := IF( lname_val        != '', ams_main_check_mname( clean_name.lname = UCase( TRIM( lname_val, LEFT) ) ), ams_main_check_mname );
						ams_main_check_addr  := IF( addr_value       != '', ams_main_check_lname( rawaddressfields.ams_street = UCase( TRIM( addr_value, LEFT) ) ), ams_main_check_lname );
						ams_main_check_city  := IF( city_val         != '', ams_main_check_addr( rawaddressfields.ams_city = UCase( TRIM( city_val, LEFT) ) ), ams_main_check_addr );
						ams_main_check_state := IF( state_val        != '', ams_main_check_city( rawaddressfields.ams_state = UCase( TRIM( state_val, LEFT) ) ), ams_main_check_city );
						ams_main_check_zip   := IF( zip_val          != '', ams_main_check_state( rawaddressfields.ams_zip5 =  TRIM( zip_val, LEFT)  ), ams_main_check_state );
						
						ams_ids := TABLE( ams_main_check_zip, {ams_id} );
						// Can't put a limit on the filter, so only returning 100 records so that the system doesn't time out
						// in future joins 
				RETURN CHOOSEN( ams_ids, AMS._Constants().AMS_RETURN_LIMIT );
         END;
                                                      
      EXPORT get_autokey_payload () := 

        FUNCTION

          tempmod_AMS := 
            MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
	            EXPORT STRING autokey_keyname_root := AMS._Constants().ak_qa_keyname;
	            EXPORT STRING typestr              := AMS._Constants().TYPE_STR;
	            EXPORT SET OF STRING1 get_skip_set := AMS._Constants().autokey_buildskipset;
		          EXPORT BOOLEAN useAllLookups       := AMS._Constants().USE_ALL_LOOKUPS;
	          END;

          ams_fdids := AutoKeyI.AutoKeyStandardFetch(tempmod_AMS).ids;

          // ****** Join to the payload key
          ds_byAK := get_ams_pids_by_fdids( ams_fdids );
	
	      RETURN ds_byAK; 

      END;
      
   /* **************************************************************************************
      *
      *                Get AMS data Batch
      * 
      ************************************************************************************** 
      *
      *          Get AMS data in Ingeix layout using AMS Autokeys
      * 
      ************************************************************************************** */
      
		EXPORT get_AMS_batch_autokey_data( DATASET( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.pl_rec ) ak_input ):=
      FUNCTION

		  //**** GET FAKEIDS - FLAPSD SEARCH
			ak_config_data := 
        MODULE(BatchServices.Interfaces.i_AK_Config)
					 EXPORT UseAllLookUps := AMS._Constants().USE_ALL_LOOKUPS;
           EXPORT skip_set      := AMS._Constants().autokey_buildskipset;
			  END;
			
			//**** GET FAKEIDS - FLAPD SEARCH
			ak_key     := AMS._Constants().AUTOKEY_NAME;
			ak_in      := PROJECT( ak_input,Autokey_batch.Layouts.rec_inBatchMaster );
			ak_out_all := Autokey_batch.get_fids(ak_in, ak_key, ak_config_data);
			ak_out     := DEDUP( SORT( ak_out_all, acctno, id ), acctno, id );  // sort and dedup the fake-ids
			outpl_rec  := DATASET([],AMS.Layouts.base.main);
			typ_str    := AMS._Constants().TYPE_STR;

			AutokeyB2.mac_get_payload( ak_out, ak_key, outpl_rec, outpl, did, bdid, typ_str );

			RETURN outpl; 
		END;
 
   /* **************************************************************************************
      *
      *             Get AMS data in Ingeix layout using AMS Tax ID
      * 
      ************************************************************************************** */
		EXPORT get_AMS_prov_ids_from_taxid( DATASET( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.pl_rec ) tx_input ):=
      FUNCTION
			  ds_in_taxid := tx_input( taxid != '' AND name_last != '' );
                 
        ds_in_taxid_deduped := 
          DEDUP( SORT( ds_in_taxid, acctno, taxid ),
			           acctno, taxid);
			  
        // populate the (ingenix) provider id with the AMS id, to use to join against the AMS state license
        // key to pick up those two fields.  
        // Also to combine back in the medlic_bactch_service after the bit flags are set.
        ds_ams_recs_by_taxid := 
          JOIN( ds_in_taxid_deduped, ams.keys().main.taxid.qa,
								KEYED( LEFT.taxid = RIGHT.tax_id ) AND
                LEFT.name_last = RIGHT.clean_name.lname AND
                ut.NNEQ( LEFT.name_first, RIGHT.clean_name.fname),
								TRANSFORM( prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.id_rec,
                           SELF.ProviderId  := (UNSIGNED6)RIGHT.ams_id;
                           SELF.did         := RIGHT.did;
			                     SELF.TaxID       := RIGHT.tax_id;
			                     SELF             := LEFT,
                           SELF             := [];
									       ),
								INNER, LIMIT(AMS._Constants().AMS_JOIN_TAXID_LIMIT, SKIP)
              );		
        
        ds_ams_taxid_recs_plus_lic :=
          JOIN( ds_ams_recs_by_taxid, ams.keys().StateLicense.amsid.qa,
                KEYED( (STRING)LEFT.providerid = RIGHT.ams_id ),
                TRANSFORM( prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.id_rec,
                           SELF.acctno      := TRIM( LEFT.acctno, LEFT, RIGHT ) + '_AMS';
                           SELF.license_number := RIGHT.rawfields.st_lic_num;
			                     SELF.st             := RIGHT.rawfields.st_lic_state;
			                     SELF                := LEFT;
                           SELF                := [];
                        ),
								LEFT OUTER, LIMIT(AMS._Constants().AMS_JOIN_TAXID_LIMIT, SKIP)
              );		
              

			  ds_results_deduped := 
          DEDUP( SORT( ds_ams_taxid_recs_plus_lic, acctno, providerid ),
                 RECORD, ALL );


			  RETURN ds_results_deduped;		
        
      END;
      
   /* **************************************************************************************
      *
      *             Get AMS data in Ingeix layout using AMS license and state
      * 
      ************************************************************************************** */
      EXPORT get_AMS_prov_ids_from_licnum( DATASET( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.pl_rec ) lic_input) := 
        FUNCTION
			    
          ds_in_licnum := lic_input( license_number != '' );

          ds_in_licnum_deduped := 
            DEDUP( SORT( ds_in_licnum, acctno, license_number, st ),
                   acctno, license_number, st
                 );

          // Set the Ingenix providerid to the AMS id, for the subsequent AMS join       
			    ds_ams_recs_by_lic := 
            JOIN( ds_in_licnum_deduped, ams.keys().main.LicenseNumberState.qa,
									KEYED(LEFT.license_number = RIGHT.st_lic_num AND
									      ut.NNEQ( LEFT.st, RIGHT.st_lic_state ) ),
                  TRANSFORM( {prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.id_rec, STRING30 lname, STRING30 fname},
                             SELF.ProviderId  := (UNSIGNED6)RIGHT.ams_id;
                             SELF.did         := RIGHT.did;
			                       SELF.lname       := RIGHT.clean_name.lname;
                             SELF.fname       := RIGHT.clean_name.fname;
                             SELF             := LEFT;
                             SELF             := [];
									         ),
								  INNER, KEEP(AMS._Constants().AMS_JOIN_LIMIT_SMAll)
                );		
           
          ds_ams_lic_recs_plus_taxid := 
            JOIN( ds_ams_recs_by_lic, ams.keys().main.amsid.qa,
									KEYED( (STRING)LEFT.ProviderId = RIGHT.ams_id ) AND
                  LEFT.lname = RIGHT.clean_name.lname AND
                  ut.NNEQ( LEFT.fname, RIGHT.clean_name.fname),
									TRANSFORM( prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.id_rec,
                             SELF.acctno := TRIM( LEFT.acctno, LEFT, RIGHT ) + '_AMS';
                             SELF.did    := IF( LEFT.did = 0, RIGHT.did, LEFT.did );
			                       SELF.TaxID  := RIGHT.rawdemographicsfields.tax_id;  
			                       SELF        := LEFT;
                             SELF        := [];
									         ),
								  LEFT OUTER, LIMIT(AMS._Constants().AMS_JOIN_TAXID_LIMIT, SKIP)
                );		
            
           
			    results_deduped := 
           DEDUP( SORT( ds_ams_lic_recs_plus_taxid, acctno, providerid ), 
                  RECORD, ALL );
      
			RETURN results_deduped;
	 END;


   /* **************************************************************************************
      *
      *           Get AMS payload from AMS IDs
      * 
      ************************************************************************************** */
      
      EXPORT get_AMS_by_ams_ids( DATASET( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.rec_with_bitflag ) ams_pids ) :=
        FUNCTION
          
          doxie.MAC_Header_Field_Declare() 
          ams_payload_by_ams_ids_all := 
            JOIN( ams_pids, ams.keys().main.amsid.qa, 
                  KEYED( (STRING)LEFT.providerid = RIGHT.ams_id),
                  TRANSFORM( AMS.Layouts.ams_provider_batch_service_rec,
                             SELF.Acctno                 := LEFT.Acctno;
                             SELF.providerid             := (STRING)LEFT.providerid;
                             SELF.did                    := RIGHT.did;
                             SELF.title                  := RIGHT.clean_name.title;
                             SELF.fname                  := RIGHT.clean_name.fname;
                             SELF.mname                  := RIGHT.clean_name.mname;
                             SELF.lname                  := RIGHT.clean_name.lname;
                             SELF.name_suffix            := RIGHT.clean_name.name_suffix;
                             SELF.phone                  := RIGHT.clean_phones.phone;
                             SELF.fax                    := RIGHT.clean_phones.fax;
                             SELF.TAX_ID                 := RIGHT.rawdemographicsfields.tax_id;    
                             SELF.dob_date               := RIGHT.rawdemographicsfields.dob_date;
                             SELF.Prov_Clean_prim_range  := RIGHT.clean_company_address.prim_range;
                             SELF.Prov_Clean_predir      := RIGHT.clean_company_address.predir;
                             SELF.Prov_Clean_prim_name   := RIGHT.clean_company_address.prim_name;
                             SELF.Prov_Clean_addr_suffix := RIGHT.clean_company_address.addr_suffix;
                             SELF.Prov_Clean_postdir     := RIGHT.clean_company_address.postdir;
                             SELF.Prov_Clean_unit_desig  := RIGHT.clean_company_address.unit_desig;
                             SELF.Prov_Clean_sec_range   := RIGHT.clean_company_address.sec_range;
                             SELF.Prov_Clean_p_city_name := RIGHT.clean_company_address.p_city_name;
                             SELF.Prov_Clean_v_city_name := RIGHT.clean_company_address.v_city_name;
                             SELF.Prov_Clean_st          := RIGHT.clean_company_address.st;
                             SELF.Prov_Clean_zip         := RIGHT.clean_company_address.zip;
                             SELF.Prov_Clean_zip4        := RIGHT.clean_company_address.zip4;
                             SELF.Bob_rank               := RIGHT.rawaddressfields.bob_rank;
                             SELF                        := RIGHT;
                             SELF                        := [];
                           ),
                  INNER, KEEP(AMS._Constants().AMS_RETURN_LIMIT)  
                );
          ams_payload_by_ams_ids_all_dedup :=
            DEDUP( SORT(  ams_payload_by_ams_ids_all, Acctno, providerid, did, lname, fname, mname, prov_clean_prim_range, prov_clean_prim_name, prov_clean_p_city_name, prov_clean_st, prov_clean_zip, phone, dob_date ),
                    Acctno, providerid, did, lname, fname, mname, prov_clean_prim_range, prov_clean_prim_name, prov_clean_p_city_name, prov_clean_st, prov_clean_zip, phone, dob_date);
 
          RETURN ams_payload_by_ams_ids_all_dedup;
        END;

   END;  // raw module
    


