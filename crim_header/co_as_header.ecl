


import crim_common,crimsrch,ut,did_add,header_slimsort;

co := crim_header.File_Crim_Offender2(vendor not in bad_vendors);

crim_header.layout_crim_header tco_as_header(co l) := transform
	self.cdl :=0;
	self.rid :=0;
	self.in_latest := true;
	self.earliest_process_date 	:= l.process_date;
	self.latest_process_date 	:= l.process_date;
//
	self.offender_key			:= l.offender_key;
	self.vendor					:= l.vendor;
	self.state_origin			:= l.state_origin;
	self.data_type				:= l.data_type;
	self.source_file			:= l.source_file;
	self.case_number			:= l.case_number;
	self.name_type				:= l.pty_typ;
	self.dob					:= l.dob;
	self.dob_alias				:= l.dob_alias;
	self.orig_ssn				:= l.orig_ssn;
	self.dle_num				:= l.dle_num;
  self.fbi_num				:= l.fbi_num;
  self.doc_num				:= l.doc_num;
  self.ins_num				:= l.ins_num;
  self.id_num					:= l.id_num;
	self.ncic_number			:= '';
	self.sor_number				:= '';
  self.dl_num					:= l.dl_num;
  self.dl_state				:= l.dl_state;
	self.veh_tag				:= '';
	self.veh_state				:= '';
	self.prim_range				:= l.prim_range;
	self.predir					:= l.predir;
	self.prim_name				:= l.prim_name;
	self.addr_suffix			:= l.addr_suffix;
	self.postdir				:= l.postdir;
	self.unit_desig				:= l.unit_desig;
	self.sec_range				:= l.sec_range;
	self.p_city_name			:= l.p_city_name;
	self.v_city_name			:= l.v_city_name;
	self.state					:= l.state;
	self.zip5					:= l.zip5;
	self.zip4					:= l.zip4;
	self.title					:= l.title;
	self.fname					:= l.fname;
	self.mname					:= l.mname;
	self.lname					:= l.lname;
	self.name_suffix			:= l.name_suffix;
	self.did					:= (integer6) l.did;
	self.did_score				:= 0;
	self.county_fips_code_origin := '';
	self.gender := '';
	end;

presult :=  project(co,tco_as_header(left));

presultd := dedup(sort(distribute(presult,hash(offender_key)),record,local),record,local);

presult0 := presultd(name_type='0');
presultx := presultd(name_type<>'0');
/*
lMatchSet := ['S','A','D'];
did_Add.MAC_Match_Flex
	(presult0, lMatchSet,						
	 orig_ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did,
	 layout_crim_header,
	 false, did_score,
	 75,						//dids with a score below here will be dropped
	 co_as_header_with_did
	)
*/

export co_as_header := presult0 + presultx : persist ('~thor_data400::persist::crim_header::co_as_header');
