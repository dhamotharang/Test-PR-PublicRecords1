

import crim_common,crimsrch,ut,did_add,header_slimsort;


sps := sort(distribute(crim_header.File_Sex_Pred_Search_DID(vendor_code not in bad_vendors),hash(seisint_primary_key)),seisint_primary_key,local);
spm := crim_header.File_Sex_Pred_2(vendor_code not in bad_vendors);

layout_spmn := record
    unsigned1	countx;
	string16	seisint_primary_key;
	string30	offender_id;
	string30	doc_number;
	string30	sor_number;
	string30	st_id_number;
	string30	fbi_number;
	string30	ncic_number;
	string9		orig_ssn;
	string8		date_of_birth;
	string8		date_of_birth_aka;
 	string30	orig_dl_number;
	string2		orig_dl_state;
	//
	string30	court_1;
	string25	court_case_number_1;
	string40	orig_veh_plate_1;
	string2		orig_veh_state_1;
	//
end;

layout_spmn  t_normalize_spm(spm l,integer c) := transform
self.countx := c;
self.court_1 := 
		case(c,			1 =>l.court_1,
						2 =>l.court_2,
						3 =>l.court_3,
						4 =>l.court_4,
						5 =>l.court_5,'');
self.court_case_number_1 := 
		case(c,			1 =>l.court_case_number_1,
						2 =>l.court_case_number_2,
						3 =>l.court_case_number_3,
						4 =>l.court_case_number_4,
						5 =>l.court_case_number_5,'');
self.orig_veh_plate_1 := 
		case(c,			1 =>if(l.orig_veh_plate_1<>'NOT AVAILABLE',l.orig_veh_plate_1,''),
						2 =>if(l.orig_veh_plate_2<>'NOT AVAILABLE',l.orig_veh_plate_2,''),'');
				
self.orig_veh_state_1 := 
		case(c,			1 =>l.orig_veh_state_1,
						2 =>l.orig_veh_state_2,'');
self := l;
end;

spmn := sort(distribute(normalize(spm, 5, t_normalize_spm(left,counter)),hash(seisint_primary_key)),seisint_primary_key,local);

layout_spj := record
	string8		dt_last_reported;
	string16	seisint_primary_key;
	string2		vendor_code;
	string20	source_file;
	string2		state_of_origin;
	string50	name_orig;
	string1		name_type;
	string9		orig_ssn;
	string8		date_of_birth;
	string8		dob_aka;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string3		cleaning_score;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		st;
	string5		zip;
	string4		zip4;
	string4		cart;
	string1		cr_sort_sz;
	string4		lot;
	string1		lot_order;
	string2		dpbc;
	string1		chk_digit;
	string2		rec_type;
	string2		fips_st;
	string3		fips_county;
	string10	geo_lat;
	string11	geo_long;
	string4		msa;
	string7		geo_blk;
	string1		geo_match;
	string4		err_stat;
	string12	did;
	string3		score;
	string9		best_ssn;
//
	string30	m_offender_id;
	string30	m_doc_number;
	string30	m_sor_number;
	string30	m_st_id_number;
	string30	m_fbi_number;
	string30	m_ncic_number;
	string9		m_orig_ssn;
	string8		m_date_of_birth;
	string8		m_date_of_birth_aka;
	string30	m_court_1;
	string25	m_court_case_number_1;
	string30	m_orig_dl_number;
	string2		m_orig_dl_state;
	string40	m_orig_veh_plate_1;
	string2		m_orig_veh_state_1;
end;


layout_spj sps_spmn_as_joined(sps l,spmn r) := transform
	self := l;
	self.m_offender_id			:= r.offender_id; 	
	self.m_doc_number			:= r.doc_number;
	self.m_sor_number			:= r.sor_number;	
	self.m_st_id_number			:= r.st_id_number;	
	self.m_fbi_number			:= r.fbi_number;
	self.m_ncic_number			:= r.ncic_number;
	self.m_orig_ssn				:= r.orig_ssn;
	self.m_date_of_birth		:= r.date_of_birth;
	self.m_date_of_birth_aka	:= r.date_of_birth_aka;
	self.m_court_1				:= r.court_1;
	self.m_court_case_number_1	:= r.court_case_number_1;
	self.m_orig_dl_number		:= r.orig_dl_number;
	self.m_orig_dl_state		:= r.orig_dl_state;
	self.m_orig_veh_plate_1		:= r.orig_veh_plate_1;
	self.m_orig_veh_state_1		:= r.orig_veh_state_1;
end;

spj := join(sps,spmn(countx=1 or court_case_number_1<>'' or orig_veh_plate_1<>''),left.seisint_primary_key=right.seisint_primary_key,sps_spmn_as_joined(left,right),local);


crim_header.layout_crim_header tspj_as_header(spj l) := transform
	self.cdl :=0;
	self.rid :=0;
	self.in_latest := true;
	self.earliest_process_date 	:= l.dt_last_reported;
	self.latest_process_date 	:= l.dt_last_reported;
//
	self.offender_key			:= l.seisint_primary_key;
	self.vendor						:= l.vendor_code;
	self.state_origin			:= l.state_of_origin;
	self.data_type				:= '4';
	self.source_file			:= l.source_file;
	self.case_number			:= l.m_court_case_number_1;
	self.name_type				:= l.name_type;
	self.dob							:= l.date_of_birth;
	self.dob_alias				:= l.dob_aka;
	self.orig_ssn					:= l.orig_ssn;
	self.dle_num					:= l.m_st_id_number;
  self.fbi_num					:= l.m_fbi_number;
  self.doc_num					:= l.m_doc_number;
  self.ins_num					:= '';
  self.id_num						:= l.m_offender_id;
	self.ncic_number			:= l.m_ncic_number;
	self.sor_number				:= l.m_sor_number;
  self.dl_num						:= l.m_orig_dl_number;
  self.dl_state					:= l.m_orig_dl_state;
	self.veh_tag					:= l.m_orig_veh_plate_1;
	self.veh_state				:= l.m_orig_veh_state_1;
	self.prim_range				:= l.prim_range;
	self.predir						:= l.predir;
	self.prim_name				:= l.prim_name;
	self.addr_suffix			:= l.suffix;
	self.postdir					:= l.postdir;
	self.unit_desig				:= l.unit_desig;
	self.sec_range				:= l.sec_range;
	self.p_city_name			:= l.p_city_name;
	self.v_city_name			:= l.v_city_name;
	self.state						:= l.st;
	self.zip5							:= l.zip;
	self.zip4							:= l.zip4;
	self.title						:= l.title;
	self.fname						:= l.fname;
	self.mname						:= l.mname;
	self.lname						:= l.lname;
	self.name_suffix			:= l.name_suffix;
	self.did							:= (integer6) l.did;
	self.did_score				:= 0;
	self.county_fips_code_origin := '';
	self.gender := '';
	end;

presult :=  project(spj,tspj_as_header(left));

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
	 sp_as_header_with_did
	)
*/

export sp_as_header := presult0 + presultx :  persist ('~thor_data400::persist::crim_header::sp_as_header');
