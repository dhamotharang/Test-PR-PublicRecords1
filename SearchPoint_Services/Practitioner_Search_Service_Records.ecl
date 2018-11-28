IMPORT Address, AutoHeaderI, autokey, autokeyb2, AutokeyI, AutoStandardI, CNLD_Practitioner,  
       CNLD_Practitioner_Services, DEA, doxie, doxie_files, HEADER, iesp, Ingenix_natlprof, 
       NCPDP, NPPES, ut, watchdog, std;
       
// The CNLD gennum = PractitionerID = DID in Ingenix and NCPDP

EXPORT Practitioner_Search_Service_Records := 
  MODULE
	  // Defining Interface parameters
    EXPORT Iparams := 
      INTERFACE(  AutoStandardI.InterfaceTranslator.fname_value.params
		             ,AutoStandardI.InterfaceTranslator.lname_value.params
		             ,AutoStandardI.InterfaceTranslator.state_value.params
		             ,AutoStandardI.InterfaceTranslator.zip_value_cleaned.params
		             ,AutoStandardI.InterfaceTranslator.ssn_value.params
		             ,AutoStandardI.InterfaceTranslator.phone_value.params
                 ,AutoStandardI.InterfaceTranslator.application_type_val.params
								 ,AutoStandardI.InterfaceTranslator.dppa_purpose.params
								 ,AutoStandardI.InterfaceTranslator.glb_purpose.params
		           )
	    // Fields passed in from SearchServices via in_mod and used throughout this attribute.
		  EXPORT BOOLEAN  isPharmacistSearch  := FALSE;  // default to false 
      EXPORT STRING20 deaNum              := '';     // default to null 
      EXPORT STRING22 federalTaxId        := '';     // default to null    
      EXPORT STRING20 practitionerId      := '';     // default to null   
      EXPORT STRING25 stateLicenseNumber  := '';     // default to null    
      EXPORT STRING15 npiNumber           := '';     // default to null    
      EXPORT STRING   uniquePhysicianID   := '';     // default to null 
      EXPORT INTEGER  PageNum             :=  1;     // default to first page - outputting the first 3k results
      // EXPORT STRING   fname_value         := '';
	  END;


	EXPORT resultRecs( Iparams in_mod) := 
    FUNCTION

      // ***** Main processing
		
   
// TODO:  Wild card searches for:  first/last name (done with Autokeys) and zip code

     /* *****************************************************************************************
        *
        *                   -----[ Local Functions and Variables ]-----
	      * 
        ***************************************************************************************** */
 		
  	  // 1. Store passed in fields & options.
  		// Store input soap/xml fields into internal shortened attribute names to be used later
  		in_fname   := AutoStandardI.InterfaceTranslator.fname_value.val(in_mod);
  		in_lname   := AutoStandardI.InterfaceTranslator.lname_value.val(in_mod);
      in_phone   := AutoStandardI.InterfaceTranslator.phone_value.val(in_mod);
      in_ssn     := AutoStandardI.InterfaceTranslator.ssn_value.val(in_mod);
      in_state	 := AutoStandardI.InterfaceTranslator.state_value.val(in_mod);
  		in_zip     := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod);
  		in_appType := AutoStandardI.InterfaceTranslator.application_type_val.val(in_mod);
			in_glb 	   := AutoStandardI.InterfaceTranslator.glb_purpose.val(in_mod);
			in_dppa		 := AutoStandardI.InterfaceTranslator.dppa_purpose.val(in_mod); 

      // set all input variables to upper case for searching against the key files.
      STRING20 in_deaNum             := StringLib.StringToUpperCase(in_mod.deaNum);           // can't rename to deaNumber or you'll get a name collision with the key file
      STRING22 in_federalTaxId       := StringLib.StringToUpperCase(in_mod.federalTaxId);
      STRING20 in_practitionerId     := StringLib.StringToUpperCase(in_mod.practitionerId);
      STRING25 in_stateLicenseNumber := StringLib.StringToUpperCase(in_mod.stateLicenseNumber);
      STRING15 in_npiNumber          := StringLib.StringToUpperCase(in_mod.npiNumber);
      STRING   in_uniquePhysicianID  := StringLib.StringToUpperCase(in_mod.uniquePhysicianID);
      INTEGER  in_pageNum            := in_mod.PageNum;
      BOOLEAN  isPharmacistSearch    := in_mod.isPharmacistSearch;
         
      isGennum := SearchPoint_Services.Functions.isGennum( in_practitionerId ); 
           
      // tempmod for dids
  		tempmod2 := 
  		  MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoHeaderI.LIBIN.FetchI_Hdr_Indv.FULL, OPT ) )
  			  EXPORT forceLocal := TRUE;
  		    EXPORT noFail     := FALSE;
  	    END;

   	  // get dids from header search
  		ds_dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do( tempmod2 );       

     /* *****************************************************************************************
        *
        *                           -----[ Data Source: CNLD ]-----
  	    *
        *****************************************************************************************
  	    *   NOTE:  The CNLD gennum = PractitionerID = DID in Ingenix and NCPDP
        *       
        ****************************************************************************************** */
 

      // ----------[ Get PractitionerID by CNLD Autokey Records ]----------------------------------
      //  tempmod for CNLD fdids
      cnld_tempmod := 
	      MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
  	      EXPORT STRING autokey_keyname_root := CNLD_Practitioner.Constants().ak_qa_keyname;
  		    EXPORT STRING typestr              := CNLD_Practitioner.Constants().TYPE_STR;
  		    EXPORT SET OF STRING1 get_skip_set := CNLD_Practitioner.Constants().ak_skipSet;
  		    EXPORT BOOLEAN workHard            := CNLD_Practitioner.Constants().WORK_HARD;
  		    EXPORT BOOLEAN noFail              := CNLD_Practitioner.Constants().NO_FAIL;
  		    EXPORT BOOLEAN useAllLookups       := CNLD_Practitioner.Constants().USE_ALL_LOOKUPS;
  	    END;
		
  		// -----------[ Get CNLD fdids  ]------------------------------------------------------------
  		ds_cnld_fdids := AutoKeyI.AutoKeyStandardFetch(cnld_tempmod).ids;


      // -----------[ Get PractitionerID by Cnld Autokey ]-----------------------------------------
      autokeyCnldResults := CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_fids ( ds_cnld_fdids );  


      // -----------[ Get PractitionerID by Cnld DEA Key ]-----------------------------------------
      deaCnldResults := CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_dea ( in_deaNum ); 

    
  	  // -----------[  Get PractitionerID by Cnld FEIN Key ]---------------------------------------
      fedTaxIdCnldResults := CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_fein ( in_federalTaxId ); 


      // -----------[  Get PractitionerID by Cnld Gennum Key (Practitioner ID) ]-------------------
      practitionerIdCnldResults := IF( isGennum, 
                                       CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_practitionerID ( in_practitionerId ),
                                       DATASET( [], CNLD_Practitioner_Services.raw.cnld_practitionerId_rec )                                       
                                     );

      // -----------[ Get PractitionerID by Cnld NPI Keys ]----------------------------------------
      npiCnldResults := CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_npi ( in_npiNumber );  	   
        

      // -----------[  Get PractitionerID by Cnld State License Number Key ]-----------------------
      stlicNumCnldResults := CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_st_LicNum ( in_state, in_stateLicenseNumber );  	   
        

      // -----------[  Get PractitionerID by Cnld UPIN Number Key ]--------------------------------
      uniquePhysicianIdCnldResults := CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_upin ( in_uniquePhysicianID );   	   

      // -----------[  Get PractitionerID by Cnld Zipcode Key ]------------------------------------
      zipcodeCnldResults := CNLD_Practitioner_Services.raw.get_cnld_practitionerIds_by_zip ( in_zip );  	   
        
      // get CNLD Practitioner IDs based on the input 
      cnldPids := MAP( in_deaNum             != '' => deaCnldResults,                // DEA CNLD key
                       in_federalTaxID       != '' => fedTaxIdCnldResults,           // FEIN CNLD key
                       in_npiNumber          != '' => npiCnldResults,                // NPI CNLD key
                       in_practitionerID     != '' => PractitionerIdCnldResults,     // gennum if first char is not numeric 
                       in_stateLicenseNumber != '' => stLicNumCnldResults,           // CNLD State license key
                       in_uniquePhysicianID  != '' => uniquePhysicianIdCnldResults,  // CNLD -- no UPIN in data
                       in_zip                != '' => zipcodeCnldResults,            // Zip CNLD key
                       /* default */                  autokeyCnldResults
                     );
        
      // dedup Practitioner IDs to reduce time in future joins
      cnld_practitionerIds := DEDUP( SORT( cnldPids, cnld_practitionerId, RECORD ), cnld_practitionerId );
        
      // Get CNLD payload by Practitioner IDs send in the boolean isPharmacistsSearch to filter if needed
      cnld_payload := CNLD_Practitioner_Services.raw.get_cnld_payload_by_pids ( cnld_practitionerIds, isPharmacistSearch, in_zip );

      // Transform and keep only data needed for this service (plus penalization fields)
      cnldResults := 
        PROJECT( cnld_payload,
                 TRANSFORM( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization,
                            SELF.firstName      := LEFT.fname;
                            SELF.middleName     := LEFT.mname;
                            SELF.lastName       := LEFT.lname;
                            SELF.suffix         := LEFT.name_suffix;
                            SELF.gender         := SearchPoint_Services.Functions.convertTitle( LEFT.title ); 
                            SELF.address        := Address.Addr1FromComponents( LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, '', '' );
                            SELF.address2       := Address.Addr1FromComponents( '', '', '', '', '', LEFT.unit_desig,LEFT.sec_range);
                            SELF.city           := LEFT.p_city_name;
                            SELF.state          := LEFT.st;
                            SELF.zip            := LEFT.zip;
                            SELF.extZip         := LEFT.zip4; 
                            SELF.phoneNumber    := LEFT.address_phone;
                            SELF.practitionerID := LEFT.gennum;                                                   
                            SELF.birthdate      := LEFT.dob;
                            SELF.ssn            := LEFT.ssn;
                            SELF.dt_last_seen   := (STRING8)LEFT.date_lastseen;
                            SELF.AddrRank       := IF((INTEGER) LEFT.address_rank = 0, 1000, (INTEGER) LEFT.address_rank);
                            SELF.source         := SearchPoint_Services.Constants.cnldSourceRank;  // cnld (file no longer updated) (3)
                            SELF                := LEFT;
                            SELF                := [];
                         )
               );	

     /* *****************************************************************************************
        *
        *                         -----[ Data Source: Ingenix ]-----
        * 
        ***************************************************************************************** */
      // -----------[ Ingenix record for Payload join ]--------------------------------------------
      Ingenix_provider_id_rec := 
        RECORD
          UNSIGNED6 Ingenix_provider_id;
        END;

      /* Creating a record where the payload data is a child data set so that we can filter and dedup without 
         getting an out of memory or memory pool exhausted error trying to pull in all the records.  Processing 
         the provider IDs individually allows us to trim 844k records down to something the system can handle. */
      Ingenix_with_child_DataSet :=
        RECORD
          UNSIGNED6 Ingenix_provider_id;
          DATASET (SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization) Ingenix_payload_child_dataSet;
        END;
   
      // -----------[ INGENIX Autokey Records ]-----------------------------------------------------
      // tempmod for INGENIX fdids
      ing_tempmod := 
        MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
          EXPORT STRING autokey_keyname_root := SearchPoint_Services.Constants.IngenixAutoKey.AUTOKEY_NAME;
          EXPORT STRING typestr              := SearchPoint_Services.Constants.IngenixAutoKey.TYPE_STR;
          EXPORT SET OF STRING1 get_skip_set := SearchPoint_Services.Constants.IngenixAutoKey.AUTOKEY_SKIP_SET;
          EXPORT BOOLEAN workHard            := SearchPoint_Services.Constants.IngenixAutoKey.WORK_HARD;
          EXPORT BOOLEAN noFail              := SearchPoint_Services.Constants.IngenixAutoKey.NO_FAIL;
          EXPORT BOOLEAN useAllLookups       := SearchPoint_Services.Constants.IngenixAutoKey.USE_ALL_LOOKUPS;
        END;
      
      // ING fdids
      ds_ing_fdids := CHOOSEN( AutoKeyI.AutoKeyStandardFetch(ing_tempmod).ids, 1000);
        
      AutokeyIngenixResults := JOIN( ds_ing_fdids,
                                     Ingenix_NatlProf.Key_Provider_Payload,
                                     KEYED( LEFT.id = RIGHT.fakeid ),
                                     TRANSFORM ( Ingenix_provider_id_rec,
                                                 SELF.Ingenix_provider_id := (UNSIGNED6) RIGHT.ProviderID;
                                               )
                                   );
        

      // -----------[ Ingenix DEA Key ]---------------------------------------------------------------
      deaIngenixRecs := Ingenix_NatlProf.key_DEA_DEANumber( KEYED( l_deanumber = in_deaNum ) );
        
      // get provider ids 
      Ingenix_provider_id_rec xfm_Ingenix_ProvIDs_fromDeaKey( Ingenix_NatlProf.key_DEA_DEANumber l) := 
        TRANSFORM	
          SELF.Ingenix_provider_id := (UNSIGNED) l.ProviderID;
        END;

      deaIngenixResults := PROJECT( deaIngenixRecs, xfm_Ingenix_ProvIDs_fromDeaKey (LEFT) ); 
      

      // -----------[  Ingenix DID Key (Practitioner ID) ]--------------------------------------------
      didIngenixRecs    := doxie_files.key_provider_did( KEYED( l_did = (UNSIGNED6) in_practitionerId ) );

      // get provider ids 
      Ingenix_provider_id_rec xfm_Ingenix_ProvIDs_fromDidKey( doxie_files.key_provider_did l) := 
        TRANSFORM	
          SELF.Ingenix_provider_id := l.ProviderID;
        END;

      PractitionerIdIngenixResults := IF( isGennum, 
                                          DATASET( [], Ingenix_provider_id_rec ),
                                          PROJECT( didIngenixRecs, xfm_Ingenix_ProvIDs_fromDidKey (LEFT) )
                                        );


      // -----------[  Ingenix FEIN Key ]-------------------------------------------------------------
      feinIngenixRecs    := doxie_files.key_provider_taxid( KEYED( l_taxid = in_federalTaxId ) );

      // get provider ids 
      Ingenix_provider_id_rec xfm_Ingenix_ProvIDs_fromFeinKey( doxie_files.key_provider_taxid l) := 
        TRANSFORM	
          SELF.Ingenix_provider_id := (UNSIGNED6) l.ProviderID;
        END;

      fedTaxIdIngenixResults := PROJECT( feinIngenixRecs, xfm_Ingenix_ProvIDs_fromFeinKey (LEFT) ); 


      // -----------[ Ingenix NPI Keys ]-----------------------------------------------------------
      IngenixNpiRecs := Ingenix_NatlProf.key_providerID_NPI( KEYED( l_npi = in_npiNumber) );

      Ingenix_provider_id_rec xfm_Ingenix_ProvIDs_fromNpiKey( Ingenix_NatlProf.key_providerID_NPI l) := 
        TRANSFORM	
          SELF.Ingenix_provider_id := (UNSIGNED6)l.ProviderID;
        END;

      npiIngenixResults := PROJECT( IngenixNpiRecs, xfm_Ingenix_ProvIDs_fromNpiKey (LEFT) );  	   
        

      // -----------[  Ingenix --SSN to get dids from Header (no ssn data in Ingenix payload) ]-----

      // join dids from header search to get provider id
      ssnIngenixResults  := 
        JOIN( ds_dids, doxie_files.key_provider_did, 
              KEYED( LEFT.did = RIGHT.l_did),
              TRANSFORM( Ingenix_provider_id_rec,
                         SELF.Ingenix_provider_id := RIGHT.providerid;;
                       )
            );


      // -----------[  Ingenix State License Number Key ]--------------------------------------------
      LicNumIngenixRecs := doxie_files.key_provider_license( KEYED( licensestate = in_state AND licensenumber = in_stateLicenseNumber ) );

      Ingenix_provider_id_rec xfm_Ingenix_ProvIDs_fromLicenseKey( doxie_files.key_provider_license l) := 
        TRANSFORM	
          SELF.Ingenix_provider_id := l.ProviderID;
        END;

      stlicNumIngenixResults := PROJECT( LicNumIngenixRecs, xfm_Ingenix_ProvIDs_fromLicenseKey (LEFT) );  	   
        

      // -----------[  Ingenix UPIN Number Key ]------------------------------------------------------
      upinIngenixRecs := Ingenix_NatlProf.key_ProviderID_UPIN( KEYED( l_upin = in_UniquePhysicianId ) );

      Ingenix_provider_id_rec xfm_Ingenix_ProvIDs_fromUpinKey( Ingenix_NatlProf.key_ProviderID_UPIN l) := 
        TRANSFORM	
          SELF.Ingenix_provider_id := (UNSIGNED6) l.ProviderID;
        END;

      uniquePhysicianIdIngenixResults := PROJECT( upinIngenixRecs, xfm_Ingenix_ProvIDs_fromUpinKey (LEFT) );  	   

      // -----------[  Ingenix Zip by Autokey ]------------------------------------------------------
  // TODO -- wild card zip search -- 
  // TODO -- Which zip results to keep -- now just keeping the first 500 returned

      autokey_zip_Ingenix     := autokey.key_zip(SearchPoint_Services.Constants.IngenixAutoKey.AUTOKEY_NAME);
      zip_autokey_IngenixRecs :=  autokey_zip_Ingenix( KEYED(zip = (INTEGER)in_zip) AND did != 0 );

      zipcodeIngenixResults := JOIN( zip_autokey_IngenixRecs,
                                     Ingenix_NatlProf.Key_Provider_Payload,
                                     KEYED( LEFT.did = RIGHT.fakeid ),
                                     TRANSFORM ( Ingenix_provider_id_rec,
                                                 SELF.Ingenix_provider_id := (UNSIGNED6) RIGHT.ProviderID;
                                               )
                                   );

      // get provider ids for user input entered
      IngenixRecs_all := MAP( in_deaNum             != '' => deaIngenixResults,                // DEA Ingenix key
                              in_federalTaxID       != '' => fedTaxIdIngenixResults,           // FEIN Ingenix key
                              in_npiNumber          != '' => npiIngenixResults,                // NPI Ingenix key
                              in_practitionerID     != '' => PractitionerIdIngenixResults,     // did if first char is not alpha- Ingenix DID 
                              in_ssn                != '' => ssnIngenixResults,                // use ssn to do header lookup
                              in_stateLicenseNumber != '' => stLicNumIngenixResults,           // Ingenix upin key
                              in_uniquePhysicianID  != '' => uniquePhysicianIdIngenixResults,  // Ingenix -- need key
                              in_zip                != '' => zipcodeIngenixResults,            // Zip Ingenix key
                              /* default */                  autokeyIngenixResults
                            );
        
      IngenixRecsBase := DEDUP( SORT( IngenixRecs_all, Ingenix_provider_id, RECORD ), Ingenix_provider_id );
       
      // if pharmacist search, filter base set by speciality name
      IngenixRecsPharmacist := 
        JOIN( IngenixRecsBase,
              Ingenix_NatlProf.key_speciality_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ) AND
              ( stringlib.StringToUpperCase(RIGHT.specialityname) = 'PHARMACOLOGY - CLINICAL' OR 
                stringlib.StringToUpperCase(RIGHT.specialityname) = 'PHARMACY' ),
              TRANSFORM( Ingenix_provider_id_rec,
                         SELF := LEFT;
                       )
            );
        
      // check to see if it's a pharmachist search
      IngenixRecs_temp := IF( isPharmacistSearch,
                              IngenixRecsPharmacist,
                              IngenixRecsBase
                            );
        
      IngenixRecsGroup      := GROUP( IngenixRecs_temp, Ingenix_provider_id );
        
      // get all ingenix data needed for this service (including penalization fields) dedup file
      get_provider_data( UNSIGNED Ingenix_provider_id ) :=
        FUNCTION
          ds_providerIDs := doxie_files.key_provider_id( KEYED( l_providerid = (UNSIGNED) Ingenix_provider_id ) AND 
                                                         ( in_zip = '' OR zip = in_zip ) AND 
                                                         (UNSIGNED) did != 0 );
          
          providerID_slimmed := 
            PROJECT( ds_providerIDs,
                     TRANSFORM( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization, 
                                SELF.firstName      := TRIM( LEFT.firstName, LEFT, RIGHT );
                                SELF.middleName     := TRIM( LEFT.middleName, LEFT, RIGHT );
                                SELF.lastName       := TRIM( LEFT.lastName, LEFT, RIGHT );
                                SELF.suffix         := TRIM( LEFT.suffix, LEFT, RIGHT );
                                SELF.gender         := SearchPoint_Services.Functions.convertGender( LEFT.gender );
                                SELF.address        := TRIM( LEFT.address, LEFT, RIGHT );
                                SELF.address2       := IF( REGEXFIND( '[^\\x00]', LEFT.address2 ) = TRUE,
                                                           LEFT.address2,
                                                           ''
                                                         );
                                SELF.city           := TRIM( LEFT.city, LEFT, RIGHT );
                                SELF.state          := TRIM( LEFT.state, LEFT, RIGHT );
                                SELF.zip            := TRIM( LEFT.zip, LEFT, RIGHT );
                                SELF.extZip         := TRIM( LEFT.extZip, LEFT, RIGHT ); 
                                SELF.phoneNumber    := TRIM( LEFT.phoneNumber, LEFT, RIGHT );
                                SELF.practitionerID := SearchPoint_Services.Functions.getDid( LEFT.did );    
                                SELF.birthdate      := TRIM( LEFT.birthdate, LEFT, RIGHT );
                                SELF.dt_last_seen   := TRIM( LEFT.dt_last_seen, LEFT, RIGHT );
                                SELF.AddrRank       := IF( (INTEGER)LEFT.provideraddresstiertypeid = 0, 1000, (INTEGER)LEFT.provideraddresstiertypeid);
                                SELF.source         := SearchPoint_Services.Constants.ingenixSourceRank; // Ingenix (1)
                                SELF                := LEFT;
                                SELF                := [];
                              )
                   );
                    
          Results_sorted := 
            DEDUP( SORT( providerID_slimmed, 
                         lastName, firstName, -dt_last_seen, RECORD ),
                   RECORD, EXCEPT extZip, dt_last_seen
                 ); 
                
          RETURN Results_sorted;
        END;
   
      /* Getting the payload data as a child data set so that we can filter and dedup without getting an 
         out of memory or memory pool exhausted error trying to pull in all the records.  Processing the
         provider IDs individually allows us to trim 844k records down to something the system can handle. */
      IngenixChildPayload := PROJECT( IngenixRecs_temp,
                                      TRANSFORM( Ingenix_with_child_DataSet,
                                                 SELF.Ingenix_provider_id := LEFT.Ingenix_provider_id;
                                                 SELF.Ingenix_payload_child_dataSet := get_provider_data( LEFT.Ingenix_provider_id );
                                               )
                                    );
   
      // limit hit with FedTaxID: #STORED( 'federalTaxId', '742161737' );  -- 3354 provider IDs associated with this TaxID
      SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization xfm_Ingenix_to_Payload ( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization R ):= 
        TRANSFORM
          SELF := R;
        END;

      // normalize the child dataset back to the layout needed to join the result sets.
      IngenixResults := NORMALIZE( IngenixChildPayload, 
                                   LEFT.Ingenix_payload_child_dataSet,
                                   xfm_Ingenix_to_Payload( RIGHT ) 
                                 );
                                

     /* *****************************************************************************************
        *
        *                           -----[ Data Source: NCPDP ]-----
        * 
        ***************************************************************************************** */
      
      // -----------[ NCPDP record for Payload join ]--------------------------------------------------
      NCPDP_provider_id_rec := 
        RECORD
          STRING10 NCPDP_provider_id;
        END;


      // -----------[ NCPDP Autokey Records ]-------------------------------------------------------
  // TODO -- wild card name search 
      // tempmod for NCPDP fdids
      ncpdp_tempmod_Phys := 
        MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
          EXPORT STRING autokey_keyname_root := SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalPhys_AutoKey;
          EXPORT STRING typestr              := SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalPhys_TYPE_STR;
          EXPORT SET OF STRING1 get_skip_set := SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalPhys_AUTOKEY_SKIP_SET;
          EXPORT BOOLEAN workHard            := SearchPoint_Services.Constants.NCPDP_AutoKey.WORK_HARD;
          EXPORT BOOLEAN noFail              := SearchPoint_Services.Constants.NCPDP_AutoKey.NO_FAIL;
          EXPORT BOOLEAN useAllLookups       := SearchPoint_Services.Constants.NCPDP_AutoKey.USE_ALL_LOOKUPS;
        END;
      
      ncpdp_tempmod_Mail := 
        MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
          EXPORT STRING autokey_keyname_root := SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalMail_AutoKey;
          EXPORT STRING typestr              := SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalMail_TYPE_STR;
          EXPORT SET OF STRING1 get_skip_set := SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalMail_AUTOKEY_SKIP_SET;
          EXPORT BOOLEAN workHard            := SearchPoint_Services.Constants.NCPDP_AutoKey.WORK_HARD;
          EXPORT BOOLEAN noFail              := SearchPoint_Services.Constants.NCPDP_AutoKey.NO_FAIL;
          EXPORT BOOLEAN useAllLookups       := SearchPoint_Services.Constants.NCPDP_AutoKey.USE_ALL_LOOKUPS;
        END;

      // NCPDP fdids   // when a fein key search or zip code autokey search is done, the fids can exponentially increase the 
      // physical addr // number of pids returned.  Limiting the number of records returned at the first level 
      // key           // reduces (hopefully eliminates) the possibility of a "memory limit exceeded" error.
      ds_ncpdp_fdids_Phys := CHOOSEN( AutoKeyI.AutoKeyStandardFetch(ncpdp_tempmod_Phys).ids, SearchPoint_Services.Constants.RecordLimit);

      autokeyNcpdpResults_Phys := 
        JOIN( ds_ncpdp_fdids_Phys,
              NCPDP.key_AutokeyPayload_ContLegalPhys,
              KEYED( LEFT.id = RIGHT.fakeid ),
              TRANSFORM( NCPDP_provider_id_rec,
                         SELF.NCPDP_provider_id := RIGHT.NCPDP_provider_id;
                       )
              , LEFT OUTER
            );

      // NCPDP fdids   // when a fein key search or zip code autokey search is done, the fids can exponentially increase the 
      // mailing addr  // number of pids returned.  Limiting the number of records returned at the first level 
      // key           // reduces (hopefully eliminates) the possibility of a "memory limit exceeded" error.
      ds_ncpdp_fdids_Mail := CHOOSEN( AutoKeyI.AutoKeyStandardFetch(ncpdp_tempmod_Mail).ids, SearchPoint_Services.Constants.RecordLimit);

      autokeyNcpdpResults_Mail := 
        JOIN( ds_ncpdp_fdids_Mail,
              NCPDP.key_AutokeyPayload_ContLegalMail,
              KEYED( LEFT.id = RIGHT.fakeid ),
              TRANSFORM( NCPDP_provider_id_rec,
                         SELF.NCPDP_provider_id := RIGHT.NCPDP_provider_id;
                       )
              , LEFT OUTER
            );                  

      autokeyNcpdpResults := DEDUP( SORT( autokeyNcpdpResults_Phys + autokeyNcpdpResults_Mail, NCPDP_provider_id, RECORD ), NCPDP_provider_id );

      // -----------[ NCPDP DEA Key ]---------------------------------------------------------------
      deaNcpdpRecs        := NCPDP.key_DEA( KEYED( DEA_registration_id = in_deaNum ) );
        
      // get provider ids 
      NCPDP_provider_id_rec xfm_NCPDP_ProvIDs_fromDeaKey( NCPDP.key_DEA l) := 
        TRANSFORM	
          SELF.NCPDP_provider_id := l.ncpdp_provider_id;
        END;

      deaNcpdpResults := PROJECT( deaNcpdpRecs, xfm_NCPDP_ProvIDs_fromDeaKey (LEFT) ); 


      // -----------[  NCPDP DID Key (Practitioner ID) ]--------------------------------------------
      didNcpdpRecs    := NCPDP.key_DID( KEYED( did = (UNSIGNED6) in_practitionerId ) );

      // get provider ids 
      NCPDP_provider_id_rec xfm_NCPDP_ProvIDs_fromDidKey( NCPDP.key_Did l) := 
        TRANSFORM	
          SELF.NCPDP_provider_id := l.ncpdp_provider_id;
        END;


      PractitionerIdNcpdpResults := IF( isGennum, 
                                        DATASET( [], NCPDP_provider_id_rec ),
                                        PROJECT( didNcpdpRecs, xfm_NCPDP_ProvIDs_fromDidKey (LEFT) )
                                      );

      // -----------[  NCPDP FEIN Key ]-------------------------------------------------------------
      feinNcpdpRecs    := NCPDP.key_FEIN( KEYED( federal_tax_id = in_federalTaxId ) );

      // get provider ids 
      NCPDP_provider_id_rec xfm_NCPDP_ProvIDs_fromFeinKey( NCPDP.key_FEIN l) := 
        TRANSFORM	
          SELF.NCPDP_provider_id := l.ncpdp_provider_id;
        END;

        fedTaxIdNcpdpResults := PROJECT( feinNcpdpRecs, xfm_NCPDP_ProvIDs_fromFeinKey (LEFT) ); 
       

      // -----------[  NCPDP NPI Key ]--------------------------------------------------------------
      npiNcpdpRecs := NCPDP.key_NPI( KEYED( national_provider_id = in_npiNumber ) );

      NCPDP_provider_id_rec xfm_NCPDP_ProvIDs_fromNpiKey( NCPDP.key_NPI l) := 
        TRANSFORM	
          SELF.NCPDP_provider_id := l.ncpdp_provider_id;
        END;

      npiNumberNcpdpResults := PROJECT( npiNcpdpRecs, xfm_NCPDP_ProvIDs_fromNpiKey (LEFT) );  	  
        
        
      // -----------[  NCPDP: use SSN to get dids from Header (no ssn data in NCPDP payload) ]-----

      // join dids from header search to get provider id
      ssnNCPDPResults  := 
        JOIN( ds_dids, NCPDP.key_DID, 
              KEYED( LEFT.did = RIGHT.did),
              TRANSFORM( NCPDP_provider_id_rec,
                         SELF.NCPDP_provider_id := RIGHT.ncpdp_provider_id;
                       )
            );


      // -----------[  NCPDP State License Number Key ]--------------------------------------------
      LicNumNcpdpRecs := NCPDP.key_SLN_State( KEYED( state_license_number = in_stateLicenseNumber  AND phys_state = in_state) );

      NCPDP_provider_id_rec xfm_NCPDP_ProvIDs_fromLicenseKey( NCPDP.key_SLN_State l) := 
        TRANSFORM	
          SELF.NCPDP_provider_id := l.ncpdp_provider_id;
        END;

      stlicNumNcpdpResults := PROJECT( LicNumNcpdpRecs, xfm_NCPDP_ProvIDs_fromLicenseKey (LEFT) );  	
        
        
      // -----------[  NCPDP UPIN Number Key ]------------------------------------------------------
      // There are no UPINs in the NCPDP code at the time of development of this search (3/2012)
      upinNcpdpResults := DATASET( [], NCPDP_provider_id_rec );

        // -----------[  NCPDP Zip Key ]------------------------------------------------------
  // TODO -- wild card zip search -- Straight zip search works with autokey filter
  // TODO -- Which zip results to keep -- now just keeping the first 500 returned
      autokey_zipPhys := autokeyb2.key_zip( SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalPhys_AutoKey );
      zip_autokey_NcpdpRecsPhys := autokey_zipPhys( KEYED(zip = (INTEGER)in_zip) );

      zipcodeNcpdpResultsPhys := JOIN( zip_autokey_NcpdpRecsPhys,
                                       NCPDP.key_AutokeyPayload_ContLegalPhys,
                                       KEYED( LEFT.bdid = RIGHT.fakeid) AND RIGHT.did != 0,
                                       TRANSFORM( NCPDP_provider_id_rec,
                                                  SELF.NCPDP_provider_id := RIGHT.NCPDP_provider_id;
                                                )
                                       , LEFT OUTER
                                    );

      autokey_zipMail := autokeyb2.key_zip( SearchPoint_Services.Constants.NCPDP_AutoKey.ContLegalMail_AutoKey );
      zip_autokey_NcpdpRecsMail := autokey_zipMail( KEYED(zip = (INTEGER)in_zip) );
      zipcodeNcpdpResultsMail   := JOIN( zip_autokey_NcpdpRecsMail,
                                         NCPDP.key_AutokeyPayload_ContLegalMail,
                                         KEYED( LEFT.bdid = RIGHT.fakeid)AND RIGHT.did != 0,
                                         TRANSFORM( NCPDP_provider_id_rec,
                                                    SELF.NCPDP_provider_id := RIGHT.NCPDP_provider_id;
                                                  )
                                         , LEFT OUTER
                                      );

      zipcodeNcpdpResults       := zipcodeNcpdpResultsPhys + zipcodeNcpdpResultsMail;

      // get provider ids for user input entered
      NcpdpRecs_all := MAP( in_deaNum             != '' => deaNcpdpResults,               // DEA NCPDP key
                            in_federalTaxID       != '' => fedTaxIdNcpdpResults,          // FEIN NCPDP key
                            in_npiNumber          != '' => npiNumberNcpdpResults,         // NPI NCPDP key
                            in_practitionerID     != '' => PractitionerIdNcpdpResults,    // did/CNLD to NCPDP DID to NCPDP provider id
                            in_ssn                != '' => ssnNCPDPResults,
                            in_stateLicenseNumber != '' => stLicNumNcpdpResults,          // NCPDP -- need key
                            in_uniquePhysicianID  != '' => upinNcpdpResults,              // NCPDP -- need key
                            in_zip                != '' => zipcodeNcpdpResults,           // Zip NCPDP key -- done with autokeys
                            /* default */                  autokeyNcpdpResults            // Autokeys: 
                                                                                          //           first & last name and state
                          );                                                              //           phone number 
      
      NcpdpRecsBase := DEDUP( SORT( NcpdpRecs_all, NCPDP_provider_id, RECORD ), NCPDP_provider_id );
        
      // If pharmacist search, join to get contact title
      NcpdpRecsPharmacyTemp := 
        JOIN( NcpdpRecsBase,
              NCPDP.key_ProviderID,
              KEYED( LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id ), 
              TRANSFORM( {NCPDP_provider_id_rec, STRING contact_title}, 
                          SELF := RIGHT;
                       )
            );

      // If pharmacist search, filter out records by keeping only those in contact title list (which contains only Pharmacist titles)
      NcpdpRecsPharmacy := 
        JOIN( NcpdpRecsPharmacyTemp,
              SORTED( SearchPoint_Services.PharmacistContactTitles_NCPDP, contact_title ),
              LEFT.contact_title = RIGHT.contact_title,
              TRANSFORM( NCPDP_provider_id_rec,
                         SELF := LEFT;
                       )
            );
        
      // filter dataset if this is a pharmacist search
      NcpdpRecs := IF( isPharmacistSearch,
                       NcpdpRecsPharmacy,
                       NcpdpRecsBase
                     );
        
      // get NCPDP payload
      NcpdpRecsPayload := 
        JOIN( NcpdpRecs,
              NCPDP.key_ProviderID,
              KEYED( LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id ) AND
              RIGHT.did != 0,
              TRANSFORM( NCPDP.Layouts.keybuild,
                         SELF := RIGHT;
                       )
            );
           
      // use watchdog to get birthday and gender (using title) from watchdog key
      // keep only data needed for this service (plus penalization fields)
      		
			glb_ok := ut.permissionTools.glb.ok(in_glb);
			dppa_ok := ut.permissionTools.dppa.ok(in_dppa);	
			
			doxie.mac_best_records(NcpdpRecsPayload,
														 did,
														 outfile,
														 dppa_ok,
														 glb_ok, 
														 ,
														 doxie.DataRestriction.fixed_DRM);

			SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization xform_best(NcpdpRecsPayload L, outfile R) := TRANSFORM
				SELF.firstName      := TRIM( L.fname, LEFT, RIGHT );
        SELF.middleName     := TRIM( L.mname, LEFT, RIGHT );
        SELF.lastName       := TRIM( L.lname, LEFT, RIGHT );
        SELF.suffix         := TRIM( L.suffix, LEFT, RIGHT);
        SELF.gender         := SearchPoint_Services.Functions.convertTitle( R.title );
        SELF.address        := TRIM( L.phys_loc_address1, LEFT, RIGHT );
        SELF.address2       := TRIM( L.phys_loc_address2, LEFT, RIGHT );
        SELF.city           := TRIM( L.phys_p_city_name, LEFT, RIGHT );
        SELF.state          := TRIM( L.phys_state, LEFT, RIGHT );
        SELF.zip            := TRIM( L.phys_zip5, LEFT, RIGHT );
        SELF.extZip         := TRIM( L.phys_zip4, LEFT, RIGHT ); 
        SELF.phoneNumber    := (STRING)L.phys_loc_phone;
        SELF.practitionerID := SearchPoint_Services.Functions.getDid( (STRING)R.did );                                                   
        SELF.birthdate      := (STRING)R.dob;
        SELF.ssn            := R.ssn;
        SELF.dt_last_seen   := (STRING)L.dt_last_seen;
        SELF.source         := SearchPoint_Services.Constants.ncpdpSourceRank;  // ncpdp  (2)
        SELF.addrRank       := SearchPoint_Services.Constants.ncpdpDefaultAddrRank; // place holder because ncpdp does not have a ranking system for the address
        SELF                := L;
        SELF                := [];
			END;

			NcpdpResults := JOIN(NcpdpRecsPayload, outfile,
													(INTEGER)LEFT.did = RIGHT.did,
												xform_best(LEFT, RIGHT), LEFT OUTER);

  // TODO: rollup -- Rules???
      // dedup before concatination so mitigate exceeding the memory limit 
      // also, not using date last seen because at the time the service was created, because the date last seen fields were populated with the same date (per data vendor)
      AllRecs_temp := DEDUP( IngenixResults, practitionerID, lastName, firstName, middleName, suffix, Address, Address2, city, state, zip, phoneNumber, birthdate, ALL ) + 
                      DEDUP( NcpdpResults,   practitionerID, lastName, firstName, middleName, suffix, Address, Address2, city, state, zip, phoneNumber, birthdate, ALL )  + 
                      DEDUP( CnldResults,    practitionerID, lastName, firstName, middleName, suffix, Address, Address2, city, state, zip, phoneNumber, birthdate, ALL );
        
      // dedup 
      AllRecs      := DEDUP( AllRecs_temp, practitionerID, lastName, firstName, middleName, suffix, Address, Address2, city, state, zip, phoneNumber, birthdate, ALL ); 
       
      AllRecs_Penalized := 
        PROJECT( AllRecs,
                 TRANSFORM( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization, 
                            SELF.addrPenalt  := SearchPoint_Services.Functions.get_addrPenalty( in_state, in_zip, LEFT.state, LEFT.zip ),
                            SELF.namePenalt  := SearchPoint_Services.Functions.get_namePenalty( in_fname, in_lname, LEFT.firstName, LEFT.lastName );
                            SELF.phonePenalt := ut.mod_penalize.phone( in_phone, LEFT.phoneNumber );
                            SELF.ssnPenalt   := ut.mod_penalize.SSN( in_ssn, LEFT.ssn );
                            SELF             := LEFT;
                          )
               );
        
      /* for some reason, the penalties coming back are allowing invalid records through.  I am filtering the 
         output results by the input phone, ssn and zip when they are in input data to compensate.
         An example of what is happening:  a zip code search is requested input zip = 45371 (Tipp City), a 
         penalty of 2 is returned for Dayton address zips (45424 was one of the zips that returned a 
         penalty of 2) from the penalization function. The penalty threshold is 10 and therefore
         the Dayton addresses were being returned to the user when the Tipp City zip code was entered.
         SSN and Phones penilizations were displaying similar issues.
      */
      AllRecs_filteredByPen := AllRecs_Penalized( ( namePenalt + phonePenalt + ssnPenalt + addrPenalt ) < AutoStandardI.GlobalModule().penalty_threshold );
      AllRecs_filteredByPhn := AllRecs( ut.NNEQ( phoneNumber, in_phone) );
      AllRecs_filteredBySsn := AllRecs( ut.NNEQ( ssn, in_ssn ) );
      AllRecs_filteredByZip := AllRecs( zip = in_zip );
        
      AllRecs_filtered      := IF( in_zip != '',
                                   AllRecs_filteredByZip,  // When zip is entered the penalty calculates a range; therefore, will be filtering by zip when the zip is entered.
                                   IF( in_phone != '',
                                       AllRecs_filteredByPhn,       // phone & SSN penalization returns: Constants.DEFAULT_THRESHOLD-1 (line 13: AutoStandardI.LIB_PenaltyI_Phone)
                                       IF( in_ssn != '',            // (so all records will always fall within the threshold -- 
                                           AllRecs_FilteredBySsn,   // therefore filtering by input phone & SSN when these were the search input.
                                           AllRecs_filteredByPen
                                         )  
                                     )                            
                                 );
      
      // in the following sort, 
      AllRecs_sorted := 
        SORT( AllRecs_filtered, 
              source, IF( AddrRank = 0, 1000, AddrRank), practitionerID, -dt_last_seen, lastName,  
              firstName, middleName, Address, city, state, zip, birthdate, RECORD 
            ); 

      // At the time of the first release (4/2012) for this product, we are required to return only one record 
      // For the address, the sort should have the records in the correct order (with the exception of the first
      // five rules in the map statement, but the rollup ensures we are getting the correct/best address.
      // 
      // Sources: 1 = Ingenix (preferred source)
      //          2 = NCPDP (National Council for Prescription Drug Programs)
      //          3 = CNLD (ChoicePoint National License Database)
      // Rules used for this rollup:
      // If the record is an Ingenix record and the rank is less than 10, keep the lowest Ingenix record
      // If the record is an Ingenix record and the rank is greater than 10 AND 
      //        the compared record is NCPDP AND the NCPDP last seen date is within the last three months, 
      //        then use the NCPDP record. The reasoning behind this choice was that Ingenix was be our best
      //        source at the time of the release.  The NCPDP file does not have a ranking field, but it does
      //        have a date last seen.  So if the Ingenix record isn't one of their best records and the NCPDP
      //        record has an address seen in the last three months, then use the NCPDP record.
      // The CNLD data source has not had an update since early in 2012, therefore output the results from this
      //       file as a last resort.
      Recs_Rollup := 
        ROLLUP( AllRecs_sorted, 
                LEFT.practitionerID = RIGHT.practitionerID,
                TRANSFORM( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization,
                           side                := MAP( LEFT.source = 0 => RIGHT,
                                                       LEFT.source = RIGHT.source AND LEFT.AddrRank <= RIGHT.AddrRank      => LEFT,
                                                       LEFT.source = RIGHT.source AND LEFT.AddrRank >  RIGHT.AddrRank      => RIGHT,
                                                       LEFT.source = SearchPoint_Services.Constants.ingenixSourceRank AND RIGHT.source = SearchPoint_Services.Constants.ncpdpSourceRank AND LEFT.AddrRank <= 10        => LEFT,
                                                       LEFT.source = SearchPoint_Services.Constants.ingenixSourceRank AND RIGHT.source = SearchPoint_Services.Constants.ncpdpSourceRank AND LEFT.AddrRank > 10 AND 
                                                       ((((INTEGER)Std.Date.Today() - (INTEGER)RIGHT.dt_last_seen ) /100) <= 2 ) => RIGHT,  // date is within three months 
                                                       LEFT.source = SearchPoint_Services.Constants.ncpdpSourceRank AND RIGHT.source = SearchPoint_Services.Constants.ncpdpSourceRank AND 
                                                       LEFT.dt_last_seen < RIGHT.dt_last_seen                              => LEFT,
                                                       LEFT.source = SearchPoint_Services.Constants.ncpdpSourceRank AND RIGHT.source = SearchPoint_Services.Constants.ncpdpSourceRank AND 
                                                       LEFT.dt_last_seen > RIGHT.dt_last_seen                              => RIGHT,
                                                       LEFT.source < RIGHT.source                                          => LEFT,
                                                       LEFT.source > RIGHT.source                                          => RIGHT,
                                                                                                                              LEFT
                                                     );
                           SELF.address        := side.address;
                           SELF.address2       := side.address2;
                           SELF.city           := side.city;
                           SELF.state          := side.state;
                           SELF.zip            := side.zip;
                           SELF.extZip         := side.extZip; 
                           SELF.phoneNumber    := side.phoneNumber;
                           SELF                := side;
                           SELF                := [];
                         )
              );

      /* Not using address information from mac_best_records because it contains the practitioners home address
         Since we are only allowed to return one record per practitioner ID, I am pulling the information from 
         doxie.mac_best_records so that can at least give the customer the best name we have availalbe for that 
         DID.  
         7/2012 -- when the record is a gennum, the name was blank because the practitioner ID was 
                   the gennum instead of the DID.  Adding the check for the gennum for the record 
                   allows us to pull the data from the record when there would be no data in the 
                   best file. */
      Recs_GetBestName :=
        PROJECT( Recs_Rollup,
                 TRANSFORM( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization,
                            isGennum        := SearchPoint_Services.Functions.isGennum( LEFT.practitionerId );
														ds_best_outfile := IF( NOT isGennum, SearchPoint_Services.Functions.getBestData( LEFT.practitionerID, dppa_ok, glb_ok ) );
                            SELF.prefix     := IF( isGennum, LEFT.prefix, ds_best_outfile[1].title );
                            SELF.firstName  := IF( isGennum, LEFT.firstName, ds_best_outfile[1].fname );
                            SELF.middleName := IF( isGennum, LEFT.middleName, ds_best_outfile[1].mname );
                            SELF.lastName   := IF( isGennum, LEFT.lastName, ds_best_outfile[1].lname );
                            SELF.suffix     := IF( isGennum, LEFT.suffix, ds_best_outfile[1].name_suffix );
                            SELF.gender     := IF( isGennum, LEFT.gender, SearchPoint_Services.Functions.convertTitle( ds_best_outfile[1].title ) );
                            // left.birthdate was populated from best file.
                            SELF.birthdate  := LEFT.birthdate;
                            SELF            := LEFT;
                          )
               );
   
      // transform to final iesp layout
      iesp.searchpoint.t_PractitionerSummary xfm_to_summary_layout( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization l ) :=
        TRANSFORM
          SELF.Address.StreetAddress1 := l.address; 
          SELF.Address.StreetAddress2 := l.address2;  
          SELF.Address.City           := l.city;
          SELF.Address.State          := l.state;
          SELF.Address.Zip5           := l.zip; 
          SELF.Address.Zip4           := l.extzip;
          SELF.DateOfBirth.Year       := (INTEGER) SearchPoint_Services.Functions.GetYear( l.birthdate );
          SELF.DateOfBirth.Month      := (INTEGER) SearchPoint_Services.Functions.GetMonth( l.birthdate );
          SELF.DateOfBirth.Day        := (INTEGER) SearchPoint_Services.Functions.GetDay( l.birthdate );
          SELF.Gender                 := l.gender;
          SELF.PractitionerID         := l.practitionerID;
          SELF.Name.First             := l.firstname;
          SELF.Name.Middle            := l.middlename;
          SELF.Name.Last              := l.lastname;
          SELF.Name.Suffix            := l.suffix;
          SELF                        := [];
        END;
        
      Results := PROJECT( Recs_GetBestName, xfm_to_summary_layout (LEFT) ); 
	
      RETURN Results;

    END;

  END;

/*  Practitioner Search Service Searches February, 2012

Query Type	                Attribute          Required	  Allow_Wildcard
DeaNumber	                  deaNumber            Yes	      No
FederalTaxId	              federalTaxId         Yes	      No
FirstNameLastNameAndState	  firstName            No         Yes
	                          lastName             Yes        Yes
                            state                Yes        No
Npi	                        npiNumber            Yes        No
PhoneNumber                 phoneNumber          Yes        No
PractitionerId              practitionerId       Yes        No
Ssn                         ssn                  Yes        No
StateLicenseNumberAndState  stateLicenseNumber   Yes        No
	                          state                Yes        No
UniquePhysicianId           uniquePhysicianId    Yes        No
Zipcode                     zipcode              Yes        Yes

*/

      
      
/* Leaving the followig code in. At the time of creation (2/2012), it was decided that we were simply replacing the legacy 
   system with an equivalent process and not enhancing the results with additional sources available to us.  This code was 
   already completed. Below is the code for the DEA source.It can be used in the future should a product 
   request come in to make the results more robust.
 		   
         deaNcpdpResults  := PROJECT( NCPDPdeaRecsPlusDobAndGender, xfm_into_final_dea_layout_NCPDP( LEFT ) ); 
			
	   // -----[ DEA: DEA Key ]-----
         deaSearchRecs          := DEA.Key_dea_reg_num( KEYED( dea_registration_number = deaNum ) AND NOT is_company_flag );
			
			deaRecsBest := dx_BestRecords.append(deaSearchRecs, did, dx_BestRecords.Constants.perm_type.glb);
			deaRecsPlusDOB := PROJECT( deaSearchRecs,
				TRANSFORM( {RECORDOF( deaSearchRecs ), STRING dob}, 
					dobORG     := (STRING) LEFT._best.dob;
					SELF.dob   := convertDOB;
					SELF.title := IF( LEFT.title != '',
							LEFT.title,
							LEFT._best.title);
					SELF     := LEFT;
				);					
  													 
                   
			SearchPoint_Services.Layouts.PractitionerSearch.layout_summary xfm_summary_info( RECORDOF( deaRecsPlusDOB ) l) :=
		      TRANSFORM
			      SELF.address1     := IF( TRIM( l.prim_range, LEFT, RIGHT ) != '',
					                         TRIM( l.prim_range, LEFT, RIGHT ) + ' ',
													 ''
												  ) + 
					                     IF( TRIM( l.predir, LEFT, RIGHT ) != '',
												    TRIM( l.predir, LEFT, RIGHT ) + ' ',
													 ''
												  ) + 
												IF( TRIM( l.prim_name, LEFT, RIGHT ) != '',
												    TRIM(l.prim_name, LEFT, RIGHT ) + ' ',
													 ''
												  ) + 
												IF( TRIM( l.addr_suffix, LEFT, RIGHT ) != '',
												    TRIM( l.addr_suffix, LEFT, RIGHT ) + ' ',
													 ''
												  ) + 
												IF( TRIM( l.postdir, LEFT, RIGHT ) != '',
												    TRIM( l.postdir, LEFT, RIGHT ),
													 ''
												  );                      
				   SELF.address2     := IF( TRIM( l.unit_desig, LEFT, RIGHT ) != '', 
                                        TRIM( l.unit_desig, LEFT, RIGHT ) + ' ',
                                        '' 
                                      )  + 
                                    IF( TRIM( l.sec_range, LEFT, RIGHT ) != '', 
                                        TRIM( l.sec_range, LEFT, RIGHT ),
                                        ''
                                      );
				   SELF.city         := TRIM( l.p_city_name, LEFT, RIGHT );
				   SELF.state        := TRIM( l.st, LEFT, RIGHT );
				   SELF.zip          := TRIM( l.zip, LEFT, RIGHT );
				   SELF.dateOfBirth  := l.dob;    
 				   SELF.pharmacistID := '';  // todo - ???join with cnld file to get gennum/pharmID in CNLD data -- Terri is working on this  -- or return the did
               SELF.firstName    := TRIM( l.fname, LEFT, RIGHT );
               SELF.middleName   := TRIM( l.mname, LEFT, RIGHT );
               SELF.lastName     := TRIM( l.lname, LEFT, RIGHT );
               SELF.nameSuffix   := TRIM( l.name_suffix, LEFT, RIGHT );
               SELF.gender       := convertGender( l.title  ); 
		      END;
		
		   // transform layout into Practitioner Search layout response / ouput layout	
		   SearchPoint_Services.Layouts.PractitionerSearch.layout_response xfm_into_final_dea_layout( RECORDOF( deaRecsPlusDOB) l) :=
		      TRANSFORM
               SELF.error_code          := ''; // Per Jason, these error fields are 
               SELF.error_message       := ''; //            created by the app layer
               SELF.query_date          := queryDate;
				   SELF.practitionerSummary := PROJECT( l, xfm_summary_info( LEFT ) );
		      END;

			
		   deaKeyResults  := PROJECT( deaRecsPlusDOB, xfm_into_final_dea_layout( LEFT ) );


         deaResultsAll := deaNcpdpResults + deaKeyResults;
         // When adding this source -- still need to do a rollup of results
        
         */
