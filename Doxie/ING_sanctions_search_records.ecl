IMPORT autokey, autokeyI, doxie, AutoStandardI, Address, OIG, Healthcare_Header_Services,ut,Gateway;

EXPORT ING_Sanctions_Search_Records ( STRING11 taxid_value, BOOLEAN include_OIG ) := 
   FUNCTION


		gateways_in := Gateway.Configuration.Get();
		dHCPGWCfg := gateways_in(Gateway.Configuration.IsHCHCP(Gateway.Constants.ServiceName.IsHCHCP));
    doxie.MAC_Header_Field_Declare()
		gm := AutoStandardI.GlobalModule();
		//Format search criteria into new format
		n1 := Address.CleanNameFields (address.CleanPersonFML73(gm.unparsedfullname));
		a1 := Address.CleanFields(address.GetCleanAddress(gm.addr,gm.city+' '+gm.state+' '+gm.zip,address.Components.Country.US).str_addr);
		newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
		newlayout setinput():=	transform
																 self.acctno:='1';
																 isUnparsedName := gm.unparsedfullname <> '';
																 self.name_first := if (isUnparsedName,n1.fname,gm.firstname);
																 self.name_middle := if (isUnparsedName,n1.mname,gm.middlename);
																 self.name_last := if (isUnparsedName,n1.lname,gm.lastname);
																 self.name_suffix := if(isUnparsedName,n1.name_suffix,gm.namesuffix);
																 self.prim_range := a1.prim_range;
																 self.predir := a1.predir;
																 self.prim_name := a1.prim_name;
																 self.addr_suffix := a1.addr_suffix;
																 self.postdir := a1.postdir;
																 self.unit_desig := '';
																 self.sec_range := a1.sec_range;
																 self.p_city_name := gm.city;
																 self.st := gm.state;
																 self.z5 := gm.zip;
																 self.zip4 := '';
																 self.dob := (string)gm.dob;
																 self.did := (integer)gm.did;
																 self.TaxID := taxid_value;
																 self.providersrc := if(exists(dHCPGWCfg),'P','');
																 self:=[]
														end;
		ds:=dataset([setinput()]);
		tmpMod:= MODULE(PROJECT(gm, Healthcare_Header_Services.IParams.searchParams,opt))	end;	
		Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
			 self.glb_ok := ut.glb_ok (gm.GLBPurpose);
			 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
			 self.DRM := gm.DataRestrictionMask;
	 		self.glb:= gm.GLBPurpose;
                        self.dppa:= gm.DPPAPurpose; 
		 self.includeSanctions := true;
			// self:=[];Do not uncomment otherwise the default values will not get set.
		end;
		cfg:=dataset([buildConfig()]);
		rawData := Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(ds,cfg);
		filterResponse := rawdata(exists(legacysanctions));

    org_out_rec := doxie.ingenix_sanctions_module.layout_ingenix_OIG_sanctions_search;

		org_out_rec xfm_ingenix_into_final_layout (Healthcare_Header_Services.Layouts.layout_LegacySanctions l) :=
		   TRANSFORM
			   SELF.rec_type := 'ING';
				 self.did := (integer)l.did;
				 self.provco_address_clean_v_city_name:=l.provco_address_clean_p_city_name;
				SELF          :=   l;
				SELF          :=  [];
			END; // end sanction transform into final layout

		ds_sanc_recs_in_output_layout := project(filterResponse.LegacySanctions, xfm_ingenix_into_final_layout(left));


	   // Get OIG autokey data using autokeys
		ds_OIG_autokey := OIG.Autokey_payload();
		
		// transform OIG results into final layout with ingenix data included
		doxie.ingenix_sanctions_module.layout_ingenix_OIG_sanctions_search xfm_OIG_into_final_layout ( OIG.layouts.KeyBuild l ) :=
		   TRANSFORM
			   SELF.rec_type                         := 'OIG';
				SELF.did                              := l.did;
			   SELF.Prov_Clean_fname                 := l.FIRSTNAME;
			   SELF.Prov_Clean_mname                 := l.MIDNAME;
			   SELF.Prov_Clean_lname                 := l.LASTNAME;
			   SELF.ProvCo_Address_Clean_prim_range  := l.prim_range;
			   SELF.ProvCo_Address_Clean_predir      := l.predir;
			   SELF.ProvCo_Address_Clean_prim_name   := l.prim_name;
			   SELF.ProvCo_Address_Clean_addr_suffix := l.addr_suffix;
			   SELF.ProvCo_Address_Clean_postdir     := l.postdir;
			   SELF.ProvCo_Address_Clean_unit_desig  := l.unit_desig;
			   SELF.ProvCo_Address_Clean_sec_range   := l.sec_range;
			   SELF.ProvCo_Address_Clean_p_city_name := l.p_city_name;
			   SELF.ProvCo_Address_Clean_v_city_name := l.v_city_name;
			   SELF.ProvCo_Address_Clean_st          := l.st;
			   SELF.ProvCo_Address_Clean_zip         := l.zip;
			   SELF.ProvCo_Address_Clean_zip4        := l.zip4;
			   SELF.SANC_DOB                         := l.DOB;
			   SELF                                  := l;    	
		      SELF                                  := [];
		   END; // end OIG transform into final layout
		
		ds_OIG_recs_in_output_layout  := PROJECT( ds_OIG_autokey, xfm_OIG_into_final_layout ( LEFT ) );

		ds_sanc_and_OIG_recs_in_output_layout := ds_sanc_recs_in_output_layout + ds_OIG_recs_in_output_layout;
		
      // 20110616 -- Added option to display OIG data records		
		ds_out_recs :=  IF( include_OIG,
		                    ds_sanc_and_OIG_recs_in_output_layout,
								  ds_sanc_recs_in_output_layout
								 ); 

		// output(ds,named('SearchCriteria'));
		// output(rawData,named('rawData'));
		// output(filterResponse,named('filterResponse'));
		// output(ds_sanc_recs_in_output_layout,named('ds_sanc_recs_in_output_layout'));
		// output(ds_OIG_recs_in_output_layout,named('ds_OIG_recs_in_output_layout'));
	
   RETURN ds_out_recs;

END;