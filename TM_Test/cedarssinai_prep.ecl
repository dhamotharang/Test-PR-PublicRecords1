import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_cedars_sinai_seq := record
unsigned4 seq := 0;
layout_cedarssinai_in;
end;

// Add unique sequence number to input
layout_cedars_sinai_seq SequenceInput(layout_cedarssinai_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

cedars_sinai_seq := project(File_CedarsSinai_In, SequenceInput(left, counter)) : persist('TMTEST::cedars_sinai_seq');

string GetWord(string str) := if(Stringlib.StringToUpperCase(str[1..(Stringlib.Stringfind(str, ' ', 1) -1)]) <> '',
                                 Stringlib.StringToUpperCase(str[1..(Stringlib.Stringfind(str, ' ', 1) -1)]),
						   str);

boolean CheckAddr(string str) := Stringlib.StringFilter(GetWord(str), '0123456789') <> '' or
                                 GetWord(str) = 'PO' or
						   GetWord(str) = 'P.O.' or
						   GetWord(str) = 'BOX';
						   
has(string src, string str) := stringlib.stringfind(Stringlib.StringToUpperCase(src),str,1) > 0;

TitleRank(string title) :=
map((has(title, 'CEO') or has(title, 'OWNER')) AND 
		~has(title, 'WIFE') => 1,
	has(title, 'PRESIDENT') AND 
		~has(title, 'VICE') and
		~has(title, 'V PRES') and
		~has(title, 'V-PRES') and
		~has(title, 'WIFE') => 1,
	has(title, 'PRINCIPAL') => 1,
	has(title, 'PARTNER') and
		~has(title, 'LTD PARTNER') => 1,
	(has(title, 'GENERAL MANAGER') or has(title, 'GENERAL MGR') or has (title, 'GNRL MGR')) and
		~has(title, 'MANAGER FINANCE') and
		~has(title, 'MANAGER/SALES') => 1,
	has(title, 'CHAIRMAN') => 1,
	has(title, 'CHIEF') => 2,
	has(title, 'CFO') => 2,
	has(title, 'COO') => 2,
	has(title, 'CIO') => 2,
	has(title, 'CTO') => 2,
	has(title, 'CMO') => 2,
	has(title, 'CSO') => 2,
	has(title, 'EVP') => 3,
	has(title, 'SVP') => 3,
	(has(title, 'SENIOR') or has(title, 'EXECUTIVE')) and
	(has(title, 'VP') or has(title, 'PRESIDENT')) => 3,
	has(title, 'PRESIDENT') OR has(title, 'VP') => 4,
	has(title, 'DIRECTOR') => 5,
	has(title, 'MANAGER') or has(title,'MGR') => 6,
	has(title, 'SECRETARY') or has(title,'SECY') => 7,
	has(title, 'EXECUTOR') => 8,
	title = '' => 30,
	31);

// Isolate company name
layout_cedars_sinai_temp := record
layout_cedars_sinai_seq;
string120 company_name := '';
string50 addr1 := '';
string50 addr2 := '';
end;

layout_cedars_sinai_temp IsolateCompanyName(layout_cedars_sinai_seq l) := transform
self.company_name := map(not CheckAddr(l.CnAdrAll_1_01_Addrline1) and CheckAddr(l.CnAdrAll_1_01_Addrline2) => Stringlib.StringToUpperCase(l.CnAdrAll_1_01_Addrline1),
                         not CheckAddr(l.CnAdrAll_1_01_Addrline1) and not CheckAddr(l.CnAdrAll_1_01_Addrline2) => if(TitleRank(l.CnAdrAll_1_01_Addrline1) >= 30,
					                                                                                            Stringlib.StringToUpperCase(l.CnAdrAll_1_01_Addrline1),
																							  if(Stringlib.StringFind(l.CnAdrAll_1_01_Addrline1, ',', 1) = 0,
																							     Stringlib.StringToUpperCase(l.CnAdrAll_1_01_Addrline2),
																								Stringlib.StringToUpperCase(l.CnAdrAll_1_01_Addrline1[(Stringlib.StringFind(l.CnAdrAll_1_01_Addrline1, ',', 1)+1)..]))),
				     CheckAddr(l.CnAdrAll_1_01_Addrline1) and not CheckAddr(l.CnAdrAll_1_01_Addrline2) and
					   (Stringlib.StringToUpperCase(l.CnAdrAll_1_01_Addrline2[1..3]) = 'C/O' or l.CnAdrAll_1_01_Addrline3 = '') => Stringlib.StringToUpperCase(l.CnAdrAll_1_01_Addrline2),
					'');
self := l;
end;

cedars_sinai_seq_cn := project(cedars_sinai_seq(not(Stringlib.StringToUpperCase(CnAdrAll_1_01_Type)='HOME')), IsolateCompanyName(left));

// Strip out C/O from company name
layout_cedars_sinai_temp StripCareOf(layout_cedars_sinai_temp l) := transform
self.company_name := if(l.company_name[1..4] = 'C/O ', l.company_name[5..], l.company_name);
self := l;
end;

cedars_sinai_seq_cn_fix := project(cedars_sinai_seq_cn, StripCareOf(left));

// Isolate address lines 1 and 2
layout_cedars_sinai_temp IsolateAddrLines(layout_cedars_sinai_temp l) := transform
self.addr1 := map(CheckAddr(l.CnAdrAll_1_01_Addrline1) => l.CnAdrAll_1_01_Addrline1,
                  CheckAddr(l.CnAdrAll_1_01_Addrline2) => l.CnAdrAll_1_01_Addrline2,
			   CheckAddr(l.CnAdrAll_1_01_Addrline3) => l.CnAdrAll_1_01_Addrline3,
			   '');
string50 temp_addr2 := map(CheckAddr(l.CnAdrAll_1_01_Addrline1) => l.CnAdrAll_1_01_Addrline2,
                  CheckAddr(l.CnAdrAll_1_01_Addrline2) => l.CnAdrAll_1_01_Addrline3,
			   '');
			   
self.addr2 := if(Stringlib.StringToUpperCase(temp_addr2) <> l.company_name, temp_addr2, '');
self := l;
end;

cedars_sinai_seq_addr := project(cedars_sinai_seq_cn_fix, IsolateAddrLines(left));

// Blank address line 2 if c/o
// Swap address line 2 and company_name if Cedars-Sinai
layout_cedars_sinai_temp FixAddr2(layout_cedars_sinai_temp l) := transform
self.addr2 := map(Stringlib.StringToUpperCase(l.addr2[1..3]) = 'C/O' => '',
                  Stringlib.StringToUpperCase(l.addr2[1..6]) = 'CEDARS' => l.cnadrall_1_01_addrline1,
			   l.addr2);
self.company_name := if(Stringlib.StringToUpperCase(l.addr2[1..6]) = 'CEDARS',
                        Stringlib.StringToUpperCase(l.addr2),
				    l.company_name);
self := l;
end;

cedars_sinai_seq_fix := project(cedars_sinai_seq_addr, FixAddr2(left));

// clean the names and addresses
layout_cedars_sinai_clean := record
layout_cedars_sinai_temp;
string73  clean_name; 
string182 clean_bus_address;
string10  phone10;
end;

layout_cedars_sinai_clean CleanInput(layout_cedars_sinai_temp l) := transform
self.clean_name := addrcleanlib.cleanPerson73(trim(l.cnbio_first_name) + ' ' +
                                              if(l.cnbio_middle_name <> '', trim(l.cnbio_middle_name) + ' ', '') +
									 trim(l.cnbio_last_name));
self.clean_bus_address := addrcleanlib.cleanAddress182(trim(l.Addr1) + ' ' + trim(l.Addr2), trim(l.cnadrall_1_01_city) + ', ' + trim(l.cnadrall_1_01_state) + ' ' + trim(l.cnadrall_1_01_zip[1..5]));
self.phone10 := '';
self := l;
end;

cedars_sinai_clean_init := project(cedars_sinai_seq_fix, CleanInput(left));

// Project clean fields to base format
layout_cedarssinai_base InitBase(layout_cedars_sinai_clean l) := transform
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

cedars_sinai_clean := project(cedars_sinai_clean_init, InitBase(left)) : persist('TMTEST::cedars_sinai_clean');

// Project into BDID in batch format
Business_Header_SS.Layout_BDID_OutBatch InitBatch(layout_cedarssinai_base l) := transform
self.company_name := l.company_name;
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

cedars_sinai_bdid_batch_in := project(cedars_sinai_clean, InitBatch(left));

matchset := ['A','N'];

Business_Header_SS.MAC_Match_Flex
(
	cedars_sinai_bdid_batch_in, matchset,
	company_name, 
	prim_range, prim_name, z5,
	sec_range, st,
	phone_field, fein_field,
	bdid,	
	Business_Header_SS.Layout_BDID_OutBatch,
	true, score,  //these should default to zero in definition
	cedars_sinai_bdid_batch_match,
	1,   //keep count
	75   //score threshold
)

Business_Header_SS.MAC_BestAppend(
	cedars_sinai_bdid_batch_match,
	'BEST_ALL',
	'BEST_ALL',
	cedars_sinai_bdid_batch_best,
	false
)

cedars_sinai_bdid_batch := cedars_sinai_bdid_batch_best : persist('TMTEST::cedars_sinai_bdid_batch');

// Join to base file to add bdid information
layout_cedarssinai_base CombineBest(layout_cedarssinai_base l, Business_Header_SS.Layout_BDID_OutBatch r) := transform
self.bdid := r.bdid;
self.bdid_score := r.score;
self.bus_best_phone := r.best_phone;
self.bus_best_fein := r.best_fein;
self.bus_best_CompanyName := r.best_CompanyName;
self.bus_best_addr1 := r.best_addr1;
self.bus_best_city := r.best_city;
self.bus_best_state := r.best_state;
self.bus_best_zip := r.best_zip;
self.bus_best_zip4 := r.best_zip4;
self := l;
end;

cedars_sinai_bdid_best := join(cedars_sinai_clean,
                                cedars_sinai_bdid_batch,
						  left.seq = right.seq,
						  CombineBest(left, right),
						  left outer,
						  hash);
						  
// Append the group id
bhg := Business_Header.File_Super_Group;

cedars_sinai_group_id := join(bhg,
                              cedars_sinai_bdid_best(bdid <> 0),
						left.bdid = right.bdid,
						transform(layout_cedarssinai_base, self.group_id := left.group_id, self := right),
						right outer,
						hash);
						 
cedars_sinai_group_id_all := cedars_sinai_group_id + cedars_sinai_bdid_best(bdid = 0) : persist('TMTEST::cedars_sinai_bdid_best');

// Add dids for contacts associated with the businesses
didville.Layout_Did_OutBatch InitExec(layout_cedarssinai_base l) := transform
self.dob := '';
self.ssn := '';
self.phone10 := '';
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

cedars_sinai_exec_to_did := project(cedars_sinai_group_id_all(lname <> ''),InitExec(left));

DID_Matchset := ['A','Z'];

DID_Add.MAC_Match_Flex(cedars_sinai_exec_to_did, 
	 DID_Matchset,
	 ssn, dob, fname, mname,lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10, 
	 did,
	 didville.Layout_Did_OutBatch, 
	 TRUE, score, 
      50,  //low score threshold
	 cedars_sinai_exec_did_match)

didville.MAC_BestAppend(cedars_sinai_exec_did_match,'BEST_ALL','BEST_ALL',0,true,cedars_sinai_exec_did_best)


cedars_sinai_gid_all_dist := distribute(cedars_sinai_group_id_all, hash(seq));
cedars_sinai_exec_did_best_dist := distribute(cedars_sinai_exec_did_best, hash(seq)) : persist('TMTEST::cedars_sinai_did');

// Add did and did scores and best info
Layout_cedarssinai_base AppendDIDBest(Layout_cedarssinai_base l, didville.Layout_Did_OutBatch r) := transform
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

cedars_sinai_exec_did_append := join(cedars_sinai_gid_all_dist,
                                     cedars_sinai_exec_did_best_dist,
					            left.seq = right.seq,
					            AppendDIDBest(left, right),
					            left outer,
					            local)    : persist('TMTEST::cedars_sinai_did_best');

cedars_sinai_out := dedup(sort(cedars_sinai_exec_did_append, seq, -score), seq);

export cedarssinai_prep := cedars_sinai_out  : persist('TMTEST::cedars_sinai_bdid_did_prep');
