import ut, Header, prte2_marriage_divorce, mdr, _validate;

EXPORT as_header := MODULE

	Header.Layout_New_Records map_to_person_header(Files.Search le) := TRANSFORM
		self.did											:= (integer)le.did;
		self.rid 											:= 0;
		self.pflag1 									:= '';
		self.pflag2 									:= '';
		self.pflag3 									:= '';
		self.src                      := mdr.sourceTools.src_Marriage;
		self.dt_first_seen 						:= le.dt_first_seen;
		self.dt_last_seen 						:= le.dt_last_seen;
		self.dt_vendor_first_reported := le.dt_vendor_first_reported;
		self.dt_vendor_last_reported 	:= le.dt_vendor_last_reported;
		self.dt_nonglb_last_seen 			:= self.dt_last_seen;
		self.rec_type 								:= '';
		self.vendor_id 								:= (string)hash(le.record_id+trim(le.fname)+trim(le.lname));
	  self.phone 										:= '';
		self.ssn 											:= '';
		self.dob 											:= (unsigned)le.dob;
		self.city_name 								:= le.v_city_name;
		self.zip4 										:= le.zip4;
		self.cbsa 										:= if(le.msa!='',le.msa + '0','');
		self.tnt 											:= '';
		self.valid_ssn 								:= '';
		self.jflag1 									:= '';
		self.jflag2 									:= '';
		self.jflag3 									:= '';
		self.persistent_record_id			:= le.persistent_record_id;
		self := le;
		self := [];
	END;

//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
EXPORT person_header_mar_div := project(Files.Search(did>0),map_to_person_header(left));

END;