import ut,mdr,Address,business_header,prte2_Vehicle, header,standard, VehicleV2, std;

EXPORT as_headers := module

//YOU ONLY NEED THIS WHEN YOUR FILE HAS CONSUMERS
	header.Layout_New_Records		map_to_new_recs(layouts.Party_Building	l)	:= 	transform
	  self.src                      := MDR.sourceTools.fVehicles(l.state_origin,l.source_code);   //Multiple email sources
		self.did											:= (unsigned6)l.append_did;
		self.rid											:= 0;
		self.dt_first_seen 						:= l.date_first_seen;
		self.dt_last_seen  						:= l.date_last_seen;
		self.dt_vendor_last_reported	:= l.date_vendor_last_reported;
		self.dt_vendor_first_reported	:= l.date_vendor_first_reported;
		self.dt_nonglb_last_seen      := l.date_last_seen;
		self.rec_type                 := IF(regexfind('R', l.Sequence_Key) and l.history='','1','2');
		self.vendor_id                := l.vehicle_key;
		self.ssn											:= if ((integer)l.orig_ssn=0,'',l.orig_ssn);
		self.dob											:= (integer)l.orig_DOB;
		self.title										:= l.Append_Clean_Name.title;
		self.fname										:= l.Append_Clean_Name.fname;
		self.mname										:= l.Append_Clean_Name.mname;
		self.lname										:= l.Append_Clean_Name.lname;
		self.name_suffix							:= l.Append_Clean_Name.name_suffix;
		self.prim_range								:= l.Append_Clean_Address.prim_range;
		self.predir										:= l.Append_Clean_Address.predir;
		self.prim_name								:= l.Append_Clean_Address.prim_name;
		self.suffix										:= l.Append_Clean_Address.addr_suffix;
		self.postdir									:= l.Append_Clean_Address.postdir;
		self.unit_desig								:= l.Append_Clean_Address.unit_desig;
		self.sec_range								:= l.Append_Clean_Address.sec_range;
		self.city_name								:= l.Append_Clean_Address.v_city_name;
		self.st												:= l.Append_Clean_Address.st;
		self.zip					    				:= l.Append_Clean_Address.zip5;
		self.zip4					    				:= l.Append_Clean_Address.zip4;
		self.county										:= l.Append_Clean_Address.fips_county;
		self.cbsa					   					:= l.Append_Clean_Address.cbsa;
		self.geo_blk				  			  := l.Append_Clean_Address.geo_blk;
		self.phone										:= '';
		self := l;
	end;

	export person_header_vehicle_recs :=project(files.party_building(orig_party_type<>'B' and append_did <> 0),map_to_new_recs(left));



//YOU ONLY NEED THIS WHEN YOUR FILE HAS BUSINESSES - THIS SENDS DATA INTO THE LEGACY BUSINESS HEADER
map_to_old_business_header(dataset(recordof(files.party_building)) in_ds) := function
	
	Business_Header.Layout_Business_Header_New xform1(in_ds le) := transform
		//UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER 
		self.rcid 										:= 0; //Not available
		SELF.source                   := MDR.sourceTools.fVehicles(le.state_origin,le.source_code);
		SELF.BDID                     := (unsigned6)le.append_bdid;	
		self.vl_id                    := TRIM(le.vehicle_key); 
		SELF.vendor_id                := '';
		SELF.source_group             := '';
		SELF.dt_first_seen  				  := (unsigned4)le.date_first_seen;
		SELF.dt_last_seen  					  := (unsigned4)le.date_last_seen;
		SELF.dt_vendor_first_reported := (unsigned4)le.date_vendor_first_reported;
		SELF.dt_vendor_last_reported  := (unsigned4)le.date_vendor_last_reported;
		SELF.company_name             := std.str.ToUppercase(STD.Str.CleanSpaces(le.append_clean_cname));
		SELF.current                  := true;
		//the existing data doesn't really support the normalize due to the invalid addresses for admin and tech
		//i just did this so you'd see the proper way of handling if good data was there	
		SELF.prim_range 							:= le.append_clean_address.prim_range;
		SELF.predir     							:= le.append_clean_address.predir;
		SELF.prim_name  							:= le.append_clean_address.prim_name;
		SELF.addr_suffix							:= le.append_clean_address.addr_suffix;
		SELF.postdir    							:= le.append_clean_address.postdir;
		SELF.unit_desig 							:= le.append_clean_address.unit_desig;
		SELF.sec_range  							:= le.append_clean_address.sec_range;
		SELF.city											:= le.append_clean_address.v_city_name;
		SELF.state         						:= le.append_clean_address.st;
		SELF.zip        							:= (unsigned3)le.append_clean_address.zip5;
		SELF.zip4       							:= (unsigned2)le.append_clean_address.zip4;
		SELF.county										:= le.append_clean_address.fips_county;
		SELF.geo_lat    							:= le.append_clean_address.geo_lat;
		SELF.geo_long   							:= le.append_clean_address.geo_long;
		SELF.phone										:= 0;	
		SELF.fein 										:= (unsigned4)le.append_fein;
  	SELF := le;
		SELF := [];
  END;

  dsMapped 			:= project(in_ds,xform1(left));
	
  return dsMapped;
	
end;

export old_business_header_vehicle_recs := map_to_old_business_header(files.party_building(append_clean_cname<>'' and append_bdid <>0));

export new_business_header_vehicle_recs :=  VehicleV2.As_Business_Linking(files.party_building(append_bdid <>0), true);

end;