IMPORT Address, AutoHeaderI, AutoStandardI, BankruptcyV3, CNLD_Practitioner, 
       CNLD_Practitioner_Services, DEA, doxie, doxie_files, iesp, Ingenix_natlprof, LiensV2, NCPDP, 
       NPPES, ut;


/* NOTE:  CNLD: ChoicePoint National Licensure Database -- Data vendor/provider

          The SearchPoint services were ChoicePoint legacy searches ported over to HPCC systems.  The input for this 
          search is called "gennum" and is displayed to the user as the Practitioner ID. The gennum was generated to  
          be equivalent to our DID (linking all the ChoicePoint file together). When the SearchPoint services were 
          ported over to HPCC / ECL code, we began using the DID as the Gennum II. 

          The CNLD data contains a one time dump from ChoicePoint and no further updates will be done.  */
          
EXPORT Practitioner_Report_Service_Records := 
  MODULE
	  // Defining Interface parameters
    EXPORT Iparams := 
      INTERFACE(AutoStandardI.InterfaceTranslator.application_type_val.params)
      // Fields passed in from ReportService via in_mod and used throughout this attribute.
		  EXPORT BOOLEAN isPharmacistSearch := FALSE;  // default to false -- the pharmacist search is a proper sub-set 
                                                   //                     of the provider search.
      EXPORT STRING  gennum             := '';     // default to null   
    END;

     /* *****************************************************************************************
        *
        *                  -----[ Main processing ]-----
	      * 
        ***************************************************************************************** */

	  EXPORT resultRecs( Iparams in_mod) := 
      FUNCTION
	
     /* *****************************************************************************************
        *
        *                  -----[ Local Functions and Variables ]-----
	      * 
        ***************************************************************************************** */

      BOOLEAN isPharmacistSearch := in_mod.isPharmacistSearch;
      STRING  in_practitionerId  := in_mod.gennum;

      // -------------[ DEA record for Payload join ]----------------------------------------------
      dea_rec := 
		    RECORD
      	  STRING deaNumber;
        END;

      isGennum := SearchPoint_Services.Functions.isGennum( in_practitionerId );
      
 
      
      /* For the SP_Services.Practitioner_report_service, we need to display various information about the practitioner.
         A few examples: dea, criminal, sanctions.  To link to these key files we need to search by did. If the user 
         inputs one of the old PractitionerIDs (what was known as the Gennum), then we need to hit the CNLD key file to 
         get the related DID for the practitioner and use that to link to our key files.                                */
      practitionerDids_all := IF( isGennum,
                                  CNLD_Practitioner_Services.raw.getPractitionerDidsFromGennum( in_practitionerId ),
                                  DATASET( [ (UNSIGNED6) in_practitionerId  ], CNLD_Practitioner_Services.raw.did_rec )
                                );
      
      practitionerDids :=  DEDUP( practitionerDids_all, did);
         

      // -------------[ tempmod for dids ]---------------------------------------------------------
		  tempmod2 := 
		    MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoHeaderI.LIBIN.FetchI_Hdr_Indv.FULL, OPT ) )
			    EXPORT forceLocal := TRUE;
		      EXPORT noFail     := FALSE;
	      END;

 	    // get dids from header search
		  ds_dids := AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do( tempmod2 );       


     /* *****************************************************************************************
        *
        *              -----[ Data Source: CNLD ==> PractitionID: GENNUM ]-----
        * 
        ***************************************************************************************** */
 
       // -------------[  CNLD Payload Recs ]------------------------------------------------------
       
       /* The Practitioner ID coming into the Report could be either the old gennum or it could be a new did.
          If the practitioner id is a gennum, get the payload by the practitionerId coming into the search
          If the in_practitionerID is a DID, retreive the practitioner ID and us that to get the cnld payload.
          When the in_practitionerId is a gennum, send FALSE always in order to get results from get_cnld_payload_by_pids */              
      cnldPayload := IF( isGennum, 
                         CNLD_Practitioner_Services.raw.get_cnld_payload_by_pids( DATASET( [ in_practitionerId  ], CNLD_Practitioner_Services.raw.cnld_practitionerId_rec ), FALSE ),
                         CNLD_Practitioner_Services.raw.get_cnld_payload_by_did ( practitionerDids )
                       );
                                                                                       

      // -------------[  CNLD Additional Training Recs ]-------------------------------------------
      cnldAdditionalTraining := 
        PROJECT( cnldPayload,
                 TRANSFORM( iesp.searchpoint.t_SearchPointAdditionalMedicalTraining,
                            EndDate        := LEFT.train_enddate[1..4] + LEFT.train_enddate[9..10] + LEFT.train_enddate[6..7];
                            StartDate      := LEFT.train_startdate[1..4] + LEFT.train_startdate[9..10] + LEFT.train_startdate[6..7];
                            SELF.Category  := LEFT.traincatdesc;
                            SELF.EndDate   := iesp.ECL2ESP.toDate( (UNSIGNED)EndDate );
                            SELF.Institute := LEFT.train_institute;
                            SELF.StartDate := iesp.ECL2ESP.toDate( (UNSIGNED)StartDate );
                          )
               );
     
   
      // -------------[  CNLD Address Recs ]-------------------------------------------------------      
      CnldAddress := 
        PROJECT( CnldPayload, 
                 TRANSFORM( iesp.searchpoint.t_SearchPointAddress,
                            SELF.StreetAddress1 := Address.Addr1FromComponents( LEFT.prim_range, 
                                                                                LEFT.predir, 
                                                                                LEFT.prim_name, 
                                                                                LEFT.addr_suffix, 
                                                                                LEFT.postdir, '', '' ); 
				                    SELF.StreetAddress2 := Address.Addr1FromComponents( '', '', '', '', '', 
                                                                                LEFT.unit_desig, 
                                                                                LEFT.sec_range );
				                    SELF.City           := LEFT.p_city_name;
			                      SELF.State          := LEFT.st;
                            SELF.Zip5           := LEFT.zip; 
                            SELF.Zip4           := LEFT.zip4;
                            SELF.Fax            := IF( LENGTH(TRIM((STRING)LEFT.address_fax,LEFT,RIGHT)) = 10,
                                                       LEFT.address_fax[1..3] + '-' + LEFT.address_fax[4..6] + '-' + LEFT.address_fax[7..10],
                                                       IF( LENGTH(TRIM((STRING)LEFT.address_fax,LEFT,RIGHT)) = 7,
                                                           LEFT.address_fax[1..3] + '-' + LEFT.address_fax[4..7],
                                                           LEFT.address_fax
                                                         )
                                                     );
                            SELF.Phone          := IF( LENGTH(TRIM((STRING)LEFT.address_phone,LEFT,RIGHT)) = 10,
                                                       LEFT.address_phone[1..3] + '-' + LEFT.address_phone[4..6] + '-' + LEFT.address_phone[7..10],
                                                       IF( LENGTH(TRIM((STRING)LEFT.address_phone,LEFT,RIGHT)) = 7,
                                                           LEFT.address_phone[1..3] + '-' + LEFT.address_phone[4..7],
                                                           LEFT.address_phone
                                                         )
                                                     );
                            SELF.AddressType    := IF(LEFT.address_type = 'P',
                                                      'Practice Address',
                                                      IF(LEFT.address_type = 'U',
                                                         'Home Address',
                                                         IF(LEFT.address_type = 'B',
                                                            'Billing Address',
                                                            LEFT.address_type
                                                           )));
                            SELF.AddressRank    := LEFT.address_rank;
                            SELF                := [];
                          )
               ); 

       
      // -------------[  CNLD DEA Info ]------------------------------------------
      cnldDea := 
        PROJECT( CnldPayload,
                 TRANSFORM( iesp.searchpoint.t_SearchPointDEANumber,
                            SELF.DEAAddress.StreetAddress1 := Address.Addr1FromComponents( LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, LEFT.postdir, '' , '' ); 
				                    SELF.DEAAddress.StreetAddress2 := Address.Addr1FromComponents( '', '', '', '', '', LEFT.unit_desig, LEFT.sec_range );  
				                    SELF.DEAAddress.City           := LEFT.p_city_name;
			                      SELF.DEAAddress.State          := LEFT.st;
                            SELF.DEAAddress.Zip5           := LEFT.zip;
                            SELF.DEAAddress                := [];
                            SELF.ExpirationDate            := iesp.ECL2ESP.toDate ( (UNSIGNED)LEFT.deanbr_exp );
                            SELF.Number                    := LEFT.deanbr;  
                            SELF.Schedule                  := LEFT.deanbr_sch; // is already converted to F/T format
                            SELF                           := [];
                          )
               );
 
      // -------------[  Ingenix Education Recs ]--------------------------------------------------
      CnldEducation :=
        PROJECT( CnldPayload, 
                 TRANSFORM( iesp.searchpoint.t_SearchPointEducation,
                            SELF.Degree        := LEFT.degree;
                            SELF.School        := LEFT.schoolcode;
                            SELF.YearGraduated := LEFT.schoolyear;
                          )
               );

 
      // -------------[  CNLD NPI Info ]-----------------------------------------------------------
      // Only NPI numbers are provided by NCPDP at this time 
      CnldNPIs :=
        PROJECT( CnldPayload, 
                 TRANSFORM( { STRING npiNumber },
                            SELF.npiNumber := LEFT.npi;
                          ) 
               );
             
      // -------------[  CNLD Tax ID Info ]--------------------------------------------------------
      // Only Tax IDs are provided by NCPDP at this time 
      CnldTaxIds := 
        PROJECT( CnldPayload, 
                 TRANSFORM( { STRING PractitionerTaxID }, 
                            SELF.PractitionerTaxID := LEFT.tax_id;
                          )
               );

       
      // -------------[  CNLD Sanction Info ]------------------------------------------------------
      cnldSanction := 
        PROJECT( CnldPayload,
                 TRANSFORM( iesp.searchpoint.t_SearchPointSanction,
                            // SELF.Action         := ;  // waiting for Jason to map the fields to the CNLD data
                            // SELF.Amount         := ;
                            // SELF.Complaint      := ;
                            SELF.DocumentumID   := LEFT.sanction_docid; 
                            SELF.SanctionCase   := LEFT.sanction_case;  
                            SELF.SanctionDate   := iesp.ECL2ESP.toDate ( (UNSIGNED)LEFT.sanction_date );
                            SELF.SanctionSource := LEFT.sanction_source;
                            SELF.SanctionType   := LEFT.sanction_type;
                            SELF.State          := LEFT.sanction_state;
                            // SELF.DocumentPages  := ;  // Waiting for Jason to get back with us on how to connect real time to the web server he gets this info from
                            SELF                := []; 
                          )
                            
               );

 
      // -------------[  CNLD Specialty Info ]-----------------------------------------------------
      cnldSpecialty_all := 
        PROJECT( CnldPayload,
                 TRANSFORM( { STRING PractitionerSpecialty },
                            SELF.PractitionerSpecialty := LEFT.Specialty_Code  
                          )
               );

      cnldSpecialty_phramacist := cnldSpecialty_all(PractitionerSpecialty IN CNLD_Practitioner.Constants().CNLD_PharmacistCodes );
     
      cnldSpecialty := IF( isPharmacistSearch,
                           cnldSpecialty_phramacist,
                           cnldSpecialty_all
                         );
                          
      // -------------[  CNLD State License Info ]-------------------------------------------------
      CnldStateLicense := 
        PROJECT( CnldPayload,
                 TRANSFORM( iesp.searchpoint.t_SearchPointStateLicense,
                            SELF.ExpirationDate := iesp.ECL2ESP.toDate ( (UNSIGNED)LEFT.st_lic_num_exp );
                            SELF.Number         := LEFT.st_lic_num;
                            SELF.State          := LEFT.st_lic_in;
                            SELF.Status         := MAP( LEFT.licstatdesc = 'A'                    =>  'ACTIVE',
                                                        LEFT.licstatdesc = 'I'                    =>  'INACTIVE',
                                                        (STRING)LEFT.st_lic_num_exp != '' AND 
                                                        (STRING)LEFT.st_lic_num_exp <= ut.GetDate  =>   'INACTIVE',
                                                        (STRING)LEFT.st_lic_num_exp != '' AND 
                                                        (STRING)LEFT.st_lic_num_exp > ut.GetDate =>   'ACTIVE',
                                                                                                       LEFT.licstatdesc 
                                                       );
                            SELF._Type          := LEFT.st_lic_type;
                            SELF                := [];
                          )
               );

      // -------------[  CNLD UPIN Info ]----------------------------------------------------------
      cnldUPINs := 
        PROJECT( CnldPayload,
                 TRANSFORM( { STRING UPIN },
                             SELF.UPIN := LEFT.upin_num;
                          )
               );

 
     /* *****************************************************************************************
        *
        *                 -----[ Data Source: Ingenix ]-----
        * 
        ***************************************************************************************** */

      // -------------[ Ingenix record for Payload join ]------------------------------------------
      Ingenix_provider_id_rec := 
		    RECORD
      	  UNSIGNED6 Ingenix_provider_id;
        END;


      // -------------[  Ingenix - Get Payload // DID Key (Practitioner ID) ]----------------------
      ingenixDid := doxie_files.key_provider_did( KEYED( l_did = (UNSIGNED6) in_practitionerId ) );
 
      ingenix_provider_id_rec xfm_Ingenix_ProvIDs_fromDidKey( doxie_files.key_provider_did l) := 
		    TRANSFORM	
	        SELF.ingenix_provider_id := (UNSIGNED6) l.ProviderID;
        END;

      ingenixProvID := PROJECT( ingenixDid, xfm_Ingenix_ProvIDs_fromDidKey (LEFT) ); 
     
      ingenixPayload := 
        JOIN( IngenixProvID,
              doxie_files.key_provider_id,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ) AND
              (INTEGER) RIGHT.did != 0,
              TRANSFORM ( RIGHT ),
              INNER
            );

      
      // -------------[  Ingenix Additional Medical Training Recs ]--------------------------------      
      ingenixAdditionalTraining := DATASET( [], iesp.searchpoint.t_SearchPointAdditionalMedicalTraining );


      // -------------[  Ingenix Address Recs ]----------------------------------------------------
      // because Ingenix does not have address ranking, we are using the tier type id as the ranking value
      // Also -- since Ingenix uses 0 as no tier type available and 1 as the best ranking, when the 
      // tier type is 0, 1000 is displayed instead to allow for proper sorting of the record.
      // For more information about ingenix tier type ids, see: doxie_ING_services.convert_tierTypeIDs
      ingenixAddress := 
        PROJECT( ingenixPayload, 
                 TRANSFORM( iesp.searchpoint.t_SearchPointAddress,
                            SELF.StreetAddress1 := LEFT.address; 
				                    SELF.StreetAddress2 := LEFT.address2;  
				                    SELF.City           := LEFT.city;
			                      SELF.State          := LEFT.state;
                            SELF.Zip5           := LEFT.zip; 
                            SELF.Zip4           := LEFT.extzip;
                            SELF.Fax            := IF( LEFT.phonetype = 'Office Fax',
                                                       IF( LENGTH(TRIM(LEFT.phonenumber,LEFT,RIGHT)) = 10,
                                                           LEFT.phonenumber[1..3] + '-' + LEFT.phonenumber[4..6] + '-' + LEFT.phonenumber[7..10],
                                                           IF( LENGTH(TRIM(LEFT.phonenumber,LEFT,RIGHT)) = 7,
                                                               LEFT.phonenumber[1..3] + '-' + LEFT.phonenumber[4..7],
                                                               LEFT.phonenumber
                                                             )
                                                         ),
                                                       ''
                                                     );
                            SELF.Phone          := IF( LEFT.phonetype = 'Office Phone',
                                                       IF( LENGTH(TRIM(LEFT.phonenumber,LEFT,RIGHT)) = 10,
                                                           LEFT.phonenumber[1..3] + '-' + LEFT.phonenumber[4..6] + '-' + LEFT.phonenumber[7..10],
                                                           IF( LENGTH(TRIM(LEFT.phonenumber,LEFT,RIGHT)) = 7,
                                                               LEFT.phonenumber[1..3] + '-' + LEFT.phonenumber[4..7],
                                                               LEFT.phonenumber
                                                             )
                                                         ),
                                                       ''
                                                     );
                            SELF.AddressRank    := IF( LEFT.provideraddresstiertypeid = '0', '1000', LEFT.provideraddresstiertypeid );
                            SELF                := [];
                          )
               );
      


      // -------------[  Ingenix dea Recs ]--------------------------------------------------------
      ds_deaNumber :=
        JOIN( IngenixProvID,
              Ingenix_NatlProf.key_DEA_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ),
              TRANSFORM( dea_rec,
                         SELF.deaNumber := RIGHT.deanumber;
                       ),
              INNER
            );
             
      ingenixDea := 
        JOIN( ds_deaNumber,
              dea.Key_dea_reg_num,
              KEYED( LEFT.deaNumber = RIGHT.dea_registration_number ),
              TRANSFORM( iesp.searchpoint.t_SearchPointDEANumber,
                         SELF.DEAAddress.StreetAddress1 := Address.Addr1FromComponents( RIGHT.prim_range, RIGHT.predir, RIGHT.prim_name, RIGHT.addr_suffix, RIGHT.postdir, '' , '' ); 
				                 SELF.DEAAddress.StreetAddress2 := Address.Addr1FromComponents( '', '', '', '', '', RIGHT.unit_desig, RIGHT.sec_range );  
				                 SELF.DEAAddress.City           := RIGHT.p_city_name;
			                   SELF.DEAAddress.State          := RIGHT.st;
                         SELF.DEAAddress.Zip5           := RIGHT.zip;
                         SELF.ExpirationDate            := iesp.ECL2ESP.toDate ( (UNSIGNED)RIGHT.expiration_date );
                         SELF.Number                    := RIGHT.dea_registration_number;
                         SELF.Schedule                  := SearchPoint_Services.Functions.convertDeaSched(RIGHT.drug_schedules);
                         SELF                           := [];
                       ),
              INNER
            );
 


      // -------------[  Ingenix Education Recs ]--------------------------------------------------
      ingenixEducation_temp :=
        JOIN( IngenixProvID,
              Ingenix_NatlProf.key_medschool_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ),
              TRANSFORM( { UNSIGNED6 Ingenix_provider_id, iesp.searchpoint.t_SearchPointEducation },
                         SELF.Ingenix_provider_id := LEFT.Ingenix_provider_id;
                         SELF.School              := RIGHT.medschoolname;
                         SELF.YearGraduated       := RIGHT.graduationyear;
                         SELF                     := [];
                       ),
              INNER
           );
            
      ingenixEducation :=
        JOIN( ingenixEducation_temp,
              Ingenix_NatlProf.key_degree_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ),
              TRANSFORM( iesp.searchpoint.t_SearchPointEducation,
                         SELF.Degree := RIGHT.degree;
                         SELF        := LEFT;
                         SELF        := [];
                       ),
              INNER
            );


      // -------------[  Ingenix NPI Info ]--------------------------------------------------------
      ingenixNPIs :=
        JOIN( ingenixProvID,
              Ingenix_NatlProf.key_NPI_providerid,
              KEYED( LEFT.ingenix_provider_id = RIGHT.l_providerid ) AND RIGHT.npi != '',
              TRANSFORM( { STRING npiNumber },
                         SELF.npiNumber := RIGHT.npi;
                       ),
              INNER 
            );
             
      

      // -------------[  Sanctions ]---------------------------------------------------------------
      
      // -------------[ Sanctions record for Payload join ]----------------------------------------
      sanction_rec := 
		    RECORD
      	  STRING sanctionID;
        END;
      
      ingenixSanctionIds_all := 
        JOIN( practitionerDids,
              doxie_files.key_sanctions_did,
              KEYED( LEFT.did = RIGHT.l_did ),
              TRANSFORM( sanction_rec,
                         SELF.sanctionID := RIGHT.sanc_id;
                       ),
              INNER
            );
             
      ingenixSanction := 
        JOIN( ingenixSanctionIds_all, 
              doxie_files.key_sanctions_sancid,
              KEYED( (UNSIGNED)LEFT.sanctionID = RIGHT.l_sancid ),
              TRANSFORM( iesp.searchpoint.t_SearchPointSanction,
                         action              := IF( RIGHT.sanc_terms != '' AND RIGHT.sanc_cond != '',
                                                    RIGHT.sanc_terms + ' - ' + RIGHT.sanc_cond,
                                                    IF( RIGHT.sanc_cond = '',
                                                        RIGHT.sanc_terms,
                                                        RIGHT.sanc_cond
                                                      )
                                                  );
                         source              := IF( RIGHT.sanc_brdtype != '' AND RIGHT.sanc_src_desc != '',
                                                    RIGHT.sanc_brdtype + ' - ' + RIGHT.sanc_src_desc,
                                                    IF( RIGHT.sanc_brdtype = '',
                                                        RIGHT.sanc_src_desc,
                                                        RIGHT.sanc_brdtype
                                                      )
                                                  );
                         SELF.Action         := action;  // NOT sure if this is the correct mapping!
                         SELF.Amount         := RIGHT.sanc_fines;
                         SELF.Complaint      := RIGHT.sanc_reas;
                         SELF.DocumentumID   := ''; // Not in our data
                         SELF.SanctionCase   := RIGHT.sanc_licnbr;  // NOT sure if this is the correct mapping!!!
                         SELF.SanctionDate   := iesp.ECL2ESP.toDate ( (UNSIGNED)RIGHT.sanc_sancdte_form );
                         SELF.SanctionSource := source;
                         SELF.SanctionType   := RIGHT.sanc_type;
                         SELF.State          := RIGHT.sanc_sancst;
                         SELF                := []; // 'document pages' is not in our data
                       ),
              INNER
            );
                          
 

      // -------------[  Ingenix Specialty Info ]--------------------------------------------------
      
      ingenixSpecialty_all := 
        JOIN( ingenixProvID,
              Ingenix_NatlProf.key_speciality_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ) AND
              RIGHT.specialityname != '',
              TRANSFORM( { STRING PractitionerSpecialty },
                         SELF.PractitionerSpecialty := RIGHT.specialityname;
                       ),
              INNER
            );
      
      ingenixSpecialty_pharmacy := 
        JOIN( ingenixProvID,
              Ingenix_NatlProf.key_speciality_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ) AND
              RIGHT.specialityname != ''                             AND
              ( stringlib.StringToUpperCase(RIGHT.specialityname) = 'PHARMACOLOGY - CLINICAL' OR 
                stringlib.StringToUpperCase(RIGHT.specialityname) = 'PHARMACY' ),
              TRANSFORM( { STRING PractitionerSpecialty },
                         SELF.PractitionerSpecialty := RIGHT.specialityname;
                       ),
              INNER
            );
      
      ingenixSpecialty := IF( isPharmacistSearch,
                              ingenixSpecialty_pharmacy,
                              ingenixSpecialty_all
                            );

      // -------------[  Ingenix State License Info ]----------------------------------------------
      ingenixStateLicense := 
        JOIN( ingenixProvID,
              Ingenix_NatlProf.key_license_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ),
              TRANSFORM( iesp.searchpoint.t_SearchPointStateLicense,
                         SELF.ExpirationDate := iesp.ECL2ESP.toDate ( (UNSIGNED)RIGHT.termination_date );
                         SELF.Number         := RIGHT.licensenumber;
                         SELF.State          := RIGHT.licensestate;
                         SELF.Status         := IF( RIGHT.termination_date = '',
                                                    '',
                                                    IF( (STRING)RIGHT.termination_date < ut.GetDate,
                                                        'INACTIVE',
                                                        'ACTIVE'
                                                      )
                                                  );
                         SELF                := [];
                       ),
              INNER
            );


      // -------------[  Ingenix Tax ID Info ]-----------------------------------------------------
     ingenixTaxIds_all := 
        JOIN( practitionerDids,
              ingenixPayload,
              LEFT.did = (UNSIGNED)RIGHT.did AND
              RIGHT.taxid != '',
              TRANSFORM( { STRING PractitionerTaxID }, 
                         SELF.PractitionerTaxID := RIGHT.taxid;
                       ),
              INNER
            );

      ingenixTaxIds_deduped := 
        DEDUP( SORT( IngenixTaxIds_all, PractitionerTaxID, RECORD ), PractitionerTaxID );
      
      ingenixtaxIds := 
        ROLLUP( IngenixTaxIds_deduped,
                LEFT.PractitionerTaxID != RIGHT.PractitionerTaxID,
                TRANSFORM( { STRING PractitionerTaxID },
                           SELF.PractitionerTaxID := LEFT.PractitionerTaxID + ', ' + RIGHT.PractitionerTaxID; 
                         )
              );
      

      // -------------[  Ingenix UPIN Info ]-------------------------------------------------------
      ingenixUPINs :=
        JOIN( IngenixProvID,
              Ingenix_NatlProf.key_UPIN_providerid,
              KEYED( LEFT.Ingenix_provider_id = RIGHT.l_providerid ) AND
              RIGHT.upin != '',
              TRANSFORM( { STRING UPIN },
                         SELF.UPIN := RIGHT.upin;
                       ),
              INNER
            );
             
 
     /* *****************************************************************************************
        *
        *                    -----[ Data Source: NCPDP ]-----
        * 
        ***************************************************************************************** */

	    // -------------[  NCPDP DID Key (Practitioner ID) ]-----------------------------------------
      NcpdpDids    := NCPDP.key_DID( KEYED( did = (UNSIGNED6) in_practitionerId ) );


      // -------------[  NCPDP Payload Recs ]------------------------------------------------------
      ncpdpPayload := 
        JOIN( NcpdpDids, 
              NCPDP.key_ProviderID,
              KEYED( LEFT.ncpdp_provider_id = RIGHT.ncpdp_provider_id ),
              TRANSFORM (RIGHT),
              INNER
            );


      // -------------[  NCPDP Additional Medical Training Recs ]----------------------------------      
      ncpdpAdditionalTraining := DATASET( [], iesp.searchpoint.t_SearchPointAdditionalMedicalTraining );


      // -------------[  NCPDP Address Recs ]------------------------------------------------------    
      
      // 1000 is used because NCPDP does not rank their records and ranked records are required for output
      // Setting to 1000 to match what is being done with Ingenix when the tier type ID is not available.
      // for more information about tier type ids see: doxie_ING_services.convert_tierTypeIDs
      ncpdpAddress := 
        PROJECT( ncpdpPayload, 
                 TRANSFORM( iesp.searchpoint.t_SearchPointAddress,
                            SELF.StreetAddress1 := Address.Addr1FromComponents( LEFT.phys_prim_range, 
                                                                                LEFT.phys_predir, 
                                                                                LEFT.phys_prim_name, 
                                                                                LEFT.phys_addr_suffix, 
                                                                                LEFT.phys_postdir, '', '' ); 
				                    SELF.StreetAddress2 := Address.Addr1FromComponents( '', '', '', '', '', 
                                                                                LEFT.phys_unit_desig, 
                                                                                LEFT.phys_sec_range );
				                    SELF.City           := LEFT.phys_p_city_name;
			                      SELF.State          := LEFT.phys_state;
                            SELF.Zip5           := LEFT.phys_zip5; 
                            SELF.Zip4           := LEFT.phys_zip4;
                            SELF.Fax            := IF( LENGTH(TRIM(LEFT.phys_loc_fax_number,LEFT,RIGHT)) = 10,
                                                       LEFT.phys_loc_fax_number[1..3] + '-' + LEFT.phys_loc_fax_number[4..6] + '-' + LEFT.phys_loc_fax_number[7..10],
                                                       IF( LENGTH(TRIM(LEFT.phys_loc_fax_number,LEFT,RIGHT)) = 7,
                                                           LEFT.phys_loc_fax_number[1..3] + '-' + LEFT.phys_loc_fax_number[4..7],
                                                           LEFT.phys_loc_fax_number
                                                         )
                                                     );
                            SELF.Phone          := IF( LENGTH(TRIM(LEFT.phys_loc_phone,LEFT,RIGHT)) = 10,
                                                       LEFT.phys_loc_phone[1..3] + '-' + LEFT.phys_loc_phone[4..6] + '-' + LEFT.phys_loc_phone[7..10],
                                                       IF( LENGTH(TRIM(LEFT.phys_loc_phone,LEFT,RIGHT)) = 7,
                                                           LEFT.phys_loc_phone[1..3] + '-' + LEFT.phys_loc_phone[4..7],
                                                           LEFT.phys_loc_phone
                                                         )
                                                     );
                            SELF.AddressType    := 'PHYSICAL';  // set to physical address because we are returning the phys addr to the cust.
                            SELF.AddressRank    := '1000'; 
                            SELF                := [];
                          )
               ); 


      // -------------[  NCPDP DEA Info ]----------------------------------------------------------
      ncpdpDea := 
        PROJECT( ncpdpPayload,
                 TRANSFORM( iesp.searchpoint.t_SearchPointDEANumber,
                            SELF.DEAAddress.StreetAddress1 := Address.Addr1FromComponents( LEFT.phys_prim_range, LEFT.phys_predir, LEFT.phys_prim_name, LEFT.phys_addr_suffix, LEFT.phys_postdir, '' , '' ); 
				                    SELF.DEAAddress.StreetAddress2 := Address.Addr1FromComponents( '', '', '', '', '', LEFT.phys_unit_desig, LEFT.phys_sec_range );  
				                    SELF.DEAAddress.City           := LEFT.phys_p_city_name;
			                      SELF.DEAAddress.State          := LEFT.phys_state;
                            SELF.DEAAddress.Zip5           := LEFT.phys_zip5;
                            SELF.Number                    := LEFT.dea_registration_id;
                            SELF                           := [];
                          )
               );
      
      
      // -------------[  NCPDP Education Info ]----------------------------------------------------
      ncpdpEducation := DATASET( [], iesp.searchpoint.t_SearchPointEducation );
      
      
      // -------------[  NCPDP NPI Info ]----------------------------------------------------------
      ncpdpNPIs :=
        PROJECT( ncpdpPayload,
                 TRANSFORM( { STRING npiNumber },
                            SELF.npiNumber := LEFT.national_provider_id;
                          ) 
               );
             
            
      // -------------[  NCPDP Sanction Info ]-----------------------------------------------------
      ncpdpSanction := DATASET( [], iesp.searchpoint.t_SearchPointSanction );


      // -------------[  NCPDP Specialty Info ]----------------------------------------------------
      // No specialty information is provided by NCPDP at this time (20121204)
      ncpdpSpecialty := DATASET( [], { STRING PractitionerSpecialty } );
        
                           
      // -------------[  NCPDP State License Info ]------------------------------------------------
      // Only the license number is provided by NCPDP at this time
      ncpdpStateLicense := 
        PROJECT( ncpdpPayload,
                 TRANSFORM( iesp.searchpoint.t_SearchPointStateLicense,
                            SELF.Number         := LEFT.state_license_number;
                            SELF.State          := LEFT.phys_state;
                            SELF                := [];
                          )
               );


      // -------------[  NCPDP Tax ID Info ]-------------------------------------------------------
     ncpdpTaxIds := 
        PROJECT( ncpdpPayload,
                 TRANSFORM( { STRING PractitionerTaxID }, 
                            SELF.PractitionerTaxID := LEFT.state_income_tax_id;
                          )
               );

      
      // -------------[  NCPDP UPIN Info ]---------------------------------------------------------
      // No UPINs are provided by NCPDP at this time
      ncpdpUPINs :=
        PROJECT( ncpdpPayload,
                 TRANSFORM( { STRING UPIN }, 
                            SELF.UPIN := LEFT.federal_tax_id;
                          )
               );

     /* *****************************************************************************************
        *
        *                    -----[ PractitionID: DID ==> Mac_best_records ]-----
        * 
        ***************************************************************************************** */
				
			gm := AutoStandardI.GlobalModule();

      doxie.mac_best_records( practitionerDids, did, ds_best_outfile, TRUE, ut.glb_ok(gm.GLBPurpose), , 'FALSE' );  
   
      // for dids not in best records but found only in DEA records bug# 131657
      ds_dea_outfile := JOIN(practitionerDids,DEA.key_DEA_did,
                        KEYED(LEFT.did=RIGHT.my_did),
                        TRANSFORM(doxie.layout_best,
                          SELF.did:=(UNSIGNED)RIGHT.did,
                          SELF.ssn:=RIGHT.best_ssn,
                          SELF.city_name:=RIGHT.p_city_name,
                          SELF:=RIGHT,SELF:=[]),
                        LEFT OUTER,LIMIT(100,SKIP));
   
      /* We need to return the best name information, getting the dob, ssn and name information from 
         doxie.mac_best_records from the practitioner ID when it is no zero.
         We are not using address information from mac_best_records because it contains the practitioners 
         home address not their business location.  
         The user may enter an old practitioner ID (Gennum) that we do not have a did for. In this case, 
         the Practitioner ID is set to the input practitioner id and the name information is taken from 
         CNLD file. */
      practitionerNonZeroDids := IF(EXISTS(ds_best_outfile),ds_best_outfile(did!=0),ds_dea_outfile);
      cnldBestData :=
        PROJECT( cnldPayload,
                 TRANSFORM( iesp.searchpoint.t_practitioner,
                            SELF.DateOfBirth       := iesp.ECL2ESP.toDate ( (UNSIGNED4)LEFT.dob );
                            SELF.PractitionerId    := IF( LEFT.did = 0,
                                                          LEFT.gennum,
                                                          (STRING) LEFT.did
                                                        );
                            SELF.Name.First        := LEFT.fname;
                            SELF.Name.Middle       := LEFT.mname;
                            SELF.Name.Last         := LEFT.lname;
                            SELF.Name.Suffix       := LEFT.name_suffix;
                            SELF.Name.Prefix       := LEFT.title;
                            SELF.Gender            := SearchPoint_Services.Functions.convertTitle( LEFT.title );    // using name title 
                            SELF.SSN               := LEFT.ssn;
                            SELF                   := [];
                          )
               );
      
      bestData := 
        PROJECT( practitionerNonZeroDids,
                 TRANSFORM( iesp.searchpoint.t_practitioner,
                            SELF.DateOfBirth       := iesp.ECL2ESP.toDate ( (UNSIGNED4)LEFT.dob );
                            SELF.DateOfDeath       := iesp.ECL2ESP.toDate ( (UNSIGNED4)LEFT.dod );
                            SELF.PractitionerId    := IF( LEFT.did = 0,
                                                          in_practitionerid,
                                                          (STRING) LEFT.did
                                                        );
                            SELF.Name.First        := LEFT.fname;
                            SELF.Name.Middle       := LEFT.mname;
                            SELF.Name.Last         := LEFT.lname;
                            SELF.Name.Suffix       := LEFT.name_suffix;
                            SELF.Name.Prefix       := LEFT.title;
                            SELF.Gender            := SearchPoint_Services.Functions.convertTitle( LEFT.title );    // using name title 
                            SELF.SSN               := LEFT.ssn;
                            SELF                   := [];
                          )
               );
      
      

     /* *****************************************************************************************
        *
        *       -----[ Check for Parent Data. I.E. Bankruptcy, Judgments & Liens, Status ]-----
        * 
        ***************************************************************************************** */

      // If there's a hit in the file, return Yes flag for criminalHistory 
      checkForBankruptcy_best := 
        JOIN( bestData,
              BankruptcyV3.key_bankruptcyv3_did(),
              KEYED( (UNSIGNED)LEFT.PractitionerId = RIGHT.did ),
              TRANSFORM( iesp.searchpoint.t_practitioner,
                         SELF.BankruptcyLienJudgementHistory := IF( (UNSIGNED)LEFT.PractitionerID = RIGHT.did,
                                                                    'YES',
                                                                    'NO'
                                                                  );
                         SELF                                := LEFT;
                         SELF                                := [];
                      ),
              LEFT OUTER, KEEP( 1 )
            );
     
      checkForLienJudgements_bestBankruptcy := 
        JOIN( checkForBankruptcy_best,
              LiensV2.key_liens_DID,
              KEYED( (UNSIGNED)LEFT.PractitionerId = RIGHT.did ),
              TRANSFORM( iesp.searchpoint.t_practitioner,
                         SELF.BankruptcyLienJudgementHistory := IF( LEFT.BankruptcyLienJudgementHistory = 'Yes' OR (UNSIGNED)LEFT.PractitionerID = RIGHT.did,
                                                                    'YES',
                                                                    'NO'
                                                                  );
                         SELF                                := LEFT;
                         SELF                                := [];
                       ),
              LEFT OUTER, KEEP( 1 )
            );
      
      checkForCriminalHistory_bestBnkLienJud := 
        JOIN( checkForLienJudgements_bestBankruptcy,
              doxie_files.Key_Offenders(),
              KEYED( (UNSIGNED) LEFT.PractitionerId = RIGHT.sdid ),
              TRANSFORM( iesp.searchpoint.t_practitioner,
                         SELF.CriminalHistory := IF( (UNSIGNED6)LEFT.PractitionerID = RIGHT.sdid,
                                                     'YES',
                                                     'NO'
                                                   );
                         SELF                 := LEFT;
                         SELF                 := [];
                       ),
              LEFT OUTER, KEEP( 1 )
            );

      // add Gennum to the dataset to the CNLD payload to pick up the status and type
      addCnldGennum :=
        JOIN( checkForCriminalHistory_bestBnkLienJud,
              CNLD_Practitioner.key_DID,
              KEYED( (UNSIGNED) LEFT.PractitionerId = RIGHT.did ),
              TRANSFORM( {iesp.searchpoint.t_practitioner, STRING gennum},
                         SELF.gennum := RIGHT.gennum;
                         SELF        := LEFT;
                         SELF        := [];
                       ), 
              LEFT OUTER
            );
     
      addCnldDataToDidRecs := 
        JOIN( addCnldGennum,
              CNLD_Practitioner.key_PractitionerID,
              KEYED( LEFT.gennum = RIGHT.gennum ),
              TRANSFORM( iesp.searchpoint.t_practitioner,
                         SELF.PractitionerStatus := IF(RIGHT.profstat = 'A',
                                                       'ACTIVE',
                                                       IF(RIGHT.profstat = 'I', 
                                                          'INACTIVE',
                                                          RIGHT.profstat
                                                         ));
                         SELF.PractitionerType   := RIGHT.prescribertype;
                         SELF                    := LEFT;
                         SELF                    := [];
                       ), 
              LEFT OUTER
            );
     
      addFields2CnldData := 
        JOIN( cnldBestData,
              CNLD_Practitioner.key_PractitionerID,
              KEYED( LEFT.PractitionerId = RIGHT.gennum ),
              TRANSFORM( iesp.searchpoint.t_practitioner,
                         SELF.PractitionerStatus := IF(RIGHT.profstat = 'A',
                                                       'ACTIVE',
                                                       IF(RIGHT.profstat = 'I', 
                                                          'INACTIVE',
                                                          RIGHT.profstat
                                                         ));
                         SELF.PractitionerType   := RIGHT.prescribertype;
                         SELF                    := LEFT;
                         SELF                    := [];
                       ), 
              LEFT OUTER
            );

      mainFields        := addCnldDataToDidRecs + addFields2CnldData;
      
      mainFields_deduped := 
        DEDUP( mainFields, RECORD, ALL );
      mainFields_sorted := 
        SORT( mainFields, -ssn );  // sorting by -ssn gives us the record from the best key lookup first
                                   // The legacy system only outputs one record, this sort gives our
                                   // best record output.  
                          
      

     /* *****************************************************************************************
        *
        *                        -----[ Datasets for Output ]-----
        * 
        ***************************************************************************************** */


      // -------------[  Additional Medical Training   ]-------------------------------------
      additionalTraining_all    := CnldAdditionalTraining + ingenixAdditionalTraining + NcpdpAdditionalTraining;
      additionalTraining :=
        DEDUP( SORT( additionalTraining_all, -EndDate, Institute, Category, StartDate, RECORD ), 
               EndDate.Year, Institute, Category, StartDate.Year );
               
 
      // -------------[  Address Locations   ]-----------------------------------------------------
      // Sorting by all fields output with the exception of address 2 (because that is not always populated), 
      // phone and fax.  This will keep all the same street address records together for the rollup
      Address_sorted :=
         DEDUP( SORT( CnldAddress + IngenixAddress + NcpdpAddress, StreetAddress1, City, State, Zip5, RECORD ), ALL);
         
      /* During the rollup, keeping the addresses with the lowest Address Rank
         At the time of the first release, we are only allowed to output 6 addresses.  Adding rules to 
         rollup as many of the addresses at the same address as possible in order to give the customer
         the max number of varying addresses as possible.                                               */
      Address_rollup :=
        ROLLUP( Address_sorted,
                LEFT.StreetAddress1 = RIGHT.StreetAddress1 AND
                LEFT.City           = RIGHT.City AND
                LEFT.State          = RIGHT.State AND
                LEFT.Zip5           = RIGHT.Zip5,
                TRANSFORM( iesp.searchpoint.t_SearchPointAddress,
                           SELF.StreetAddress1 := LEFT.StreetAddress1; 
				                   SELF.StreetAddress2 := IF( LENGTH( TRIM( LEFT.StreetAddress2, LEFT, RIGHT ) ) > LENGTH( TRIM( RIGHT.StreetAddress2, LEFT, RIGHT ) ),
                                                      LEFT.StreetAddress2, 
                                                      RIGHT.StreetAddress2
                                                    );  
				                   SELF.City           := LEFT.City;
			                     SELF.State          := LEFT.State;
                           SELF.Zip5           := LEFT.Zip5; 
                           SELF.Zip4           := IF( LENGTH( TRIM( LEFT.Zip4, LEFT, RIGHT ) ) > LENGTH( TRIM( RIGHT.Zip4, LEFT, RIGHT ) ),
                                                      LEFT.Zip4, 
                                                      RIGHT.Zip4
                                                    );
                            SELF.Fax            := IF( LEFT.Fax != '',
                                                       LEFT.Fax,
                                                       RIGHT.Fax
                                                      );
                            SELF.Phone          := IF( LEFT.Phone != '',
                                                       LEFT.Phone,
                                                       RIGHT.Phone
                                                      );
                            SELF.addressType    := IF( LEFT.addressType = '', RIGHT.addressType, LEFT.addressType);
                            SELF.addressRank    := IF( LEFT.addressRank = '' OR (UNSIGNED)LEFT.addressRank > (UNSIGNED)RIGHT.addressRank,
                                                       RIGHT.addressRank,
                                                       LEFT.addressRank
                                                     );
                            SELF                := [];
                         )
              );
 
      // the previous rollup adds a blank row as the first record.  Removing that first blank record below in the sort.
      // NOTE TO SELF -- must adjust the tier type ID for ingenix for ranking
      address_rollup_sorted_by_tiertype := 
        SORT( Address_rollup[2..], (UNSIGNED)addressRank, RECORD );
        
      addrLayout := 
        PROJECT( address_rollup_sorted_by_tiertype, 
                 TRANSFORM( iesp.searchpoint.t_SearchPointAddress,
                            SELF.addressRank := IF( LEFT.addressRank = '1000', '0', LEFT.addressRank );
                            SELF := LEFT;
                            SELF := [];
                          )
               );
               
      /* At the time of the release we are only allowed to give the customer 6 addresses.
         Also at the time of the release, there is no available fields in the data to preform
         address ranking for Ingenix and NCPDP. The address rank from CNLD is used. The address
         rank for Ingenix is the tier type ID, and 0 is entered for NCPDP (because there is no
         ranking available in NCPDP data.  Once the sort is done, I am taking the first 
         6 due to the lack of ranking fields in the data at the time of the release.  
         There are fields available in Ingenix and work is in progress to have those
         fields exposed in the base/key files.                                                 */
      Address := addrLayout[1..6];

 
      // -------------[  DEA  ]--------------------------------------------------------------------
      dea_all := cnldDea + ingenixDea + ncpdpDea;
      
      dea_sorted := 
        SORT( dea_all,
              Number,
              DEAAddress.StreetAddress1,
              DEAAddress.City,
              DEAAddress.State,
              DEAAddress.Zip5,
              Schedule,
              RECORD
            );
               
      
      // rollup duplicate addresses with the same DEA number and schedule
      dea_rollup := 
        ROLLUP( dea_sorted, 
                LEFT.Number = RIGHT.Number AND
                LEFT.Schedule = RIGHT.Schedule AND
                LEFT.DEAAddress.StreetAddress1 = RIGHT.DEAAddress.StreetAddress1 AND
                LEFT.DEAAddress.City = RIGHT.DEAAddress.City,
                TRANSFORM( iesp.searchpoint.t_SearchPointDEANumber,
                           SELF.DEAAddress.StreetAddress2 := IF( LENGTH( TRIM( LEFT.DEAAddress.StreetAddress2, LEFT, RIGHT ) ) > LENGTH( TRIM( RIGHT.DEAAddress.StreetAddress2, LEFT, RIGHT ) ),
                                                                 LEFT.DEAAddress.StreetAddress2, 
                                                                RIGHT.DEAAddress.StreetAddress2
                                                               );
                           SELF.ExpirationDate            := MAP( LEFT.ExpirationDate.year   > RIGHT.ExpirationDate.year  => LEFT.ExpirationDate,
                                                                  RIGHT.ExpirationDate.year  > LEFT.ExpirationDate.year   => RIGHT.ExpirationDate,
                                                                  LEFT.ExpirationDate.month  > RIGHT.ExpirationDate.month => LEFT.ExpirationDate,
                                                                  RIGHT.ExpirationDate.month > LEFT.ExpirationDate.month  => RIGHT.ExpirationDate,
                                                                  LEFT.ExpirationDate.day    > RIGHT.ExpirationDate.day   => LEFT.ExpirationDate,
                                                                  RIGHT.ExpirationDate.day   > LEFT.ExpirationDate.day    => RIGHT.ExpirationDate,
                                                                  /* default */                                              LEFT.ExpirationDate
                                                                );
                           SELF                           := LEFT;
                         )
             );
                             
      // the previous rollup adds a blank row as the first record.  Removing that first blank record below in the sort.
      dea_sort_rollup := 
        SORT( dea_rollup[2..], -ExpirationDate, RECORD ); 
      
      // at the time release, I was only to return 10 dea records -- limit below.
      dea := dea_sort_rollup[1..10];                  
           

      // -------------[  Education  ]--------------------------------------------------------------
      Education_all := cnldEducation + ingenixEducation + ncpdpEducation;
      
      Education :=
        DEDUP( SORT( Education_all, -YearGraduated, School, Degree, RECORD ), 
               YearGraduated, School, Degree  );
                
      // -------------[  NPI    ]------------------------------------------------------------------
      NPIs_all           := CnldNPIs + IngenixNPIs + NcpdpNPIs;
      NPIs_all_non_blank := NPIs_all(npiNumber != '');
      
      NPIs_deduped := 
        DEDUP( SORT( NPIs_all_non_blank, npiNumber, RECORD ), npiNumber );
               
      NPIs := 
        ROLLUP( NPIs_deduped,
                LEFT.npiNumber != RIGHT.npiNumber,
                TRANSFORM( { STRING npiNumber },
                           SELF.npiNumber := IF( LEFT.npiNumber = '', 
                                                 RIGHT.npiNumber, 
                                                 LEFT.npiNumber + ', ' + RIGHT.npiNumber 
                                               ); 
                         )
              );             
 

      // -------------[  Sanctions  ]--------------------------------------------------------------
      sanction_all := cnldSanction + ingenixSanction + ncpdpSanction;
      
      sanction_sorted := 
        DEDUP( SORT( sanction_all, -SanctionDate, State, SanctionCase, Action, SanctionSource, SanctionType, 
                     Complaint, Amount, DocumentumId, DocumentPages, RECORD  ), 
               SanctionDate.Year, State, SanctionCase, Action, SanctionSource, SanctionType, Complaint, 
               Amount, DocumentumId, DocumentPages );
       
      
      // at the time of the initial release we were only to output 10 Sanction records
      sanction := sanction_sorted[1..10];             
      
       
     // --------------[  Specialty    ]------------------------------------------------------------
      specialty_all           := cnldSpecialty + ingenixSpecialty + ncpdpSpecialty;
      specialty_all_non_blank := specialty_all( PractitionerSpecialty != '');

      specialty_deduped := 
        DEDUP( SORT( specialty_all_non_blank, PractitionerSpecialty, RECORD ),  PractitionerSpecialty );
              
      // 20120626 Per Jason Ding, we are only to return the fist five specialties.
      specialty_deduped_keepFive := specialty_deduped[1..5];
      
      PractitionerSpecialty := 
        ROLLUP( specialty_deduped_keepFive,
                LEFT.PractitionerSpecialty != RIGHT.PractitionerSpecialty,
                TRANSFORM( { STRING PractitionerSpecialty },
                           SELF.PractitionerSpecialty := IF( LEFT.PractitionerSpecialty = '', 
                                                             RIGHT.PractitionerSpecialty, 
                                                             IF( RIGHT.PractitionerSpecialty != '',
                                                                 LEFT.PractitionerSpecialty + ', ' + RIGHT.PractitionerSpecialty,
                                                                 LEFT.PractitionerSpecialty
                                                               )
                                                           ); 
                         )
              );
                          
  
      // -------------[  State License   ]---------------------------------------------------------
      StateLicense_all           := cnldStateLicense + IngenixStateLicense + ncpdpStateLicense;
      StateLicense_all_non_blank := StateLicense_all( Number != '');
      
      // Sort by date most recent first
      StateLicense_sorted := 
        DEDUP( SORT( StateLicense_all_non_blank, -ExpirationDate, Number, State, Status, _Type, RECORD ), 
               ExpirationDate.Year, Number, State, Status, _Type);
      
      // At the time of the initial release, we were only to output 10 State license records
      StateLicense := StateLicense_sorted[1..10];
                

      // -------------[  Tax IDs   ]---------------------------------------------------------------
      TaxIds_all           := cnldTaxIds + ingenixTaxIds + ncpdpTaxIds;
      TaxIds_all_non_blank := TaxIds_all( PractitionerTaxID != '');
      
      // 20120626 Per Jason Ding, we are only to return the fist three tax IDs.
      TaxIds_deduped := 
        DEDUP( SORT( TaxIds_all_non_blank, PractitionerTaxID, RECORD ), PractitionerTaxID )[1..3];
               
      
      TaxIds := 
        ROLLUP( TaxIds_deduped,
                LEFT.PractitionerTaxID != RIGHT.PractitionerTaxID,
                TRANSFORM( { STRING PractitionerTaxID },
                           SELF.PractitionerTaxID := IF( LEFT.PractitionerTaxID = '', RIGHT.PractitionerTaxID, LEFT.PractitionerTaxID + ', ' + RIGHT.PractitionerTaxID ); 
                         )
              );
 
 
      // -------------[  UPINs   ]-----------------------------------------------------------------
      UPINs_all      := cnldUPINs + IngenixUPINs + ncpdpUPINs;
      UPINs_nonblank := UPINS_all(UPIN != '');
      
      UPINs_deduped := 
        DEDUP( SORT( UPINs_nonblank, UPIN, RECORD ), 
               UPIN );
      
      UPINs := 
        ROLLUP( UPINs_deduped,
                LEFT.UPIN != RIGHT.UPIN,
                TRANSFORM( { STRING UPIN },
                           SELF.UPIN := IF( LEFT.UPIN = '', RIGHT.UPIN, LEFT.UPIN + ', ' + RIGHT.UPIN ); 
                         )
              );             

 
     /* *****************************************************************************************
        *
        *                    -----[ Transform to Final IESP Layout ]-----
        * 
        ***************************************************************************************** */
      
      iesp.searchpoint.t_Practitioner xfm_to_practitioner_layout( iesp.searchpoint.t_Practitioner l ) :=
		    TRANSFORM
			    SELF.BankruptcyLienJudgementHistory             := l.BankruptcyLienJudgementHistory;
 			    SELF.AddressList                                := Address;
			    SELF.CriminalHistory                            := l.CriminalHistory;
			    SELF.DateOfBirth                                := l.DateOfBirth;
			    SELF.DateOfDeath                                := l.DateOfDeath;
			    SELF.PractitionerId                             := l.PractitionerId;
			    SELF.Name                                       := l.Name;
			    SELF.Gender                                     := l.Gender;
          SELF.PractitionerAdditionalMedicalTrainingList  := additionalTraining;
			    SELF.PractitionerDEANumberList                  := dea;
			    SELF.PractitionerEducationList                  := Education;
			    SELF.PractitionerSpecialty                      := PractitionerSpecialty[1].PractitionerSpecialty;
			    SELF.PractitionerStateLicenseList               := StateLicense;
			    SELF.PractitionerTaxID                          := taxIds[1].PractitionerTaxID;
			    SELF.PractitionerType                           := l.practitionerType;
			    SELF.PractitionerSanctionList                   := sanction;
			    SELF.PractitionerStatus                         := IF(l.practitionerStatus = 'A',
                                                                'ACTIVE',
                                                                IF(l.practitionerStatus = 'I', 
                                                                   'INACTIVE',
                                                                   l.practitionerStatus
                                                                  ));
			    SELF.SSN                                        := l.ssn;
			    SELF.Upin                                       := UPINs[1].upin;
			    SELF.NpiNumber                                  := NPIs[1].NpiNumber;
          SELF                                            := [];
		    END;
      
      Results  := PROJECT( mainFields_sorted, xfm_to_practitioner_layout (LEFT) ); 
      RETURN Results;

    END;
END;  