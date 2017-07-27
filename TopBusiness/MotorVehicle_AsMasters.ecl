import Address,VehicleV2,MDR;

export MotorVehicle_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared party_base       := VehicleV2.File_VehicleV2_Party; // party & title/registration info
	shared party_filtered_init   := party_base(Vehicle_key != '');

  shared main_base        := VehicleV2.File_VehicleV2_Main;  // vehicle characteristics info
	shared main_filtered    := 
		join(
			main_base(Vehicle_key != ''),
			dedup(party_filtered_init(Append_Clean_cname != ''),vehicle_key,all),
			left.vehicle_key = right.vehicle_key,
			transform(left));
	
	shared party_filtered :=
		join(
			party_filtered_init,
			dedup(party_filtered_init(Append_Clean_cname != ''),vehicle_key,all),
			left.vehicle_key = right.vehicle_key,
			transform(left));
			
  // Extract company name/address info for linking from temp combined party file
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function

  linking_extracted := project(party_filtered(append_clean_cname != ''),
			transform(Layout_Linking.Unlinked,
				self.source          := MDR.sourceTools.fVehicles(left.state_origin,left.source_code),
				self.source_docid    := left.vehicle_key;
				self.source_party    := left.orig_name_type + 
				                        intformat(hash32(left.orig_name,left.orig_address,
																								 left.orig_city, left.orig_state,
																								 left.orig_zip) % 1000000000,9,1),
				self.date_first_seen := (unsigned4)left.date_first_seen,
				self.date_last_seen  := (unsigned4)left.date_last_seen,
				self.company_name    := left.Append_Clean_cname,
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range      := left.Append_Clean_Address.prim_range,
				self.predir          := left.Append_Clean_Address.predir,
				self.prim_name       := left.Append_Clean_Address.prim_name,
				self.addr_suffix     := left.Append_Clean_Address.addr_suffix,
				self.postdir         := left.Append_Clean_Address.postdir,
				self.unit_desig      := left.Append_Clean_Address.unit_desig,
				self.sec_range       := left.Append_Clean_Address.sec_range,
				self.city_name       := left.Append_Clean_Address.v_city_name,
				self.state           := left.Append_Clean_Address.st,
				self.zip             := left.Append_Clean_Address.zip5,
				self.county_fips     := left.Append_Clean_Address.fips_county,
				self.msa             := '',
				self.phone           := '', 
				self.fein            := '',
				self.url             := '',
				self.duns            := '',
				self.experian        := '',
				self.zoom := '',
				self.incorp_state    := '',
				self.incorp_number   := ''));

		return linking_extracted;

	end;
	
  // Extract info for unlinked records from the entire vehicle party/main combined file
	export dataset(Layout_motorvehicle.Main.Unlinked) As_motorvehicle_Master := function

   unlinked_extracted := project(main_filtered,
			  transform(Layout_motorvehicle.Main.Unlinked,
					self.source          := MDR.sourceTools.fVehicles(left.state_origin,left.source_code),
 				  self.source_docid    := trim(left.vehicle_key,left,right) + '//' +  trim(left.iteration_key,left,right); // OR left.orig_vin; ???
					self.vendor          := left.source_code;
					self.vehicle_id      := left.vehicle_key;
					// v--- fields from the base vehiclev2 main file
          self.VIN                := left.orig_VIN,
	        self.Vehicle_Type       := left.Orig_Vehicle_Type_Desc;
	        self.Model_Year         := if(left.VINA_Model_Year != '',left.VINA_Model_Year,left.orig_year),
	        self.Make               := if(left.VINA_Make_Desc != '',left.VINA_Make_Desc,left.orig_make_desc),
	        self.Series             := if(left.VINA_VP_Series_Name != '',left.VINA_VP_Series_Name,left.orig_series_desc), // contains model & series info combined, i..e Civic LX
	        self.Style              := if(left.VINA_Body_Style_Desc != '',left.VINA_Body_Style_Desc,left.orig_body_desc),
	        self.Base_Price         := left.VINA_Price));
		
		return dedup(dedup(unlinked_extracted,record,all,local),record,all);
	
	end;
	
	export dataset(Layout_MotorVehicle.Title) As_MotorVehicle_Master_Title := function
	
		unlinked_extracted := project(party_filtered(Ttl_Latest_Issue_Date != ''),
			transform(Layout_MotorVehicle.Title,
				self.vendor        := left.source_code,
				self.vehicle_id    := left.vehicle_key,
				self.event_id      := 'T' + hash64(left.vehicle_key,left.state_origin,if(left.ttl_number != '',left.ttl_number,left.ttl_latest_issue_date)),
				self.state_jurisdiction := left.state_origin,
	      self.Title_Number  := left.Ttl_Number;
	      self.Title_Date    := left.Ttl_Latest_Issue_Date));
		
		return dedup(dedup(unlinked_extracted,record,all,local),record,all);
		
	end;
	
	export dataset(Layout_MotorVehicle.Registration) As_MotorVehicle_Master_Registration := function
		
		unlinked_extracted := project(party_filtered(Reg_Latest_Effective_Date != ''),
			transform(Layout_MotorVehicle.Registration,
				self.vendor := left.source_code,
				self.vehicle_id    := left.vehicle_key,
				self.event_id := 'R' + hash64(left.vehicle_key,left.state_origin,if(left.reg_latest_effective_date != '',left.reg_latest_effective_date,left.reg_first_date)),
				self.state_jurisdiction := left.state_origin,
				self.Original_Registration_Date   := if(left.Reg_First_Date !='',
																								left.Reg_First_Date,
																								left.Reg_Earliest_Effective_Date);
				self.Registration_Date            := left.Reg_Latest_Effective_Date;
				self.Registration_Expiration_Date := left.Reg_Latest_Expiration_Date;
				self.License_Plate                := left.Reg_License_Plate;
				self.License_Plate_Type           := left.Reg_License_Plate_Type_Desc;
				self.Previous_License_Plate       := left.Reg_Previous_License_Plate));

		deduped_extracted := dedup(dedup(unlinked_extracted,record,all,local),record,all);
	 
	 return deduped_extracted;

	end;

  // Extract name/address info from the entire vehicle party/main combined file
	export dataset(Layout_motorvehicle.Party) As_motorvehicle_Master_Party := function

   party_extracted_title := project(party_filtered(Ttl_Latest_Issue_Date != ''),
		 transform(Layout_motorvehicle.party,
				self.event_id      := 'T' + hash64(left.vehicle_key,left.state_origin,if(left.ttl_number != '',left.ttl_number,left.ttl_latest_issue_date)),
				self.vendor       := left.source_code;  // needed for linking ???
				self.party_type             := left.orig_name_type;
				self.party_type_description := map(left.orig_name_type = '1' => 'Owner',
				                                   left.orig_name_type = '2' => 'Lessor',
																					 left.orig_name_type = '4' => 'Registrant', 
																					 left.orig_name_type = '5' => 'Lessee',
																					 left.orig_name_type = '7' => 'LienHolder',	
                                           'Unknown'); // OR left.orig_name_type);  ???
        self.company_name               := left.Append_Clean_CName;
        self.title                      := left.Append_Clean_Name.title;
        self.fname                      := left.Append_Clean_Name.fname;
	      self.mname                      := left.Append_Clean_Name.mname;
	      self.lname                      := left.Append_Clean_Name.lname;
	      self.name_suffix                := left.Append_Clean_Name.name_suffix;
				self.prim_range                 := left.Append_Clean_Address.prim_range,
				self.predir                     := left.Append_Clean_Address.predir,
				self.prim_name                  := left.Append_Clean_Address.prim_name,
				self.addr_suffix                := left.Append_Clean_Address.addr_suffix,
				self.postdir                    := left.Append_Clean_Address.postdir,
				self.unit_desig                 := left.Append_Clean_Address.unit_desig,
				self.sec_range                  := left.Append_Clean_Address.sec_range,
				self.city_name                  := left.Append_Clean_Address.v_city_name,
				self.st                         := left.Append_Clean_Address.st,
				self.zip5                       := left.Append_Clean_Address.zip5,
				self.zip4                       := left.Append_Clean_Address.zip4,
				self.did												:= (unsigned)left.Append_DID,
				self.ssn												:= (unsigned)left.Append_SSN,
				self.history                    := left.history
		));

   party_extracted_registration := project(party_filtered(Reg_Latest_Effective_Date != ''),
		 transform(Layout_motorvehicle.party,
				self.event_id := 'R' + hash64(left.vehicle_key,left.state_origin,if(left.reg_latest_effective_date != '',left.reg_latest_effective_date,left.reg_first_date)),
				self.vendor       := left.source_code;  // needed for linking ???
				self.party_type             := left.orig_name_type;
				self.party_type_description := map(left.orig_name_type = '1' => 'Owner',
				                                   left.orig_name_type = '2' => 'Lessor',
																					 left.orig_name_type = '4' => 'Registrant', 
																					 left.orig_name_type = '5' => 'Lessee',
																					 left.orig_name_type = '7' => 'LienHolder',	
                                           'Unknown'); // OR left.orig_name_type);  ???
        self.company_name               := left.Append_Clean_CName;
        self.title                      := left.Append_Clean_Name.title;
        self.fname                      := left.Append_Clean_Name.fname;
	      self.mname                      := left.Append_Clean_Name.mname;
	      self.lname                      := left.Append_Clean_Name.lname;
	      self.name_suffix                := left.Append_Clean_Name.name_suffix;
				self.prim_range                 := left.Append_Clean_Address.prim_range,
				self.predir                     := left.Append_Clean_Address.predir,
				self.prim_name                  := left.Append_Clean_Address.prim_name,
				self.addr_suffix                := left.Append_Clean_Address.addr_suffix,
				self.postdir                    := left.Append_Clean_Address.postdir,
				self.unit_desig                 := left.Append_Clean_Address.unit_desig,
				self.sec_range                  := left.Append_Clean_Address.sec_range,
				self.city_name                  := left.Append_Clean_Address.v_city_name,
				self.st                         := left.Append_Clean_Address.st,
				self.zip5                       := left.Append_Clean_Address.zip5,
				self.zip4                       := left.Append_Clean_Address.zip4,
				self.did												:= (unsigned)left.Append_DID,
				self.ssn												:= (unsigned)left.Append_SSN,
				self.history                    := left.history
		));

		return party_extracted_title + party_extracted_registration;

	end;

end;
