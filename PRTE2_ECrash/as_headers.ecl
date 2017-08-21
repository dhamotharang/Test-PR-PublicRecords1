import ut,mdr,Address,business_header, header,standard, std;

EXPORT as_headers := module

//YOU ONLY NEED THIS WHEN YOUR FILE HAS CONSUMERS
	header.Layout_New_Records		map_to_new_recs(recordof(file_keybuildV2.out)	l)	:= 	transform
	  self.src                      := MDR.sourceTools.src_Accidents_ECrash;   
		self.did											:= (unsigned6)l.did;
		self.rid											:= 0;
		self.dt_first_seen 						:= (unsigned3)l.dt_first_seen;
		self.dt_last_seen  						:= (unsigned3)l.dt_last_seen;
		self.dt_vendor_last_reported	:= (unsigned3)l.date_vendor_last_reported;
		self.dt_vendor_first_reported	:= 0;
		self.dt_nonglb_last_seen      := (unsigned3)l.dt_last_seen;
		self.rec_type                 := '';
		self.vendor_id                := '';
		self.ssn											:= l.ssn;
		self.dob											:= (integer)l.DOB;
		self.title										:= l.title;
		self.fname										:= l.fname;
		self.mname										:= l.mname;
		self.lname										:= l.lname;
		self.name_suffix							:= l.name_suffix;
		self.prim_range								:= l.prim_range;
		self.predir										:= l.predir;
		self.prim_name								:= l.prim_name;
		self.suffix										:= l.addr_suffix;
		self.postdir									:= l.postdir;
		self.unit_desig								:= l.unit_desig;
		self.sec_range								:= l.sec_range;
		self.city_name								:= l.v_city_name;
		self.st												:= l.st;
		self.zip					    				:= l.zip;
		self.zip4					    				:= l.zip4;
		self.county										:= '';
		self.cbsa					   					:= '';
		self.geo_blk				  			  := '';
		self.phone										:= '';
		self := l;
	end;

	export person_header_ecrash_recs := project(file_keybuildV2.out(cname = '', did <> '0'),map_to_new_recs(left));
	
	
	Business_Header.Layout_Business_Header_New xform1(recordof(file_keybuildV2.out) le) := transform
		//UNLIKE PRODUCTION WE'RE GOING TO PASS OUR ENTITY ID'S INTO THE HEADER 
		self.rcid 										:= 0; //Not available
		SELF.source                   := MDR.sourceTools.src_Accidents_ECrash;
		SELF.BDID                     := (unsigned6)le.b_did;	
		self.vl_id                    := ''; 
		SELF.vendor_id                := '';
		SELF.source_group             := '';
		SELF.dt_first_seen  				  := (unsigned4)le.dt_first_seen;
		SELF.dt_last_seen  					  := (unsigned4)le.dt_last_seen;
		SELF.dt_vendor_first_reported := 0;
		SELF.dt_vendor_last_reported  := (unsigned4)le.date_vendor_last_reported;
		SELF.company_name             := le.cname;
		SELF.current                  := true;
		//the existing data doesn't really support the normalize due to the invalid addresses for admin and tech
		//i just did this so you'd see the proper way of handling if good data was there	
		SELF.prim_range 							:= le.prim_range;
		SELF.predir     							:= le.predir;
		SELF.prim_name  							:= le.prim_name;
		SELF.addr_suffix							:= le.addr_suffix;
		SELF.postdir    							:= le.postdir;
		SELF.unit_desig 							:= le.unit_desig;
		SELF.sec_range  							:= le.sec_range;
		SELF.city											:= le.v_city_name;
		SELF.state         						:= le.st;
		SELF.zip        							:= (unsigned3)le.zip;
		SELF.zip4       							:= (unsigned2)le.zip4;
		SELF.county										:= '';
		SELF.geo_lat    							:= '';
		SELF.geo_long   							:= '';
		SELF.phone										:= 0;	
		SELF.fein 										:= 0;
  	SELF := le;
		SELF := [];
  END;

	export old_business_header_ecrash_recs := project(file_keybuildV2.out(cname <> '', b_did <> '0'),xform1(left));

end;	