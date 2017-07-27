IMPORT AutoStandardI, CNLD_Practitioner, CNLD_Practitioner_Services;

/* 
CNLD  - ChoicePoint National Licensure Database -- Data vendor/provider

Available functions:
 o funtions that return a table of ams_ids:
   - get_cnld_practitionerIds_by_fids ( DATASET( {unsigned6 ID, boolean isDID, boolean isBDID, boolean IsFake} )  ds_cnld_fdids )
   - get_cnld_practitionerIds_by_dea ( STRING20 in_deaNum ) 
   - get_cnld_practitionerIds_by_fein ( STRING22 in_federalTaxId )
   - get_cnld_practitionerIds_by_practitionerID ( STRING20 in_practitionerId )
   - get_cnld_practitionerIds_by_npi ( STRING15 in_npiNumber ) 
   - get_cnld_practitionerIds_by_st_LicNum ( STRING5 in_state, STRING25 in_stateLicenseNumber )
   - get_cnld_practitionerIds_by_upin ( STRING in_uniquePhysicianID )
   - get_cnld_practitionerIds_by_zip ( STRING5 in_zip ) 
   - 

 o function that return a dataset containing the (only) cnld payload: 
   - getPractitionerDidsFromGennum ( UNSIGNED6 practitionerDids )
   - get_cnld_payload_by_did( DATASET( did_rec) practitionerDids )
   - get_cnld_payload_by_pids ( DATASET( cnld_practitionerId_rec ) cnld_practitionerIds, BOOLEAN isPharmacistsSearch = FALSE )
   
*/


EXPORT raw := 
  MODULE

  		     
    // --------[ CNLD record for Payload join -- the practitioner ID is the gennum ]---------------
    EXPORT cnld_practitionerId_rec := 
		 RECORD
       STRING20 cnld_practitionerId;
     END;

    // -------[ CNLD Did record ]------------------------------------------------------------------ 
    EXPORT did_rec :=
      RECORD
        UNSIGNED6 did;
      END;

    /* ******************************************
       *
       *    Get CNLD Payload from Provider Ids
       * 
       ****************************************** */

    // get ams payload by ams provider IDs
    // Added in_zip to the function call to further restrict the records in the resulting join
    EXPORT get_cnld_payload_by_pids ( DATASET( cnld_practitionerId_rec ) cnld_practitionerIds, BOOLEAN isPharmacistsSearch = FALSE, STRING in_zip = '' ) :=
      FUNCTION

        cnld_payload_all := 
          JOIN( cnld_practitionerIds, CNLD_Practitioner.key_PractitionerID, 
                KEYED( LEFT.cnld_practitionerId = RIGHT.gennum) AND (RIGHT.zip = in_zip OR in_zip = ''),
				        TRANSFORM( RIGHT ),
                INNER
              );

        cnld_payload_pharmacist := cnld_payload_all(  specialty_code IN CNLD_Practitioner.Constants().CNLD_PharmacistCodes  );
               
                     
        RETURN IF( isPharmacistsSearch,
                    cnld_payload_pharmacist,
                    cnld_payload_all );
      END;


      /* ********************************************
         *
         *    Get CNLD Practitioner IDs (GENNUMs)
         * 
         ******************************************** */
 
      // ----------[ Get PractitionerID by CNLD Autokey Records ]----------------------------------
		
      EXPORT get_cnld_practitionerIds_by_fids ( DATASET( {unsigned6 ID, boolean isDID, boolean isBDID, boolean IsFake} )  ds_cnld_fdids ) :=
        FUNCTION
          fidsCnldResults := JOIN( ds_cnld_fdids,
                                   CNLD_Practitioner.key_AutokeyPayload,
                                   KEYED( LEFT.id = RIGHT.fakeid ),
                                          TRANSFORM ( cnld_practitionerId_rec,
                                                      SELF.cnld_practitionerId := RIGHT.gennum;
                                        )
                                 );  

          RETURN fidsCnldResults;
        END;

      // -----------[ Get PractitionerID by Cnld DEA Key ]-----------------------------------------
      EXPORT get_cnld_practitionerIds_by_dea ( STRING20 in_deaNum ) :=
        FUNCTION
          deaCnldRecs := CNLD_Practitioner.key_DEA( KEYED( deanbr = in_deaNum ) );
      
          // get provider ids 
          cnld_practitionerId_rec xfm_Cnld_ProvIDs_fromDeaKey( CNLD_Practitioner.key_DEA l) := 
		      TRANSFORM	
	          SELF.cnld_practitionerId := l.gennum;
          END;

          deaCnldResults := PROJECT( deaCnldRecs, xfm_Cnld_ProvIDs_fromDeaKey (LEFT) ); 

          RETURN deaCnldResults;
        END;
	    // -----------[  Get PractitionerID by Cnld FEIN (tax id) Key ]---------------------------------------
      EXPORT get_cnld_practitionerIds_by_fein ( STRING22 in_federalTaxId ) :=
        FUNCTION
          fedTaxIdCnldRecs := CNLD_Practitioner.key_FEIN( KEYED( tax_id = in_federalTaxId ) );

          // get provider ids 
          cnld_practitionerId_rec xfm_Cnld_ProvIDs_fromFeinKey( CNLD_Practitioner.key_FEIN l) := 
		        TRANSFORM	
	            SELF.cnld_practitionerId := l.gennum;
            END;

          fedTaxIdCnldResults := PROJECT( fedTaxIdCnldRecs, xfm_Cnld_ProvIDs_fromFeinKey (LEFT) ); 

          RETURN fedTaxIdCnldResults;
        END;
       
	    // -----------[  Get PractitionerID by Cnld Gennum Key (Practitioner ID) ]-------------------
      EXPORT get_cnld_practitionerIds_by_practitionerID ( STRING20 in_practitionerId ) :=
        FUNCTION
          practitionerIdCnldRecs    := CNLD_Practitioner.key_PractitionerID( KEYED( gennum = in_practitionerId ) );

          // get provider ids 
          cnld_practitionerId_rec xfm_Cnld_ProvIDs_fromGennumKey( CNLD_Practitioner.key_PractitionerID l) := 
		        TRANSFORM	
	            SELF.cnld_practitionerId := l.gennum;
            END;

          practitionerIdCnldResults := PROJECT( practitionerIdCnldRecs, xfm_Cnld_ProvIDs_fromGennumKey (LEFT) );
                                          
          RETURN practitionerIdCnldResults;
        END;
          
      // -----------[ Get PractitionerID by Cnld NPI Keys ]----------------------------------------
      EXPORT get_cnld_practitionerIds_by_npi ( STRING15 in_npiNumber ) :=
        FUNCTION
          cnldNpiRecs := CNLD_Practitioner.key_NPI( KEYED( npi = in_npiNumber) );

          cnld_practitionerId_rec xfm_Cnld_ProvIDs_fromNpiKey( CNLD_Practitioner.key_NPI l) := 
		        TRANSFORM	
	            SELF.cnld_practitionerId := l.gennum;
            END;

          npiCnldResults := PROJECT( CnldNpiRecs, xfm_Cnld_ProvIDs_fromNpiKey (LEFT) );  	   
      
          RETURN npiCnldResults;
        END;
          
      // -----------[  Get PractitionerID by Cnld State License Number Key ]-----------------------
      EXPORT get_cnld_practitionerIds_by_st_LicNum ( STRING5 in_state, STRING25 in_stateLicenseNumber ) :=
        FUNCTION
          licNumCnldRecs := CNLD_Practitioner.key_stLicNum( KEYED( st_lic_in = in_state  AND st_lic_num = in_stateLicenseNumber) );

          cnld_practitionerId_rec xfm_Cnld_ProvIDs_fromLicenseKey( CNLD_Practitioner.key_stLicNum l) := 
      		  TRANSFORM	
	            SELF.cnld_practitionerId := l.gennum;
            END;

          licNumCnldResults := PROJECT( LicNumCnldRecs, xfm_Cnld_ProvIDs_fromLicenseKey (LEFT) );  	   
      
          RETURN licNumCnldResults;
        END;
          
      // -----------[  Get PractitionerID by Cnld UPIN Number Key ]--------------------------------
      EXPORT get_cnld_practitionerIds_by_upin ( STRING in_uniquePhysicianID ) :=
        FUNCTION
          upinCnldRecs := CNLD_Practitioner.key_UPIN( KEYED( upin_num = in_uniquePhysicianID ) );

          cnld_practitionerId_rec xfm_Cnld_ProvIDs_fromUpinKey( CNLD_Practitioner.key_UPIN l) := 
		        TRANSFORM	
	            SELF.cnld_practitionerId := l.gennum;
            END;

          upinCnldResults := PROJECT( upinCnldRecs, xfm_Cnld_ProvIDs_fromUpinKey (LEFT) );   	   

          RETURN upinCnldResults;
        END;
          
      // -----------[  Get PractitionerID by Cnld Zipcode Key ]------------------------------------
      EXPORT get_cnld_practitionerIds_by_zip ( STRING5 in_zip ) :=
        FUNCTION
          zipcodeCnldRecs := CNLD_Practitioner.key_ZIP( KEYED( zip = in_zip ) );

          cnld_practitionerId_rec xfm_Cnld_ProvIDs_fromZipKey( CNLD_Practitioner.key_ZIP l) := 
   		      TRANSFORM	
      	      SELF.cnld_practitionerId := l.gennum;
            END;

          zipcodeCnldResults := PROJECT( zipcodeCnldRecs, xfm_Cnld_ProvIDs_fromZipKey (LEFT) );  	   

          RETURN zipCodeCnldResults;
        END;

      // -----------[  Get DIDs from gennum ]------------------------------------------------------
      // When the user enters a gennum (old CNLD term used as the practitioner ID), this function gets the equivalent DIDs
      // so that we can use the associated DIDs to join to other sources (ie: dea, sanctions, etc)
      EXPORT getPractitionerDidsFromGennum( STRING in_practitionerId ) :=
        FUNCTION
          practitionerId_all     := CNLD_Practitioner.key_PractitionerID( KEYED( gennum = in_practitionerId ) );
          practitionerId_payload := practitionerId_all( did != 0 );
          
          // get provider dids from the gennum
          did_rec xfm_get_dids_fromGennum( CNLD_Practitioner.key_PractitionerID l) := 
		         TRANSFORM	
	               SELF.did := l.did;
               END;

          practitionerDids := PROJECT( practitionerId_payload, xfm_get_dids_fromGennum (LEFT) );
                                          
          RETURN practitionerDids;
        END;
        
      /* if the user enters an DID, we can still check cnld data by finding the equivalent practitioner id/gennum;
         then use that/those gennum(s) to get the payload */
      EXPORT get_cnld_payload_by_did( DATASET( did_rec) practitionerDids ) :=
        FUNCTION
          practitionerIds     := 
            JOIN( practitionerDids, 
                  CNLD_Practitioner.key_DID,
                  ( KEYED( LEFT.did = RIGHT.did ) ),
                  TRANSFORM( cnld_practitionerId_rec, 
                             SELF.cnld_practitionerid := RIGHT.gennum 
                           ) 
               );
          practitionerId_payload := get_cnld_payload_by_pids( practitionerIds, FALSE );

          RETURN practitionerId_payload;
        END;
END;