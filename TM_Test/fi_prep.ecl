import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_fairisaac_seq := record
unsigned4 seq := 0;
layout_fairisaac_in;
end;

// Add unique sequence number to input
layout_fairisaac_seq SequenceInput(layout_fairisaac_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

fairisaac_seq := project(File_fairisaac_In, SequenceInput(left, counter)) : persist('TMTEST::fairisaac_seq');

// clean the names and addresses
layout_fairisaac_clean := record
layout_fairisaac_seq;
string182 clean_address;
string10  phone10;
end;

layout_fairisaac_clean CleanInput(layout_fairisaac_seq l) := transform
self.clean_address := addrcleanlib.cleanAddress182(trim(l.ADDR1) + ' ' + trim(l.ADDR2), trim(l.CITY) + ', ' + trim(l.billtostate) + ' ' + l.ZIP_CODE[1..5]);
self.phone10 := Address.CleanPhone(l.PHONE);
self := l;
end;

fairisaac_clean_init := project(fairisaac_seq, CleanInput(left));

// Project clean fields to base format
layout_fairisaac_base InitBase(layout_fairisaac_clean l) := transform
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
  self := l;
end;

fairisaac_clean := project(fairisaac_clean_init, InitBase(left)) : persist('TMTEST::fairisaac_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_fairisaac_base l) := transform
self.company_name := Stringlib.StringToUpperCase(l.ACCTNAME);
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

fairisaac_bdid_batch_in := project(fairisaac_clean, InitBatch(left));

matchset := ['A','P','N'];

Business_Header_SS.MAC_Match_Flex
(
	fairisaac_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	fairisaac_bdid_batch_match,
	1,   //keep count
	65   //score threshold
)

fairisaac_bdid_batch := fairisaac_bdid_batch_match : persist('TMTEST::fairisaac_bdid_batch');

// Join to base file to add bdid information
layout_fairisaac_base AppendBDID(layout_fairisaac_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self := l;
end;

fairisaac_bdid_append := join(fairisaac_clean,
                                 fairisaac_bdid_batch,
						   left.seq = right.seq,
						   AppendBDID(left, right),
						   left outer,
						   hash);

// Append Best Information
bhb := Business_Header.File_Business_Header_Best;


ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_fairisaac_Base AppendBest(Layout_fairisaac_Base l, bhb r) := transform
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

fairisaac_bdid_best := join(fairisaac_bdid_append,
                               bhb,
					      left.bdid = right.bdid,
					      AppendBest(left, right),
					      left outer,
					      hash);
					    
// Append the group id
bhg := Business_Header.File_Super_Group;

fairisaac_group_id := join(bhg,
                              fairisaac_bdid_best(bdid <> 0),
						left.bdid = right.bdid,
						transform(layout_fairisaac_base, self.group_id := left.group_id, self := right),
						right outer,
						hash);
						 
fairisaac_group_id_all := fairisaac_group_id + fairisaac_bdid_best(bdid = 0) : persist('TMTEST::fairisaac_bdid_best');

fairisaac_prep_out := dedup(sort(fairisaac_group_id_all, seq, -bdid_score), seq);

export fi_prep := fairisaac_prep_out  : persist('TMTEST::fairisaac_bdid_prep');
