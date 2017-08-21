import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_nohit_test_seq := record
unsigned4 seq;
layout_nohit_test_in;
end;

// Add unique sequence number to input
layout_nohit_test_seq SequenceInput(layout_nohit_test_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

nohit_test_seq := project(File_nohit_test_in, SequenceInput(left, counter));

// clean the names and addresses
layout_nohit_test_clean := record
layout_nohit_test_seq;
string73  clean_name; 
string182 clean_bus_address;
string182 clean_prin_address;
string10  phone10;
string9   ssn;
string9   fein;
end;

layout_nohit_test_clean CleanInput(layout_nohit_test_seq l) := transform
self.clean_name := address.cleanPerson73(l.INQR_PRIN_NAME);
self.clean_bus_address := address.cleanAddress182(trim(l.INQR_STREET), trim(l.INQR_CITY) + ', ' + trim(l.INQR_STATE) + ' ' + trim(l.INQR_ZIP));
self.clean_prin_address := address.cleanAddress182(trim(l.INQR_PRIN_STREET), trim(l.INQR_PRIN_CITY) + ', ' + trim(l.INQR_PRIN_STATE) + ' ' + trim(l.INQR_PRIN_ZIP));
self.phone10 := Address.CleanPhone(trim(l.INQR_TEL));
self.ssn := l.INQR_PRIN_TAX;
self.fein := l.INQR_TAX;
self := l;
end;

nohit_test_clean_init := project(nohit_test_seq, CleanInput(left));

// Project clean fields to base format
layout_nohit_test_base InitBase(layout_nohit_test_clean l) := transform
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
    // clean business address
  self.prin_prim_range := l.clean_prin_address[1..10];
  self.prin_predir := l.clean_prin_address[11..12];
  self.prin_prim_name := l.clean_prin_address[13..40];
  self.prin_addr_suffix := l.clean_prin_address[41..44];
  self.prin_postdir := l.clean_prin_address[45..46];
  self.prin_unit_desig := l.clean_prin_address[47..56];
  self.prin_sec_range := l.clean_prin_address[57..64];
  self.prin_p_city_name := l.clean_prin_address[65..89];
  self.prin_v_city_name := l.clean_prin_address[90..114];
  self.prin_st := l.clean_prin_address[115..116];
  self.prin_zip := l.clean_prin_address[117..121];
  self.prin_zip4 := l.clean_prin_address[122..125];
  self.prin_cart := l.clean_prin_address[126..129];
  self.prin_cr_sort_sz := l.clean_prin_address[130];
  self.prin_lot := l.clean_prin_address[131..134];
  self.prin_lot_order := l.clean_prin_address[135];
  self.prin_dbpc := l.clean_prin_address[136..137];
  self.prin_chk_digit := l.clean_prin_address[138];
  self.prin_rec_type := l.clean_prin_address[139..140];
  self.prin_fips_state := l.clean_prin_address[141..142];
  self.prin_fips_county := l.clean_prin_address[143..145];
  self.prin_geo_lat := l.clean_prin_address[146..155];
  self.prin_geo_long := l.clean_prin_address[156..166];
  self.prin_msa := l.clean_prin_address[167..170];
  self.prin_geo_blk := l.clean_prin_address[171..177];
  self.prin_geo_match := l.clean_prin_address[178];
  self.prin_err_stat := l.clean_prin_address[179..182];
  // clean contact name
  self.title := l.clean_name[1..5];
  self.fname := l.clean_name[6..25];
  self.mname := l.clean_name[26..45];
  self.lname := l.clean_name[46..65];
  self.name_suffix := l.clean_name[66..70];
  self.name_score := l.clean_name[71..73];
  self := l;
end;

nohit_test_clean := project(nohit_test_clean_init, InitBase(left)) : persist('TMTEST::equifax_nohit_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_nohit_test_base l) := transform
//Business_Header_SS.Layout_BDID_InBatch InitBatch(layout_nohit_test_base l) := transform
self.phone10 := l.phone10;
self.company_name := trim(l.INQR_BUS);
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

nohit_bdid_batch_in := project(nohit_test_clean, InitBatch(left));

/*
// Append BDID and Best/Verify Information
Business_Header_SS.MAC_BDID_Append(
	nohit_bdid_batch_in,
	nohit_bdid_batch_match,
	1
)
*/

matchset := ['A','P','F','N'];

Business_Header_SS.MAC_Match_Flex
(
	nohit_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein,
	BDID,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	nohit_bdid_batch_match
)

Business_Header_SS.MAC_BestAppend(
	nohit_bdid_batch_match,
	'BEST_ALL',
	'BEST_ALL',
	nohit_bdid_batch_best,
	false
)

// Join to base file to add bdid information
layout_nohit_test_base CombineBest(layout_nohit_test_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
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

nohit_test_bdid_best := join(nohit_test_clean,
                             nohit_bdid_batch_best,
						     left.seq = right.seq,
						     CombineBest(left, right),
						     lookup) : persist('TMTEST::equifax_nohit_bdid_best');
							 
// Add dids for principals associated with the businesses
// Normalize to try principal address and company address to get DIDs
didville.Layout_Did_OutBatch InitPrin(layout_nohit_test_base l, unsigned1 cnt) := transform
self.dob := '';
self.suffix := l.name_suffix;
self.prim_range := choose(cnt, l.bus_prim_range, l.prin_prim_range);
self.predir := choose(cnt, l.bus_predir, l.prin_predir);
self.prim_name := choose(cnt, l.bus_prim_name, l.prin_prim_name);
self.addr_suffix := choose(cnt, l.bus_addr_suffix, l.prin_addr_suffix);
self.postdir := choose(cnt, l.bus_postdir, l.prin_postdir);
self.unit_desig := choose(cnt, l.bus_unit_desig, l.prin_unit_desig);
self.sec_range := choose(cnt, l.bus_sec_range, l.prin_sec_range);
self.p_city_name := choose(cnt, l.bus_p_city_name, l.prin_p_city_name);
self.st := choose(cnt, l.bus_st, l.prin_st);
self.z5 := choose(cnt, l.bus_zip, l.prin_zip);
self.zip4 := choose(cnt, l.bus_zip4, l.prin_zip4);
self := l;
end;

nohit_prin_init := normalize(nohit_test_bdid_best(lname <> ''), 2, InitPrin(left, counter));
nohit_prin_to_did := nohit_prin_init((prim_name <> '' and z5 <> '') or ssn <> '');

didville.MAC_DidAppend(nohit_prin_to_did, nohit_prin_did_match, true, 'Z4G')

didville.MAC_BestAppend(nohit_prin_did_match,'BEST_ALL','BEST_ALL',0,true,nohit_prin_did_best)

nohit_prin_did_best_dist := distribute(nohit_prin_did_best(did <> 0), hash(seq));
nohit_prin_did_best_sort := sort(nohit_prin_did_best_dist, seq, -score, local);
nohit_prin_did_best_dedup := dedup(nohit_prin_did_best_sort, seq, local);

nohit_test_bdid_best_dist := distribute(nohit_test_bdid_best, hash(seq));

Layout_NoHit_Test_Prin_Base FormatPrin(layout_nohit_test_base l, didville.Layout_Did_OutBatch r) := transform
self := r;
self := l;
end;

nohit_prin_did_base := join(nohit_test_bdid_best_dist,
                            nohit_prin_did_best_dedup,
							left.seq = right.seq,
							FormatPrin(left, right),
							local) : persist('TMTEST::equifax_nohit_did_best');

// Add did and did scores
layout_nohit_test_base AppendDID(layout_nohit_test_base l, didville.Layout_Did_OutBatch r) := transform
self.did := r.did;
self.score := r.score;
self := l;
end;

nohit_test_best := join(nohit_test_bdid_best_dist,
                        nohit_prin_did_best_dedup,
					    left.seq = right.seq,
						AppendDID(left, right),
						left outer,
						local);

export nohit_test_prep := nohit_test_best  : persist('TMTEST::equifax_nohit_best');