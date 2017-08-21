import ut, Address, Business_Header, Business_Header_SS, did_add, DidVille, header_slimsort, Watchdog;

layout_sga_contact_seq := record, MAXLENGTH(32768)
unsigned4 seq := 0;
string11 MainContactID;
string11 MainCompanyID;
string3  Active;
string20 FirstName;
string2  MidInital;
string20 LastName;
string53 Age;
string1  Gender;
string80 PrimaryTitle;
string3  TitleLevel1;
string80 PrimaryDept;
string80 SecondTitle;
string3  TitleLevel2;
string80 SecondDept;
string80 ThirdTitle;
string3  TitleLevel3;
string80 ThirdDept;
string40 SkillCategory;
string40 SkillSubCategory;
string30 ReportTo;
string32 OfficePhone;
string6  OfficeExt;
string32 OfficeFax;   
string35 OfficeEmail;  
string32 DirectDial;
string32 MobilePhone;
string50 OfficeAddress1;
string30 OfficeAddress2;
string25 OfficeCity;
string2 OfficeState;
string15 OfficeZip;
string15 OfficeCountry;
string40 School;
string20 Degree;
string3  GraduationYear;
string15 Country;
string53 Salary;
string53 Bonus;
string53 Compensation;
string35 Citizenship;
string50 DiversityCandidate;
string11 EntryDate;
string11 LastUpdate;
string32 Biography;
end;

// Add unique sequence number to input
layout_sga_contact_seq SequenceInput(layout_sga_contact_in l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

sga_contact_seq := project(File_SGA_Contact_In, SequenceInput(left, counter)) : persist('TMTEST::sga_contact_seq');

layout_sga_contact_clean := record, MAXLENGTH(32768)
layout_sga_contact_seq;
string73  clean_name; 
string182 clean_address;
string10  phone10;
end;

layout_sga_contact_clean CleanInputNames(layout_sga_contact_seq l) := transform
self.clean_name := addrcleanlib.cleanPerson73(trim(l.FirstName) + ' ' + trim(l.MidInital) + trim(l.LastName));
self.clean_address := addrcleanlib.cleanAddress182(trim(l.OfficeAddress1) + ' ' + trim(l.OfficeAddress2), trim(l.OfficeCity) + ', ' + trim(l.OfficeState) + ' ' + trim(l.OfficeZip[1..5]));
self.phone10 := Address.CleanPhone(l.OfficePhone);
self := l;
end;

sga_contact_clean_init := project(sga_contact_seq, CleanInputNames(left));

Layout_sga_contact_Base InitBase(layout_sga_contact_clean l) := transform
  self.seq := l.seq;
  // clean office address
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

sga_contact_clean := project(sga_contact_clean_init, InitBase(left)) : persist('TMTEST::sga_contact_clean');

// Add bdid and business address and phone information
sga_company := sga_prep;

Layout_sga_contact_Base AppendBusinessInfo(Layout_sga_contact_Base l, Layout_SGA_Base r) := transform
self.bdid := r.bdid,
self.group_id := r.group_id,
self.bus_prim_range := r.prim_range;
self.bus_predir := r.predir;
self.bus_prim_name := r.prim_name;
self.bus_addr_suffix := r.addr_suffix;
self.bus_postdir := r.postdir;
self.bus_unit_desig := r.unit_desig;
self.bus_sec_range := r.sec_range;
self.bus_p_city_name := r.p_city_name;
self.bus_v_city_name := r.v_city_name;
self.bus_st := r.st;
self.bus_zip := r.zip;
self.bus_zip4 := r.zip4;
self.bus_cart := r.cart;
self.bus_cr_sort_sz := r.cr_sort_sz;
self.bus_lot := r.lot;
self.bus_lot_order := r.lot_order;
self.bus_dbpc := r.dbpc;
self.bus_chk_digit := r.chk_digit;
self.bus_rec_type := r.rec_type;
self.bus_fips_state := r.fips_state;
self.bus_fips_county := r.fips_county;
self.bus_geo_lat := r.geo_lat;
self.bus_geo_long := r.geo_long;
self.bus_msa := r.msa;
self.bus_geo_blk := r.geo_blk;
self.bus_geo_match := r.geo_match;
self.bus_err_stat := r.err_stat;
self.bus_phone10 := r.phone10;
self := l;
end;

sga_contact_clean_append := join(sga_contact_clean,
                                 sga_company,
						   left.MainCompanyID = right.MainCompanyID,
						   AppendBusinessInfo(left, right),
						   left outer,
						   hash);
						   
// Add dids for executives associated with the businesses
didville.Layout_Did_OutBatch InitContacts1(Layout_sga_contact_Base l) := transform
self.dob := '';
self.ssn := '';
self.phone10 := l.phone10;
self.suffix := l.name_suffix;
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

sga_contact_to_did1 := project(sga_contact_clean_append(lname <> '', zip <> '' or phone10 <> ''),InitContacts1(left));

didville.Layout_Did_OutBatch InitContacts2(Layout_sga_contact_Base l) := transform
self.dob := '';
self.ssn := '';
self.phone10 := l.bus_phone10;
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

sga_contact_to_did2 := project(sga_contact_clean_append(lname <> '', bus_zip <> '' or bus_phone10 <> ''),InitContacts2(left));

sga_contact_to_did := sga_contact_to_did1 + sga_contact_to_did2;

DID_Matchset := ['A','Z','P'];

DID_Add.MAC_Match_Flex(sga_contact_to_did, 
	 DID_Matchset,
	 ssn, dob, fname, mname,lname, suffix, 
	 prim_range, prim_name, sec_range, z5, st, phone10, 
	 did,
	 didville.Layout_Did_OutBatch, 
	 TRUE, score, 
      50,  //low score threshold
	 sga_contact_did_match)

didville.MAC_BestAppend(sga_contact_did_match,'BEST_ALL','BEST_ALL',0,true,sga_contact_did_best)

// Add did and did scores and best info
Layout_sga_contact_Base AppendDIDBest(Layout_sga_contact_Base l, didville.Layout_Did_OutBatch r) := transform
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

sga_contact_did_append := join(sga_contact_clean_append,
                                     sga_contact_did_best,
					            left.seq = right.seq,
					            AppendDIDBest(left, right),
					            left outer,
							  hash)    : persist('TMTEST::sga_contact_did_best');

/*							  
// Append BDID and Group ID
sga_company := sga_prep;

layout_company_id := record
sga_company.MainCompanyID;
sga_company.group_id;
sga_company.bdid;
end;

sga_company_ids := table(sga_company, layout_company_id);

sga_contact_bdid_append := join(sga_contact_did_append,
                                sga_company_ids,
						  left.MainCompanyID = right.MainCompanyID,
						  transform(Layout_sga_contact_Base,
						            self.bdid := right.bdid,
								  self.group_id := right.group_id,
								  self := left),
						  left outer,
						  hash);
*/
sga_contact_dedup := dedup(sort(sga_contact_did_append, seq, -score), seq);
sga_contact_out := sort(sga_contact_dedup, (integer)MainCompanyID);


export sga_contacts_prep := sga_contact_out : persist('TMTEST::sga_contacts_prep');