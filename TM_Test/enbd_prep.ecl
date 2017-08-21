import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_ENBD_seq := record
unsigned4 seq;
layout_ENBD_in;
end;

// Add unique record id to input
layout_ENBD_seq AssignSeq(layout_ENBD_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

ENBD_seq := project(file_ENBD_in, AssignSeq(left, counter));

// clean the names and addresses
layout_ENBD_clean := record
layout_ENBD_seq;
string182 clean_bus_address;
string73  clean_name;
string10  phone10;
end;

layout_ENBD_clean CleanInput(layout_ENBD_seq l) := transform
self.clean_bus_address := addrcleanlib.cleanAddress182(trim(l.STREET_ADDRESS), trim(l.CITY) + ', ' + trim(l.STATE) + ' ' + trim(l.ZIP));
self.clean_name := addrcleanlib.cleanPerson73(trim(l.EXECUTIVE_FIRST_NAME) + ' ' +
                                              trim(l.EXECUTIVE_MIDDLE_INITIAL) + if(l.EXECUTIVE_MIDDLE_INITIAL <> '', ' ', '') +
									 trim(l.EXECUTIVE_LAST_NAME));
self.phone10 := Address.CleanPhone(trim(l.PHONE));
self := l;
end;

ENBD_clean_init := project(ENBD_seq, CleanInput(left));

// Project clean fields to base format
layout_ENBD_base InitBase(layout_ENBD_clean l) := transform
  // clean business address
  self.bus_prim_range := l.clean_bus_address[1..10];
  self.bus_predir := l.clean_bus_address[11..12];
  self.bus_prim_name := l.clean_bus_address[13..40];
  self.bus_addr_suffix := l.clean_bus_address[41..44];
  self.bus_postdir := l.clean_bus_address[45..46];
  self.bus_unit_desig := l.clean_bus_address[47..56];
  self.bus_sec_range := l.clean_bus_address[57..64];
  self.bus_p_city_name := l.clean_bus_address[65..89];
  self.bus_v_city_name := l.clean_bus_address[90..114];
  self.bus_st := l.clean_bus_address[115..116];
  self.bus_zip := l.clean_bus_address[117..121];
  self.bus_zip4 := l.clean_bus_address[122..125];
  self.bus_cart := l.clean_bus_address[126..129];
  self.bus_cr_sort_sz := l.clean_bus_address[130];
  self.bus_lot := l.clean_bus_address[131..134];
  self.bus_lot_order := l.clean_bus_address[135];
  self.bus_dbpc := l.clean_bus_address[136..137];
  self.bus_chk_digit := l.clean_bus_address[138];
  self.bus_rec_type := l.clean_bus_address[139..140];
  self.bus_fips_state := l.clean_bus_address[141..142];
  self.bus_fips_county := l.clean_bus_address[143..145];
  self.bus_geo_lat := l.clean_bus_address[146..155];
  self.bus_geo_long := l.clean_bus_address[156..166];
  self.bus_msa := l.clean_bus_address[167..170];
  self.bus_geo_blk := l.clean_bus_address[171..177];
  self.bus_geo_match := l.clean_bus_address[178];
  self.bus_err_stat := l.clean_bus_address[179..182];
// clean contact name
  self.title := l.clean_name[1..5];
  self.fname := l.clean_name[6..25];
  self.mname := l.clean_name[26..45];
  self.lname := l.clean_name[46..65];
  self.name_suffix := l.clean_name[66..70];
  self.name_score := l.clean_name[71..73];
  self := l;
end;

ENBD_clean := project(ENBD_clean_init, InitBase(left)) : persist('TMTEST::ENBD_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_ENBD_base l) := transform
self.phone10 := l.phone10;
self.company_name := Stringlib.StringToUpperCase(l.BUSINESS_NAME);
self.prim_range := l.bus_prim_range;
self.predir := l.bus_predir;
self.prim_name := l.bus_prim_name;
self.addr_suffix := l.bus_addr_suffix;
self.postdir := l.bus_postdir;
self.unit_desig := l.bus_unit_desig;
self.sec_range := l.bus_sec_range;
self.p_city_name := l.bus_p_city_name;
self.st := l.bus_st;
self.z5 := l.bus_zip;
self.zip4 := l.bus_zip4;
self := l;
end;

ENBD_bdid_batch_in := project(ENBD_clean, InitBatch(left));

matchset := ['A','P','N'];

Business_Header_SS.MAC_Match_Flex
(
	ENBD_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	ENBD_bdid_batch_match,
	1,   //keep count
	65   //score threshold
)

Business_Header_SS.MAC_BestAppend(
	ENBD_bdid_batch_match,
	'BEST_ALL',
	'BEST_ALL',
	ENBD_bdid_batch_best,
	false
)

ENBD_bdid_batch := ENBD_bdid_batch_best;

// Join to base file to add bdid information
layout_ENBD_base CombineBest(layout_ENBD_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self.best_phone := r.best_phone;
self.best_fein := r.best_fein;
self.best_CompanyName := r.best_CompanyName;
self.best_addr1 := r.best_addr1;
self.best_city := r.best_city;
self.best_state := r.best_state;
self.best_zip := r.best_zip;
self.best_zip4 := r.best_zip4;

self.verify_best_phone := r.verify_best_phone;
self.verify_best_fein := r.verify_best_fein;
self.verify_best_address := r.verify_best_address;
self.verify_best_CompanyName := r.verify_best_CompanyName;
self := l;
end;

ENBD_bdid_best := join(ENBD_clean,
                                ENBD_bdid_batch,
						  left.seq = right.seq,
						  CombineBest(left, right),
						  left outer,
						  hash)   : persist('TMTEST::ENBD_bdid_best');

						  
// Add dids for executives associated with the businesses
didville.Layout_Did_OutBatch InitExec(layout_ENBD_base l) := transform
self.dob := '';
self.ssn := '';
self.suffix := l.name_suffix;
self.prim_range := l.bus_prim_range;
self.predir := l.bus_predir;
self.prim_name := l.bus_prim_name;
self.addr_suffix := l.bus_addr_suffix;
self.postdir := l.bus_postdir;
self.unit_desig := l.bus_unit_desig;
self.sec_range := l.bus_sec_range;
self.p_city_name := l.bus_p_city_name;
self.st := l.bus_st;
self.z5 := l.bus_zip;
self.zip4 := l.bus_zip4;
self := l;
end;

ENBD_exec_init := project(ENBD_bdid_best(lname <> ''),InitExec(left));
ENBD_exec_to_did := ENBD_exec_init((prim_name <> '' and z5 <> '') or ssn <> '');

DID_Matchset := ['A','P','Z'];

DID_Add.MAC_Match_Flex(ENBD_exec_to_did, 
	 DID_Matchset,
	 NONE, NONE, fname, mname,lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10, 
	 did,
	 didville.Layout_Did_OutBatch, 
	 TRUE, score, 
      50,  //low score threshold
	 ENBD_exec_did_match)

ENBD_bdid_best_dist := distribute(ENBD_bdid_best, hash(seq));
ENBD_exec_did_match_dist := distribute(ENBD_exec_did_match, hash(seq));

// Add did and did scores
Layout_ENBD_base AppendDID(Layout_ENBD_base l, didville.Layout_Did_OutBatch r) := transform
self.did := r.did;
self.score := r.score;
self := l;
end;

ENBD_exec_did := join(ENBD_bdid_best_dist,
                           ENBD_exec_did_match_dist,
					  left.seq = right.seq,
					  AppendDID(left, right),
					  left outer,
					  local)    : persist('TMTEST::ENBD_did');
					    
ENBD_exec_did_dist := distribute(ENBD_exec_did, hash(bdid));
							 						  
// Append the group id
bhg := Business_Header.File_Super_Group;

ENBD_group_id := join(bhg,
                      ENBD_exec_did_dist(bdid <> 0),
				  left.bdid = right.bdid,
				  transform(layout_ENBD_base, self.group_id := left.group_id, self := right),
				  right outer,
				  hash);
						 
ENBD_group_id_all := ENBD_group_id + ENBD_exec_did_dist(bdid = 0);
					 
ENBD_out := sort(ENBD_group_id_all, seq);

export ENBD_prep := ENBD_out   : persist('TMTEST::ENBD_prep');
