IMPORT Address, AutoStandardI, doxie, Healthcare_Header_Services, ut;

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
		Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
			 self.glb_ok := ut.glb_ok (gm.GLBPurpose);
			 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
                         self.DRM := gm.DataRestrictionMask;
	 	   self.glb:= gm.GLBPurpose;
       self.dppa:= gm.DPPAPurpose; 

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
		 
// NPPESS no longer needed as Header does it all

    // The four code paths are described after the end of the attribute.
		out_final_with_penalt := ds_ING_out_final;

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
