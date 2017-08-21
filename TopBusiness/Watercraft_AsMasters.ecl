import Address,Watercraft,MDR;

export Watercraft_AsMasters := module(Interface_AsMasters.Unlinked.Default)

  shared main_base       := Watercraft.File_Base_Main_Prod;   // vessel/registration info & lienholder1/2 name/addr
	shared search_base     := Watercraft.File_Base_Search_Prod; // owner & registrant name/addr
	shared main_filtered   := main_base(watercraft_key != '');
	shared search_filtered := search_base(watercraft_key != '');

  // Extract company name/address info for linking from both watercraft main & search files
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function

    // First extract owner & registrant company name/addr from the watercraft search file
		search_extracted := normalize(search_filtered(company_name != ''),if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source          := MDR.sourceTools.fWatercraft(left.source_code,left.state_origin),
				self.source_docid    := trim(left.watercraft_key) + '//' + left.sequence_key,
				self.source_party    := left.orig_name_type_code + hash64(left.company_name),
				// OR name_type_code + hash comp name & addr parts like done in UCC ----v    ???
				//self.source_party    := left.party_type[1] + intformat(hash32(left.orig_name,left.orig_address1,left.orig_address2,left.orig_city,left.orig_state,left.orig_zip5) % 1000000000,9,1),
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen  := (unsigned4)left.date_last_seen,
				self.company_name    := left.company_name,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid             := 0,
				self.prim_range      := left.prim_range,
				self.predir          := left.predir,
				self.prim_name       := left.prim_name,
				self.addr_suffix     := left.suffix,
				self.postdir         := left.postdir,
				self.unit_desig      := left.unit_desig,
				self.sec_range       := left.sec_range,
				self.city_name       := choose(counter,left.p_city_name,left.v_city_name),
				self.state           := left.st,
				self.zip             := left.zip5,
				self.zip4            := left.zip4,
				self.county_fips     := left.ace_fips_county,
				self.msa             := left.msa,
				self.phone           := left.phone_1, 
				self.fein            := left.fein,
				self.url             := '',
				self.duns            := '',
				self.experian        := '',
				self.zoom := '',
				self.incorp_state    := '',
				self.incorp_number   := ''));


    // Next extract lienholder1&2 name/address info from the watercraft main file.
		main_extracted := normalize(main_filtered(lien_1_name != ''),if(left.lien_2_name != '',2,1),
			transform(Layout_Linking.Unlinked,
				self.source          := MDR.sourceTools.fWatercraft(left.source_code,left.state_origin),
				self.source_docid    := trim(left.watercraft_key) + '//' + left.sequence_key,
        // v--- L=Lienholder to distinguish these from O(Owner) & R(Registrant) recs from above
				self.source_party    := 'L' + hash64(choose(counter,left.lien_1_name,left.lien_2_name)),
				                        //    ^----- OR ???
				self.date_first_seen := (unsigned4) left.title_issue_date;
				self.date_last_seen  := (unsigned4)choose(counter,left.lien_1_date,left.lien_2_date),
				self.company_name    := choose(counter,left.lien_1_name,left.lien_2_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				lien_addr_line1      := choose(counter,left.lien_1_address_1 + left.lien_1_address_2,
	                                             left.lien_2_address_1 + left.lien_2_address_2);
				lien_addr_line2      := choose(counter,left.lien_1_city+left.lien_1_state+left.lien_1_zip,
				                                       left.lien_2_city+left.lien_2_state+left.lien_2_zip);
				parsed_addr := address.CleanAddress183(lien_addr_line1,lien_addr_line2);
				self.aid             := 0,
				self.prim_range      := Address.CleanFields(parsed_addr).prim_range,
				self.predir          := Address.CleanFields(parsed_addr).predir,
				self.prim_name       := Address.CleanFields(parsed_addr).prim_name,
				self.addr_suffix     := Address.CleanFields(parsed_addr).addr_suffix,
				self.postdir         := Address.CleanFields(parsed_addr).postdir,
				self.unit_desig      := Address.CleanFields(parsed_addr).unit_desig,
				self.sec_range       := Address.CleanFields(parsed_addr).sec_range,
				self.city_name       := Address.CleanFields(parsed_addr).p_city_name,
				self.state           := Address.CleanFields(parsed_addr).st,
				self.zip             := Address.CleanFields(parsed_addr).zip,
				self.zip4            := Address.CleanFields(parsed_addr).zip4,
				self.county_fips     := Address.CleanFields(parsed_addr).county[3..5],
				self.msa             := Address.CleanFields(parsed_addr).msa,
				self.phone           := '', 
				self.fein            := '',
				self.url             := '',
				self.duns            := '',
				self.experian        := '',
				self.zoom := '',
				self.incorp_state    := '',
				self.incorp_number   := ''));
	
		// combine search & main extracted data
		all_extracted := search_extracted + main_extracted;

		return all_extracted;

	end;


  // Extract vessel&registration info for unlinked records from the entire watercraft main file
	export dataset(Layout_Watercraft.Main.Unlinked) As_Watercraft_Master := function

		main_extracted := project(main_base,
			  transform(Layout_Watercraft.Main.Unlinked,
					self.source          := MDR.sourceTools.fWatercraft(left.source_code,left.state_origin),
				self.source_docid    := trim(left.watercraft_key) + '//' + left.sequence_key,
		      // vessel & basic registration info from the right main rec
				  self.st_registration                 := left.st_registration;
	        self.hull_number                     := left.hull_number;
	        self.model_year                      := left.model_year;
		      self.watercraft_make_description     := left.watercraft_make_description;
	        self.propulsion_description          := left.propulsion_description;
	        self.watercraft_length               := left.watercraft_length;
	        self.use_description                 := left.use_description;
	        self.name_of_vessel                  := left.watercraft_name;
	        self.registration_status_description := left.registration_status_description;
	        self.registration_number             := left.registration_number; 
	        self.registration_date               := left.registration_date;
	        self.registration_expiration_date    := left.registration_expiration_date;
					self.history_flag                    := left.history_flag;
		));

		return main_extracted;

	end;


  // Extract company name/address info for party records from both watercraft main & search files
	export dataset(Layout_Watercraft.Party) As_Watercraft_Master_Party := function

    // First extract owner & registrant name/addr from the watercraft search file
		search_extracted := join(dedup(main_filtered,watercraft_key,sequence_key,all),search_filtered,
			left.watercraft_key = right.watercraft_key and
			left.sequence_key = right.sequence_key,
			transform(Layout_Watercraft.party,
			  // get fields used for linking from the main file
				self.hull_number                := left.hull_number;
				self.registration_date          := left.registration_date;
				self.history_flag               := left.history_flag;
				// get all other fields from the search file
				self.orig_name_type_code        := right.orig_name_type_code;
				self.orig_name_type_description := right.orig_name_type_description;
	      self.company_name               := right.company_name;
	      self.title                      := right.title;
	      self.fname                      := right.fname;
	      self.mname                      := right.mname;
	      self.lname                      := right.lname;
	      self.name_suffix                := right.name_suffix;
	      self.prim_range                 := right.prim_range;
	      self.predir                     := right.predir;
	      self.prim_name                  := right.prim_name;
	      self.suffix                     := right.suffix;
	      self.postdir                    := right.postdir;
	      self.unit_desig                 := right.unit_desig;
	      self.sec_range                  := right.sec_range;
	      self.city_name                  := right.p_city_name;
	      self.st                         := right.st;
	      self.zip5                       := right.zip5;
	      self.zip4                       := right.zip4
		));

    // Next extract lienholder1&2 name/address info from the main file.
		main_extracted := normalize(main_filtered(lien_1_name != ''),if(left.lien_2_name != '',2,1),
			transform(Layout_watercraft.party,
			  // get fields used for linking & party info fields all from the main file
				self.hull_number       := left.hull_number;
				self.registration_date := left.registration_date;
				self.history_flag      := left.history_flag;
				self.orig_name_type_code        := 'L';
				self.orig_name_type_description := 'LIENHOLDER';
				self.company_name    := choose(counter,left.lien_1_name,left.lien_2_name),
	      self.title           := '';
	      self.fname           := '';
	      self.mname           := '';
	      self.lname           := '';
	      self.name_suffix     := '';
				lien_addr_line1      := choose(counter,left.lien_1_address_1 + left.lien_1_address_2,
	                                             left.lien_2_address_1 + left.lien_2_address_2);
				lien_addr_line2      := choose(counter,left.lien_1_city+left.lien_1_state+left.lien_1_zip,
				                                       left.lien_2_city+left.lien_2_state+left.lien_2_zip);
				parsed_addr := address.CleanAddress183(lien_addr_line1,lien_addr_line2);
				self.prim_range      := Address.CleanFields(parsed_addr).prim_range,
				self.predir          := Address.CleanFields(parsed_addr).predir,
				self.prim_name       := Address.CleanFields(parsed_addr).prim_name,
				self.suffix          := Address.CleanFields(parsed_addr).addr_suffix,
				self.postdir         := Address.CleanFields(parsed_addr).postdir,
				self.unit_desig      := Address.CleanFields(parsed_addr).unit_desig,
				self.sec_range       := Address.CleanFields(parsed_addr).sec_range,
				self.city_name       := Address.CleanFields(parsed_addr).p_city_name,
				self.st              := Address.CleanFields(parsed_addr).st,
				self.zip5            := Address.CleanFields(parsed_addr).zip,
				self.zip4            := Address.CleanFields(parsed_addr).zip4,
	  ));			

		// combine search & main extracted data
		all_extracted := search_extracted + main_extracted;
		return all_extracted;

	end;

end;
