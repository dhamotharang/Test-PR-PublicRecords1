
IMPORT Address, AMS, AutoKeyI, AutoStandardI, Doxie, doxie_files, 
       NPPES, prof_LicenseV2_Services, ut;
	
	// The following module defines a group of attributes that obtain data specifically to backfill
	// Ingenix records retrieved by doxie.ING_provider_report_records. There are about a half dozen
	// attributes strewn across our code repository that call doxie.ING_provider_report_records, but
	// not all of them need to have AMS data added. So, it makes the most sense at this point to 
	// backfill optionally the Ingenix records here.
EXPORT mod_AMS_backfill := MODULE


	EXPORT get_AMS_ids(AMS.Interfaces.params aInputData) := 
		FUNCTION

       doxie.MAC_Header_Field_Declare() 
       
 			// Get AMS_IDs from a variety of input:
      // autokey module for AMS data
      AMS_tempmod := 
	      MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
	        EXPORT STRING autokey_keyname_root := AMS._Constants().AUTOKEY_NAME;
		      EXPORT STRING typestr              := AMS._Constants().TYPE_STR;
		      EXPORT SET OF STRING1 get_skip_set := AMS._Constants().autokey_buildskipset;
		      EXPORT BOOLEAN workHard            := AMS._Constants().WORK_HARD;
		      EXPORT BOOLEAN noFail              := AMS._Constants().NO_FAIL;
		      EXPORT BOOLEAN useAllLookups       := AMS._Constants().USE_ALL_LOOKUPS;
	      END;
		
      
		   // AMS fdids
    	ams_fdids        := AutoKeyI.AutoKeyStandardFetch( AMS_tempmod ).ids;
         
      byAutokey        := AMS_Services.raw.get_ams_pids_by_fdids( ams_fdids );
			byDID            := IF( aInputData.did = (UNSIGNED6)did_value, AMS_Services.raw.get_ams_pids_by_did(aInputData.did), AMS_Services.raw.get_ams_pids_by_did(aInputData.did) + AMS_Services.raw.get_ams_pids_by_did((UNSIGNED6)did_value)); 
			byBDID           := AMS_Services.raw.get_ams_pids_by_bdid(aInputData.bdid); 
			byTaxID          := AMS_Services.raw.get_ams_pids_by_taxid(aInputData); 
			byNPI            := AMS_Services.raw.get_ams_pids_by_npi(aInputData.npi);                                    
			byLicenseNumber  := AMS_Services.raw.get_ams_pids_by_lic(aInputData.licensenumber, aInputData.licensestate); 
			byProviderID     := AMS_Services.raw.get_ams_pids_by_ING_pid(aInputData.providerid);
			by_dsProviderIDs := AMS_Services.raw.get_ams_pids_by_ING_pids(aInputData.prov_ids);

			ams_ids_untyped  := DEDUP( SORT( byAutokey + byDID + byBDID + byTaxID + byNPI + byLicenseNumber + byProviderID + by_dsProviderIDs, ams_id ), ams_id );
			ams_ids          := PROJECT(ams_ids_untyped, AMS.Layouts.ams_id_rec);
			
			RETURN ams_ids;
		END;
		
	EXPORT AMS_datasets( DATASET(AMS.Layouts.ams_id_rec) ams_ids = DATASET([],AMS.Layouts.ams_id_rec) ) := 
		MODULE

			// Now obtain the various attributes belonging to a medical professional.
			EXPORT ams_main_raw           := AMS_Services.raw.get_ams_mainPayload_by_pids( ams_ids ); 
			EXPORT ams_state_licenses_raw := AMS_Services.raw.get_ams_stateLicense_by_pids( ams_ids );
			SHARED ams_id_numbers_raw     := AMS_Services.raw.get_ams_deaNpiPayload_by_pids( ams_ids );		
			SHARED ams_degrees_raw        := AMS_Services.raw.get_ams_degreePayload_by_pids( ams_ids );		
			SHARED ams_credentials_raw    := AMS_Services.raw.get_ams_credentialPayload_by_pids( ams_ids );		
			SHARED ams_affiliations_raw   := AMS_Services.raw.get_ams_affiliationPayload_by_pids( ams_ids )(record_type = AMS._Constants().CURRENT AND rawfields.affil_status = AMS._Constants().ACTIVE AND isparent = FALSE);
			SHARED ams_specialties_raw    := AMS_Services.raw.get_ams_specialtyPayload_by_pids( ams_ids );
			
			// Define exportable attributes specifically suited to meet the needs of backfilling
			// HealthCare_Provider_Services.Provider_Records.

     
			EXPORT AMS_address := 
				PROJECT(
					ams_main_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_addr_rpt_rec,
            SELF.Prov_Clean_prim_range     := LEFT.clean_company_address.prim_range;
		        SELF.Prov_Clean_predir         := LEFT.clean_company_address.predir;
		        SELF.Prov_Clean_prim_name      := LEFT.clean_company_address.prim_name;
		        SELF.Prov_Clean_addr_suffix    := LEFT.clean_company_address.addr_suffix;
		        SELF.Prov_Clean_postdir        := LEFT.clean_company_address.postdir;
		        SELF.Prov_Clean_unit_desig     := LEFT.clean_company_address.unit_desig;
		        SELF.Prov_Clean_sec_range      := LEFT.clean_company_address.sec_range;
		        SELF.Prov_Clean_p_city_name    := LEFT.clean_company_address.p_city_name;
		        SELF.Prov_Clean_v_city_name    := LEFT.clean_company_address.v_city_name;
		        SELF.Prov_Clean_st             := LEFT.clean_company_address.st;
		        SELF.Prov_Clean_zip            := LEFT.clean_company_address.zip;
		        SELF.Prov_Clean_zip4           := LEFT.clean_company_address.zip4;
		        SELF.ProviderAddressTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE;
		        SELF.prov_Clean_geo_lat        := LEFT.clean_company_address.geo_lat;
		        SELF.prov_Clean_geo_long       := LEFT.clean_company_address.geo_long;
		        SELF.phone                     := DATASET( [ { LEFT.clean_phones.phone, 'Office Phone', AMS._Constants().NO_TIER_TYPE_AVAILABLE },
												                                 { LEFT.clean_phones.fax,   'Office Fax',   AMS._Constants().NO_TIER_TYPE_AVAILABLE } 
										                                   ], 
											                                 doxie.ingenix_provider_module.ingenix_phone_slim_rec 
										                                 );
					)
				);	

			EXPORT dea_numbers := 
				PROJECT(
					ams_id_numbers_raw(src_cd_desc = 'DEA'),
					TRANSFORM( doxie.ingenix_provider_module.ingenix_dea_rec,
						SELF.DEANumber           := LEFT.rawfields.indy_id,
						SELF.DEANumberTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE,
						SELF.expiration_date     := LEFT.rawfields.indy_id_end_date;
					)
				);	
				
			EXPORT degrees := 
				PROJECT(
					ams_degrees_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_degree_rec,
						SELF.Degree           := LEFT.rawfields.degree,
						SELF.DegreeTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE
					)
				);
			
			EXPORT dob := 
				PROJECT(
					ams_main_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_dob_rec,
						SELF.BirthDate           := LEFT.rawdemographicsfields.dob_date,
						SELF.BirthDateTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE
					)
				);

			EXPORT group_affiliations := 
				JOIN(
					ams_affiliations_raw(rawfields.affil_type != AMS._Constants().PROVIDER_TO_HOSPITAL),
					ams.keys().main.amsid.qa,
					KEYED(LEFT.ams_other_id = RIGHT.ams_id),
					TRANSFORM( doxie.ingenix_provider_module.ingenix_group_rec,
						SELF.BDID                := (STRING12)RIGHT.bdid;
						SELF.GroupName           := RIGHT.rawdemographicsfields.acct_name,
						SELF.GroupNameTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE,
						SELF.Address             := Address.Addr1FromComponents(RIGHT.clean_company_address.prim_range, RIGHT.clean_company_address.predir, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.addr_suffix, RIGHT.clean_company_address.postdir, RIGHT.clean_company_address.unit_desig, RIGHT.clean_company_address.sec_range),
						SELF.City                := RIGHT.clean_company_address.p_city_name, 
						SELF.State               := RIGHT.clean_company_address.st, 
						SELF.Zip                 := RIGHT.clean_company_address.zip
					), INNER
				);
			
			EXPORT hospital_affiliations := 
				JOIN(
					ams_affiliations_raw(rawfields.affil_type = AMS._Constants().PROVIDER_TO_HOSPITAL),
					ams.keys().main.amsid.qa,
					KEYED(LEFT.ams_other_id = RIGHT.ams_id),
					TRANSFORM( doxie.ingenix_provider_module.ingenix_hospital_rec,
						SELF.BDID                   := (STRING12)RIGHT.bdid,
						SELF.HospitalName           := RIGHT.rawdemographicsfields.acct_name,
						SELF.HospitalNameTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE,
						SELF.Address                := Address.Addr1FromComponents(RIGHT.clean_company_address.prim_range, RIGHT.clean_company_address.predir, RIGHT.clean_company_address.prim_name, RIGHT.clean_company_address.addr_suffix, RIGHT.clean_company_address.postdir, RIGHT.clean_company_address.unit_desig, RIGHT.clean_company_address.sec_range),
						SELF.City                   := RIGHT.clean_company_address.p_city_name, 
						SELF.State                  := RIGHT.clean_company_address.st, 
						SELF.Zip                    := RIGHT.clean_company_address.zip
					), INNER
				);
				
			EXPORT name := 
				PROJECT(
					ams_main_raw,
					TRANSFORM( doxie.ingenix_provider_module.ING_NPPES_name_rec,
            comma_b4_credential         := stringlib.StringFind( LEFT.rawdemographicsfields.full_name, ',', 1); // find the position of the comma before the credential text (MD, LPN, etc).  We can then strip the remaining text out of the field as the credential for the record.
            SELF.Prov_Name_Prefix_Text  := LEFT.clean_name.title,
            SELF.Prov_Clean_fname       := LEFT.clean_name.fname,
            SELF.Prov_Clean_mname       := LEFT.clean_name.mname,
            SELF.Prov_Clean_lname       := LEFT.clean_name.lname;
            SELF.Prov_Clean_name_suffix := LEFT.clean_name.name_suffix,
            SELF.Prov_Credential_Text   := IF( comma_b4_credential > 0, TRIM( LEFT.rawdemographicsfields.full_name[comma_b4_credential+2..60], RIGHT),''), // full_name is defined as a string -- selected 60 figuring that if all three names were 15 characters long, 55 should cover all fields
            SELF.ProviderNameTierID     := AMS._Constants().NO_TIER_TYPE_AVAILABLE
            
					)
				);	
        
      		
			EXPORT name_rpt := 
				PROJECT(
					ams_main_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_name_rec,
            SELF.Prov_Clean_fname       := LEFT.clean_name.fname,
            SELF.Prov_Clean_mname       := LEFT.clean_name.mname,
            SELF.Prov_Clean_lname       := LEFT.clean_name.lname;
            SELF.Prov_Clean_name_suffix := LEFT.clean_name.name_suffix,
            SELF.ProviderNameTierID     := AMS._Constants().NO_TIER_TYPE_AVAILABLE           
					)
				);	


      EXPORT Gender := CASE( name[1].prov_name_prefix_text, 'MR'  => 'M',
                                                            'MR.' => 'M',
                                                            'MS'  => 'F', 
                                                            'MS.' => 'F',
                                                            'MRS' => 'F', 
                                                       /* default */  ''
                           );

      EXPORT Gender_name := CASE( name[1].prov_name_prefix_text, 'MR'  => 'Male',
                                                                 'MR.' => 'Male',
                                                                 'MS'  => 'Female', 
                                                                 'MS.' => 'Female',
                                                                 'MRS '=> 'Female', 
                                                            /* default */      ''
                                );     

			EXPORT npi_numbers := 
				PROJECT(
					ams_id_numbers_raw(src_cd_desc = 'NPI'),
					TRANSFORM( doxie.ingenix_provider_module.ingenix_npi_rec,
						SELF.NPI           := LEFT.rawfields.indy_id,
						SELF.NPITierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE
					)
				);	
			
      EXPORT providerdid := 
        PROJECT(
					ams_main_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_did_rec,
            SELF.did := (STRING12)LEFT.did;
           )
         );
      
			EXPORT specialties :=
				DEDUP(
					PROJECT(
						ams_specialties_raw,
						TRANSFORM( doxie.ingenix_provider_module.ingenix_specialty_rec,
							SELF.SpecialtyID         := 0,
							SELF.SpecialtyName       := LEFT.specialty_desc,
							SELF.SpecialtyGroupID    := 0,
							SELF.SpecialtyGroupName  := '',
							SELF.SpecialtyTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE
						)
					),
					RECORD, ALL
				);
        

      EXPORT ams_ssn_last_four :=
        DEDUP( SORT( PROJECT( ams_main_raw,
						                  TRANSFORM( doxie.ingenix_provider_module.ingenix_ssn_rec,
							                           SELF.ssn  := LEFT.rawdemographicsfields.ssn_last4;
                                       )
                            ),
					
                     ssn ), 
               ssn
             );

      // key sanctions did layout: l_did sanc_id internal_fpos  
      EXPORT ams_sanction_ids := 
        JOIN( ams_main_raw, doxie_files.key_sanctions_did,
              KEYED( LEFT.did = RIGHT.l_did ),
              TRANSFORM( doxie.ingenix_provider_module.ingenix_sanc_child_rec,
                         SELF.SANC_ID := RIGHT.sanc_id;
                       ), INNER
            );
            
     STRING federalBoard := 'FEDERAL BOARDS';
     STRING typeOIG      := 'DEBARRED/EXCLUDED';
     STRING typeGSA1     := 'EXCLUDED';
     STRING typeGSA2     := 'EXCLUDED/DELETED';            

     EXPORT ams_sanction_data :=
       JOIN( ams_sanction_ids, doxie_files.key_sanctions_sancid, 
             KEYED( (UNSIGNED6)LEFT.sanc_id = RIGHT.l_sancid),
             TRANSFORM( doxie.ingenix_provider_module.ingenix_sanc_child_rec_full,
                        isFederal := stringlib.StringToUpperCase(RIGHT.sanc_brdtype) = federalBoard;
                        isOIG := stringlib.StringToUpperCase(RIGHT.sanc_type)= typeOIG;
                        isGSA := stringlib.StringToUpperCase(RIGHT.sanc_type)= typeGSA1 OR stringlib.StringToUpperCase(RIGHT.sanc_type)= typeGSA2;
                        
                        SELF.SANC_ID           := (STRING7)RIGHT.l_sancid;
                        SELF.sanc_grouptype    := MAP( isFederal      => 'FEDERAL', 
														                           /* default */     'STATE' );
                        SELF.sanc_subgrouptype := MAP( isFederal AND isGSA => 'GSA', 
														                           isFederal AND isOIG => 'OIG', 
														                           /* default */             '');
                        SELF.NPPESVerified     := '';
                        SELF                   := RIGHT;
                      ), INNER
           );
             
            
     
      // Ingenix defines the License Number to be STRING12, AMS: STRING20. AMS pre-pads the 
      // license number with 0's in some instances.  See DID: 355778810. Ex: the lic number
      // is: 000000000117347 is displaying instead of: 117347.  Casting from AMS to Ingenix
      // layout definition, trancates the license number incorrectly. 
      // TO-DO: come back in and do a search for the first non-zero character and set
      // set the tax id to that.  Or create a new layout for any service that uses AMS data 
			EXPORT state_licenses := 
				PROJECT(
					ams_state_licenses_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_license_rpt_rec,
						license_length               := LENGTH(TRIM(LEFT.rawfields.st_lic_num, LEFT, RIGHT));
            SELF.LicenseState            := LEFT.rawfields.st_lic_state;
						SELF.LicenseNumber           := IF( license_length > 12, 
                                                LEFT.rawfields.st_lic_num[license_length-11..license_length],
                                                LEFT.rawfields.st_lic_num );
						SELF.Effective_Date          := LEFT.rawfields.st_lic_issue_date;
						SELF.Termination_Date        := LEFT.rawfields.st_lic_exp_date;
						SELF.LicenseNumberTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE;
					)
				);
       
       

			EXPORT state_licenses_searchService := 
				PROJECT(
					ams_state_licenses_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_license_rec,
						license_length               := LENGTH(TRIM(LEFT.rawfields.st_lic_num,LEFT,RIGHT));
            SELF.LicenseState            := LEFT.rawfields.st_lic_state;
						SELF.LicenseNumber           := IF( license_length > 12, 
                                                LEFT.rawfields.st_lic_num[license_length-11..license_length],
                                                LEFT.rawfields.st_lic_num );
						SELF.LicenseNumberTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE
					)
				);
			
			EXPORT taxid := 
				PROJECT(
					ams_main_raw,
					TRANSFORM( doxie.ingenix_provider_module.ingenix_taxid_rec,
						SELF.TaxID           := LEFT.rawdemographicsfields.tax_id,
						SELF.TaxIDTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE
					)
				);

      
      

		END;

  // Get AMS data for the Report service and the Batch Service
  EXPORT get_ams_report_records (DATASET(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.rec_with_bitflag) ds_ams_recs = DATASET([],prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.rec_with_bitflag )) := 
		FUNCTION                                                                                                                                              
      UCase := StringLib.StringToUpperCase;

        
    // ********************************************************************************************
		
	  //          Transforms to convert AMS Data into passed in Ingenix layout
						
    // ******************************************************************************************** 

     doxie.ingenix_provider_module.ingenix_phone_slim_rec xfm_get_phones ( STRING10 phoneNumber, STRING60 PhoneType ) :=
        TRANSFORM
          SELF.PhoneNumber           := phoneNumber;
          SELF.PhoneType             := PhoneType;
          SELF.PhoneNumberTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
        END;

        xfm_get_ams_bus_addr ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds,bob_rank,phone,fax),bob_rank,phone,fax);   
      doxie.ingenix_provider_module.ingenix_addr_rpt_rec xfm_get_ams_bus_addr_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=
        TRANSFORM
          SELF.ProviderAddressTierTypeID := (UNSIGNED2)L.bob_rank;     // Numeric value indicating the level of "Best" (1=best, 2=2nd best, etc)
          SELF.phone                     := DATASET( [ xfm_get_phones( L.phone, 'Office Phone' ),
                                                       xfm_get_phones( L.fax,   'Office Fax' ) 
										                                 ]
										                               )(PhoneNumber <> '');  
          SELF                           := L;
          SELF                           := [];
        END;
             ds_final:=project(ds_tmp,xfm_get_ams_bus_addr_xform(left));
            return ds_final;
        end;         

        xfm_get_ams_dea ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds,DEANumber,dea_expiration_date),DEANumber,dea_expiration_date);  
      doxie.ingenix_provider_module.ingenix_dea_rec xfm_get_ams_dea_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=
        TRANSFORM
          SELF.DEANumber           := L.DEANumber;
          SELF.expiration_date     := L.dea_expiration_date;
          SELF.DEANumberTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
        END;

          ds_final:=project(ds_tmp,xfm_get_ams_dea_xform(left));
            return ds_final;
        end;  

    // ********************************************************************************************
		
	  //          Transforms to convert AMS Data into passed in Ingenix layout
						
    // ******************************************************************************************** 

    xfm_get_ams_degree ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds,Degree),Degree);       
      doxie.ingenix_provider_module.ingenix_degree_rec xfm_get_ams_degree_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) := 
      TRANSFORM		     
          SELF.Degree           := L.Degree;
          SELF.DegreeTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
      END;
          ds_final:=project(ds_tmp,xfm_get_ams_degree_xform(left));
            return ds_final;
        end;        

      xfm_get_ams_did ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds(did!=0),did),did);
          doxie.ingenix_provider_module.ingenix_did_rec xfm_get_ams_did_xform ( ds_tmp L ) :=
            TRANSFORM
              SELF.DID := (STRING12) L.did;
              SELF     := L;
            END;
            ds_final:=project(ds_tmp,xfm_get_ams_did_xform(left));
            return ds_final;
        end;
        
        xfm_get_ams_dob ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds,dob_date),dob_date);      
      doxie.ingenix_provider_module.ingenix_dob_rec xfm_get_ams_dob_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=
        TRANSFORM
          SELF.BirthDate           := L.dob_date;
          SELF.BirthDateTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
          SELF                     := L;
        END;
         ds_final:=project(ds_tmp,xfm_get_ams_dob_xform(left));
            return ds_final;
        end;                 


    xfm_get_ams_group ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds,Affiliation_BDID,Affiliation_GroupName,Affiliation_Address,Affiliation_City,Affiliation_State,Affiliation_Zip),Affiliation_BDID,Affiliation_GroupName,Affiliation_Address,Affiliation_City,Affiliation_State,Affiliation_Zip); 
      doxie.ingenix_provider_module.ingenix_group_rec  xfm_get_ams_group_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=
        TRANSFORM
          SELF.BDID                := IF( L.affiliation_type != AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_BDID, '' );
          SELF.GroupName           := IF( L.affiliation_type != AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_GroupName, '' );
          SELF.GroupNameTierTypeID := IF( L.affiliation_type != AMS._Constants().PROVIDER_TO_HOSPITAL, AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE, 0 );
          SELF.Address             := IF( L.affiliation_type != AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_Address, '' );
          SELF.City                := IF( L.affiliation_type != AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_City, '' );
          SELF.State               := IF( L.affiliation_type != AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_State, '' );
          SELF.Zip                 := IF( L.affiliation_type != AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_Zip, '' );
        END;	
    
          ds_final:=project(ds_tmp,xfm_get_ams_group_xform(left));
            return ds_final;
        end;  
 
 xfm_get_ams_hospital ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds,Affiliation_BDID,Affiliation_GroupName,Affiliation_Address,Affiliation_City,Affiliation_State,Affiliation_Zip),Affiliation_BDID,Affiliation_GroupName,Affiliation_Address,Affiliation_City,Affiliation_State,Affiliation_Zip); 
      doxie.ingenix_provider_module.ingenix_hospital_rec xfm_get_ams_hospital_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=
        TRANSFORM
          SELF.BDID                   := IF( L.affiliation_type = AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_BDID, '' );
			    SELF.HospitalName           := IF( L.affiliation_type = AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_GroupName, '' );
			    SELF.HospitalNameTierTypeID := IF( L.affiliation_type = AMS._Constants().PROVIDER_TO_HOSPITAL, AMS._Constants().NO_TIER_TYPE_AVAILABLE, 0);
			    SELF.Address                := IF( L.affiliation_type = AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_Address, '' );
          SELF.City                   := IF( L.affiliation_type = AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_City, '' );
          SELF.State                  := IF( L.affiliation_type = AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_State, '' );
          SELF.Zip                    := IF( L.affiliation_type = AMS._Constants().PROVIDER_TO_HOSPITAL, L.Affiliation_Zip, '' );
        END;	
     
          ds_final:=project(ds_tmp,xfm_get_ams_hospital_xform(left));
            return ds_final;
        end;  
                 
  xfm_get_ams_licenses ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
          ds_tmp:=dedup(sort(ds,ST_LIC_STATE,ST_LIC_NUM,ST_LIC_ISSUE_DATE,ST_LIC_EXP_DATE),ST_LIC_STATE,ST_LIC_NUM,ST_LIC_ISSUE_DATE,ST_LIC_EXP_DATE);        
      doxie.ingenix_provider_module.ingenix_license_rpt_rec xfm_get_ams_licenses_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=
        TRANSFORM
          SELF.LicenseState            := L.ST_LIC_STATE;
          SELF.LicenseNumber           := L.ST_LIC_NUM;	
          SELF.Effective_Date          := L.ST_LIC_ISSUE_DATE;
          SELF.Termination_Date        := L.ST_LIC_EXP_DATE;
          SELF.LicenseNumberTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
          SELF                         := L;
        END;
     
          ds_final:=project(ds_tmp,xfm_get_ams_licenses_xform(left));
            return ds_final;
        end;  
        

xfm_get_ams_names ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
    ds_tmp:=dedup(sort(ds,lname,fname,mname,name_suffix),lname,fname,mname,name_suffix);
      doxie.ingenix_provider_module.ingenix_name_rec xfm_get_ams_names_xform ( ds_tmp L ) :=
        TRANSFORM
           SELF.Prov_Clean_lname       := L.lname;
           SELF.Prov_Clean_fname       := L.fname;
           SELF.Prov_Clean_mname       := L.mname;
           SELF.Prov_Clean_name_suffix := L.name_suffix; 
           SELF.ProviderNameTierID     := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
           SELF                        := L;
           // SELF                        := [];
         END;
          ds_final:=project(ds_tmp,xfm_get_ams_names_xform(left));
            return ds_final;
        end;

xfm_get_ams_npi ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
    ds_tmp:=dedup(sort(ds,NPI),NPI);
    
      doxie.ingenix_provider_module.ingenix_npi_rec xfm_get_ams_npi_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=
        TRANSFORM
           SELF.NPI           := L.NPI;
           SELF.NPITierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
           SELF               := L;
           // SELF               := [];
         END;
          ds_final:=project(ds_tmp,xfm_get_ams_npi_xform(left));
            return ds_final;
        end;  

xfm_get_ams_specialty ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
    ds_tmp:=dedup(sort(ds,specialty_desc),specialty_desc);
    
      doxie.ingenix_provider_module.ingenix_specialty_rec xfm_get_ams_specialty_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=  
        TRANSFORM
					SELF.SpecialtyID         := 0,
					SELF.SpecialtyName       := L.specialty_desc,
					SELF.SpecialtyGroupID    := 0,
					SELF.SpecialtyGroupName  := '',
					SELF.SpecialtyTierTypeID := AMS._Constants().NO_TIER_TYPE_AVAILABLE
        END;
          ds_final:=project(ds_tmp,xfm_get_ams_specialty_xform(left));
            return ds_final;
        end;  

xfm_get_ams_ssn ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
    ds_tmp:=dedup(sort(ds,ams_ssn_last4),ams_ssn_last4);
    
      doxie.ingenix_provider_module.ingenix_ssn_rec xfm_get_ams_ssn_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=  
        TRANSFORM
          SELF.ssn := L.ams_ssn_last4;
        END; 
           ds_final:=project(ds_tmp,xfm_get_ams_ssn_xform(left));
            return ds_final;
        end; 
        
xfm_get_ams_taxid ( dataset(AMS.Layouts.ams_provider_batch_service_rec) ds ) :=function
    ds_tmp:=dedup(sort(ds,tax_id),tax_id);
    
      doxie.ingenix_provider_module.ingenix_taxid_rec xfm_get_ams_taxid_xform ( AMS.Layouts.ams_provider_batch_service_rec L ) :=  
        TRANSFORM
          SELF.TaxID           := L.tax_id;
          SELF.TaxIDTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
          SELF                 := L;
          // SELF                 := [];
        END;
            ds_final:=project(ds_tmp,xfm_get_ams_taxid_xform(left));
            return ds_final;
        end;
  
		 ds_ams_main     := sort(AMS_Services.raw.get_AMS_by_ams_ids( ds_ams_recs ),acctno,providerid,bob_rank);
     ds_ams_main_lic := 
        JOIN( ds_ams_main, ams.keys().StateLicense.amsid.qa,
              KEYED( LEFT.providerid = RIGHT.ams_id),
              TRANSFORM( AMS.Layouts.ams_provider_batch_service_rec,
                         SELF.ST_LIC_STATE      := RIGHT.rawfields.ST_LIC_STATE;
                         SELF.ST_LIC_NUM        := RIGHT.rawfields.ST_LIC_NUM;	
                         SELF.ST_LIC_ISSUE_DATE := RIGHT.rawfields.ST_LIC_ISSUE_DATE;
                         SELF.ST_LIC_EXP_DATE   := RIGHT.rawfields.ST_LIC_EXP_DATE;
                         SELF                   := LEFT;
                         // SELF                   :=[];
                       ),
              LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_JOIN_LIMIT_SMAll ),limit(0)
            );
           
     ds_ams_main_lic_deduped := sort(DEDUP( SORT( ds_ams_main_lic, acctno,bob_rank,-ST_LIC_EXP_DATE), acctno, ST_LIC_NUM, ST_LIC_EXP_DATE, ALL ),acctno,ST_LIC_NUM,-ST_LIC_EXP_DATE);
     
     // pick up the amsid for the associated affiliation 
     ds_add_ams_affiliation_amsid := 
       JOIN( ds_ams_main, ams.keys().Affiliation.AMSID.qa, 
             KEYED( LEFT.providerid = RIGHT.ams_id)                         AND
                     RIGHT.record_type = AMS._CONSTANTS().CURRENT           AND 
                     RIGHT.rawfields.affil_status = AMS._CONSTANTS().ACTIVE AND 
                     RIGHT.isparent = FALSE,
             TRANSFORM( AMS.Layouts.ams_provider_batch_service_rec,
                        SELF.ams_other_id := RIGHT.ams_other_id;
                        SELF              := LEFT;
                      ),
             LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_RETURN_LIMIT ),limit(0)
           );

     ds_add_ams_affiliation_amsid_deduped := DEDUP( SORT( ds_add_ams_affiliation_amsid, acctno), acctno, RECORD, ALL );
   
     // join back to the AMS main key to pick up the affiliation data from the "other_ams_id" picked up in the previous join
     // AMS only has amsid for the affiliation, that's why there's a need for a second join
     ds_add_affiliation_data := 
				JOIN( ds_add_ams_affiliation_amsid_deduped,
					    ams.keys().main.amsid.qa,
					    KEYED( LEFT.ams_other_id = RIGHT.ams_id ),
					    TRANSFORM( AMS.Layouts.ams_provider_batch_service_rec,
						             SELF.Affiliation_type      := RIGHT.rawdemographicsfields.acct_name;
						             SELF.Affiliation_BDID      := (STRING12)RIGHT.bdid;
						             SELF.Affiliation_GroupName := RIGHT.rawdemographicsfields.acct_name;
						             SELF.Affiliation_Address   := Address.Addr1FromComponents( RIGHT.clean_company_address.prim_range, 
                                                                                    RIGHT.clean_company_address.predir, 
                                                                                    RIGHT.clean_company_address.prim_name, 
                                                                                    RIGHT.clean_company_address.addr_suffix, 
                                                                                    RIGHT.clean_company_address.postdir, 
                                                                                    RIGHT.clean_company_address.unit_desig, 
                                                                                    RIGHT.clean_company_address.sec_range );
						             SELF.Affiliation_City      := RIGHT.clean_company_address.p_city_name; 
						             SELF.Affiliation_State     := RIGHT.clean_company_address.st; 
						             SELF.Affiliation_Zip       := RIGHT.clean_company_address.zip;
                         SELF                       := LEFT;
                       ), 
              LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_RETURN_LIMIT ),limit(0)
			   	  );
				
     ds_add_affiliation_data_deduped := DEDUP( SORT( ds_add_affiliation_data, acctno), acctno, RECORD, ALL );
     ds_add_degree :=
       JOIN( ds_ams_main, 
             ams.keys().Degree.amsid.qa,
             KEYED( LEFT.providerid = RIGHT.ams_id),
             TRANSFORM( AMS.Layouts.ams_provider_batch_service_rec,
                        SELF.Degree := RIGHT.rawfields.Degree;
                        SELF        := LEFT;
                      ),
              LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_RETURN_LIMIT ),limit(0)
		   		 );

     ds_add_degree_deduped := DEDUP( SORT( ds_add_degree, acctno), acctno, RECORD, ALL );
     ds_add_NPI_n_DEA :=
       JOIN( ds_ams_main, 
             ams.keys().IDNumber.AMSID.qa,
             KEYED(LEFT.providerid = RIGHT.ams_id),
             TRANSFORM( AMS.Layouts.ams_provider_batch_service_rec,
                        SELF.DEANumber           := IF( RIGHT.src_cd_desc = 'DEA', RIGHT.rawfields.indy_id,'');
						            SELF.dea_expiration_date := IF( RIGHT.src_cd_desc = 'DEA', RIGHT.rawfields.indy_id_end_date, '');
                        SELF.NPI                 := IF( RIGHT.src_cd_desc = 'NPI', RIGHT.rawfields.indy_id,'');
						            SELF                     := LEFT;
                      ),
              LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_RETURN_LIMIT ),limit(0)
		   		 );

     ds_add_NPI_n_DEA_deduped := DEDUP( SORT( ds_add_NPI_n_DEA, acctno), acctno, RECORD, ALL );
   
     // The child dataset limit is 100 here because we only output 20 and the data source at the time of 
     // development expodes here
     ds_add_specialty :=
       JOIN( ds_ams_main, 
             ams.keys().specialty.amsid.qa,
             KEYED(LEFT.providerid = RIGHT.ams_id),
             TRANSFORM( AMS.Layouts.ams_provider_batch_service_rec,
                        SELF.specialty_desc := RIGHT.specialty_desc;
						            SELF                := LEFT;
                        SELF                := [];
                      ),
              LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_RETURN_LIMIT ),limit(0)
		   		 );
           
			
     ds_add_specialty_deduped := DEDUP( SORT( ds_add_specialty, acctno), acctno, RECORD, ALL );

  		
     ds_all_needed_ams_fields :=
       DEDUP( SORT( ds_ams_main, acctno, providerid, bob_rank,did, lname, fname, mname, title, prov_clean_prim_range, prov_clean_prim_name, prov_clean_p_city_name, prov_clean_st, prov_clean_zip, bob_rank, st_lic_state, st_lic_num, st_lic_issue_date, st_lic_exp_date, npi, deanumber, dea_expiration_date, degree, specialty_desc, affiliation_bdid, affiliation_groupname, affiliation_address, affiliation_city, affiliation_state, affiliation_zip, affiliation_type, ams_ssn_last4, ams_other_id),
              acctno, providerid, did, lname, fname, mname, title, prov_clean_prim_range, prov_clean_prim_name, prov_clean_p_city_name, prov_clean_st, prov_clean_zip, bob_rank, st_lic_state, st_lic_num, st_lic_issue_date, st_lic_exp_date, npi, deanumber, dea_expiration_date, degree, specialty_desc, affiliation_bdid, affiliation_groupname, affiliation_address, affiliation_city, affiliation_state, affiliation_zip, affiliation_type, ams_ssn_last4, ams_other_id);

rec_tmp_all:=record
  STRING20 acctno;
  STRING10  ProviderID;
  STRING1  Gender;
  STRING7  Gender_Name;
  BOOLEAN  sanc_flag;
  dataset(AMS.Layouts.ams_provider_batch_service_rec) main_rec;
end;

	   ds_tmp := group(dedup(sort( ds_all_needed_ams_fields,acctno,providerid,bob_rank ), acctno,providerid),acctno,providerid);
     my_rec_111:=recordof(ds_tmp);
rec_tmp_all xform(my_rec_111 l, dataset(my_rec_111) R):=transform
  self.acctno:=l.acctno;
  SELF.Gender               := IF( L.title = 'MR', 'M',
                                           IF( L.title = 'MS' OR L.title = 'MRS', 'F', '') );
  SELF.Gender_Name          := IF( L.title = 'MR', 'Male',
                                           IF( L.title = 'MS' OR L.title = 'MRS', 'Female', '') );
  self.main_rec:=dedup(sort(r,record),record);
  self:=l;
  self:=[];
end;


     ds_tmp_1:=rollup(ds_tmp,GROUP,xform(left,ROWS(LEFT)));

     {doxie.ingenix_provider_module.layout_ingenix_provider_report, STRING20 acctno} xfm_AMS_batch_to_ING_layout( rec_tmp_all L ) := 
				TRANSFORM
          SELF.providerdid          := xfm_get_ams_did(L.main_rec);//DATASET( [ xfm_get_ams_did(L.main_rec) ] )( (UNSIGNED)did != 0);
          SELF.name                 := xfm_get_ams_names(L.main_rec);
          SELF.taxid                := xfm_get_ams_taxid(L.main_rec);
          SELF.dob                  := xfm_get_ams_dob(L.main_rec);
          SELF.npi                  := xfm_get_ams_npi(ds_add_NPI_n_DEA_deduped(acctno=L.Acctno,ProviderID=L.ProviderID,NPI<>''));
          SELF.license              := xfm_get_ams_licenses(ds_ams_main_lic_deduped(acctno=L.Acctno,ProviderID=l.ProviderID));
          SELF.dea                  := xfm_get_ams_dea(ds_add_NPI_n_DEA_deduped(acctno=L.Acctno,ProviderID=l.ProviderID,DEANumber<>''));
          SELF.degree               := xfm_get_ams_degree(ds_add_degree_deduped(acctno=L.Acctno,ProviderID=l.ProviderID));
          SELF.specialty            := xfm_get_ams_specialty(ds_add_specialty_deduped(acctno=L.Acctno,ProviderID=l.ProviderID));
          SELF.business_address     := xfm_get_ams_bus_addr(L.main_rec);  
          SELF.group_affiliation    := xfm_get_ams_group(ds_add_affiliation_data_deduped(acctno=L.Acctno,ProviderID=l.ProviderID));   
          SELF.hospital_affiliation := xfm_get_ams_hospital(ds_add_affiliation_data_deduped(acctno=L.Acctno,ProviderID=l.ProviderID)); 
          SELF.SSN                  := xfm_get_ams_ssn(L.main_rec);
          SELF                      := L;
          SELF                      := [];         
        END;
   
	   ds_AMS_batch_in_ING_layout_plus_acctno := PROJECT( ds_tmp_1, xfm_AMS_batch_to_ING_layout(LEFT) );

     ds_AMS_in_ING_layout_sorted := SORT( ds_AMS_batch_in_ING_layout_plus_acctno, acctno, providerid);
     
      // Not sorting in this rollup because that's being done when Ingenix and AMS are combined
      ds_ams_in_ING_layout_rolled :=
        ROLLUP( ds_AMS_in_ING_layout_sorted,
                LEFT.acctno = RIGHT.acctno AND
                LEFT.providerid = RIGHT.providerid,  // here we are joining by AMS ID
                TRANSFORM( {doxie.ingenix_provider_module.layout_ingenix_provider_report, STRING20 acctno},
                           SELF.Gender               := IF( LEFT.Gender != '', LEFT.Gender, RIGHT.Gender );
                           SELF.Gender_Name          := IF( LEFT.Gender_Name != '', LEFT.Gender_Name, RIGHT.Gender_Name );
                           SELF.providerdid          := LEFT.providerdid + RIGHT.providerdid;
                           SELF.name                 := LEFT.name + RIGHT.name;
                           SELF.taxid                := LEFT.taxid + RIGHT.taxid;
                           SELF.dob                  := LEFT.dob + RIGHT.dob;
                           SELF.npi                  := LEFT.npi + RIGHT.npi;
                           SELF.license              := LEFT.license + RIGHT.license;
                           SELF.dea                  := LEFT.dea + RIGHT.dea;
                           SELF.degree               := LEFT.degree + RIGHT.degree;
                           SELF.specialty            := LEFT.specialty + RIGHT.specialty;
                           SELF.business_address     := LEFT.business_address + RIGHT.business_address;  
                           SELF.group_affiliation    := LEFT.group_affiliation + RIGHT.group_affiliation;   
                           SELF.hospital_affiliation := LEFT.hospital_affiliation + RIGHT.hospital_affiliation; 
                           SELF.SSN                  := LEFT.SSN + RIGHT.SSN;
                           SELF                      := LEFT;
                           SELF                      := [];         
                        )
              );
                 
      ds_ams_providerid_removed := 
        PROJECT( ds_ams_in_ING_layout_rolled, 
                 TRANSFORM( {doxie.ingenix_provider_module.layout_ingenix_provider_report, STRING20 acctno}, 
                            SELF.providerid := '';  // remove the AMS provider id from the dataset
                            SELF            := LEFT;
														SELF            := [];         
                          )
               );
     // OUTPUT( ds_ams_recs, named('ds_ams_recs'));
     // OUTPUT( ds_ams_providerid_removed, named('ds_ams_providerid_removed') );
     
     RETURN ds_ams_providerid_removed;
  END;


    /* ********************************************************************
		
         Begin backfill of Doxie Search Service records with AMS records
						
       ******************************************************************** */

  // Backfill with AMS data. Apply appropriate rules to rollup/dedup child dataset records.
  EXPORT backfill_ing_SearchService_with_amsRecs( DATASET(doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt) ds_ing_provider_search_recs = DATASET([],doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt),
	                                               AMS.Interfaces.params aInputData
						                              ) := 
		FUNCTION   
						
       doxie.MAC_Header_Field_Declare() 
    /* *************************************************************************************************
		
	           Convert Ingenix Data by adding DID to enable joining Ingenix records with AMS recs by DID
						
       ************************************************************************************************* */
		 

      /* Adding the DID to the current Ingenix layout. The DID can then be used to join the Ingenix records to the 
         AMS records.  Because the search service can have multiple different individuals (i.e. Search J Smith, 
         Ingenix (or AMS ) could have John/Jason/Jerry/Joe/Jane/Jan/ ect Smith, but not necessarily all)) in it's output.  
         Simply concatenating the records is not an option.
         Joining the Ingenix records to the provider key to get the DIDs for the Ingenix records. (The main payload key for 
         AMS has DIDs.) We can then combine the two result sets using DIDs.
      */
      ing_temp_rec := 
        RECORD
          doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt;
          UNSIGNED6 DID;
      END;
      

       ds_ing_provider_search_recs_with_DIDs_all :=
        JOIN( ds_ing_provider_search_recs,
              doxie_files.key_provider_id,
              KEYED( (UNSIGNED6)LEFT.ProviderID = RIGHT.l_ProviderID),
              TRANSFORM( ing_temp_rec,
                         SELF.DID := (UNSIGNED6)RIGHT.did;
                         SELF     := LEFT;
                         SELF     := [];
				               ),
						  LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_JOIN_LIMIT ),limit(0)
            );
      ds_ing_provider_search_recs_with_DIDs := DEDUP( SORT( ds_ing_provider_search_recs_with_DIDs_all, DID), DID );

      // Because the records are rolled up first by did and then by Ingenix provider ID, the Ingenix records 
      // with a zero DIDs are separated out from the main dataset. 
      
      // The AMS records with the zero DIDs cannot be rolled into the Ingenix records 
      // with zero DIDs. So the Ingenix records with zero DIDs (which may or may not have a provider ID ) are 
      // simply passed through and appended to the end result.  
      // The Ingenix records with non-zero DIDs are used to join with the AMS data.
      ds_ing_zero_dids     := ds_ing_provider_search_recs_with_DIDs ( DID = 0 );
      ds_ing_non_zero_dids := ds_ing_provider_search_recs_with_DIDs ( DID != 0 );
      
    /* ******************************************
		
	           Get AMS Data
						
       ****************************************** */
		 
      // We are joining the AMS to Ingenix by DID.
      // The following layout contains all of the AMS fields needed to backfill 
      // (contained in) the Ingenix records.
      
      // Ingenix defines the License Number to be STRING12, AMS: STRING20. AMS pre-pads the 
      // license number with 0's.  See DIDs: 355778810 & 1899916518. Ex: the lic number
      // is: 000000000117 is displaying instead of: 007347.  
      // TO-DO: come back in and do a search for the first non-zero character and set
      // set the tax id to that.  Or create a new layout for any service that uses AMS data 
		ams_provider_search_service_rec :=
        RECORD
          AMS.Layouts.Base.Main;                           // Current AMS Main Payload
          AMS.Layouts.Input.StateLicense.ST_LIC_NUM;       // State license number 
			 AMS.Layouts.Input.StateLicense.ST_LIC_STATE;     // Issuing State
			 STRING10 NPI;
        END;

    
      // AMS main payload key -- get AMS payload from input data
		 ams_ids      := get_AMS_ids( aInputData);
     ams_main_raw := AMS_Services.raw.get_ams_mainPayload_by_pids_filtered( ams_ids, aInputData ); 
		 // dedup is necessary to avoid OOM errors
		 ams_main_raw_dedup := 
		   DEDUP( SORT( ams_main_raw, ams_id, -did, -bdid, rawdemographicsfields.last_name, 
			              rawdemographicsfields.first_name, rawdemographicsfields.middle_name, 
										rawdemographicsfields.tax_id, rawdemographicsfields.dob_date, 
										rawaddressfields.ams_street, rawaddressfields.ams_city, 
										rawaddressfields.ams_state, rawaddressfields.ams_zip5 ), 
					    ams_id, did, bdid, rawdemographicsfields.last_name, 
			        rawdemographicsfields.first_name, rawdemographicsfields.middle_name, 
							rawdemographicsfields.tax_id, rawdemographicsfields.dob_date, 
							rawaddressfields.ams_street, rawaddressfields.ams_city, 
							rawaddressfields.ams_state, rawaddressfields.ams_zip5
						); 
		  
		  
      // Ingenix defines the License Number to be STRING12, AMS: STRING20. AMS pre-pads the 
      // license number with 0's in some instances.  See DID: 355778810. Ex: the lic number
      // is: 000000000117347 is displaying instead of: 117347.  Casting from AMS to Ingenix
      // layout definition, trancates the license number incorrectly.
      // TO-DO: come back in and do a search for the first non-zero character and set
      // set the tax id to that.  Or create a new layout for any service that uses AMS data 
      ds_ams_raw_plus_lic :=
        JOIN( ams_main_raw_dedup, ams.keys().StateLicense.amsid.qa,
              LEFT.ams_id = RIGHT.ams_id,
              TRANSFORM( ams_provider_search_service_rec,
                         license_length    := LENGTH(TRIM(RIGHT.rawfields.st_lic_num, LEFT,RIGHT));
                         SELF.ST_LIC_NUM   := IF(license_length > 12, 
                                                 RIGHT.rawfields.ST_LIC_NUM[license_length-11..license_length],
                                                 RIGHT.rawfields.ST_LIC_NUM );
                         SELF.ST_LIC_STATE := RIGHT.rawfields.ST_LIC_STATE;
                         SELF              := LEFT;
                         SELF              := [];
                       )
              , LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_CHILD_DATASET_LIMIT ),limit(0)
           );
		
		 // dedup is necessary to avoid OOM errors
		 ds_ams_raw_plus_lic_dedup := 
		   DEDUP( SORT( ds_ams_raw_plus_lic, ams_id, -did, -bdid, rawdemographicsfields.last_name, 
			              rawdemographicsfields.first_name, rawdemographicsfields.middle_name, 
										rawdemographicsfields.tax_id, rawdemographicsfields.dob_date, 
										rawaddressfields.ams_street, rawaddressfields.ams_city, 
										rawaddressfields.ams_state, rawaddressfields.ams_zip5, 
										ST_LIC_NUM, ST_LIC_STATE ), 
					    ams_id, did, bdid, rawdemographicsfields.last_name, 
			        rawdemographicsfields.first_name, rawdemographicsfields.middle_name, 
							rawdemographicsfields.tax_id, rawdemographicsfields.dob_date, 
							rawaddressfields.ams_street, rawaddressfields.ams_city, 
							rawaddressfields.ams_state, rawaddressfields.ams_zip5, 
							ST_LIC_NUM, ST_LIC_STATE 
						); 
		  
      // add AMS NPI                             
      ds_ams_all_doxie_prov_out_fields :=
        JOIN( ds_ams_raw_plus_lic_dedup,  ams.keys().IDNumber.AMSID.qa,
              LEFT.ams_id = RIGHT.ams_id AND 
							RIGHT.src_cd_desc = 'NPI',
              TRANSFORM( ams_provider_search_service_rec,
                         SELF.NPI := RIGHT.rawfields.indy_id;
                         SELF     := LEFT;
                         SELF     := [];
                       )
              , LEFT OUTER, KEEP( AMS._CONSTANTS().AMS_CHILD_DATASET_LIMIT ),limit(0)
            );
     
	   // again, since we only picked up the npi's in the previous join, removing the excess records
		ds_ams_all_doxie_prov_out_fields_dedup :=
		   DEDUP( SORT( ds_ams_raw_plus_lic, ams_id, -did, -bdid, rawdemographicsfields.last_name, 
			              rawdemographicsfields.first_name, rawdemographicsfields.middle_name, 
										rawdemographicsfields.tax_id, rawdemographicsfields.dob_date, 
										rawaddressfields.ams_street, rawaddressfields.ams_city, 
										rawaddressfields.ams_state, rawaddressfields.ams_zip5, 
										ST_LIC_NUM, ST_LIC_STATE, NPI ), 
					    ams_id, did, bdid, rawdemographicsfields.last_name, 
			        rawdemographicsfields.first_name, rawdemographicsfields.middle_name, 
							rawdemographicsfields.tax_id, rawdemographicsfields.dob_date, 
							rawaddressfields.ams_street, rawaddressfields.ams_city, 
							rawaddressfields.ams_state, rawaddressfields.ams_zip5, 
							ST_LIC_NUM, ST_LIC_STATE, NPI 
						); 
		
		  
    /* ********************************************************************************************
		
	           Transforms to convert AMS Data into passed in Ingenix layout
						
       ******************************************************************************************** */

      doxie.ingenix_provider_module.ingenix_phone_slim_rec xfm_get_phones ( STRING10 phoneNumber, STRING60 PhoneType ) :=
        TRANSFORM
          SELF.PhoneNumber           := phoneNumber;
          SELF.PhoneType             := PhoneType;
          SELF.PhoneNumberTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
          SELF                       := [];
        END;


      doxie.ingenix_provider_module.ingenix_addr_rec xfm_get_ams_addr ( ams_provider_search_service_rec L ) :=
        TRANSFORM
          SELF.Prov_Clean_prim_range     := L.clean_company_address.prim_range;
          SELF.Prov_Clean_predir         := L.clean_company_address.predir;
          SELF.Prov_Clean_prim_name      := L.clean_company_address.prim_name;
          SELF.Prov_Clean_addr_suffix    := L.clean_company_address.addr_suffix;
          SELF.Prov_Clean_postdir        := L.clean_company_address.postdir;
          SELF.Prov_Clean_unit_desig     := L.clean_company_address.unit_desig;
          SELF.Prov_Clean_sec_range      := L.clean_company_address.sec_range;
          SELF.Prov_Clean_p_city_name    := L.clean_company_address.p_city_name;
          SELF.Prov_Clean_v_city_name    := L.clean_company_address.v_city_name;
          SELF.Prov_Clean_st             := L.clean_company_address.st;
          SELF.Prov_Clean_zip            := L.clean_company_address.zip;
          SELF.Prov_Clean_zip4           := L.clean_company_address.zip4;
          SELF.ProviderAddressTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
          SELF.phone                     := DATASET( [ xfm_get_phones( L.clean_phones.phone, 'Office Phone' ),
                                                       xfm_get_phones( L.clean_phones.fax,   'Office Fax' ) 
										                                 ]
										                               );  
          SELF                           := L;
          SELF                           := [];
        END;
          

      doxie.ingenix_provider_module.ingenix_dob_rec xfm_get_ams_dob ( ams_provider_search_service_rec L ) :=
        TRANSFORM
          SELF.BirthDate           := L.rawdemographicsfields.dob_date;
          SELF.BirthDateTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
          SELF                     := L;
          SELF                     := [];
        END;
                    

      doxie.ingenix_provider_module.ingenix_license_rec xfm_get_ams_licenses ( ams_provider_search_service_rec L ) :=
        TRANSFORM
          SELF.LicenseState  := L.st_lic_state;
          SELF.LicenseNumber := L.st_lic_num;	
          SELF               := L;
          SELF               := [];
        END;


      doxie.ingenix_provider_module.ING_NPPES_name_rec xfm_get_ams_names ( ams_provider_search_service_rec L ) :=
        TRANSFORM
           SELF.Prov_Clean_lname       := L.clean_name.lname;
           SELF.Prov_Clean_fname       := L.clean_name.fname;
           SELF.Prov_Clean_mname       := L.clean_name.mname;
           SELF.Prov_Clean_name_suffix := L.clean_name.name_suffix; 
           SELF.Prov_Name_Prefix_Text  := L.clean_name.title;
           SELF                        := L;
           SELF                        := [];
         END;

      doxie.ingenix_provider_module.ingenix_taxid_rec xfm_get_ams_taxid ( ams_provider_search_service_rec L ) :=  
        TRANSFORM
          SELF.TaxID           := L.rawdemographicsfields.tax_id;
          SELF.TaxIDTierTypeID := AMS._CONSTANTS().NO_TIER_TYPE_AVAILABLE;
          SELF                 := L;
          SELF                 := [];
        END;
  
      // Per Kathy Bardeen, all AMS records will be displayed as if they came from Ingenix data (see rec_type below).
			ing_temp_rec xfm_AMS_to_ING_layout(ams_provider_search_service_rec L) := 
				TRANSFORM
					SELF.name     := DATASET( [ xfm_get_ams_names(L) ] );
					SELF.address  := DATASET( [ xfm_get_ams_addr(L) ] );
					SELF.dob      := DATASET( [ xfm_get_ams_dob(L) ] );
					SELF.license  := DATASET( [ xfm_get_ams_licenses(L) ] );
					SELF.taxid    := DATASET( [ xfm_get_ams_taxid(L) ] );
					SELF.rec_type := 'ING';  // AMS is used solely to backfill Ingenix and will not have it's own type recognized
          SELF          := L;
          SELF          := [];
				END;

			ds_AMS_in_ING_layout := PROJECT( ds_ams_all_doxie_prov_out_fields, xfm_AMS_to_ING_layout(LEFT) );

      // Filtering the AMS data that has been transformed to the Ingenix layout into two
      // datasets, one with non-zero dids, the other with zero dids. Per Kathy Bardeen, she would
      // like all AMS records with zero dids to be rolled up by license number and license state.
      
      // The AMS dataset with non-zero did records will be combined with with Ingenix records and 
      // used to "backfill" the Ingenix data.
      ds_ams_in_ING_layout_zero_dids     := ds_AMS_in_ING_layout( DID  = 0 ); 
      ds_AMS_in_ING_layout_non_zero_dids := ds_AMS_in_ING_layout( DID != 0 ); 
      
      // Because the AMS zero DID records will always be singletons, the following rollup can use 
      // the data from the name and license child records (first record first child ) for 
      // the rollup. 
      ds_AMS_zero_dids_rolled_by_license := 
        ROLLUP( SORT( ds_ams_in_ING_layout_zero_dids, license[1].licensenumber[1], 
				              license[1].licensestate[1], name[1].prov_clean_lname[1], 
											name[1].prov_clean_fname, RECORD  ),
                LEFT.license[1].licensenumber[1] = RIGHT.license[1].licensenumber[1]   AND
                LEFT.license[1].licensestate[1]  = RIGHT.license[1].licensestate[1]    AND
								LEFT.name[1].prov_clean_lname[1] = RIGHT.name[1].prov_clean_lname[1]   AND
								LEFT.name[1].prov_clean_fname[1] = RIGHT.name[1].prov_clean_fname[1],
                TRANSFORM( ing_temp_rec,
                           SELF.name          := CHOOSEN( DEDUP( SORT( LEFT.name + RIGHT.name, RECORD ), RECORD),AMS._Constants().AMS_CHILD_DATASET_LIMIT_LARGE );
                           SELF.address       := CHOOSEN( DEDUP( SORT( LEFT.address + RIGHT.address, RECORD ), RECORD), AMS._Constants().AMS_CHILD_DATASET_LIMIT_LARGE );
                           SELF.dob           := CHOOSEN( DEDUP( SORT( LEFT.dob + RIGHT.dob, RECORD ), RECORD), AMS._Constants().AMS_CHILD_DATASET_LIMIT_LARGE );
					                 SELF.license       := CHOOSEN( DEDUP( SORT( LEFT.license + RIGHT.license, RECORD ), RECORD), AMS._Constants().AMS_CHILD_DATASET_LIMIT_LARGE );
					                 SELF.NPI           := IF( LEFT.NPI != '', LEFT.npi, RIGHT.npi );
                           SELF.taxid         := CHOOSEN( DEDUP( SORT( LEFT.TaxId + RIGHT.TaxId, RECORD ), RECORD), AMS._Constants().AMS_CHILD_DATASET_LIMIT_LARGE );
                           SELF.nppesverified := IF( LEFT.nppesverified != '', LEFT.nppesverified, RIGHT.nppesverified );
                           SELF.provider_organization_name := IF( LEFT.provider_organization_name != '', LEFT.provider_organization_name, RIGHT.provider_organization_name );
					                 SELF.providerid    := IF( LEFT.providerid != '', LEFT.providerid, RIGHT.providerid );
                           SELF.rec_type      := IF( LEFT.rec_type != '', LEFT.rec_type, RIGHT.rec_type );
                           SELF               := LEFT;
                           SELF               := [];
                      ) );


      // Combine the Ingenix records passed into the function (with DIDs appeneded) with the AMS records 
      // that are now in the Ingenix layout including DIDs.
			ds_ING_with_AMS_nonzero_dids :=  ds_ing_non_zero_dids & ds_AMS_in_ING_layout_non_zero_dids;
      
      // Roll the records up first by DID to put include the AMS records found that match the Ingenix 
      // records
      ds_ING_with_AMS_rolled_by_did :=
        ROLLUP( SORT( ds_ING_with_AMS_nonzero_dids, DID),
                LEFT.DID = RIGHT.DID,
				        TRANSFORM( ing_temp_rec,
                           SELF.name          := LEFT.name + RIGHT.name;
                           SELF.address       := LEFT.address + RIGHT.address;
                           SELF.dob           := LEFT.dob + RIGHT.dob;
					                 SELF.license       := LEFT.license + RIGHT.license;
					                 SELF.NPI           := IF( LEFT.NPI != '', LEFT.npi, RIGHT.npi );
                           SELF.taxid         := LEFT.TaxId + RIGHT.TaxId;
                           SELF.nppesverified := IF( LEFT.nppesverified != '', LEFT.nppesverified, RIGHT.nppesverified );
                           SELF.provider_organization_name := IF( LEFT.provider_organization_name != '', LEFT.provider_organization_name, RIGHT.provider_organization_name );
					                 SELF.providerid    := IF( LEFT.providerid != '', LEFT.providerid, RIGHT.providerid );
                           SELF.rec_type      :=  IF( LEFT.rec_type != '', LEFT.rec_type, RIGHT.rec_type );
                           SELF               := LEFT;
                           SELF               := [];
                      ) );

    // Again we need to split the dataset from the previous Rollup. There could be more than one 
    // AMS record that does not have an Ingenix provider ID but has a different DID. If we roll up by 
    // Ingenix provider ID, these records would be rolled together if we did not filter out the 
    // records with a blank provider. In almost all cases, these empty provider ID records are 
    // AMS records that do not have an associated Ingenix record with both a DID and a provider id
    
    // EXAMPLE: an Ingenix record came into the function containing an provider id.  When the 
    // provider ID was matched to the Ingenix DID file, the join resulted in two identical records
    // except for the did.  Combining the AMS to Ingenix records using the DIDs, combined the two 
    // sources. But there were now virtually identical records.  To ensure we picked up all the 
    // AMS records associated with the Ingenix provider ID, the records are subsequently rolled 
    // up by Ingenix provider ID, then the child datasets are then sorted, rolled up and sorted
    // by tier type ID.
    
    ds_ING_with_AMS_no_providerid   := ds_ING_with_AMS_rolled_by_did( providerid  = '' );
    ds_ING_with_AMS_with_providerid := ds_ING_with_AMS_rolled_by_did( providerid != '' );
    
    ds_ING_with_AMS_Rollup_Providerid :=
      ROLLUP( SORT( ds_ING_with_AMS_with_providerid, providerid),
              LEFT.providerid = RIGHT.providerid,
              TRANSFORM( ing_temp_rec,
                         SELF.name          := LEFT.name + RIGHT.name;
                         SELF.address       := LEFT.address + RIGHT.address;
                         SELF.dob           := LEFT.dob + RIGHT.dob;
					               SELF.license       := LEFT.license + RIGHT.license;
					               SELF.NPI           := IF( LEFT.NPI != '', LEFT.npi, RIGHT.npi );
                         SELF.taxid         := LEFT.TaxId + RIGHT.TaxId;
                         SELF.nppesverified := IF( LEFT.nppesverified != '', LEFT.nppesverified, RIGHT.nppesverified );
                         SELF.provider_organization_name := IF( LEFT.provider_organization_name != '', LEFT.provider_organization_name, RIGHT.provider_organization_name );
					               SELF.providerid    := IF( LEFT.providerid != '', LEFT.providerid, RIGHT.providerid );
                         SELF.rec_type      :=  IF( LEFT.rec_type != '', LEFT.rec_type, RIGHT.rec_type );
                         SELF               := LEFT;
                         SELF               := [];
                       ) );
                    
    // In the following project, the child datasets are sorted first to put the records in a sorted
    // order that most accurately allows for rollup and back fill.  The final sort on each child
    // dataset is done to output the child sets in the most accurate order from the Ingenix vendor.  
    // Note:  The Tier type IDs are not simply sorted in ascending order because a tier type ID of 
    //        zero indicates "no tier type available". So if we simply sort in ascending order the  
    //        customer would actually have our worst records displayed first.
   
    ds_ams_ING_rollChildData := 
      PROJECT( ds_ING_with_AMS_Rollup_Providerid, 
               TRANSFORM( doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt,
                          SELF.name := SORT( ROLLUP( SORT( LEFT.name, Prov_Clean_lname, Prov_Clean_fname, Prov_Clean_mname, Prov_Clean_name_suffix, Prov_Credential_Text, Prov_Name_Prefix_Text, ProviderNameTierID ), 
                                                      LEFT.Prov_Clean_lname = RIGHT.Prov_Clean_lname AND
                                                      LEFT.Prov_Clean_fname = RIGHT.Prov_Clean_fname AND
                                                      LEFT.Prov_Clean_mname = RIGHT.Prov_Clean_mname AND
                                                      ut.NNEQ( LEFT.Prov_Clean_name_suffix, RIGHT.Prov_Clean_name_suffix ) AND
                                                      ut.NNEQ( LEFT.Prov_Credential_Text,   RIGHT.Prov_Credential_Text )   AND 
                                                      ut.NNEQ( LEFT.Prov_Name_Prefix_Text,  RIGHT.Prov_Name_Prefix_Text ),
                                                      TRANSFORM( doxie.ingenix_provider_module.ING_NPPES_name_rec,
                                                                 SELF.Prov_Clean_name_suffix := IF( LEFT.Prov_Clean_name_suffix = '', RIGHT.Prov_Clean_name_suffix, LEFT.Prov_Clean_name_suffix ), 
                                                                 SELF.Prov_Credential_Text   := IF( LEFT.Prov_Credential_Text   = '', RIGHT.Prov_Credential_Text,   LEFT.Prov_Credential_Text ),
                                                                 SELF.Prov_Name_Prefix_Text  := IF( LEFT.Prov_Name_Prefix_Text  = '', RIGHT.Prov_Name_Prefix_Text,  LEFT.Prov_Name_Prefix_Text ),
                                                                 SELF.ProviderNameTierID     := IF( LEFT.ProviderNameTierID > RIGHT.ProviderNameTierID AND RIGHT.ProviderNameTierID != 0, RIGHT.ProviderNameTierID, LEFT.ProviderNameTierID ),
                                                                 SELF                        := LEFT
                                                               )
                                                    ),
                                              ProviderNameTierID , RECORD
                                            );
					               SELF.address := SORT( ROLLUP( SORT( LEFT.address, Prov_Clean_prim_range, Prov_Clean_prim_name, Prov_Clean_v_city_name, Prov_Clean_p_city_name, Prov_Clean_st, Prov_Clean_zip, Prov_Clean_addr_suffix, Prov_Clean_postdir, ProviderAddressTierTypeID ),    
                                                       LEFT.Prov_Clean_prim_range  = RIGHT.Prov_Clean_prim_range  AND
                                                       LEFT.Prov_Clean_prim_name   = RIGHT.Prov_Clean_prim_name   AND
                                                       LEFT.Prov_Clean_v_city_name = RIGHT.Prov_Clean_v_city_name AND
                                                       LEFT.Prov_Clean_p_city_name = RIGHT.Prov_Clean_p_city_name AND 
                                                       LEFT.Prov_Clean_st          = RIGHT.Prov_Clean_st          AND
                                                       LEFT.Prov_Clean_zip         = RIGHT.Prov_Clean_zip         AND
                                                       ut.NNEQ( LEFT.Prov_Clean_addr_suffix, RIGHT.Prov_Clean_addr_suffix ) AND
                                                       ut.NNEQ( LEFT.Prov_Clean_postdir,     RIGHT.Prov_Clean_postdir )     AND 
                                                       ut.NNEQ( LEFT.Prov_Clean_unit_desig,  RIGHT.Prov_Clean_unit_desig )  AND 
                                                       ut.NNEQ( LEFT.Prov_Clean_sec_range,   RIGHT.Prov_Clean_sec_range ), 
                                                       TRANSFORM( doxie.ingenix_provider_module.ingenix_addr_rec,
                                                                  SELF.Prov_Clean_predir         := IF( LEFT.Prov_Clean_predir      = '', RIGHT.Prov_Clean_predir, LEFT.Prov_Clean_predir),
		                                                              SELF.Prov_Clean_addr_suffix    := IF( LEFT.Prov_Clean_addr_suffix = '', RIGHT.Prov_Clean_addr_suffix, LEFT.Prov_Clean_addr_suffix),
		                                                              SELF.Prov_Clean_postdir        := IF( LEFT.Prov_Clean_postdir     = '', RIGHT.Prov_Clean_postdir, LEFT.Prov_Clean_postdir),
		                                                              SELF.Prov_Clean_unit_desig     := IF( LEFT.Prov_Clean_unit_desig  = '', RIGHT.Prov_Clean_unit_desig, LEFT.Prov_Clean_unit_desig),
		                                                              SELF.Prov_Clean_sec_range      := IF( LEFT.Prov_Clean_sec_range   = '', RIGHT.Prov_Clean_sec_range, LEFT.Prov_Clean_sec_range),
		                                                              SELF.Prov_Clean_p_city_name    := IF( LEFT.Prov_Clean_p_city_name = '', RIGHT.Prov_Clean_p_city_name, LEFT.Prov_Clean_p_city_name),
		                                                              SELF.Prov_Clean_zip4           := IF( LEFT.Prov_Clean_zip4        = '', RIGHT.Prov_Clean_zip4, LEFT.Prov_Clean_zip4),
		                                                              SELF.ProviderAddressTierTypeID := IF( (LEFT.ProviderAddressTierTypeID != 0 AND LEFT.ProviderAddressTierTypeID < RIGHT.ProviderAddressTierTypeID) OR
                                                                                                        RIGHT.ProviderAddressTierTypeID = 0, LEFT.ProviderAddressTierTypeID, RIGHT.ProviderAddressTierTypeID),
		                                                              SELF.phone                     := SORT( DEDUP( SORT( LEFT.phone + RIGHT.phone, phonenumber, phonetype, phonenumbertiertypeid ), phonenumber, phonetype ), phonenumbertiertypeid, RECORD );
                                                                  SELF                           := LEFT,
                                                                  SELF                           := []
                                                                )
                                                     ),
                                               ProviderAddressTierTypeID, RECORD
                                             );
					               SELF.dob     := SORT( DEDUP( SORT( LEFT.dob, BirthDate, BirthDateTierTypeID), BirthDate ), BirthDateTierTypeID, RECORD );
					               SELF.license := SORT( DEDUP( SORT( LEFT.license, LicenseState, LicenseNumber, LicenseNumberTierTypeID ), LicenseState, LicenseNumber ), LicenseState, LicenseNumber,LicenseNumberTierTypeID , RECORD );
					               SELF.taxid   := SORT( DEDUP( SORT( LEFT.TaxId, TaxId, TaxIDTierTypeID  ), TaxId ), TaxIDTierTypeID , RECORD );
					               SELF         := LEFT;
                         SELF         := [];
				               )
                   );
                   
     
	 
     
     // Now take the four separated datasets and concatenate them for the output.
     ds_ING_with_AMS_final := ds_ams_ING_rollChildData &
                              PROJECT( ds_ing_zero_dids &
                                       ds_ING_with_AMS_no_providerid &
                                       ds_AMS_zero_dids_rolled_by_license, doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt
                                     );

			
		return_recs := IF( COUNT( ams_ids ) = 0, 
                              ds_ing_provider_search_recs,
                              ds_ING_with_AMS_final
                     );         
    

    RETURN return_recs;
  
  END; 



  /* ****************************************************************************
		
       Begin backfill of Medlic Batch Service Ingenix records with AMS records
						
     **************************************************************************** */
  

  // Backfill with AMS data. Apply appropriate rules to rollup/dedup child dataset records.
  EXPORT backfill_ing_MedlicBatchService_with_amsRecs( DATASET(prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.rec_with_bitflag) ds_combined_batch_recs = DATASET([],prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.rec_with_bitflag)
						                                         ) := 
		FUNCTION                                                                                                                                              
      UCase := StringLib.StringToUpperCase;

        
    // ********************************************************************************************
		
	  //              Begin Ingenix Processing 
						
    // ******************************************************************************************** 


      // In the original searches, '_AMS' or '_ING' was appended to the acctno string so that we 
      // can tell which provider ID is populated in the provid field (ams or ingenix). Here the
      // file is split so that we can get the appropriate payload for each provider ID
      ds_combined_recs_ing := ds_combined_batch_recs( stringlib.StringFind( Acctno, 'ING', 1) > 0 );
  	  ds_combined_recs_ams := ds_combined_batch_recs( stringlib.StringFind( Acctno, 'AMS', 1) > 0 );
	
		  // to use the doxie.ING_provider_report_records attribute, the dataset needs to be projected
      // into isDeepDive and ProviderID.
      ds_ids_medlic_ing := 
        PROJECT( ds_combined_recs_ing, prof_licensev2_services.Layout_Search_Ids_Prov );
      
      ds_out_ing         := doxie.ING_provider_report_records( ds_ids_medlic_ing );
      ds_out_ing_sorted  := SORT( ds_out_ing, ProviderId );
      ds_org_ing_sorted  := SORT( ds_combined_recs_ing, ProviderId );
      
      
      // Join the output results back to the ING records that were passed into the function to pick up the 
      // account number for each record (which will be used to join the Ingenix and AMS records 
      // for each input record).
      ds_ing_with_acctno := 
        JOIN( SORTED( ds_org_ing_sorted, ProviderId), 
              SORTED( ds_out_ing_sorted, ProviderId),
              LEFT.ProviderId = (UNSIGNED6)RIGHT.ProviderId,
              TRANSFORM( {doxie.ingenix_provider_module.layout_ingenix_provider_report, STRING20 acctno},
                         SELF.Acctno    := stringlib.StringFindReplace( LEFT.Acctno, '_ING', '' );  // remove the '_ING' from the acctno field to speed of the join back to the AMS data
                         SELF.license              := SORT( DEDUP(sort(RIGHT.license,licensestate, licensenumber,-Termination_Date,-effective_date),licensestate, licensenumber,Termination_Date,effective_date),
                                                           licensestate, licensenumber,-Termination_Date,-effective_date,licensenumbertiertypeid)[1..20];  // the final output layout allows for 20 license numbers only
					               SELF.degree               := SORT( DEDUP( SORT(RIGHT.degree,  degree),
                                                                   degree),
                                                            degreetiertypeid );
                         SELF.specialty            := SORT( DEDUP( SORT( RIGHT.specialty, specialtyname,-(INTEGER)specialtyid ),
                                                                   specialtyname ),
                                                            specialtytiertypeid,specialtyname,-(INTEGER)specialtyid 
                                                          )[1..20]; // the final output layout expects only 20
                         SELF.business_address     := SORT( DEDUP( RIGHT.business_address,RECORD,ALL),
                                                            ProviderAddressTierTypeID )[1..10];   // final layout outputs 10
					               SELF.group_affiliation    := DEDUP( SORT( RIGHT.group_affiliation,
                                                                   UCase(GroupName), UCase(Address), UCase(City), UCase(State), UCase(Zip), GroupNameTierTypeID
                                                                 ),
                                                             UCase(GroupName), UCase(Address), UCase(City), UCase(State), UCase(Zip)
                                                           )[1..10];   // final layout outputs 10
					               SELF.hospital_affiliation := DEDUP(  SORT( RIGHT.hospital_affiliation,
                                                                    UCase(HospitalName), UCase(Address), UCase(City), UCase(State), UCase(Zip), HospitalNameTierTypeID
                                                                  ),
                                                              UCase(HospitalName), UCase(Address), UCase(City), UCase(State), UCase(Zip)
                                                           )[1..10]; // final layout outputs 10
					               SELF.residency            := SORT( DEDUP( SORT( RIGHT.residency,  residency),
                                                                  residency),
                                                            residencytiertypeid)[1..10];  // final layout outputs 10
					               SELF.medschool            := SORT( DEDUP( SORT( RIGHT.medschool,  medschoolname, graduationyear),
                                                                   medschoolname, graduationyear),
                                                            medschooltiertypeid );
								         SELF                      := RIGHT;
                         SELF                      := [];         
                      )
            );
      // Sort results now by acctno to use as the link between the Ingenix records and the AMS records
     ds_ing_output_with_acctno_sorted := SORT( ds_ing_with_acctno, Acctno );
        
      
    // ********************************************************************************************
		
	  //              Begin AMS Processing 
						
    // ******************************************************************************************** 

      ds_ams_providerid_removed := get_ams_report_records( ds_combined_recs_ams );
               
      ds_AMS_in_ING_layout_plus_acctno_sorted :=
        SORT( ds_ams_providerid_removed, Acctno );
      
      
        
      // Merge the AMS and Ingenix files together, with Ingenix as the choice when data is provided by both sources for non-dataset variables (ie: gender)
      ing_medlic_batch_w_ams_recs := 
        JOIN( SORTED( ds_ing_output_with_acctno_sorted, Acctno), 
              SORTED( ds_AMS_in_ING_layout_plus_acctno_sorted, Acctno),
              LEFT.Acctno = RIGHT.Acctno       AND
              LEFT.providerdid[1].did  != ''   AND
              RIGHT.providerdid[1].did != ''   AND
              LEFT.providerdid[1].did = RIGHT.providerdid[1].did ,
              TRANSFORM( {doxie.ingenix_provider_module.layout_ingenix_provider_report, STRING20 acctno},
                         SELF.ProviderID           := LEFT.ProviderID;
                         SELF.Gender               := IF( RIGHT.Gender = '', LEFT.Gender, RIGHT.Gender);
                         SELF.Gender_Name          := IF( RIGHT.Gender = '', LEFT.Gender, RIGHT.Gender);
                         SELF.providerdid          := DEDUP( (LEFT.providerdid + RIGHT.providerdid)((UNSIGNED)did != 0),did);
					               SELF.name                 := SORT( DEDUP( SORT( (LEFT.name + RIGHT.name),
                                                                          prov_clean_lname, prov_clean_fname, prov_clean_mname, prov_clean_name_suffix, providernametierid),
                                                                   prov_clean_lname, prov_clean_fname, prov_clean_mname, prov_clean_name_suffix),
                                                            providernametierid );
                         SELF.taxid                := SORT( DEDUP((LEFT.taxid + RIGHT.taxid)(taxid != ''),RECORD,ALL),
                                                            taxidTierTypeID );
					               SELF.dob                  := SORT( DEDUP( SORT((LEFT.dob + RIGHT.dob), birthdate, birthdatetiertypeid),
                                                                   birthdate),
                                                            birthdatetiertypeid);
                         SELF.npi                  := SORT( DEDUP( SORT((LEFT.npi + RIGHT.npi), npi, npitiertypeid),
                                                                   npi),
                                                            npitiertypeid);
					               SELF.license              := SORT( DEDUP( SORT (LEFT.license + RIGHT.license,
								                                                         licensestate, licensenumber, -effective_date,-termination_date, licensenumbertiertypeid),
                                                                   licensestate, licensenumber, effective_date,termination_date ),
																			                      licensestate, licensenumber,-Termination_Date,licensenumbertiertypeid
																		                      );
					               SELF.dea                  := SORT( DEDUP( SORT((LEFT.dea + RIGHT.dea), deanumber, deanumbertiertypeid),
                                                                   deanumber),
                                                           -expiration_date,deanumbertiertypeid );
					               SELF.degree               := SORT( DEDUP( SORT((LEFT.degree + RIGHT.degree),  degree, degreetiertypeid),
                                                                  degree),
                                                            degreetiertypeid);
                         SELF.specialty            := SORT(
                                                        ROLLUP(
                                                          SORT( LEFT.specialty + RIGHT.specialty, specialtyname,-(INTEGER)specialtyid ),
                                                          LEFT.specialtyname = RIGHT.specialtyname,
                                                          TRANSFORM( doxie.ingenix_provider_module.ingenix_specialty_rec,
                                                            SELF.SpecialtyID         := IF( LEFT.SpecialtyID         =  0, RIGHT.SpecialtyID, LEFT.SpecialtyID ),
                                                            SELF.SpecialtyName       := IF( LEFT.SpecialtyName       = '', RIGHT.SpecialtyName, LEFT.SpecialtyName ),
                                                            SELF.SpecialtyGroupID    := IF( LEFT.SpecialtyGroupID    =  0, RIGHT.SpecialtyGroupID, LEFT.SpecialtyGroupID ),
                                                            SELF.SpecialtyGroupName  := IF( LEFT.SpecialtyGroupName  = '', RIGHT.SpecialtyGroupName, LEFT.SpecialtyGroupName ),
                                                            SELF.SpecialtyTierTypeID := IF( LEFT.SpecialtyTierTypeID =  0, RIGHT.SpecialtyTierTypeID, LEFT.SpecialtyTierTypeID )
                                                          )
                                                        ),
                                                        specialtytiertypeid,specialtyname,-(INTEGER)specialtyid 
                                                      );
                         SELF.business_address     := SORT( DEDUP((LEFT.business_address + RIGHT.business_address),RECORD,ALL),
                                                            ProviderAddressTierTypeID);
					               SELF.group_affiliation    := DEDUP(
                                                        SORT( LEFT.group_affiliation + RIGHT.group_affiliation,
                                                              UCase(GroupName), UCase(Address), UCase(City), UCase(State), UCase(Zip), GroupNameTierTypeID
                                                            ),
                                                        UCase(GroupName), UCase(Address), UCase(City), UCase(State), UCase(Zip)
                                                       );
					               SELF.hospital_affiliation := DEDUP(
                                                        SORT( LEFT.hospital_affiliation + RIGHT.hospital_affiliation,
                                                              UCase(HospitalName), UCase(Address), UCase(City), UCase(State), UCase(Zip), HospitalNameTierTypeID
                                                            ),
                                                        UCase(HospitalName), UCase(Address), UCase(City), UCase(State), UCase(Zip)
                                                       );
					               SELF.ssn                  := SORT( DEDUP ( SORT( (LEFT.ssn + RIGHT.ssn ), ssn ),
                                                                    ssn),
                                                            -ssn );  // Sorting in decending order because there is no tier type id associated with ssns
                                                                     // and AMS only has the last four, not the full social security number.  If the ssns
                                                                     // are not sorted in decending order, the last four SSNs from AMS will display first
                         SELF                      := LEFT;
                         SELF                      := RIGHT;
												 self											 := [];
                       ),
              LEFT OUTER
            );

      
      
      
      // get ams recs with no corresponding Ingenix records -- Originally a FULL OUTER JOIN-- it took too much time
      ams_only_recs := 
        JOIN( ing_medlic_batch_w_ams_recs, 
              SORTED( ds_AMS_in_ING_layout_plus_acctno_sorted, Acctno),
              LEFT.Acctno = RIGHT.Acctno       AND
              LEFT.providerdid[1].did  != ''   AND
              RIGHT.providerdid[1].did != ''   AND
              LEFT.providerdid[1].did = RIGHT.providerdid[1].did ,
              TRANSFORM(RIGHT),
              RIGHT ONLY
            );
     
     all_recs := SORT( ing_medlic_batch_w_ams_recs + ams_only_recs, acctno );
     
     // transform the address into addr1 addr2 city state zip record for final transform
     all_recs_addr_trans :=
       PROJECT( all_recs, 
                TRANSFORM( doxie.ingenix_provider_module.layout_ingenix_provider_report_for_batch,
                           SELF.bus_addr2 := PROJECT(LEFT.business_address,prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View.get_address(LEFT));
                           SELF           := LEFT;
                         )
              );   
                
          // OUTPUT( ds_ams_main, named('ds_ams_main'));
          // OUTPUT( ds_ams_main_lic, named('ds_all_needed_ams_fields'));
          // OUTPUT( ds_tmp, named('ds_tmp'));
          // OUTPUT( ds_tmp1, named('ds_tmp1'));
          // OUTPUT( choosen(ds_all_needed_ams_fields,5), named('ds_all_needed_ams_fields'));
          // OUTPUT( ds_AMS_batch_in_ING_layout_plus_acctno, named('ds_AMS_batch_in_ING_layout_plus_acctno'));
          // OUTPUT( ds_ams_in_ING_layout_rolled, named('ds_ams_in_ING_layout_rolled'));

     RETURN all_recs_addr_trans;
  END;




	// Added the Include_Sanctions boolean because the doxie ING provider report processes the sanctions before grabbing 
  // the Igenix records then back fills with AMS, where as the Healthcare_Provider_Services.Report_Service gets the 
  // sanctions after all the Ingenix and AMS records have been retrieved. Having the parameter saves duplication of
  // hits against the key for the Healthcare report service.
	EXPORT do( DATASET(doxie.ingenix_provider_module.layout_ingenix_provider_report) ing_provider_recs = DATASET([],doxie.ingenix_provider_module.layout_ingenix_provider_report),
	           AMS.Interfaces.params aInputData,
             BOOLEAN Include_Sanctions = FALSE
						 ) := 
		FUNCTION

			// Backfill with AMS data if necessary. Apply appropriate rules to rollup/dedup child dataset records.
			UCase := StringLib.StringToUpperCase;
			
      ams_data := AMS_datasets(get_AMS_ids(aInputData));
     
      ams_ids  := get_AMS_ids(aInputData);
      ams_ids_for_funct_call := PROJECT( ams_ids, 
                                         TRANSFORM( prof_LicenseV2_Services.Prof_Lic_Raw.batch_view.rec_with_bitflag,
                                                    SELF.providerid := (UNSIGNED6)LEFT.ams_id;
                                                    SELF.isdeepdive := FALSE;
                                                    SELF            := [];
                                                   ) 
                                       );
     
      ams_data_in_ing_layout := get_ams_report_records(ams_ids_for_funct_call);

      // when Ingenix does not have any records, create an empty dataset so that the transform is processed
      ams_provider_id := DATASET( [{'0'}], {STRING10 ProviderID} ); 
      ams_data_full_layout := 
        PROJECT( ams_provider_id, 
                 TRANSFORM( doxie.ingenix_provider_module.layout_ingenix_provider_report,
                            SELF := LEFT;
                            SELF := [];
                          )
               );
      ds_for_processing := IF( COUNT( ing_provider_recs ) = 0,
                               ams_data_full_layout,
                               ing_provider_recs
                             );
      
      ds_check_sanc_with_dids := ams_data.providerdid( did != '0' );
        
      /* Also in this transform, we are converting the Ingenix Definition for the No Tier Type Available.
         Ingenix Tier Type Ids: 1 is best, 99 is second worst, and 0 is no data available (worst rank).
         In order to allow for sequential sorting, we are temporarily changing the 0 to 1000, so all data types can be 
         sorted in ascending order where tier type IDs = 1 are at the top of the sort order.  
      */
        
			doxie.ingenix_provider_module.layout_ingenix_provider_report xfm_rollup_dedup(doxie.ingenix_provider_module.layout_ingenix_provider_report L) := 
				TRANSFORM
					SELF.Gender           := IF( L.Gender = '', ams_data.Gender, L.Gender );
          SELF.Gender_name      := IF( L.Gender_name = '', ams_data.Gender_name, L.Gender_name );
          SELF.npi              := SORT( DEDUP( SORT((L.npi + ams_data.npi_numbers), npi),
                                                npi),
                                         npitiertypeid );
					SELF.license          := SORT( DEDUP((L.license + ams_data.state_licenses),RECORD,ALL),
                                         licensestate, licensenumber,-Termination_Date,licensenumbertiertypeid );
					SELF.name             := SORT( DEDUP( SORT( (L.name + ams_data.name_rpt),
                                                       prov_clean_lname, prov_clean_fname, prov_clean_mname, prov_clean_name_suffix),
                                                prov_clean_lname, prov_clean_fname, prov_clean_mname, prov_clean_name_suffix),
                                         providernametierid );
					SELF.providerdid      := DEDUP( (L.providerdid + ams_data.providerdid)(did != '0'),RECORD,ALL);
					SELF.taxid            := SORT( DEDUP((L.taxid + ams_data.taxid)(taxid != ''),RECORD,ALL),
                                         taxidTierTypeID );
					SELF.business_address := SORT( DEDUP((L.business_address + ams_data.ams_address),RECORD,ALL),
                                         ProviderAddressTierTypeID );
					SELF.dea              := SORT( DEDUP( SORT((L.dea + ams_data.dea_numbers), deanumber),
                                                deanumber),
                                         -expiration_date,deanumbertiertypeid );
					SELF.degree           := SORT( DEDUP( SORT((L.degree + ams_data.degrees),  degree),
                                                degree),
                                         degreetiertypeid );
					SELF.dob              := SORT( DEDUP( SORT((L.dob + ams_data.dob),   birthdate),
                                                birthdate),
                                         birthdatetiertypeid );
					SELF.ssn              := SORT( DEDUP ( SORT( (L.ssn + ams_data.ams_ssn_last_four ), ssn ),
                                                 ssn),
                                         -ssn ); // Sorting in decending order because there is no tier type id associated with ssns
                                                 // and AMS only has the last four, not the full social security number.  If the ssns
                                                 // are not sorted in decending order, the last four SSNs from AMS will display first
          SELF.sanction_id      := IF( NOT Include_Sanctions, l.sanction_id, DEDUP( SORT( l.sanction_id + ams_data.ams_sanction_ids, sanc_id ), sanc_id ));
          
          SELF.sanction_data    := IF( NOT Include_Sanctions, l.sanction_data, 
            ROLLUP( SORT( l.sanction_data + ams_data.ams_sanction_data, sanc_id ), 
                    LEFT.sanc_id = RIGHT.sanc_id, 
                    TRANSFORM( doxie.ingenix_provider_module.ingenix_sanc_child_rec_full,
                               SELF.SANC_ID                          := LEFT.SANC_ID;
                               SELF.SANC_DOB                         := IF( LEFT.SANC_DOB = '', RIGHT.SANC_DOB, LEFT.SANC_DOB );
                               SELF.SANC_TIN                         := IF( LEFT.SANC_TIN = '', RIGHT.SANC_TIN, LEFT.SANC_TIN );
                               SELF.SANC_UPIN                        := IF( LEFT.SANC_UPIN = '', RIGHT.SANC_UPIN, LEFT.SANC_UPIN );
                               SELF.SANC_PROVTYPE                    := IF( LEFT.SANC_PROVTYPE = '', RIGHT.SANC_PROVTYPE, LEFT.SANC_PROVTYPE );
                               SELF.SANC_SANCDTE_form                := IF( LEFT.SANC_SANCDTE_form = '', RIGHT.SANC_SANCDTE_form, LEFT.SANC_SANCDTE_form );
                               SELF.SANC_SANCDTE                     := IF( LEFT.SANC_SANCDTE = '', RIGHT.SANC_SANCDTE, LEFT.SANC_SANCDTE );
                               SELF.SANC_LICNBR                      := IF( LEFT.SANC_LICNBR = '', RIGHT.SANC_LICNBR, LEFT.SANC_LICNBR );
                               SELF.SANC_SANCST                      := IF( LEFT.SANC_SANCST = '', RIGHT.SANC_SANCST, LEFT.SANC_SANCST );
                               SELF.SANC_BRDTYPE                     := IF( LEFT.SANC_BRDTYPE = '', RIGHT.SANC_BRDTYPE, LEFT.SANC_BRDTYPE );	
                               SELF.SANC_SRC_DESC                    := IF( LEFT.SANC_SRC_DESC = '', RIGHT.SANC_SRC_DESC, LEFT.SANC_SRC_DESC );
                               SELF.SANC_TYPE                        := IF( LEFT.SANC_TYPE = '', RIGHT.SANC_TYPE, LEFT.SANC_TYPE );
                               SELF.SANC_TERMS                       := IF( LEFT.SANC_TERMS = '', RIGHT.SANC_TERMS, LEFT.SANC_TERMS );
                               SELF.SANC_REAS                        := IF( LEFT.SANC_REAS = '', RIGHT.SANC_REAS, LEFT.SANC_REAS );
                               SELF.SANC_COND                        := IF( LEFT.SANC_COND = '', RIGHT.SANC_COND, LEFT.SANC_COND );
                               SELF.SANC_FINES                       := IF( LEFT.SANC_FINES = '', RIGHT.SANC_FINES, LEFT.SANC_FINES );		
                               SELF.SANC_UPDTE_form                  := IF( LEFT.SANC_UPDTE_form = '', RIGHT.SANC_UPDTE_form, LEFT.SANC_UPDTE_form );
                               SELF.SANC_UPDTE                       := IF( LEFT.SANC_UPDTE = '', RIGHT.SANC_UPDTE, LEFT.SANC_UPDTE );
                               SELF.date_first_reported              := IF( LEFT.date_first_reported = '', RIGHT.date_first_reported, LEFT.date_first_reported );
                               SELF.date_last_reported               := IF( LEFT.date_last_reported = '', RIGHT.date_last_reported, LEFT.date_last_reported );
                               SELF.SANC_REINDTE_form                := IF( LEFT.SANC_REINDTE_form = '', RIGHT.SANC_REINDTE_form, LEFT.SANC_REINDTE_form );
                               SELF.SANC_REINDTE                     := IF( LEFT.SANC_REINDTE = '', RIGHT.SANC_REINDTE, LEFT.SANC_REINDTE );
                               SELF.SANC_FAB                         := IF( LEFT.SANC_FAB = '', RIGHT.SANC_FAB, LEFT.SANC_FAB );
                               SELF.SANC_UNAMB_IND                   := IF( LEFT.SANC_UNAMB_IND = '', RIGHT.SANC_UNAMB_IND, LEFT.SANC_UNAMB_IND );
                               SELF.process_date                     := IF( LEFT.process_date = '', RIGHT.process_date, LEFT.process_date );
                               SELF.date_first_seen                  := IF( LEFT.date_first_seen = '', RIGHT.date_first_seen, LEFT.date_first_seen );
                               SELF.date_last_seen                   := IF( LEFT.date_last_seen = '', RIGHT.date_last_seen, LEFT.date_last_seen );
                               SELF.Prov_Clean_title                 := IF( LEFT.Prov_Clean_title = '', RIGHT.Prov_Clean_title, LEFT.Prov_Clean_title );
                               SELF.Prov_Clean_fname                 := IF( LEFT.Prov_Clean_fname = '', RIGHT.Prov_Clean_fname, LEFT.Prov_Clean_fname );
                               SELF.Prov_Clean_mname                 := IF( LEFT.Prov_Clean_mname = '', RIGHT.Prov_Clean_mname, LEFT.Prov_Clean_mname );
                               SELF.Prov_Clean_lname                 := IF( LEFT.Prov_Clean_lname = '', RIGHT.Prov_Clean_lname, LEFT.Prov_Clean_lname );
                               SELF.Prov_Clean_name_suffix           := IF( LEFT.Prov_Clean_name_suffix = '', RIGHT.Prov_Clean_name_suffix, LEFT.Prov_Clean_name_suffix );
                               SELF.ProvCo_Address_Clean_prim_range  := IF( LEFT.ProvCo_Address_Clean_prim_range = '', RIGHT.ProvCo_Address_Clean_prim_range, LEFT.ProvCo_Address_Clean_prim_range );
                               SELF.ProvCo_Address_Clean_predir      := IF( LEFT.ProvCo_Address_Clean_predir = '', RIGHT.ProvCo_Address_Clean_predir, LEFT.ProvCo_Address_Clean_predir );
                               SELF.ProvCo_Address_Clean_prim_name   := IF( LEFT.ProvCo_Address_Clean_prim_name = '', RIGHT.ProvCo_Address_Clean_prim_name, LEFT.ProvCo_Address_Clean_prim_name );
                               SELF.ProvCo_Address_Clean_addr_suffix := IF( LEFT.ProvCo_Address_Clean_addr_suffix = '', RIGHT.ProvCo_Address_Clean_addr_suffix, LEFT.ProvCo_Address_Clean_addr_suffix );
                               SELF.ProvCo_Address_Clean_postdir     := IF( LEFT.ProvCo_Address_Clean_postdir = '', RIGHT.ProvCo_Address_Clean_postdir, LEFT.ProvCo_Address_Clean_postdir );
                               SELF.ProvCo_Address_Clean_unit_desig  := IF( LEFT.ProvCo_Address_Clean_unit_desig = '', RIGHT.ProvCo_Address_Clean_unit_desig, LEFT.ProvCo_Address_Clean_unit_desig );
                               SELF.ProvCo_Address_Clean_sec_range   := IF( LEFT.ProvCo_Address_Clean_sec_range = '', RIGHT.ProvCo_Address_Clean_sec_range, LEFT.ProvCo_Address_Clean_sec_range );
                               SELF.ProvCo_Address_Clean_p_city_name := IF( LEFT.ProvCo_Address_Clean_p_city_name = '', RIGHT.ProvCo_Address_Clean_p_city_name, LEFT.ProvCo_Address_Clean_p_city_name );
                               SELF.ProvCo_Address_Clean_st          := IF( LEFT.ProvCo_Address_Clean_st = '', RIGHT.ProvCo_Address_Clean_st, LEFT.ProvCo_Address_Clean_st );
                               SELF.ProvCo_Address_Clean_zip         := IF( LEFT.ProvCo_Address_Clean_zip = '', RIGHT.ProvCo_Address_Clean_zip, LEFT.ProvCo_Address_Clean_zip );
                               SELF.ProvCo_Address_Clean_geo_lat     := IF( LEFT.ProvCo_Address_Clean_geo_lat = '', RIGHT.ProvCo_Address_Clean_geo_lat, LEFT.ProvCo_Address_Clean_geo_lat );
                               SELF.ProvCo_Address_Clean_geo_long    := IF( LEFT.ProvCo_Address_Clean_geo_long = '', RIGHT.ProvCo_Address_Clean_geo_long, LEFT.ProvCo_Address_Clean_geo_long );
                               SELF.sanc_grouptype                   := IF( LEFT.sanc_grouptype = '', RIGHT.sanc_grouptype, LEFT.sanc_grouptype );
                               SELF.sanc_subgrouptype                := IF( LEFT.sanc_subgrouptype = '', RIGHT.sanc_subgrouptype, LEFT.sanc_subgrouptype );
                               SELF.NPPESVerified                    := IF( LEFT.NPPESVerified = '', RIGHT.NPPESVerified, LEFT.NPPESVerified );
                             )
                  ) );
          
          SELF.specialty := 
            SORT(
              ROLLUP(
                SORT( L.specialty + ams_data.specialties, specialtyname,-(INTEGER)specialtyid ),
                LEFT.specialtyname = RIGHT.specialtyname,
                TRANSFORM( doxie.ingenix_provider_module.ingenix_specialty_rec,
                  SELF.SpecialtyID         := IF( LEFT.SpecialtyID         =  0, RIGHT.SpecialtyID, LEFT.SpecialtyID ),
                  SELF.SpecialtyName       := IF( LEFT.SpecialtyName       = '', RIGHT.SpecialtyName, LEFT.SpecialtyName ),
                  SELF.SpecialtyGroupID    := IF( LEFT.SpecialtyGroupID    =  0, RIGHT.SpecialtyGroupID, LEFT.SpecialtyGroupID ),
                  SELF.SpecialtyGroupName  := IF( LEFT.SpecialtyGroupName  = '', RIGHT.SpecialtyGroupName, LEFT.SpecialtyGroupName ),
                  SELF.SpecialtyTierTypeID := IF( LEFT.SpecialtyTierTypeID =  0, RIGHT.SpecialtyTierTypeID, LEFT.SpecialtyTierTypeID )
                )
              ),
              specialtytiertypeid,specialtyname,-(INTEGER)specialtyid 
            );
					SELF.group_affiliation := 
						DEDUP(
							SORT(
								L.group_affiliation + ams_data.group_affiliations,
								UCase(GroupName), UCase(Address), UCase(City), UCase(State), UCase(Zip), GroupNameTierTypeID
							),
							UCase(GroupName), UCase(Address), UCase(City), UCase(State), UCase(Zip)
						);
					SELF.hospital_affiliation := 
						DEDUP(
							SORT(
								L.hospital_affiliation + ams_data.hospital_affiliations,
								UCase(HospitalName), UCase(Address), UCase(City), UCase(State), UCase(Zip), HospitalNameTierTypeID
							),
							UCase(HospitalName), UCase(Address), UCase(City), UCase(State), UCase(Zip)
						);
					SELF := L;
				END;
			
			ing_provider_recs_with_ams := PROJECT( ds_for_processing, xfm_rollup_dedup(LEFT) );
			

			// DEBUGs:
			// OUTPUT( aInputData.did, NAMED('inputData_did_in_do'));
      // OUTPUT( ams_data);
      // OUTPUT( get_AMS_ids(aInputData), named('get_ams_ids'));
      // OUTPUT( ing_provider_recs, NAMED('ing_provider_recs'));
      // OUTPUT( ing_provider_recs_with_ams, NAMED('ing_provider_recs_with_ams'));
			// OUTPUT( ing_provider_recs );
      // OUTPUT( ams_data );
      // OUTPUT( ds_for_processing );
      // OUTPUT( ing_provider_recs_with_ams );
      
			RETURN ing_provider_recs_with_ams;

		END;








END;


 
