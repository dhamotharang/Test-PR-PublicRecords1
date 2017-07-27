IMPORT AutoStandardI, doxie, SearchPoint_Services, ut, AutoHeaderI;

/*
Functions:
 - convertDeaSched (STRING15 deaNumber ) // converts 1 22N 33N 45 to TTTTTTT (true for each given schedule: 1,2,2N,3,3N,4,5)
 - convertGender ( STRING gender )  // returns male/female based on gender (M/F)
 - convertTitle( STRING title )     // returns male/femail based title (Mr/Mrs)

 - get_addrPenalty( STRING2 in_state, STRING5 in_zip, STRING2 match_state, STRING5 match_zip )
 - getBestData ( QSTRING20 practitionerID ) // gets doxie.mac_best_records for practitioner ID/DID
 - getDid( STRING did ) 
 - getMonth( STRING dob )
 - get_namePenalty( STRING20 in_fname, STRING20 in_lname, STRING20 match_fname, STRING20 match_lname )
 - getYear( STRING dob )


 - isGennum (STRING20 in_practitionerId )


 - removeHexFromAddr2 ( DATASET( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization ) in_recs )


*/

EXPORT Functions := 
  MODULE

		EXPORT searchParams := INTERFACE
			EXPORT STRING30  FirstName := '';
			EXPORT STRING30  MiddleName := '';
			EXPORT STRING30  LastName := '';
			EXPORT STRING25  City := '';
			EXPORT STRING2   State := '';
			EXPORT STRING6   Zip := '';
		END;

		EXPORT getHdrDidByNameAddr(searchParams srchByMod) := FUNCTION
			glbMod := MODULE(PROJECT(srchByMod,AutoStandardI.GlobalModule(),OPT)),VIRTUAL
				EXPORT BOOLEAN noFail := TRUE;
				EXPORT UNSIGNED2 zipRadius := 25;
				EXPORT BOOLEAN didOnly := TRUE;
				EXPORT BOOLEAN useOnlyBestDid := TRUE;
				EXPORT BOOLEAN currentResidentsOnly := TRUE;
			END;
				tmpmod := MODULE(PROJECT(glbMod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,OPT))
			END;
			RETURN AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tmpmod)[1].did;
		END;
   
    EXPORT convertDeaSched ( STRING15 deaSchedule ) :=
      FUNCTION
        twoN     := IF( stringlib.StringFind( deaSchedule, '2N', 1) > 0, 'T', 'F');
        remove2N := IF( twoN = 'T', stringlib.StringFindReplace( deaSchedule, '2N', '' ), deaSchedule);    // remove the 2n from the string to allow check for 2
        threeN   := IF( stringlib.StringFind( remove2N, '3N', 1) > 0, 'T', 'F');
        remove3N := IF( threeN = 'T', stringlib.StringFindReplace( remove2N, '3N', '' ), remove2N); 
        one      := IF( stringlib.StringFind( remove3N, '1', 1) > 0, 'T', 'F');
        two      := IF( stringlib.StringFind( remove3N, '2', 1) > 0, 'T', 'F');
        three    := IF( stringlib.StringFind( remove3N, '3', 1) > 0, 'T', 'F');
        four     := IF( stringlib.StringFind( remove3N, '4', 1) > 0, 'T', 'F');
        five     := IF( stringlib.StringFind( remove3N, '5', 1) > 0, 'T', 'F');
        
        newSchedule := IF( deaSchedule = '', '', one + two + twoN + three + threeN + four + five);
        RETURN newSchedule;
      END;
                                             
    
    EXPORT convertGender ( STRING gender ) :=
      FUNCTION
        RETURN( CASE( TRIM(StringLib.StringToUpperCase(gender),LEFT,RIGHT), 'M' => 'Male',
                                                                            'F' => 'Female',
                                                                    /* default */  ''
                    )
              );
      END;
                                             

    EXPORT convertTitle( STRING title ) :=
      FUNCTION
        RETURN( CASE( TRIM(StringLib.StringToUpperCase(title),LEFT,RIGHT), 'MR' => 'Male',
                                                                            'MS' => 'Female',
                                                                     /* default */  ''
                    )
              ); 
      END;    


    EXPORT get_addrPenalty( STRING2 in_state, STRING5 in_zip, STRING2 match_state, STRING5 match_zip ) :=
      FUNCTION
        in_stateUpper    := TRIM(StringLib.StringToUpperCase(in_state),LEFT,RIGHT);
        match_stateUpper := TRIM(StringLib.StringToUpperCase(match_state),LEFT,RIGHT);
             
        in_addr := 
          MODULE(ut.mod_penalize.IGenericAddress)
            EXPORT prim_range     := '';
            EXPORT predir         := '';
            EXPORT prim_name      := '';
            EXPORT postdir        := '';
            EXPORT addr_suffix    := '';
            EXPORT sec_range      := '';
            EXPORT p_city_name    := '';
            EXPORT st             := in_stateUpper;
            EXPORT z5             := in_zip;   
            EXPORT allow_wildcard := FALSE;										
            EXPORT useGlobalScope := FALSE;
          END;

          match_addr := 
            MODULE(ut.mod_penalize.IGenericAddress)
              EXPORT prim_range     := '';
              EXPORT predir         := '';
              EXPORT prim_name      := '';
              EXPORT postdir        := '';
              EXPORT addr_suffix    := '';
              EXPORT sec_range      := '';
              EXPORT p_city_name    := '';
              EXPORT st             := match_stateUpper;
              EXPORT z5             := match_zip;  
              EXPORT allow_wildcard := FALSE;											
              EXPORT useGlobalScope := FALSE;
            END;

            RETURN( ut.mod_penalize.address( in_addr, match_addr ) );
          END;


    // Since we are only returning one record, I am using doxie.mac_best_records to get the best
    // name and ssn information for the practitioner.  Since there is the possibility for misspellings
    // in the vendor's data, keeping the longest name isn't the best option.  
    EXPORT getBestData ( QSTRING20 practitionerID,
											   BOOLEAN dppa_ok,
												 BOOLEAN glb_ok) :=
      FUNCTION
        ds_inDid := DATASET( [ { (UNSIGNED6)practitionerID } ], { UNSIGNED6 did } );

				doxie.mac_best_records(ds_inDid,
															 did,
															 ds_best_outfile,
															 dppa_ok,
															 glb_ok,
															 ,
															 doxie.DataRestriction.fixed_drm);
															 
        RETURN ds_best_outfile;
      END;
                           

    EXPORT getDay( STRING dob ) := 
      FUNCTION
        dobTrim := TRIM( dob, LEFT, RIGHT );
        RETURN( IF( dobTrim != '' AND dobTrim != '0',  // will be '' if key file var is string, 0 if unsigned6
                    dobTrim[7..8], 
                    ''
                  )
              );
      END;


    EXPORT getDid( STRING did ) :=
      FUNCTION
        RETURN( IF( did = '' OR did = '0' , // will be '' if key file var is string, 0 if unsigned6
                    '',
                    TRIM( did, LEFT, RIGHT )
                  )
              );
      END;
                

    EXPORT getMonth( STRING dob ) := 
      FUNCTION
        dobTrim := TRIM( dob, LEFT, RIGHT );
        RETURN( IF( dobTrim != '' AND dobTrim != '0',  // will be '' if key file var is string, 0 if unsigned6
                    dobTrim[5..6], 
                    ''
                  )
              );
      END;            


    EXPORT get_namePenalty( STRING20 in_fname, STRING20 in_lname, STRING20 match_fname, STRING20 match_lname ) :=
      FUNCTION
        in_lastNameUpper     := TRIM(StringLib.StringToUpperCase(in_lname),LEFT,RIGHT);
        in_firstNameUpper    := TRIM(StringLib.StringToUpperCase(in_fname),LEFT,RIGHT);
        match_lastNameUpper  := TRIM(StringLib.StringToUpperCase(match_lname),LEFT,RIGHT);
        match_firstNameUpper := TRIM(StringLib.StringToUpperCase(match_fname),LEFT,RIGHT);
       
        IPersonName := PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt);
       
        mod_personname := 
         MODULE(IPersonName)						
           EXPORT lastname       := in_lastNameUpper;  
           EXPORT middlename     := '';          // middle names are not input fields
           EXPORT firstname      := in_firstNameUpper; 
        
           EXPORT lname_field    := match_lastNameUpper;
           EXPORT mname_field    := '';          // middle names are not input fields
           EXPORT fname_field    := match_firstNameUpper;						
            // Booleans to control behavior.
           EXPORT allow_wildcard := FALSE;
         END;  // mod_personname	
    
       RETURN AutoStandardI.LIBCALL_PenaltyI_Indv_name.val(mod_personname);            
      
      END; // get_namePenalty
    

    EXPORT getYear( STRING dob ) := 
      FUNCTION
        dobTrim := TRIM( dob, LEFT, RIGHT );
        RETURN( IF( dobTrim != '' AND dobTrim != '0',  // will be '' if key file var is string, 0 if unsigned6
                    dobTrim[1..4],
                    ''
                  )
             );
      END;
    

    /* 3/2012 -- all gennums start with an alpha character. If the practitioner Id 
                 entered begins with an alpha character we'll be searching 
                 the CNLD - Gennum key file, otherwise we will search the other data
                 sources for the did (and as of this release the practitioner ID returned
                 to the customer will be the DID.
       7/2012 -- Added a check for a blank/null and for a space as the first character to signify the 
                 gennum is false.  When there is no gennum added, without this check the code will 
                 process the data as if the gennum was found which results in blank output.
    */ 
    
    EXPORT isGennum (STRING20 in_practitionerId ):=
      FUNCTION
        FirstChar := in_practitionerId[1] NOT IN [ '', ' ', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
        RETURN FirstChar;
      END;
                   
    // this function was created because there were non-ascii characters in the vendors address2 field.  Data fab is working 
    // on the vendor data.
    EXPORT removeHexFromAddr2 ( DATASET( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization ) in_recs ) :=
      FUNCTION
        hexRemovedRecs :=
          PROJECT( in_recs,
                   TRANSFORM( SearchPoint_Services.Layouts.practitionerSearch.all_data_needed_for_penalization,
                              SELF.address2 := IF( REGEXFIND( '[^\\x00]', LEFT.address2 ) = TRUE,
                                                   LEFT.address2,
                                                   ''
                                                 );
                              SELF          := LEFT;
                            )
                 );
        RETURN hexRemovedRecs;  
           
      END;

			EXPORT fn_get_variant_zipcodes(STRING5 zipcode) := 
				FUNCTION
				STRING cut_zipcode := TRIM(StringLib.StringFilterOut(zipcode, '*'));
				INTEGER cut_length := LENGTH(cut_zipcode);
				INTEGER n := 5 - cut_length; 	//used to set width of incremented string in output
				INTEGER	num_variants := POWER(10,n);

					rec_zipcode := RECORD
						STRING cut_zipcode;
					END;
					
					ds_zipcode := DATASET( [ {cut_zipcode} ], rec_zipcode );
							
					rec_zipcode xfm_create_new_variant(rec_zipcode le, INTEGER c) :=
						TRANSFORM
						
										SELF.cut_zipcode := le.cut_zipcode + INTFORMAT(c-1,n,1);

									END;
					
					ds_variant_zipcodes := 
						NORMALIZE(
							ds_zipcode,
							num_variants,
							xfm_create_new_variant(LEFT,COUNTER)
						);
					
					RETURN ds_variant_zipcodes;
				END;

   END;