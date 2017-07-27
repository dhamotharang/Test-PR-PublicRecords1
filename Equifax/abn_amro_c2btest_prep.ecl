import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_abn_amro_c2btest_seq := record
unsigned4 seq;
Layout_ABN_AMRO_C2BTest_In;
end;

// Add unique sequence number to input
layout_abn_amro_c2btest_seq SequenceInput(layout_abn_amro_c2btest_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

abn_amro_c2btest_seq := project(File_ABN_AMRO_C2BTest_In, SequenceInput(left, counter));

// clean the names and addresses
layout_abn_amro_c2btest_clean := record
layout_abn_amro_c2btest_seq;
string182 clean_address;
string73  clean_name;
string10  phone10;
end;

layout_abn_amro_c2btest_clean CleanInput(layout_abn_amro_c2btest_seq l) := transform
self.clean_address := addrcleanlib.cleanAddress182(trim(l.MAILING_ADDRESS_1), trim(l.MAILING_CITY) + ', ' + trim(l.MAILING_STATE) + ' ' + trim(l.MAILING_ZIP_CODE[1..5]));
self.clean_name := addrcleanlib.cleanPerson73(l.NAME_FULL);
self.phone10 := address.CleanPhone(l.PHONE);
self := l;
end;

abn_amro_c2btest_clean_init := project(abn_amro_c2btest_seq, CleanInput(left));

// Project clean fields to base format
layout_abn_amro_c2btest_base InitBase(layout_abn_amro_c2btest_clean l) := transform
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

abn_amro_c2btest_clean := project(abn_amro_c2btest_clean_init, InitBase(left)) : persist('TMTEST::abn_amro_c2btest_clean');

// Add dids
didville.Layout_Did_OutBatch InitDID(layout_abn_amro_c2btest_base l) := transform
self.dob := '';
self.ssn := '';
self.suffix := l.name_suffix;
self.z5 := l.zip;
self := l;
end;

abn_amro_c2btest_did_init := project(abn_amro_c2btest_clean(lname <> ''),InitDID(left));
abn_amro_c2btest_to_did := abn_amro_c2btest_did_init((prim_name <> '' and z5 <> '') or ssn <> '');

didville.MAC_DidAppend(abn_amro_c2btest_to_did, abn_amro_c2btest_did_match, true, 'Z4G')

didville.MAC_BestAppend(abn_amro_c2btest_did_match,'BEST_ALL','BEST_ALL',0,true,abn_amro_c2btest_did_best)

abn_amro_c2btest_did_best_dist := distribute(abn_amro_c2btest_did_best(did <> 0), hash(seq));
abn_amro_c2btest_did_best_sort := sort(abn_amro_c2btest_did_best_dist, seq, -score, local);
abn_amro_c2btest_did_best_dedup := dedup(abn_amro_c2btest_did_best_sort, seq, local);

abn_amro_c2btest_clean_dist := distribute(abn_amro_c2btest_clean, hash(seq));

// Add did and did scores
layout_abn_amro_c2btest_base AppendDID(layout_abn_amro_c2btest_base l, didville.Layout_Did_OutBatch r) := transform
self.did := r.did;
self.score := r.score;
self := l;
end;

abn_amro_c2btest_append := join(abn_amro_c2btest_clean_dist,
                                abn_amro_c2btest_did_best_dedup,
					       left.seq = right.seq,
					       AppendDID(left, right),
					       left outer,
					       local);
							 
abn_amro_out := sort(abn_amro_c2btest_append, seq);

export abn_amro_c2btest_prep := abn_amro_out  : persist('TMTEST::abn_amro_c2btest_did');
