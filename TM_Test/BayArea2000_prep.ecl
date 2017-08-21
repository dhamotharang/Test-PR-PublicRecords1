import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_bayarea2000_seq := record
unsigned4 rid;
unsigned4 seq := 0;
layout_bayarea2000_test_in;
end;

// Add unique record id to input
layout_bayarea2000_seq AssignRID(layout_bayarea2000_test_in l, unsigned4 cnt) := transform
self.rid := cnt;
self := l;
end;

bayarea2000_seq := project(file_bayarea2000_test_in, AssignRID(left, counter)) : persist('TMTEST::bayarea2000_Seq');

layout_bayarea2000_norm_temp := record
Layout_BayArea2000_Test_Norm;
string CompanyPhoneNumber1 := '';
string CompanyPhoneNumber2 := '';
string CompanyPhoneNumber3 := '';
string CompanyPhoneNumber4 := '';
string CompanyPhoneNumber5 := '';
string CompanyPhoneNumber6 := '';
string CompanyPhoneNumber7 := '';
string CompanyPhoneNumber8 := '';
string CompanyPhoneNumber9 := '';
string CompanyPhoneNumber10 := '';
end;

// Normalize input address
layout_bayarea2000_norm_temp NormalizeInputAddress(layout_bayarea2000_seq l, unsigned4 cnt) := transform
self.CompanyAddress := choose(cnt, l.CompanyAddress1, l.CompanyAddress2, l.CompanyAddress3, l.CompanyAddress4,
                                   l.CompanyAddress5, l.CompanyAddress6, l.CompanyAddress7, l.CompanyAddress8,
					          l.CompanyAddress9, l.CompanyAddress10);

self := l;
end;

bayarea2000_norm1 := normalize(bayarea2000_seq, 10, NormalizeInputAddress(left, counter));

layout_bayarea2000_test_norm NormalizeInputPhone(layout_bayarea2000_norm_temp l, unsigned4 cnt) := transform
self.CompanyPhoneNumber := choose(cnt, l.CompanyPhoneNumber1, l.CompanyPhoneNumber2, l.CompanyPhoneNumber3, l.CompanyPhoneNumber4,
                                       l.CompanyPhoneNumber5, l.CompanyPhoneNumber6, l.CompanyPhoneNumber7, l.CompanyPhoneNumber8,
					              l.CompanyPhoneNumber9, l.CompanyPhoneNumber10);

self := l;
end;

bayarea2000_norm2 := normalize(bayarea2000_norm1(CompanyAddress <> ''), 2, NormalizeInputPhone(left, counter));

bayarea2000_norm := bayarea2000_norm2(CompanyPhoneNumber <> '');

// parse the address
pattern sws := pattern('[ \t\r\n]');
pattern ws := sws+;
pattern numbers := pattern('[0-9]')+;
pattern alphaspc := pattern('[-!.,a-zA-Z]');
pattern pobox := ['P.O.','PO'];
pattern AddressStart := (numbers | pobox);
pattern AddressField := (ws | first) AddressStart (ws | last);

layout_address_position := record
unsigned2 addrpos := MATCHPOSITION(AddressField/AddressStart);
string addrtext := bayarea2000_norm.companyaddress[MATCHPOSITION(AddressField/AddressStart)..];
bayarea2000_norm;
end;

bayarea2000_norm_parse := parse(bayarea2000_norm, CompanyAddress, AddressField, layout_address_position, not matched, noscan);


// Add unique sequence number to normalized input
layout_bayarea2000_test_norm SequenceInput(layout_address_position l, unsigned4 cnt) := transform
self.seq := cnt;
self.CompanyAddressParse := l.addrtext;
self := l;
end;

bayarea2000_norm_seq := project(bayarea2000_norm_parse, SequenceInput(left, counter)) : persist('TMTEST::bayarea2000_norm');

// clean the names and addresses
layout_bayarea2000_clean := record
layout_bayarea2000_test_norm;
string182 clean_bus_address;
string10  phone10;
end;

layout_bayarea2000_clean CleanInput(layout_bayarea2000_test_norm l) := transform
self.clean_bus_address := addrcleanlib.cleanAddress182(trim(l.CompanyAddressParse), trim(l.CompanyAddressParse));
self.phone10 := Address.CleanPhone(StringLib.StringFilter(l.CompanyPhoneNumber, '0123456789'));
self := l;
end;

bayarea2000_clean_init := project(bayarea2000_norm_seq, CleanInput(left));

// Project clean fields to base format
layout_bayarea2000_test_base InitBase(layout_bayarea2000_clean l) := transform
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

bayarea2000_clean := project(bayarea2000_clean_init, InitBase(left)) : persist('TMTEST::bayarea2000_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_bayarea2000_test_base l) := transform
self.phone10 := l.phone10;
self.company_name := Stringlib.StringToUpperCase(l.CompanyName);
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

bayarea2000_bdid_batch_in := project(bayarea2000_clean, InitBatch(left));

matchset := ['A','P','N'];

Business_Header_SS.MAC_Match_Flex
(
	bayarea2000_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone10, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	bayarea2000_bdid_batch_match,
	1,   //keep count
	75   //score threshold
)

// Join to base file to add bdid information
layout_bayarea2000_test_base AppendBDID(layout_bayarea2000_test_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self := l;
end;

bayarea2000_bdid_append := join(bayarea2000_clean,
                                bayarea2000_bdid_batch_match,
						  left.seq = right.seq,
						  AppendBDID(left, right),
						  left outer,
						  hash);

// Append Best Information
bhb := Business_Header.File_Business_Header_Best;


ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_bayarea2000_Test_Base AppendBest(Layout_bayarea2000_Test_Base l, bhb r) := transform
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

bayarea2000_bdid_best := join(bayarea2000_bdid_append,
                              bhb,
					     left.bdid = right.bdid,
					     AppendBest(left, right),
					     left outer,
					     hash);

						  
// Append the group id
bhg := Business_Header.File_Super_Group;

bayarea2000_group_id := join(bhg,
                             bayarea2000_bdid_best(bdid <> 0),
					    left.bdid = right.bdid,
					    transform(layout_bayarea2000_test_base, self.group_id := left.group_id, self := right),
					    right outer,
					    hash);
						 
bayarea2000_group_id_all := bayarea2000_group_id + bayarea2000_bdid_best(bdid = 0);
					 
bayarea2000_out := sort(bayarea2000_group_id_all, rid, seq);

export bayarea2000_prep := bayarea2000_out  : persist('TMTEST::bayarea2000_bdid_best');
