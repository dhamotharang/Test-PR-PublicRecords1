import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

dm2_in := File_DM2_In;

Layout_DM2_Test := record
string15  COID := dm2_in.datarec[1..15];
string30	Company_Name := dm2_in.datarec[16..45];
string30  Company_Mail_Stop := dm2_in.datarec[46..75];
string30  Company_Division := dm2_in.datarec[76..105];
string30  Company_Address := dm2_in.datarec[106..135];
string12  Company_PO_Box := dm2_in.datarec[136..147];
string13  Company_City := dm2_in.datarec[148..160];
string2   Company_State := dm2_in.datarec[161..162];
string10  Company_Zip := dm2_in.datarec[163..172];
string16  Phone := dm2_in.datarec[173..188];
string16  Fax := dm2_in.datarec[189..204];
string40  Email_Domain := dm2_in.datarec[205..244];
string1   lf := dm2_in.lf;
end;

dm2_data := table(dm2_in, Layout_DM2_Test);

layout_dm2_seq := record
unsigned4 rid;
unsigned4 seq := 0;
layout_dm2_test;
end;

// Add unique record id to input
layout_dm2_seq AssignRID(layout_dm2_test l, unsigned4 cnt) := transform
self.rid := cnt;
self := l;
end;

dm2_seq := project(dm2_data, AssignRID(left, counter)) : persist('TMTEST::dm2_seq');

// Normalize input address
layout_dm2_norm NormalizeInputAddress(layout_dm2_seq l, unsigned4 cnt) := transform
self.Company_Address_Norm := choose(cnt, l.Company_Address, l.Company_PO_Box);
self := l;
end;

dm2_norm := normalize(dm2_seq, 2, NormalizeInputAddress(left, counter));

// Add unique sequence number to input
layout_dm2_norm SequenceInput(layout_dm2_norm l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

dm2_norm_seq := project(dm2_norm(Company_Address_Norm <> ''), SequenceInput(left, counter)) : persist('TMTEST::dm2_norm_seq');

// clean the names and addresses
layout_dm2_clean := record
layout_dm2_norm;
string182 clean_address;
string10  phone10;
end;

layout_dm2_clean CleanInput(layout_dm2_norm l) := transform
self.clean_address := addrcleanlib.cleanAddress182(trim(l.Company_Address_Norm) + ' ' + trim(l.Company_Mail_Stop),
                       trim(l.Company_City) + ', ' + trim(l.Company_State) + ' ' + trim(l.Company_Zip[1..5]));
self.phone10 := Address.CleanPhone(l.Phone);
self := l;
end;

dm2_clean_init := project(dm2_norm_seq, CleanInput(left));

// Project clean fields to base format
layout_dm2_base InitBase(layout_dm2_clean l) := transform
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

dm2_clean := project(dm2_clean_init, InitBase(left)) : persist('TMTEST::dm2_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_dm2_base l) := transform
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

dm2_bdid_batch_in := project(dm2_clean, InitBatch(left));

matchset := ['A','N'];

Business_Header_SS.MAC_Match_Flex
(
	dm2_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone_field, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	dm2_bdid_batch_match,
	1,   //keep count
	65   //score threshold
)

dm2_bdid_batch := dm2_bdid_batch_match : persist('TMTEST::dm2_bdid_batch');

// Join to base file to add bdid information
layout_dm2_base AppendBDID(layout_dm2_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self := l;
end;

dm2_bdid_append := join(dm2_clean,
                                 dm2_bdid_batch,
						   left.seq = right.seq,
						   AppendBDID(left, right),
						   left outer,
						   hash);

// Append Best Information
bhb := Business_Header.File_Business_Header_Best;


ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

Layout_dm2_Base AppendBest(Layout_dm2_Base l, bhb r) := transform
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

dm2_bdid_best := join(dm2_bdid_append,
                               bhb,
					      left.bdid = right.bdid,
					      AppendBest(left, right),
					      left outer,
					      hash);
					    
// Append the group id
bhg := Business_Header.File_Super_Group;

dm2_group_id := join(bhg,
                              dm2_bdid_best(bdid <> 0),
						left.bdid = right.bdid,
						transform(layout_dm2_base, self.group_id := left.group_id, self := right),
						right outer,
						hash);
						 
dm2_group_id_all := dm2_group_id + dm2_bdid_best(bdid = 0);

dm2_prep_out := sort(dm2_group_id_all, seq);

export dm2_prep := dm2_prep_out : persist('TMTEST::dm2_bdid_best');
