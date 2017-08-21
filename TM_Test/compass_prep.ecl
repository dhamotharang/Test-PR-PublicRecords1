import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_compass_seq := record
unsigned4 seq := 0;
layout_compass_test_in;
end;

// Add unique sequence number to input
layout_compass_seq SequenceInput(layout_compass_test_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

compass_seq := project(File_compass_Test_In, SequenceInput(left, counter)) : persist('TMTEST::compass_seq');

// clean the names and addresses
layout_compass_clean := record
layout_compass_seq;
string73  clean_name; 
string182 clean_address;
string10  phone10;
end;

layout_compass_clean CleanInput(layout_compass_seq l) := transform
self.clean_name := addrcleanlib.cleanPerson73(trim(l.Contact_First_Name) + ' ' + trim(l.Contact_Last_Name));
self.clean_address := addrcleanlib.cleanAddress182(trim(l.Address), trim(l.City) + ', ' + trim(l.State) + ' ' + l.Zip_Code[1..5]);
self.phone10 := Address.CleanPhone(l.Phone);
self := l;
end;

compass_clean_init := project(compass_seq, CleanInput(left));

// Project clean fields to base format
layout_compass_test_base InitBase(layout_compass_clean l) := transform
  // clean business address
  self.prim_range := l.clean_address[1..10];
  self.predir := l.clean_address[11..12];
  self.prim_name := l.clean_address[13..40];
  self.addr_suffix := l.clean_address[41..44];
  self.postdir := l.clean_address[45..46];
  self.unit_desig := l.clean_address[47..56];
  self.sec_range := l.clean_address[57..64];
  self.p_city_name := l.clean_address[65..89];
  self.v_city_name := l.clean_address[90..114];
  self.st := l.clean_address[115..116];
  self.zip := l.clean_address[117..121];
  self.zip4 := l.clean_address[122..125];
  self.cart := l.clean_address[126..129];
  self.cr_sort_sz := l.clean_address[130];
  self.lot := l.clean_address[131..134];
  self.lot_order := l.clean_address[135];
  self.dbpc := l.clean_address[136..137];
  self.chk_digit := l.clean_address[138];
  self.rec_type := l.clean_address[139..140];
  self.fips_state := l.clean_address[141..142];
  self.fips_county := l.clean_address[143..145];
  self.geo_lat := l.clean_address[146..155];
  self.geo_long := l.clean_address[156..166];
  self.msa := l.clean_address[167..170];
  self.geo_blk := l.clean_address[171..177];
  self.geo_match := l.clean_address[178];
  self.err_stat := l.clean_address[179..182];
  // clean contact name
  self.title := l.clean_name[1..5];
  self.fname := l.clean_name[6..25];
  self.mname := l.clean_name[26..45];
  self.lname := l.clean_name[46..65];
  self.name_suffix := l.clean_name[66..70];
  self.name_score := l.clean_name[71..73];
  self := l;
end;

compass_clean := project(compass_clean_init, InitBase(left)) : persist('TMTEST::compass_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_compass_test_base l) := transform
self.company_name := l.Company;
self.prim_range := l.prim_range;
self.predir := l.predir;
self.prim_name := l.prim_name;
self.addr_suffix := l.addr_suffix;
self.postdir := l.postdir;
self.unit_desig := l.unit_desig;
self.sec_range := l.sec_range;
self.p_city_name := l.p_city_name;
self.st := l.st;
self.z5 := l.zip;
self.zip4 := l.zip4;
self := l;
end;

compass_bdid_batch_in := project(compass_clean, InitBatch(left));

matchset := ['A','P','N'];

Business_Header_SS.MAC_Match_Flex
(
	compass_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	compass_bdid_batch_match,
	1,   //keep count
	65   //score threshold
)

compass_bdid_batch := compass_bdid_batch_match : persist('TMTEST::compass_bdid_batch');

// Join to base file to add bdid information
layout_compass_test_base AppendBDID(layout_compass_test_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self := l;
end;

compass_bdid_append := join(compass_clean,
                                 compass_bdid_batch,
						   left.seq = right.seq,
						   AppendBDID(left, right),
						   left outer,
						   hash);

// Append Best Information
bhb := Business_Header.File_Business_Header_Best;


ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_compass_test_base AppendBest(layout_compass_test_base l, bhb r) := transform
self.bus_best_CompanyName := r.company_name;

self.bus_best_addr1 := 
			ops(r.prim_range) + 
			ops(r.predir) + 
			ops(r.prim_name) +
			ops(r.addr_suffix) +
			ops(r.postdir) +
				if(ut.tails(r.prim_name, ops(r.unit_desig) + ops(r.sec_range)),
					'',
					ops(r.unit_desig) + ops(r.sec_range));
self.bus_best_city := r.city;
self.bus_best_state := r.state;
self.bus_best_zip := if(r.zip = 0, '', intformat(r.zip, 5, 1));
self.bus_best_zip4 := if(r.zip4 <> 0, intformat(r.zip4, 4, 1), '');

self.bus_best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self.bus_best_fein := if(r.fein <> 0, intformat(r.fein, 9, 1), '');
self := l;
end;

compass_bdid_best := join(compass_bdid_append,
                               bhb,
					      left.bdid = right.bdid,
					      AppendBest(left, right),
					      left outer,
					      hash);
					    
// Append the group id
bhg := Business_Header.File_Super_Group;

compass_group_id := join(bhg,
                              compass_bdid_best(bdid <> 0),
						left.bdid = right.bdid,
						transform(layout_compass_test_base, self.group_id := left.group_id, self := right),
						right outer,
						hash);
						 
compass_group_id_all := compass_group_id + compass_bdid_best(bdid = 0) : persist('TMTEST::compass_bdid_best');

// Add dids for contacts associated with the businesses
didville.Layout_Did_OutBatch InitExec(layout_compass_test_base l) := transform
self.dob := '';
self.ssn := '';
self.phone10 := l.phone10;
//self.phone10 := l.phone10;
self.suffix := l.name_suffix;
self.prim_range := l.prim_range;
self.predir := l.predir;
self.prim_name := l.prim_name;
self.addr_suffix := l.addr_suffix;
self.postdir := l.postdir;
self.unit_desig := l.unit_desig;
self.sec_range := l.sec_range;
self.p_city_name := l.p_city_name;
self.st := l.st;
self.z5 := l.zip;
self.zip4 := l.zip4;
self := l;
end;

compass_exec_to_did := project(compass_group_id_all(lname <> ''),InitExec(left));

//DID_Matchset := ['A','D','Z','P'];
DID_Matchset := ['A','Z','P'];

DID_Add.MAC_Match_Flex(compass_exec_to_did, 
	 DID_Matchset,
	 ssn, dob, fname, mname,lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10, 
	 did,
	 didville.Layout_Did_OutBatch, 
	 TRUE, score, 
      65,  //low score threshold
	 compass_exec_did_match)

didville.MAC_BestAppend(compass_exec_did_match,'BEST_ALL','BEST_ALL',0,true,compass_exec_did_best)

compass_gid_all_dist := distribute(compass_group_id_all, hash(seq));
compass_exec_did_best_dist := distribute(compass_exec_did_best, hash(seq)) : persist('TMTEST::compass_did');

// Add did and did scores and best info
layout_compass_test_base AppendDIDBest(layout_compass_test_base l, didville.Layout_Did_OutBatch r) := transform
self.did := r.did;
self.score := r.score;
self.best_phone := r.best_phone;
self.best_title := r.best_title;
self.best_fname := r.best_fname;
self.best_mname := r.best_mname;
self.best_lname := r.best_lname;
self.best_name_suffix := r.best_name_suffix;
self.best_addr1 := r.best_addr1;
self.best_city := r.best_city;
self.best_state := r.best_state;
self.best_zip := r.best_zip;
self.best_zip4 := r.best_zip4;
self.best_addr_date := r.best_addr_date;
self.best_dob := r.best_dob;
self.best_dod := r.best_dod;
self := l;
end;

compass_exec_did_append := join(compass_gid_all_dist,
                                     compass_exec_did_best_dist,
					            left.seq = right.seq,
					            AppendDIDBest(left, right),
					            left outer,
					            local)    : persist('TMTEST::compass_did_best');

compass_prep_out := dedup(sort(compass_exec_did_append, seq, -score), seq);

export compass_prep := compass_prep_out  : persist('TMTEST::compass_bdid_did_prep');
