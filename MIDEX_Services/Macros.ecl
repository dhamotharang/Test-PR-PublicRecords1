EXPORT Macros := 
  MODULE
    
    EXPORT fnMac_penalize_results( ds_recs_in, in_mod, transformLayout, 
                                   firstname_layoutName = 'firstname', middlename_layoutName = 'middlename', lastname_layoutName = 'lastname',
                                   cname_layoutName = 'cname', licenseNumber_layoutName = 'licenseNumber', 
                                   licenseState_layoutName = 'licenseState', tin_layoutName = 'tin', penalt_layoutName = 'penalt',
                                   midex_rpt_nbr_layoutName = 'midex_rpt_nbr', ssn_layoutName = 'ssn', uniqueId_layoutName = 'uniqueId',
                                   prim_range_layoutName = 'prim_range', predir_layoutName = 'predir', prim_name_layoutName = 'prim_name',
                                   postdir_layoutName = 'postdir', addr_suffix_layoutName = 'addr_suffix', sec_range_layoutName = 'sec_range', 
                                   city_layoutName = 'city', st_layoutName = 'st', zip5_layoutName = 'zip5', phone_layoutName = 'phone',
																	 nmlsID_layoutName = 'nmls_id',dob_layoutname = 'dob'
                                 ) :=    
                                
      FUNCTIONMACRO
        IMPORT ut, AutoStandardI;
        // The following code can be used to further rank the records by including 
        // sub-penalties in the sort process at the end of the macro.
        // transformLayoutPlusPenaltFields := 
          // RECORD
            // transformLayout,
            // UNSIGNED didPenalt;
            // UNSIGNED minPenalt;
            // UNSIGNED compNamepenalt;
            // UNSIGNED licPenalt;
            // UNSIGNED addrPenalt;
            // UNSIGNED namePenalt;
            // UNSIGNED phonePenalt;
            // UNSIGNED ssnPenalt;
            // UNSIGNED midexRptNumPenalt;
            // UNSIGNED tinPenalt;  
            // UNSIGNED cumPenalty;
            // UNSIGNED dobpenalt;
            // STRING26  midexNbr;
            // STRING26  inModfirstname;  
            // STRING26  inModmiddlename;
            // STRING26  inModlastname;
          // END; // transformLayoutPlusPenaltFields for sorting dataset to product reqs after penalization
       	
        
        b_nameSearched := AutoStandardI.InterfaceTranslator.fname_value.val(in_mod) != '' OR  
                          AutoStandardI.InterfaceTranslator.mname_value.val(in_mod) != '' OR
                          AutoStandardI.InterfaceTranslator.lname_value.val(in_mod) != ''; 
                          
        b_addrSearched := AutoStandardI.InterfaceTranslator.prange_value.val(in_mod)      != '' OR
                          AutoStandardI.InterfaceTranslator.predir_value.val(in_mod)      != '' OR
                          AutoStandardI.InterfaceTranslator.pname_value.val(in_mod)       != '' OR
                          AutoStandardI.InterfaceTranslator.postdir_value.val(in_mod)     != '' OR
                          AutoStandardI.InterfaceTranslator.addr_suffix_value.val(in_mod) != '' OR
                          AutoStandardI.InterfaceTranslator.sec_range_value.val(in_mod)   != '' OR
                          AutoStandardI.InterfaceTranslator.city_value.val(in_mod)        != '' OR
                          AutoStandardI.InterfaceTranslator.state_value.val(in_mod)       != '' OR
                          AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod) != '';                 
                          
        // Calculate the penalty on the records
        ds_recs_plus_pen := PROJECT(ds_recs_in,TRANSFORM(transformLayout,
          IPersonName := PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.FULL, OPT);
       
          mod_personName := 
           MODULE(IPersonName)						
             EXPORT firstname      := AutoStandardI.InterfaceTranslator.fname_value.val(in_mod);  
             EXPORT middlename     := AutoStandardI.InterfaceTranslator.mname_value.val(in_mod);
             EXPORT lastname       := AutoStandardI.InterfaceTranslator.lname_value.val(in_mod); 
          
             EXPORT fname_field    := LEFT.firstname_layoutName;
             EXPORT mname_field    := LEFT.middlename_layoutName;          // middle names are not input fields
             EXPORT lname_field    := LEFT.lastname_layoutName;						
              // Booleans to control behavior.
             EXPORT allow_wildcard := FALSE;
           END;  // mod_personname	
          

          in_addr := 
            MODULE(ut.mod_penalize.IGenericAddress)
              EXPORT prim_range     := AutoStandardI.InterfaceTranslator.prange_value.val(in_mod);
              EXPORT predir         := AutoStandardI.InterfaceTranslator.predir_value.val(in_mod);
              EXPORT prim_name      := AutoStandardI.InterfaceTranslator.pname_value.val(in_mod);
              EXPORT postdir        := AutoStandardI.InterfaceTranslator.postdir_value.val(in_mod);
              EXPORT addr_suffix    := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(in_mod);
              EXPORT sec_range      := AutoStandardI.InterfaceTranslator.sec_range_value.val(in_mod);
              EXPORT p_city_name    := AutoStandardI.InterfaceTranslator.city_value.val(in_mod);
              EXPORT st             := AutoStandardI.InterfaceTranslator.state_value.val(in_mod);
              EXPORT z5             := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod);   
              EXPORT allow_wildcard := FALSE;										
              EXPORT useGlobalScope := FALSE;
          END;

          match_addr := 
            MODULE(ut.mod_penalize.IGenericAddress)
            EXPORT prim_range     := LEFT.prim_range_layoutName;
            EXPORT predir         := LEFT.predir_layoutName;
            EXPORT prim_name      := LEFT.prim_name_layoutName;
            EXPORT postdir        := LEFT.postdir_layoutName;
            EXPORT addr_suffix    := LEFT.addr_suffix_layoutName;
            EXPORT sec_range      := LEFT.sec_range_layoutName;
            EXPORT p_city_name    := LEFT.city_layoutName;
            EXPORT st             := LEFT.st_layoutName;
            EXPORT z5             := LEFT.zip5_layoutName;  
            EXPORT allow_wildcard := FALSE;											
            EXPORT useGlobalScope := FALSE;
          END;
        
        // for the penalties calculated in this macro, using 30 as a default value when a
        // search value entered does not match the record value. This will include the value 
        // for the cumulative penalty, but not eliminate the record from the search (unless
        // there is no min penalty that falls within the range).
        addrPenalt_raw    := ut.mod_penalize.address( in_addr, match_addr );
        // because the address penalty has extremely large penalties (ie: 3427 ), the address
        // penalty skews the penalty sorting.  4000 seems like the cap, using the following equation 
        // to reduce the address penalty to it's equivalent ratio up to 30. In the event the address
        // penalty comes back greater than 30, we'll revert the value to 30. The following equation 
        // should take care of the majority of the cases.
        // addrPenalt_temp   := IF(addrPenalt_raw < 30, 
                                 // addrPenalt_raw, 
                                 // (addrPenalt_raw * 30 ) / 4000;
        addrPenalt        := MAP( addrPenalt_raw < 31        => addrPenalt_raw, 
        
                                  addrPenalt_raw > 30 AND 
                                  addrPenalt_raw < 1001      => 33,
                                  
                                  addrPenalt_raw > 1000 AND
                                  addrPenalt_raw < 2001      => 35,
                                  
                                  addrPenalt_raw > 2000 AND
                                  addrPenalt_raw < 3001      => 38,
                                  
                                  addrPenalt_raw > 3000 AND
                                  addrPenalt_raw < 4001      => 40,
                                  
                                                                50
                               );
        
        compNamePenalt    := IF( in_mod.companyname != '', ut.mod_penalize.company_name ( AutoStandardI.InterfaceTranslator.company_name_value.val(in_mod), LEFT.cname_layoutName ), 99);

        didPenalt         := MAP( in_mod.did != '' AND in_mod.did = (STRING)LEFT.uniqueID_layoutName  => 0, 
                                  in_mod.did != '' AND in_mod.did != (STRING)LEFT.uniqueID_layoutName => 30,
                                         /* default */                                                   99);
         
				nmlsIDPenalt      := MAP( in_mod.nmls_id != '' AND in_mod.nmls_id = (STRING)LEFT.nmlsID_layoutName  => 0, 
                                  in_mod.nmls_id != '' AND in_mod.nmls_id != (STRING)LEFT.nmlsID_layoutName => 30,
																				/* default */                                                         99);
																				 
				license_number := TRIM(StringLib.StringToUpperCase(in_mod.license_number));
				license_state  := TRIM(StringLib.StringToUpperCase(in_mod.license_state));

        licPenalt         := MAP(  license_number != '' AND 
                                   LEFT.licenseNumber_layoutName = license_number AND 
                                   LEFT.licenseState_layoutName = license_state             => 0, 
                                  
                                   license_number != '' AND 
                                   LEFT.licenseNumber_layoutName = license_number AND 
                                   ( license_state = '' OR 
                                     LEFT.licenseState_layoutName = '' )                           => 5,
                                  
                                   license_number != '' AND
                                   license_state != '' AND
                                   LEFT.licenseNumber_layoutName = license_number AND
                                   LEFT.licenseState_layoutName != license_state             => 9, /* making this nine so that any other discrepancies in the record will push the record over the penalty threshold */
                                  
                                   license_number != '' AND
                                   LEFT.licenseNumber_layoutName != license_number => 30,
                                     /* default - in_mod.license_number = ''*/                          99 );
        
       midexRptNumPenalt := MAP( in_mod.midex_rpt_num != '' AND 
                                  LEFT.midex_rpt_nbr_layoutName = in_mod.midex_rpt_num     => 0,
                                  
                                  in_mod.midex_rpt_num != '' AND 
                                  LEFT.midex_rpt_nbr_layoutName != in_mod.midex_rpt_num    => 30,
                                     /* default - in_mod.midex_rpt_num = ''*/                 99 );
                                     
        namePenalt        := IF( AutoStandardI.InterfaceTranslator.lname_value.val(in_mod) != '',
                                 AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(mod_personName),
                                 99);
        
        phonePenalt       := MAP( in_mod.phone != '' AND LEFT.phone_layoutName = in_mod.phone   =>  0, 
                                  in_mod.phone != '' AND LEFT.phone_layoutName != in_mod.phone  =>  30,
                                      /* default - in_mod.phone = ''*/                              99 );
                                      
        fullSsnPenalt     := IF( in_mod.ssn != '', ut.mod_penalize.ssn ( AutoStandardI.InterfaceTranslator.ssn_value.val(in_mod), LEFT.ssn_layoutName), 99);
        
        Ssn4Penalt        := MAP( in_mod.ssn_last4 != '' AND in_mod.ssn_last4  = LEFT.ssn_layoutName[6..9] => 0, 
                                  in_mod.ssn_last4 != '' AND in_mod.ssn_last4 != LEFT.ssn_layoutName[6..9] => 30,   
                                      /* default - in_mod.ssn_last4 = ''*/                                    99 );

        SsnPenalt         := MIN( fullSsnPenalt, Ssn4Penalt );

        tinPenalt         := MAP( in_mod.tin != '' AND LEFT.tin_layoutName = in_mod.tin   => 0, 
                                  in_mod.tin != '' AND LEFT.tin_layoutName != in_mod.tin  => 30, 
                                      /* default - in_mod.tin = ''*/                         99 );
        
				inDob_year  := doxie.DOBTools(in_mod.dob_filter).year_in;
				inDob_month := doxie.DOBTools(in_mod.dob_filter).find_month;
				inDob_day   := doxie.DOBTools(in_mod.dob_filter).find_day;
        dobYear_Penalt  := MAP( inDob_year != 0 AND inDob_year  = (UNSIGNED8) LEFT.dob[1..4] => 0, 
                                inDob_year != 0 AND inDob_year != (UNSIGNED8) LEFT.dob[1..4] => 20, // Higher penalty for mismtach on year
                                  /* default -  dobYear = ''*/                 99 );
				
				dobMonth_Penalt  := MAP( inDob_month != 0 AND inDob_month  = (UNSIGNED8) LEFT.dob[5..6] => 0, 
                                 inDob_month != 0 AND inDob_month != (UNSIGNED8) LEFT.dob[5..6] => 10,
                                  /* default -  dobMonth = ''*/                 99 );
				
				dobDay_Penalt  := MAP( inDob_day != 0 AND inDob_day  = (UNSIGNED8) LEFT.dob[7..8] => 0, 
                               inDob_day != 0 AND inDob_day != (UNSIGNED8) LEFT.dob[7..8] => 5,
                                  /* default -  dobDay = ''*/                 99 );
				
				dobPenalt := dobYear_Penalt+dobMonth_Penalt+dobDay_Penalt;
				
        // Product (Bonnie Taepakdee) wanted the penalty to be the min calculated penalty.
        // The reasoning behind it was that for this product, it's better for customers to have more 
        // to filter through than to miss a potential bad customer.  
        // The problem with this logic is that there is no subfiltering within the min penalty grouping.
        // for example: if a last name, license number and license state are entered and we get hits
        // on the license number and state for multiple different last names, the matching last name 
        // may not be the first record returned.
        // To remedy this issue, we are calculating an accumulative penalty for those penalties
        // that are lower than 99 (the default, no data entered max value assigned).
        // Once the cumulative penalty is calculated, it can be combined with the minimum penalty to
        // create a new penalty that can be used as a combined sort/sub-sort value to return
        // the best records first.
        // multiplying the MIN penalty by 1000 and then adding the the cumulative penalty will 
        // combine the two penalties into one sortable integer.  Since this penalty calculation 
        // works for both person and business, we need to be able to account for the max of both
        // calculated penalties (penalt and cumulative penalt). The threshold for the service is 10
        // and the max possible value for the cumulative penalty is: 686. 
        // therefore using 1000 allow for filtering by the penalty threshold as well as the sub-sorting.
				// To avoid skewing with some high penalties, make the maximum penalty 125. This penalty is highter
				// than if no search term was added which we want to be less, but not too much higher that the sort
				// order is skewed.
        cumulativePenalty := IF( b_addrSearched, addrPenalt, 0 ) +   
                             IF( in_mod.companyname != '', compNamePenalt, 0 ) + 
                             IF( in_mod.did != '', didPenalt, 0 ) + 
														 IF( in_mod.nmls_id != '', nmlsIDPenalt, 0 ) +
                             IF( in_mod.license_number != '', licPenalt, 0 ) + 
                             IF( in_mod.midex_rpt_num != '', midexRptNumPenalt, 0 ) +  
                             IF( b_nameSearched, namePenalt, 0 ) + 
                             IF( in_mod.phone != '', phonePenalt, 0 ) + 
                             IF( in_mod.ssn != '' OR in_mod.ssn_last4 != '', ssnPenalt, 0 ) + 
                             IF( in_mod.tin != '', tinPenalt, 0 ) +
                             IF( in_mod.dob_filter != 0, dobPenalt, 0 );
                             
        
        minPenalt         := MIN( addrPenalt, compNamePenalt, didPenalt, licPenalt, midexRptNumPenalt,   
                                  namePenalt, phonePenalt, SsnPenalt, tinPenalt, nmlsIDPenalt, dobPenalt);
                                  
        SELF.penalt            := (minPenalt * 1000) + cumulativePenalty;
        // SELF.cumPenalty        := cumulativePenalty;
        // SELF.minPenalt         := minPenalt;
        // SELF.addrPenalt        := addrPenalt;
        // SELF.compNamepenalt    := compNamePenalt;
        // SELF.didPenalt         := didPenalt;
        // SELF.licPenalt         := licPenalt;
        // SELF.midexRptNumPenalt := midexRptNumPenalt;
        // SELF.namePenalt     	  := namePenalt;
				// SELF.phonePenalt       := phonePenalt;
        // SELF.ssnPenalt         := ssnPenalt;
        // SELF.tinPenalt         := tinPenalt;  
				// SELF.dobPenalt         := dobPenalt;
        // SELF.midexNbr          := in_mod.midex_rpt_num;
        // SELF.inModfirstname    := AutoStandardI.InterfaceTranslator.fname_value.val(in_mod);  
        // SELF.inModmiddlename   := AutoStandardI.InterfaceTranslator.mname_value.val(in_mod);
        // SELF.inModlastname     := AutoStandardI.InterfaceTranslator.lname_value.val(in_mod); 
        SELF                   := LEFT ) );

      RETURN ds_recs_plus_pen;

    ENDMACRO; // end of the Penalize_results functionMacro
  

    EXPORT MAC_getIncidentNumFromMidexReportNum ( inDataset, outDataset, inMidexRptNbr = 'MIDEX_RPT_NBR' ):=
                                                             
      // The incident number key needs to be searched by Batch and incident number in order to 
      //  get the complete set of records related to the incident/sanction entered.
      // Calculating the party number for future need.
                                   
      MACRO
        IMPORT SANCTN_Mari;
        
        ds_inWithDBCODE := JOIN( inDataset,
                                 SANCTN_Mari.key_MIDEX_RPT_NBR,
                                 KEYED( LEFT.inMidexRptNbr = RIGHT.midex_rpt_nbr),
                                        TRANSFORM( MIDEX_Services.Layouts.rec_midex_payloadKeyField, 
                                                   SELF.DBCODE := RIGHT.DBCODE,
                                                   SELF        := LEFT,
                                                 ),
                                 KEEP(1), 
                                 LEFT OUTER);
                                          
        outDatasetAll := PROJECT( ds_inWithDBCODE, 
                                  TRANSFORM( MIDEX_Services.Layouts.rec_midex_payloadKeyField, //{MIDEX_Services.Layouts.rec_midex_payloadKeyField, STRING8 pubSanctIncidentNum, STRING8 pubSanctnPartyNum},
                                             dash1Pos := stringlib.StringFind( LEFT.inMidexRptNbr, '-', 1);  
                                             dash2Pos := stringlib.StringFind( LEFT.inMidexRptNbr, '-', 2);  
                                             dash3Pos := stringlib.StringFind( LEFT.inMidexRptNbr, '-', 3);  
                                             batchNumHasDash          := dash3Pos  > 0; 
                                             incidentRaw              := IF( batchNumHasDash, 
                                                                             LEFT.inMidexRptNbr[dash2Pos+1..dash3Pos-1],
                                                                             LEFT.inMidexRptNbr[dash1Pos+1..dash2Pos-1]
                                                                           );
                                             IntegerIncidentRaw       := (UNSIGNED) incidentRaw;  // ensures leading zeros are dropped
                                             partyRaw                 := IF( batchNumHasDash, 
                                                                             LEFT.inMidexRptNbr[dash3Pos+1..],
                                                                             LEFT.inMidexRptNbr[dash2Pos+1..]
                                                                            ); 
                                             IntegerPartyRaw          := (UNSIGNED) partyRaw;  // ensures leading zeros are dropped
                                             batchRaw                 := IF( batchNumHasDash, 
                                                                             LEFT.inMidexRptNbr[1..dash2Pos-1],
                                                                             LEFT.inMidexRptNbr[1..dash1Pos-1]
                                                                           );
                                             SELF.midex_rpt_nbr       := LEFT.inMidexRptNbr,
                                             SELF.BATCH               := batchRaw,
                                             SELF.INCIDENT_NUM        := IncidentRaw,
                                             SELF.PARTY_NUM           := PartyRaw,
                                             // some public sanction keys are keyed with leading zeros
                                             SELF.publicIncidentNum   := INTFORMAT(IntegerIncidentRaw, 8, 1),
                                             SELF.publicPartyNum      := INTFORMAT(IntegerPartyRaw, 8,1),
                                             SELF.NP_subject_rpt_nbr  := IF( LEFT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                                                                             batchRaw + '-' + (STRING)IntegerIncidentRaw + '-' + MIDEX_Services.Constants.NONPUBLIC_SUBJECT_PARTY_NUM, 
                                                                             LEFT.inMidexRptNbr),
                                             SELF.NP_subjectParty_num := IF( LEFT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                                                                             MIDEX_Services.Constants.NONPUBLIC_SUBJECT_PARTY_NUM,
                                                                             partyRaw ),
                                             SELF                     := LEFT  // pick up dbcode
                                           ) ); 
      
      outDataset := DEDUP( SORT( outDatasetAll, midex_rpt_nbr, DBCODE ), midex_rpt_nbr, DBCODE );
        
      ENDMACRO;

   
    EXPORT MAC_GetProfLic_MidexLayout_mariRid (inDataset, outDataset) :=
      MACRO
        outDataset := 
            PROJECT( inDataset,
                     TRANSFORM( MIDEX_Services.Layouts.rec_profLicMari_payloadKeyField,
                       SELF.mari_rid := LEFT.mari_rid,
                     ) );
      ENDMACRO;
      
      
      EXPORT MAC_GetProfLic_MidexLayout_withRid (inDataset, outDataset, searchType) :=
      MACRO
       outDataset := 
         JOIN(inDataset, 
               Prof_License_Mari.key_mari_payload,
               KEYED(LEFT.mari_rid = RIGHT.mari_rid) AND
									IF( searchType = MIDEX_Services.Constants.COMP_SEARCH, 
                  RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.COMPANY OR
                  RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.BRANCH,
                  IF(searchType = MIDEX_Services.Constants.INDIV_SEARCH, 
                  RIGHT.affil_type_cd = MIDEX_Services.Constants.AFFILIATE_TYPES.INDIVIDUAL,                 
                  FALSE)),TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
                          SELF.firstname     := RIGHT.name_first,
                          SELF.middlename    := RIGHT.name_mid,
                          SELF.lastname      := RIGHT.name_last,
                          SELF.suffixname    := RIGHT.name_sufx,
                          SELF.Prefixname    := RIGHT.name_prefx,
                          SELF.CompanyName   := RIGHT.name_mari_org,
                          SELF.BDID          := RIGHT.BDID,
                          SELF.DateFirstSeen := RIGHT.date_first_seen,
                          SELF.DateLastSeen  := RIGHT.date_last_seen,
                          SELF.lic_Type      := RIGHT.std_license_desc,
                          SELF.LicNumber     := RIGHT.license_nbr,
                          SELF.licStatus     := RIGHT.std_status_desc,
                          SELF.licIssueState := RIGHT.license_state,
                          SELF               := RIGHT, 
                          SELF               := LEFT,
                          SELF               := [],
                        )
               LIMIT(ut.limits.default,SKIP));
      ENDMACRO;
    
    EXPORT MAC_midexPayloadKeyField ( inDataset, outDataset, inBatchField = 'BATCH',
                                                             inIncidentNumField = 'INCIDENT_NUM',
                                                             inPartyNumField = 'PARTY_NUM',  
                                                             inMidexRptNbr = 'MIDEX_RPT_NBR' ):=
                                                             
      // Data fabrication is creating the SANCTN, SANCTN_Mari and Prof_License_Mari payload keys with the 
      // MIDEX_Services.Layouts.rec_midex_payloadKeyField Layout as the key for the retrieving the payload.  
      // There are several keys that will need to hit the payload key. Each of the key calls can use this macro
      // to return a dataset containing only the field needed to hit the payload keys for each source. The
      // defaults for each field are set to the most commonly used field names.
                                   
      MACRO
        IMPORT SANCTN_Mari;

        ds_inWithMidexRptNbr := PROJECT( inDataset, 
                                         TRANSFORM( MIDEX_Services.Layouts.rec_midex_payloadKeyField,
                                                    // for the output of the midex report number, the party number can be: 0, 00, 000, ... , 00000000
                                                    // a party number of zero signifies that the party is an originating entity in the Non-public data
                                                    // (the 0 party is only found in the Non-public data)
                                                    // partyNumInteger removes the leading 0's so we don't miss any records when hitting the payload key 
                                                    partyNumInteger          := (UNSIGNED)LEFT.inPartyNumField;
                                                    incidentNumInteger       := (UNSIGNED)LEFT.inIncidentNumField;
                                                    midex_rpt_nbr            := TRIM(LEFT.inBatchField, LEFT, RIGHT) + '-' + (STRING)incidentNumInteger + '-' + (STRING)partyNumInteger;
                                                    SELF.midex_rpt_nbr       := midex_rpt_nbr,
                                                    SELF.BATCH               := LEFT.inBatchField,
                                                    SELF.INCIDENT_NUM        := LEFT.inIncidentNumField,
                                                    SELF.PARTY_NUM           := LEFT.inPartyNumField, 
                                                    SELF                     := LEFT
                                                    ) ); 
                                                  
        ds_addDBCODE := JOIN( ds_inWithMidexRptNbr,
                              SANCTN_Mari.key_MIDEX_RPT_NBR,
                              KEYED( LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
                                     TRANSFORM( MIDEX_Services.Layouts.rec_midex_payloadKeyField, 
                                                batchNbrTrim              := TRIM(LEFT.BATCH, LEFT, RIGHT);
                                                incidentNumInteger        := (UNSIGNED)LEFT.INCIDENT_NUM;
                                                SELF.DBCODE               := RIGHT.DBCODE,
                                                SELF.NP_subject_rpt_nbr   := IF( LEFT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                                                                                 batchNbrTrim + '-' + (STRING)incidentNumInteger + '-' + MIDEX_Services.Constants.NONPUBLIC_SUBJECT_PARTY_NUM,
                                                                                 LEFT.midex_rpt_nbr ),
                                                 SELF.NP_subjectParty_num := IF( LEFT.DBCODE = MIDEX_Services.Constants.DATASOURCE_CODE_NONPUB,
                                                                                 MIDEX_Services.Constants.NONPUBLIC_SUBJECT_PARTY_NUM,
                                                                                 LEFT.PARTY_NUM ),
                                                SELF                      := LEFT
                                              ),
                              KEEP(1), 
                              LEFT OUTER);
       
       outDataset := DEDUP( SORT( ds_addDBCODE, midex_rpt_nbr, DBCODE ), midex_rpt_nbr, DBCODE );                                                                  
                                                  
      ENDMACRO;
       
			
		// Simple macro to transfer the hash values into the iesp output structure.			
		EXPORT mac_IespHashTransfer(recName = 'LEFT') := MACRO
				SELF.AlertResult.RecordDeleted := recName.deleted;
				SELF.AlertResult.Hashes.Name.HashValue := (STRING) LEFT.name_hash;
				SELF.AlertResult.Hashes.Address.HashValue := (STRING) LEFT.address_hash;
				//SELF.AlertResult.Hashes.Incident.HashValue := (STRING) LEFT.incident_hash;
				SELF.AlertResult.Hashes.LicenseStatus.HashValue := (STRING) LEFT.license_status_hash;
				SELF.AlertResult.Hashes.NMLSId.HashValue := (STRING) LEFT.nmls_Id_hash;
				SELF.AlertResult.Hashes.NMLSRepresents.HashValue := (STRING) LEFT.Represent_hash;
				SELF.AlertResult.Hashes.NMLSDisciplinary.HashValue := (STRING) LEFT.Disciplinary_hash;
				SELF.AlertResult.Hashes.NMLSRegistration.HashValue := (STRING) LEFT.Registration_hash;
				SELF.AlertResult.Hashes.Phone.HashValue := (STRING) LEFT.phone_hash;
				SELF.AlertResult.Hashes.AKAAndNameVariation.HashValue	:= (STRING) LEFT.AKA_and_name_variation_hash,
				SELF.AlertResult.Changes.NameChanged := LEFT.namechanged;
				SELF.AlertResult.Changes.AddressChanged := LEFT.addresschanged;
				// SELF.AlertResult.Changes.IncidentChanged := LEFT.incidentchanged;
				SELF.AlertResult.Changes.LicenseStatusChanged := LEFT.licensestatuschanged;
				SELF.AlertResult.Changes.PhoneChanged := LEFT.phonechanged;
				SELF.AlertResult.Changes.NMLSIdChanged := LEFT.NMLSIdChanged;
				SELF.AlertResult.Changes.NMLSRepresentsChanged := LEFT.Representchanged;
				SELF.AlertResult.Changes.NMLSDisciplinaryChanged := LEFT.Disciplinarychanged;
				SELF.AlertResult.Changes.NMLSRegistrationChanged := LEFT.Registrationchanged;
				SELF.AlertResult.Changes.AKAAndNameVariationChanged	:= LEFT.AKAAndNameVariationChanged,
		ENDMACRO;
   
    EXPORT fnMac_setAddrs ( ds_Addrs_in, maxAddrs ) :=   
      FUNCTIONMACRO
        ds_out_Addrs :=
          PROJECT( ds_Addrs_in, 
                   TRANSFORM( iesp.share.t_Address,
                              SELF.StreetNumber := LEFT.prim_range,
                              SELF.StreetPreDirection := LEFT.predir,
                              SELF.StreetName := LEFT.prim_name,
                              SELF.StreetSuffix := LEFT.addr_suffix,
                              SELF.StreetPostDirection := LEFT.postdir,
                              SELF.UnitDesignation := LEFT.unit_desig,
                              SELF.UnitNumber := LEFT.sec_range,
                              SELF.City := LEFT.v_city_name,
                              SELF.State := LEFT.st,
                              SELF.Zip5 := LEFT.zip,
                              SELF.Zip4 := LEFT.zip4,
                              SELF.StreetAddress1 := LEFT.orig_address1,
                              SELF.StreetAddress2 := LEFT.orig_address2,
                              SELF.County := '',
                              SELF.PostalCode := '',
                              SELF.StateCityZip := '',
                           ));
                           
          RETURN CHOOSEN(ds_out_Addrs,maxAddrs);
        ENDMACRO;
 	
   
  END;