import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

// Normalize mailing addresses
layout_abn_amro_test_norm NormAddress(layout_abn_amro_test_in l, integer cnt) := transform
self.STREET := choose(cnt, l.STREET, l.MAILADDR);
self.CITY := choose(cnt, l.CITY, l.MAIL_CITY);
self.STATE := choose(cnt, l.STATE, l.MAIL_STATE);
self.ZIP := choose(cnt, l.ZIP, l.MAIL_ZIP);
self.ZIP4 := choose(cnt, l.ZIP4, l.MAIL_ZIP4);
self := l;
end;

abn_amro_test_norm := normalize(Equifax.File_ABN_AMRO_Test_In, 2, NormAddress(left, counter));
abn_amro_test_sort := sort(abn_amro_test_norm, PROSPECT_HOUSEHOLD_KEY, -ZIP, -STREET);
abn_amro_test_dedup := dedup(abn_amro_test_sort,
                          left.PROSPECT_HOUSEHOLD_KEY = right.PROSPECT_HOUSEHOLD_KEY and
                            ((left.ZIP = right.ZIP and left.STREET = right.STREET) or
					      (right.ZIP = '' and right.STREET = '')));

layout_abn_amro_test_seq := record
unsigned4 seq;
layout_abn_amro_test_norm;
end;

// Add unique sequence number to input
layout_abn_amro_test_seq SequenceInput(layout_abn_amro_test_norm l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

abn_amro_test_seq := project(abn_amro_test_dedup, SequenceInput(left, counter));

// clean the names and addresses
layout_abn_amro_test_clean := record
layout_abn_amro_test_seq;
string182 clean_bus_address;
string10  phone10;
string9   fein;
end;

layout_abn_amro_test_clean CleanInput(layout_abn_amro_test_seq l) := transform
self.clean_bus_address := address.cleanAddress182(trim(l.STREET), trim(l.CITY) + ', ' + trim(l.STATE) + ' ' + trim(l.ZIP));
self.phone10 := '';
self.fein := '';
self := l;
end;

abn_amro_test_clean_init := project(abn_amro_test_seq, CleanInput(left));

// Project clean fields to base format
layout_abn_amro_test_base InitBase(layout_abn_amro_test_clean l) := transform
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
  self := l;
end;

abn_amro_test_clean := project(abn_amro_test_clean_init, InitBase(left)) : persist('TMTEST::abn_amro_test_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_abn_amro_test_base l) := transform
self.phone10 := l.phone10;
self.company_name := Stringlib.StringToUpperCase(trim(l.COMPNAME));
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

abn_amro_bdid_batch_in := project(abn_amro_test_clean, InitBatch(left));

/*
// Append BDID and Best/Verify Information
Business_Header_SS.MAC_BDID_Append(
	abn_amro_bdid_batch_in,
	abn_amro_bdid_batch_match,
	1
)
*/

matchset := ['A','P','F','N'];

Business_Header_SS.MAC_Match_Flex
(
	abn_amro_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein,
	BDID,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	abn_amro_bdid_batch_match,
	1,   //keep count
	33   //score threshold
)

Business_Header_SS.MAC_BestAppend(
	abn_amro_bdid_batch_match,
	'BEST_ALL',
	'BEST_ALL',
	abn_amro_bdid_batch_best,
	false
)

// Join to base file to add bdid information
layout_abn_amro_test_base CombineBest(layout_abn_amro_test_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self.best_phone := r.best_phone;
self.best_fein := r.best_fein;
self.best_CompanyName := r.best_CompanyName;
self.best_addr1 := r.best_addr1;
self.best_addr2 := r.best_addr2;
self.verify_best_phone := r.verify_best_phone;
self.verify_best_fein := r.verify_best_fein;
self.verify_best_address := r.verify_best_address;
self.verify_best_CompanyName := r.verify_best_CompanyName;
self := l;
end;

abn_amro_test_bdid_best := join(abn_amro_test_clean,
                                abn_amro_bdid_batch_best,
						  left.seq = right.seq,
						  CombineBest(left, right),
						  lookup);
							 
abn_amro_out := sort(abn_amro_test_bdid_best, PROSPECT_HOUSEHOLD_KEY, if(bdid <> 0, 1, 1), -bdid_score);

export abn_amro_test_prep := abn_amro_out  : persist('TMTEST::abn_amro_test_best');
