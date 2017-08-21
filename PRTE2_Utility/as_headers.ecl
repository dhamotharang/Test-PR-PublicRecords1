import Business_Header, mdr, ut, Header, utilfile;

EXPORT as_headers := module

//Person Header
Header.Layout_New_Records 	map_to_person_header(layouts.as_header l, unsigned2 cnt) := transform
	  self.did											:= (unsigned6)l.did;
		self.rid 											:= 0;
		self.pflag1 									:= '';
		self.pflag2 									:= '';
		self.pflag3 									:= '';
		self.src                      := MDr.sourceTools.src_Utilities;
		self.dt_first_seen  				  := (unsigned3)l.date_first_seen[1..6];
		self.dt_last_seen  					  := 0; //Not available
		self.dt_vendor_first_reported := 0; //Not available
		self.dt_vendor_last_reported  := 0; //Not available
		self.rec_type 								:= ''; //Not available
		self.vendor_id 								:= l.id;
	  self.phone 										:= choose(cnt,ut.cleanPhone(l.Phone),ut.cleanPhone(l.Work_Phone));
		self.ssn 											:= l.ssn;
		self.dob 											:= (integer)l.dob;
		self.suffix 									:= '';
		self.city_name 								:= l.v_city_name;
		self.zip4 										:= l.zip4;
		self.cbsa 										:= '';
		self.tnt 											:= '';
		self.valid_ssn 								:= '';
		self.jflag1 									:= '';
		self.jflag2 									:= '';
		self.jflag3 									:= '';
		self.persistent_record_id			:= 0;
		self := l;
		self := [];
	end;

	choosey(string pPhone, string pCompany_Phone) := map(pPhone	!= ''	and pCompany_Phone	!= '' => 2, 1);
									
	dAsPersonHeader	:= normalize(	files.header_utility(did<>''), choosey(left.Phone, left.work_Phone)
																,map_to_person_header(left,counter)
															);

//this then gets read into a separate process (our Header process) for the creation and managing of our LexID's
export person_header_utility := dedup(dAsPersonHeader, record);

//Base file mapping to Business Header Linking Interface
export new_business_header_utility := utilfile.As_Business_Linking(prte2_utility.Files.header_utility, true);

export old_business_header_utility := utilfile.fAs_Business_Header(prte2_utility.Files.header_utility, true);

end;