IMPORT Address, AMS, AMS_Services, AutoHeaderI, autokey, Autokey_batch, AutokeyI, AutoStandardI, batchservices, doxie, ut,
       doxie_files, ingenix_natlprof, NPPES, Healthcare_Header_Services, ut;

EXPORT ING_provider_search_records ( STRING15 taxid_value, STRING2 lic_st, STRING12 lic_num,
                                     BOOLEAN include_NPPES, BOOLEAN only_NPI_number_entered, 
												             STRING10 npi_number) := 
	FUNCTION											 
   
    doxie.MAC_Header_Field_Declare()
		gm := AutoStandardI.GlobalModule();
		//Format search criteria into new format
		a1 := Address.CleanFields(address.GetCleanAddress(gm.addr,gm.city+' '+gm.state+' '+gm.zip,address.Components.Country.US).str_addr);
		newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
		newlayout setinput():=	transform
																 self.acctno:='1';
																 self.name_first := stringlib.StringToUpperCase(gm.firstname);
																 self.name_middle := stringlib.StringToUpperCase(gm.middlename);
																 self.name_last :=stringlib.StringToUpperCase(gm.lastname);
																 self.name_suffix := stringlib.StringToUpperCase(gm.namesuffix);
																 self.prim_range := a1.prim_range;
																 self.predir := a1.predir;
																 self.prim_name := a1.prim_name;
																 self.addr_suffix := a1.addr_suffix;
																 self.postdir := a1.postdir;
																 self.unit_desig := '';
																 self.sec_range := a1.sec_range;
																 self.p_city_name := stringlib.StringToUpperCase(gm.city);
																 self.st := stringlib.StringToUpperCase(gm.state);
																 self.z5 := gm.zip;
																 self.zip4 := '';
																 self.dob := (string)gm.dob;
																 self.did := (integer)gm.did;
																 self.license_number :=lic_num; 
																 self.license_state := lic_st;
																 self.TaxID := taxid_value;
																 self.NPI := npi_number;
																 self:=[]
														end;
		ds:=dataset([setinput()]);
		tmpMod:= MODULE(PROJECT(gm, Healthcare_Header_Services.IParams.searchParams,opt))	end;	
		Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
			 self.glb_ok := ut.glb_ok (gm.GLBPurpose);
			 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
			 self.DRM := gm.DataRestrictionMask;
			// self:=[];Do not uncomment otherwise the default values will not get set.
		end;
		cfg:=dataset([buildConfig()]);

		rawDataOrig := Healthcare_Header_Services.Records.getRecordsIndividual(ds,cfg);
		foundHit := exists(rawDataOrig);
		// rawDataAlt := if(not foundHit,Healthcare_Provider_Services.Provider_Records_Consolidated.getRecordsByAutoKeys(tmpMod));
		rawData := rawDataOrig;
		npiData := rawDataOrig.npis[1].npi;
		rawDataFmt := Healthcare_Header_Services.Records.fmtRecordsSearch(rawData);
		ds_project_ING := rawDataFmt;
    org_out_rec := doxie.ingenix_provider_module.layout_ingenix_provider_search_plus;
      
      // transform ING name child dataset into ING/NPPES name rec child dataset
		doxie.ingenix_provider_module.ING_NPPES_name_rec xfm_ING_name_info (doxie.ingenix_provider_module.ingenix_name_rec l) :=
		   TRANSFORM
			  SELF.Prov_Name_prefix_Text  := '';
				SELF.Prov_Clean_fname       := l.Prov_Clean_fname;
				SELF.Prov_Clean_mname       := l.Prov_Clean_mname;
				SELF.Prov_Clean_lname       := l.Prov_Clean_lname;
				SELF.Prov_Clean_name_suffix := l.Prov_Clean_name_suffix;
				SELF.Prov_Credential_Text   := '';
				SELF.ProviderNameTierID     := l.ProviderNameTierID;
		   END;
		
		// transform ING layout into ING/NPPES output record layout	
		doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search xfm_ING_into_final_layout (org_out_rec l) :=
		   TRANSFORM
			  SELF.rec_type := 'ING';
				SELF.name     := PROJECT( choosen(l.name,100), xfm_ING_name_info( LEFT ) );
        self.address 	:= choosen(l.address,100);
        self.dob 			:= choosen(l.dob,100);
        self.license 	:= choosen(l.license,100);
        self.taxid		:= choosen(l.taxid,100);
				SELF          := l;
				SELF          := [];
		   END;

		// The original Ingenix Search and output 
		ds_ING_out  := PROJECT( ds_project_ING, xfm_ING_into_final_layout(LEFT));
    doxie.Mac_CHD_Penalty( ds_ING_out, ds_ING_out_final_pre,
								           name, prov_clean_fname, prov_clean_mname, prov_clean_lname,
					                 FALSE, faked_ssn_child, faked_ssn_field,
					                 TRUE, dob, birthdate, FALSE, address, prov_clean_predir,
					                 prov_clean_prim_range,prov_clean_prim_name,
								           prov_clean_addr_suffix,prov_clean_postdir,prov_clean_sec_range,
							             prov_clean_v_city_name,faked_county,prov_clean_st,prov_clean_zip,
					                 FALSE, faked_phone_child, faked_phone_field, TRUE );

		ds_ING_out_final := 
			PROJECT( ds_ING_out_final_pre, transform(doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt, self.npi := npiData; self := left; self :=[]; ));


      /* ****************************************
		
		            Get NPPES Data
						
       **************************************** */
		 
/* NPPESS no longer needed as Header does it all
		// Get NPPES records based on FLAPSD input
		ds_NPPES_autokey := NPPES.Autokey_payload();  // auto key lookup with all input
	
    // Get NPPES records based on npi from the NPI key
		ds_NPPES_NPIkey := NPPES.Key_NPPES_npi (npi = npi_number); 

 		// Ancillary transform: transform NPPES name child dataset into ING/NPPES name child dataset
    doxie.ingenix_provider_module.ING_NPPES_name_rec xfm_NPPES_name_info ( Address.Layout_Clean_Name l, 
		                                                                       STRING20 ProvCredTxt ) :=
			TRANSFORM
				SELF.Prov_Name_prefix_Text  := l.title;
				SELF.Prov_Clean_fname       := l.fname;
				SELF.Prov_Clean_mname       := l.mname;
				SELF.Prov_Clean_lname       := l.lname;
				SELF.Prov_Clean_name_suffix := l.name_suffix;
				SELF.Prov_Credential_Text   := ProvCredTxt;
				SELF.ProviderNameTierID     := [];
			END;
				
		// Ancillary transform: transform NPPES address fields into ING/NPPES address child dataset
		doxie.ingenix_provider_module.ingenix_addr_rec_Online xfm_NPPES_address_info ( Address.Layout_Clean182_fips l, 
																																			      STRING20 Telephone_Number, 
																							                              STRING20 Fax_Number, 
																																						string	dt_first_seen,
																																						string	dt_last_seen) :=
			TRANSFORM
				SELF.Prov_Clean_prim_range     := l.prim_range;
				SELF.Prov_Clean_predir         := l.predir;
				SELF.Prov_Clean_prim_name      := l.prim_name;
				SELF.Prov_Clean_addr_suffix    := l.addr_suffix;
				SELF.Prov_Clean_postdir        := l.postdir;
				SELF.Prov_Clean_unit_desig     := l.unit_desig;
				SELF.Prov_Clean_sec_range      := l.sec_range;
				SELF.Prov_Clean_p_city_name    := l.p_city_name;
				SELF.Prov_Clean_v_city_name    := l.v_city_name;
				SELF.Prov_Clean_st             := l.st;
				SELF.Prov_Clean_zip            := l.zip;
				SELF.Prov_Clean_zip4           := l.zip4;
				SELF.ProviderAddressTierTypeID := [];
				self.first_seen := dt_first_seen;
				self.last_seen := dt_last_seen;
				SELF.phone:= DATASET( [ { Telephone_Number, 'Office Phone', 0 },
																{ Fax_Number,       'Office Fax',   0 } 
										          ], 
											        doxie.ingenix_provider_module.ingenix_phone_slim_rec 
										        ); 
			END;
 	
		// transform NPPES autokey layout into ING/NPPES output record layout		
		doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search xfm_NPPES_into_final_layout (ds_NPPES_NPIkey l) :=
		   TRANSFORM
			  SELF.rec_type                   := 'NPPES';
				SELF.name                       := PROJECT( l.clean_name_provider, xfm_NPPES_name_info( LEFT, l.Provider_Credential_Text ) );
				SELF.address                    := PROJECT( l.clean_location_address, xfm_NPPES_address_info( LEFT, l.Provider_Business_Practice_Location_Address_Telephone_Number, l.Provider_Business_Practice_Location_Address_Fax_Number, (String)l.dt_first_seen, (String)l.dt_last_seen ) );
				SELF.Provider_Organization_Name := l.Provider_Organization_Name;
				SELF.did                        := (string)l.did;
				SELF                            := l;
				SELF                            := [];
		   END;

		// Only NPPES data is output      
		ds_only_NPI_entered_out := PROJECT( choosen(dedup(sort(ds_NPPES_NPIkey,-process_date),record,all),1), xfm_NPPES_into_final_layout(LEFT));
    doxie.Mac_CHD_Penalty( ds_only_NPI_entered_out, ds_only_NPI_entered_out_final_pre,
								           name, prov_clean_fname, prov_clean_mname, prov_clean_lname,
					                 FALSE, faked_ssn_child, faked_ssn_field,
					                 TRUE, dob, birthdate, FALSE, address, prov_clean_predir,
					                 prov_clean_prim_range,prov_clean_prim_name,
								           prov_clean_addr_suffix,prov_clean_postdir,prov_clean_sec_range,
							             prov_clean_v_city_name,faked_county,prov_clean_st,prov_clean_zip,
					                 FALSE, faked_phone_child, faked_phone_field, TRUE );

		ds_only_NPI_entered_out_final := 
			PROJECT( ds_only_NPI_entered_out_final_pre, doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt );

		// transform NPPES autokey layout into ING/NPPES output record layout		
		doxie.ingenix_provider_module.layout_NPPES_provider_search_penalt xfm_NPPES_into_Penalty_layout (NPPES.Layouts.KeyBuild l, UNSIGNED c ) :=
		   TRANSFORM
        SELF.rec_count                  := c;
				SELF.rec_type                   := 'NPPES';
				SELF.name                       := PROJECT( l.clean_name_provider, xfm_NPPES_name_info( LEFT, l.Provider_Credential_Text ) );
				SELF.address                    := PROJECT( l.clean_location_address, xfm_NPPES_address_info( LEFT, l.Provider_Business_Practice_Location_Address_Telephone_Number, l.Provider_Business_Practice_Location_Address_Fax_Number, (String)l.dt_first_seen, (String)l.dt_last_seen  ) );
				SELF.MailingAddress             := PROJECT( l.clean_mailing_address,  xfm_NPPES_address_info( LEFT , l.Provider_Business_Mailing_Address_Telephone_Number, l.Provider_Business_Mailing_Address_Fax_Number, (String)l.dt_first_seen, (String)l.dt_last_seen  ) );
				SELF.Provider_Organization_Name := l.Provider_Organization_Name;
				SELF.did                        := (string)l.did;
				SELF                            := l;
				SELF                            := [];
		   END;
		
		/*
		1.  The NPPES data contains two different address fields--a location address and a mailing address. 
		Initially, the NPPES autokeys allowed a search only on the mailing address. The NPPES autokeys have 
		been enhanced so that the customer can search on both the Provider mailing address and location address.
		2.  Per Product Management, only the location address may be returned. The code has been modified to 
		penalize the input address against the mailing and location addresses to ensure we are not losing a hit 
		if the customer enters a PO box for the input address.
		3.  Since each NPPES record contains both the location and mailing address, when the system gets a hit 
		on the mailing address and it passes the penalization for that record, a transform preserves the 
		associated location address.
		4.  In the case where the customer enters the location address and the system gets a hit on the location 
		address that passes penalization, the location address is still returned. The transform always grabs the 
		location address for the output.
		* /
		ds_autokey_penalt_layout := PROJECT( ds_NPPES_autokey, xfm_NPPES_into_Penalty_layout( LEFT, COUNTER ));
		doxie.Mac_CHD_Penalty( ds_autokey_penalt_layout, ds_NPPES_autokey_Location_penalt,
								           name, prov_clean_fname, prov_clean_mname, prov_clean_lname,
					                 FALSE, faked_ssn_child, faked_ssn_field,
					                 TRUE, dob, birthdate, FALSE, address, prov_clean_predir,
					                 prov_clean_prim_range,prov_clean_prim_name,
								           prov_clean_addr_suffix,prov_clean_postdir,prov_clean_sec_range,
							             prov_clean_v_city_name,faked_county,prov_clean_st,prov_clean_zip,
					                 FALSE, faked_phone_child, faked_phone_field, TRUE );
                           
		doxie.Mac_CHD_Penalty( ds_autokey_penalt_layout, ds_NPPES_autokey_mailing_penalt,
								           name, prov_clean_fname, prov_clean_mname, prov_clean_lname,
					                 FALSE, faked_ssn_child, faked_ssn_field,
					                 TRUE, dob, birthdate,FALSE, MailingAddress, prov_clean_predir,
					                 prov_clean_prim_range, prov_clean_prim_name,
								           prov_clean_addr_suffix, prov_clean_postdir, prov_clean_sec_range,
							             prov_clean_v_city_name,faked_county,prov_clean_st,prov_clean_zip,
					                 FALSE, faked_phone_child, faked_phone_field, TRUE );
						  		
		
		ds_NPPES_ak_innerJoin := 
      JOIN( ds_NPPES_autokey_Location_penalt, ds_NPPES_autokey_mailing_penalt, 
		        LEFT.rec_count = RIGHT.rec_count,
						TRANSFORM( doxie.ingenix_provider_module.layout_Ingenix_NPPES_provider_search_penalt,
											 SELF.penalt := IF( LEFT.penalt < RIGHT.penalt, LEFT.penalt, RIGHT.penalt);
											 SELF        := LEFT;
											 SELF        := [];
										 ) // end transform
		      );  // end INNER join
		
		ds_NPPES_ak_fullOnlyJoin := 
      JOIN( ds_NPPES_autokey_Location_penalt, ds_NPPES_autokey_mailing_penalt, 
		        LEFT.rec_count = RIGHT.rec_count,
						TRANSFORM( doxie.ingenix_provider_module.layout_Ingenix_NPPES_provider_search_penalt,
											 SELF.penalt := IF( LEFT.rec_count = 0, RIGHT.penalt, LEFT.penalt);
											 SELF        := IF( LEFT.rec_count = 0, RIGHT, LEFT);
											 SELF        := [];
										 ),  // transform
                     FULL ONLY     
		      ); // end FULL ONLY join
		
		ds_NPPES_ak_combinedJoin := ds_NPPES_ak_innerJoin + ds_NPPES_ak_fullOnlyJoin;
		
		ds_NPPES_with_both_addresses_penalized   := PROJECT( ds_NPPES_ak_combinedJoin        , doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt );
		ds_NPPES_with_location_address_penalized := PROJECT( ds_NPPES_autokey_Location_penalt, doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt );
		ds_NPPES_with_mailing_address_penalized  := PROJECT( ds_NPPES_autokey_mailing_penalt , doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt );

		// If both files exist, we need one record containing the lowest penalty 
		// for each record that is in both datasets. In addition, we need each record 
		// from both datasets that do not have a corresponding record in the other dataset.
		// Else, location dataset exists and the mailing dataset doesn't. Use the dataset
		// having the location address penalty. Else, the mailing address dataset exists 
		// and the location dataset doesn't. Use the dataset having the mailing address penalty.
		ds_NPPES_ak_final_pre :=
			IF( EXISTS( ds_NPPES_autokey_location_penalt ),
				IF( EXISTS(  ds_NPPES_autokey_mailing_penalt ),
					ds_NPPES_with_both_addresses_penalized,
					ds_NPPES_with_location_address_penalized
				),		// end else
				ds_NPPES_with_mailing_address_penalized
			);

		
		ds_NPPES_ak_final_sorted :=
			SORT(
				ds_NPPES_ak_final_pre,
				rec_type,
				name[1].prov_clean_lname,
				name[1].prov_clean_fname,
				name[1].prov_clean_mname,
				address[1].prov_clean_prim_range,
				address[1].prov_clean_predir,
				address[1].prov_clean_prim_name,
				address[1].prov_clean_addr_suffix,
				address[1].prov_clean_postdir,
				address[1].prov_clean_sec_range,
				address[1].prov_clean_p_city_name,
				address[1].prov_clean_st,
				address[1].prov_clean_zip,
				address[1].prov_clean_zip4
			);
			
		ds_NPPES_ak_out_final :=
			ROLLUP(
				ds_NPPES_ak_final_sorted,
				TRANSFORM(
					doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt,
					SELF.ProviderID := IF( LEFT.ProviderID = '', RIGHT.ProviderID, LEFT.ProviderID ),
					SELF.address := IF( LEFT.address[1].phone[1].phonenumber = '', RIGHT.address, LEFT.address ),
					SELF.dob     := IF( LEFT.dob[1].birthdate = '', RIGHT.dob, LEFT.dob ),
					SELF.license := IF( LEFT.license[1].licensenumber = '', RIGHT.license, LEFT.license ),
					SELF.taxid   := IF( LEFT.taxid[1].taxid = '', RIGHT.taxid, LEFT.taxid ),
					SELF.npi     := IF( LEFT.npi = '', RIGHT.npi, LEFT.npi ),
					SELF.provider_organization_name 
					             := IF( LEFT.provider_organization_name = '', RIGHT.provider_organization_name, LEFT.provider_organization_name ),
					SELF := LEFT
				),
				rec_type,
				name[1].prov_clean_lname,
				name[1].prov_clean_fname,
				name[1].prov_clean_mname,
				address[1].prov_clean_prim_range,
				address[1].prov_clean_predir,
				address[1].prov_clean_prim_name,
				address[1].prov_clean_addr_suffix,
				address[1].prov_clean_postdir,
				address[1].prov_clean_sec_range,
				address[1].prov_clean_p_city_name,
				address[1].prov_clean_st,
				address[1].prov_clean_zip,
				address[1].prov_clean_zip4
			);
		
		// Both ING and NPPES are searched using FLAPSD 
		ds_ING_NPPES_out_final      := ds_ING_out_final + ds_NPPES_ak_out_final;

		// Both ING and NPPES are searched using FLAPSD + NPPES searched using NPI number
		ds_NPI_and_FLAPSD_out_final := ds_ING_NPPES_out_final + ds_only_NPI_entered_out_final;
		*/
    // The four code paths are described after the end of the attribute.
		out_final_with_penalt := ds_ING_out_final;
			// MAP( 
				// include_NPPES = FALSE OR
				// ( taxid_value != '' AND
				  // lname_val = ''       ) => ds_ING_out_final,   // added the taxid != '' last name  = '' check here because NPPES does not have taxid info. If the taxid is entered 
				// only_NPI_number_entered  => ds_only_NPI_entered_out_final,   // and the last name is all blank, then the final record set will most likely generate an OOM error
				// npi_number = ''          => ds_ING_NPPES_out_final, 
				// /* default........... */    ds_NPI_and_FLAPSD_out_final
			// ); 

		//verify NPI no longer needed as it is done in provider records consolidated																																
		// out_final_verified := Healthcare_provider_services.Functions.getNPIthruNPPES_SearchProv(out_final_with_penalt);

		// Slim off 'penalt'.
		out_final :=
			PROJECT(
				SORT( out_final_with_penalt, rec_type, penalt, name[1].prov_clean_lname,  IF((UNSIGNED6)providerid = 0, 999999999999, (UNSIGNED6)providerid ), RECORD ),
				doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search
			);

	
	// out_final := DATASET( [],doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search );
	// DEBUGs:
		// output(ds);
		// output(rawData);
		// output(rawDataFmt);
  // OUTPUT( out_final_with_penalt,        NAMED( 'out_final_with_penalt' ) );
  // OUTPUT( out_final_verified, NAMED( 'out_final_verified' ) );
  // output(ds_project_ING,named('ds_project_ING'));
  // output(ds_ING_out_final,named('ds_ING_out_final'));
	// output(ds_only_NPI_entered_out,named('ds_only_NPI_entered_out'));
	// output(ds_only_NPI_entered_out_final_pre,named('ds_only_NPI_entered_out_final_pre'));
	// output(ds_only_NPI_entered_out_final,named('ds_only_NPI_entered_out_final'));
	// output(ds_NPPES_ak_combinedJoin,named('ds_NPPES_ak_combinedJoin'));
	// output(ds_NPPES_with_both_addresses_penalized,named('ds_NPPES_with_both_addresses_penalized'));
	// output(ds_NPPES_with_location_address_penalized,named('ds_NPPES_with_location_address_penalized'));
	// output(ds_NPPES_with_mailing_address_penalized,named('ds_NPPES_with_mailing_address_penalized'));
	// output(ds_NPPES_ak_final_pre,named('ds_NPPES_ak_final_pre'));
	// output(ds_NPPES_ak_out_final,named('ds_NPPES_ak_out_final'));
	// output(ds_ING_NPPES_out_final,named('ds_ING_NPPES_out_final'));
	// output(ds_NPI_and_FLAPSD_out_final,named('ds_NPI_and_FLAPSD_out_final'));
	// output(out_final_with_penalt,named('out_final_with_penalt'));
	RETURN out_final;
  // RETURN out_final_with_penalt; 

END;


/*  June 2011
1)	These four cases describe what the system must do regarding Ingenix and NPPES data when a customer uses the Provider search form:
    a.	A customer enters ONLY  name, dob, addr, tax id, license#, and/or license state and does not select the NPPES checkbox.
           i.	The current Ingenix search is preformed and Ingenix output as it is today.  (The NPPES data is not searched) 
    b.	A customer enters ONLY an NPI number and selects the NPPES checkbox 
           i.	 Only NPPES will be searched using the NPI number and the NPI data will be displayed (the current Provider section blank and the NPPES section populated)
    c.	A customer enters BOTH provider information AND an NPI number and selects the NPPES checkbox 
           i.	 The personal information input will be used to search the Ingenix data as done today
           ii.	 The personal information input will be used to search the NPPES files using autokeys
           iii. The NPI number will be used to search the NPPES data using the NPI key file
           iv.	 Both the Ingenix data and the NPPES data will be displayed as in the screenshot provided
    d.   A customer enters ONLY  name, dob, addr, tax id, license#, and/or license state information, SELECTS the NPPES checkbox, but DOES NOT enter an NPI number:
           i.	 The personal information input will be used to search the Ingenix data (as done today)
           ii.	 The personal information input will also be used to search the NPPES data using autokeys
           iii. Both the Ingenix data and the NPPES data will be displayed as in the screenshot provided

2)	When the customer selects the Provider License Report on the cite listing, no NPPES data will be displayed; only Ingenix data.

Note: A request will be made to create a Health Care Provider Header that will do the linking and will allow for the NPPES/OIG data to be backfilled into the existing Ingenix Provider / Sanctions reports.

*/
