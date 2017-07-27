import Property, iesp, MDR;
export Foreclosure_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Property.File_Foreclosure_Base_v2;  // U foreclosure, N notice of Default
	//shared base := Property.file_foreclosure_building;

	shared filtered := base(name1_company != ''); 
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		extract := normalize(filtered, if(left.situs1_p_city_name != left.situs1_v_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source :=  MDR.sourceTools.src_Foreclosures, // Foreclosure
				self.source_docid := left.foreclosure_id;
				self.source_party := ''; // 
				self.date_first_seen := 0, // (unsigned4)left.recording_date,
				self.date_last_seen := (unsigned4)left.recording_date,
				self.company_name :=  left.name1_company, // also left.title_company_name as well.
				 // situs1 is property address, situs2 is mailing addr
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN;
				self.address_type :=  Constants.Address_Types.UNKNOWN;
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid        :=    left.situs1_rawaid,
				self.prim_range :=    left.situs1_prim_range,
				self.predir :=        left.situs1_predir,
				self.prim_name   :=   left.situs1_prim_name,
				self.addr_suffix :=   left.situs1_addr_suffix,
				self.postdir     :=   left.situs1_postdir,
				self.unit_desig  :=   left.situs1_unit_desig,
				self.sec_range   :=   left.situs1_sec_range, //
				self.city_name   :=  choose(counter,
														 left.situs1_p_city_name,
														 left.situs1_v_city_name),
				self.state := left.situs1_st,
				self.zip   := left.situs1_zip,
				self.county_fips := left.situs1_fipscounty,
				self.msa   := left.situs1_msa,
				self.phone := '',
				self.fein  := '',
				self.url   := '',
				self.duns  := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return dedup(extract,all);
	end;

	export dataset(Layout_Property.Main.Unlinked) As_Property_Master := function
					 
		extract :=  project(base,
			transform(Layout_Property.Main.Unlinked,
				self.source :=  MDR.sourceTools.src_Foreclosures, // Foreclosure
				self.source_docid := left.foreclosure_id;
				self.event_id     := 'FR' + hash32(left.foreclosure_id);
				self.vendor       := '';
				self.county_code  := left.state + left.county;
				self.apn          := stringlib.StringFilter(left.parcel_number_parcel_id,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
				self.property_address := iesp.ECL2ESP.SetAddress(
				left.situs1_prim_name,left.situs1_prim_range,left.situs1_predir,left.situs1_postdir,
				left.situs1_addr_suffix,left.situs1_unit_desig,left.situs1_sec_range,left.situs1_v_city_name,
				left.situs1_st,left.situs1_zip,
				left.situs1_zip4,
				'','','','','');			
				self.legal_description := '';
				self := left));

		 return dedup(dedup(extract,record,all,local),record,all);
	end;
	
	export dataset(Layout_Property.Foreclosure.Unlinked) As_Property_Master_Foreclosure := function
	
		extract :=  project(base,
			transform(Layout_Property.Foreclosure.Unlinked,
				self.foreclosure_event_id := 'FR' + hash32(left.foreclosure_id);
				self.vendor       := '';
				self.Documenttype := left.deed_desc,
				self.recordingdate := left.recording_date,
				self := left));
				
		return dedup(extract,record,all);
		
	end;
	
	export dataset(Layout_Property.Party.Unlinked) As_Property_Master_Party := function	  
		extract := project(base,
			transform(Layout_Property.Party.Unlinked,
				self.source :=  MDR.sourceTools.src_Foreclosures, // Foreclosure
				self.source_docid := left.foreclosure_id;
				self.source_party := ''; // 
				self.vendor       := '';
				self.event_id := 'FR' + hash32(left.foreclosure_id);
				self.party_type   := '';
				self.party_type_address := '';
				self.company_name := left.name1_company,
				self.owner_date := 0,
				self.name_last := left.name1_last,
				self.name_first := left.name1_first,
				self.name_middle := left.name1_middle,
				self.name_suffix := left.name1_suffix,
				self.name_title := left.name1_prefix,
				self.prim_range := left.situs1_prim_range,
				self.predir := left.situs1_predir,
				self.prim_name := left.situs1_prim_name,
				self.addr_suffix := left.situs1_addr_suffix,
				self.postdir := left.situs1_postdir,
				self.unit_desig := left.situs1_unit_desig,
				self.sec_range := left.situs1_sec_range,
				self.city_name := left.situs1_v_city_name,
				self.state := left.situs1_st,
				self.zip := left.situs1_zip,
				self.sales_date := 0,
				self.salesPrice := 0));

			return extract;
			
	end;
	
end;
