import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_directorynet_seq := record
unsigned4 seq := 0;
layout_directorynet_in;
end;

// Add unique sequence number to input
layout_directorynet_seq SequenceInput(layout_directorynet_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

directorynet_seq := project(File_directorynet_In, SequenceInput(left, counter)) : persist('TMTEST::directorynet_seq');

// clean the names and addresses
layout_directorynet_clean := record
layout_directorynet_seq;
string73  clean_name; 
string182 clean_address;
string10  phone10;
end;

layout_directorynet_clean CleanInput(layout_directorynet_seq l) := transform
self.clean_name := addrcleanlib.cleanPerson73(trim(l.First_Name) + ' ' +
                                              if(l.Middle_Name <> '', trim(l.Middle_Name) + ' ', '') +
									 trim(l.Last_Name) + ' ' +
									 trim(l.suffix));
self.clean_address := addrcleanlib.cleanAddress182(trim(l.First_Line_of_Address) + ' ' + trim(l.Second_Line_of_Address), trim(l.City) + ', ' + trim(l.State) + ' ' + trim(l.Zip_Code));
self.phone10 := Address.CleanPhone(l.Consumer_Phone);
self := l;
end;

directorynet_clean_init := project(directorynet_seq, CleanInput(left));

// Project clean fields to base format
layout_directorynet_base InitBase(layout_directorynet_clean l) := transform
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

directorynet_clean := project(directorynet_clean_init, InitBase(left)) : persist('TMTEST::directorynet_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_directorynet_base l) := transform
self.company_name := l.company_name;
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

directorynet_bdid_batch_in := project(directorynet_clean, InitBatch(left));

matchset := ['A','N'];

Business_Header_SS.MAC_Match_Flex
(
	directorynet_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone_field, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	directorynet_bdid_batch_match,
	1,   //keep count
	65   //score threshold
)

directorynet_bdid_batch := directorynet_bdid_batch_match : persist('TMTEST::directorynet_bdid_batch');

// Join to base file to add bdid information
layout_directorynet_base AppendBDID(layout_directorynet_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self := l;
end;

directorynet_bdid_append := join(directorynet_clean,
                                 directorynet_bdid_batch,
						   left.seq = right.seq,
						   AppendBDID(left, right),
						   left outer,
						   hash);

// Append Best Information
bhb := Business_Header.BestAll_MktApp;
//bhb := Business_Header.File_Business_Header_Best;


ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_DirectoryNet_Base AppendBest(Layout_DirectoryNet_Base l, bhb r) := transform
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

directorynet_bdid_best := join(directorynet_bdid_append,
                               bhb,
					      left.bdid = right.bdid,
					      AppendBest(left, right),
					      left outer,
					      hash);
					    
// Append the group id
bhg := Business_Header.File_Super_Group;

directorynet_group_id := join(bhg,
                              directorynet_bdid_best(bdid <> 0),
						left.bdid = right.bdid,
						transform(layout_directorynet_base, self.group_id := left.group_id, self := right),
						right outer,
						hash);
						 
directorynet_group_id_all := directorynet_group_id + directorynet_bdid_best(bdid = 0) : persist('TMTEST::directorynet_bdid_best');

// Add dids for contacts associated with the businesses
didville.Layout_Did_OutBatch InitExec(layout_directorynet_base l) := transform
self.dob := '';
self.ssn := '';
self.phone10 := '';
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

directorynet_exec_to_did := project(directorynet_group_id_all(lname <> ''),InitExec(left));

DID_Matchset := ['A','Z','P'];

DID_Add.MAC_Match_Flex(directorynet_exec_to_did, 
	 DID_Matchset,
	 ssn, dob, fname, mname,lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10, 
	 did,
	 didville.Layout_Did_OutBatch, 
	 TRUE, score, 
      50,  //low score threshold
	 directorynet_exec_did_match)

didville.MAC_BestAppend(directorynet_exec_did_match,'BEST_ALL','BEST_ALL',0,true,directorynet_exec_did_best)

directorynet_gid_all_dist := distribute(directorynet_group_id_all, hash(seq));
directorynet_exec_did_best_dist := distribute(directorynet_exec_did_best, hash(seq)) : persist('TMTEST::directorynet_did');

// Add did and did scores and best info
Layout_directorynet_base AppendDIDBest(Layout_directorynet_base l, didville.Layout_Did_OutBatch r) := transform
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

directorynet_exec_did_append := join(directorynet_gid_all_dist,
                                     directorynet_exec_did_best_dist,
					            left.seq = right.seq,
					            AppendDIDBest(left, right),
					            left outer,
					            local)    : persist('TMTEST::directorynet_did_best');

directorynet_prep_out := dedup(sort(directorynet_exec_did_append, seq, -score), seq);

export directorynet_prep := directorynet_prep_out  : persist('TMTEST::directorynet_bdid_did_prep');
