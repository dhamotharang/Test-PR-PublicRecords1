import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_amex_merchant_seq := record
unsigned4 rid;
unsigned4 seq := 0;
layout_amex_merchant_in;
end;

// Add unique record id to input
layout_amex_merchant_seq AssignRID(layout_amex_merchant_in l, unsigned4 cnt) := transform
self.rid := cnt;
self := l;
end;

amex_merchant_seq := project(file_amex_merchant_in, AssignRID(left, counter)) : persist('TMTEST::Amex_Merchant_Seq');

// Normalize input
layout_amex_merchant_norm NormalizeInput(layout_amex_merchant_seq l, unsigned4 cnt, unsigned1 ntyp) := transform
self.Business_Name := choose(ntyp, l.Business_Name, l.DBA);
self.Address1 := choose(cnt, l.Address1, l.Correspondence_Address1);
self.Address2 := choose(cnt, l.Address2, l.Correspondence_Address2);
self.City := choose(cnt, l.City, l.Correspondence_City);
self.State := choose(cnt, l.State, l.Correspondence_State);
self.Zipcode := choose(cnt, l.Zipcode, l.Correspondence_Zip);
self := l;
end;

amex_merchant_norm1 := normalize(amex_merchant_seq(Business_Name <> ''), 2, NormalizeInput(left, counter, 1));
amex_merchant_norm2 := normalize(amex_merchant_seq(DBA <> ''), 2, NormalizeInput(left, counter, 2));

amex_merchant_norm := amex_merchant_norm1 + amex_merchant_norm2;
amex_merchant_norm_dist := distribute(amex_merchant_norm, hash(rid, ut.CleanCompany(Business_Name)));
amex_merchant_norm_sort := sort(amex_merchant_norm_dist, rid, ut.CleanCompany(Business_Name),  -Zipcode, -State, -City, local);

layout_amex_merchant_norm RollupAmexMerchantNorm(layout_amex_merchant_norm L, layout_amex_merchant_norm r) := transform
self := l;
end;


amex_merchant_norm_rollup := rollup(amex_merchant_norm_sort,
                                    left.rid = right.rid and
							  ut.CleanCompany(left.Business_Name) = ut.CleanCompany(right.Business_Name) and
							  ((left.Zipcode = right.Zipcode and
							   left.Address1 = right.Address1 and
							   left.Address2 = right.Address2 and
							   left.city = right.city and
							   left.state = right.state)
							  OR
							   (right.Zipcode = '' and
							    right.Address1 = '' and
								right.Address2 = '' and
								right.city = '' and
								right.state = '')
							  ),
							  RollupAmexMerchantNorm(left, right),
							  local);

amex_merchant_norm_rollup_sort := sort(amex_merchant_norm_rollup, rid, Business_Name);

// Add unique sequence number to normalized input
layout_amex_merchant_norm SequenceInput(layout_amex_merchant_norm l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

amex_merchant_norm_rollup_seq := project(amex_merchant_norm_rollup_sort, SequenceInput(left, counter)) : persist('TMTEST::amex_merchant_norm');

// clean the names and addresses
layout_amex_merchant_clean := record
layout_amex_merchant_norm;
string182 clean_bus_address;
string10  phone10;
end;

layout_amex_merchant_clean CleanInput(layout_amex_merchant_norm l) := transform
self.clean_bus_address := addrcleanlib.cleanAddress182(trim(l.Address1) + ' ' + trim(l.Address2), trim(l.City) + ', ' + trim(l.State) + ' ' + trim(l.Zipcode[1..5]));
self.phone10 := Address.CleanPhone(l.Business_Phone);
self := l;
end;

amex_merchant_clean_init := project(amex_merchant_norm_rollup_seq, CleanInput(left));

// Project clean fields to base format
layout_amex_merchant_base InitBase(layout_amex_merchant_clean l) := transform
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

amex_merchant_clean := project(amex_merchant_clean_init, InitBase(left)) : persist('TMTEST::amex_merchant_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_amex_merchant_base l) := transform
self.phone10 := l.phone10;
self.company_name := Stringlib.StringToUpperCase(l.Business_Name);
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

amex_merchant_bdid_batch_in := project(amex_merchant_clean, InitBatch(left));

matchset := ['A','P','N'];

Business_Header_SS.MAC_Match_Flex
(
	amex_merchant_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	amex_merchant_bdid_batch_match,
	1,   //keep count
	75   //score threshold
)

Business_Header_SS.MAC_BestAppend(
	amex_merchant_bdid_batch_match,
	'BEST_ALL',
	'BEST_ALL',
	amex_merchant_bdid_batch_best,
	false
)

amex_merchant_bdid_batch := amex_merchant_bdid_batch_best : persist('TMTEST::amex_merchant_bdid_batch');

// Join to base file to add bdid information
layout_amex_merchant_base CombineBest(layout_amex_merchant_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
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

amex_merchant_bdid_best := join(amex_merchant_clean,
                                amex_merchant_bdid_batch,
						  left.seq = right.seq,
						  CombineBest(left, right),
						  left outer,
						  hash);
						  
// Append the group id
bhg := Business_Header.File_Super_Group;

amex_merchant_group_id := join(bhg,
                               amex_merchant_bdid_best(bdid <> 0),
						 left.bdid = right.bdid,
						 transform(layout_amex_merchant_base, self.group_id := left.group_id, self := right),
						 right outer,
						 hash);
						 
amex_merchant_group_id_all := amex_merchant_group_id + amex_merchant_bdid_best(bdid = 0);
					 
amex_merchant_out := sort(amex_merchant_group_id_all, rid, seq);

export amex_merchant_prep := amex_merchant_out  : persist('TMTEST::amex_merchant_bdid_best');
