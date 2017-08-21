import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_ecredit_customer_seq := record
unsigned4 seq;
layout_ecredit_customer_in;
end;

// Add unique record id to input
layout_ecredit_customer_seq AssignSeq(layout_ecredit_customer_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

ecredit_customer_seq := project(file_ecredit_customer_in, AssignSeq(left, counter));

// clean the names and addresses
layout_ecredit_customer_clean := record
layout_ecredit_customer_seq;
string182 clean_bus_address;
string10  phone10;
end;

layout_ecredit_customer_clean CleanInput(layout_ecredit_customer_seq l) := transform
self.clean_bus_address := addrcleanlib.cleanAddress182(trim(l.Address1) + ' ' + trim(l.Address2), trim(l.City) + ', ' + trim(l.Region) + ' ' + (trim(l.PostalCode))[1..5]);
self.phone10 := Address.CleanPhone(trim(l.PhoneNo));
self := l;
end;

ecredit_customer_clean_init := project(ecredit_customer_seq, CleanInput(left));

// Project clean fields to base format
layout_ecredit_customer_base InitBase(layout_ecredit_customer_clean l) := transform
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

ecredit_customer_clean := project(ecredit_customer_clean_init, InitBase(left)) : persist('TMTEST::ecredit_customer_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_ecredit_customer_base l) := transform
self.phone10 := l.phone10;
self.company_name := Stringlib.StringToUpperCase(l.Name);
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

ecredit_customer_bdid_batch_in := project(ecredit_customer_clean, InitBatch(left));

matchset := ['A','P','N'];

Business_Header_SS.MAC_Match_Flex
(
	ecredit_customer_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	ecredit_customer_bdid_batch_match,
	1,   //keep count
	75   //score threshold
)

Business_Header_SS.MAC_BestAppend(
	ecredit_customer_bdid_batch_match,
	'BEST_ALL',
	'BEST_ALL',
	ecredit_customer_bdid_batch_best,
	false
)

ecredit_customer_bdid_batch := ecredit_customer_bdid_batch_best : persist('TMTEST::ecredit_customer_bdid_batch');

// Join to base file to add bdid information
layout_ecredit_customer_base CombineBest(layout_ecredit_customer_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
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

ecredit_customer_bdid_best := join(ecredit_customer_clean,
                                ecredit_customer_bdid_batch,
						  left.seq = right.seq,
						  CombineBest(left, right),
						  left outer,
						  hash);
						  
// Append the group id
bhg := Business_Header.File_Super_Group;

ecredit_customer_group_id := join(bhg,
                               ecredit_customer_bdid_best(bdid <> 0),
						 left.bdid = right.bdid,
						 transform(layout_ecredit_customer_base, self.group_id := left.group_id, self := right),
						 right outer,
						 hash);
						 
ecredit_customer_group_id_all := ecredit_customer_group_id + ecredit_customer_bdid_best(bdid = 0);
					 
ecredit_customer_out := sort(ecredit_customer_group_id_all, seq);

export ecredit_customer_prep := ecredit_customer_out  : persist('TMTEST::ecredit_customer_bdid_best');
