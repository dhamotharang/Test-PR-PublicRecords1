IMPORT Business_Header, ut;

/////////////////////////////////////////////////////
// Standardize the 2 digit year dates(yyyymmdd)
/////////////////////////////////////////////////////
string8 fixdate(string8 mmddyydate) :=
MAP(
mmddyydate = '' => '',
(integer)(mmddyydate[7..8]) > (integer)(stringlib.GetDateYYYYMMDD()[3..4]) => 
		'19' + mmddyydate[7..8] + mmddyydate[1..2] + mmddyydate[4..5],
		'20' + mmddyydate[7..8] + mmddyydate[1..2] + mmddyydate[4..5]);

/////////////////////////////////////////////////////
// Standardize the 2 digit year dates(yyyymm) 
/////////////////////////////////////////////////////
string6 fixmmyydate(string4 mmyydate) :=
MAP(
mmyydate = '' => '',
(integer)(mmyydate[3..4]) > (integer)(stringlib.GetDateYYYYMMDD()[3..4]) => 
		'19' + mmyydate[3..4] + mmyydate[1..2],
		'20' + mmyydate[3..4] + mmyydate[1..2]);


ebr_demo_file := Experian_Business_Reports.File_Demographic_Data_5610_In;
ebr_header_file := Experian_Business_Reports.File_Header_Records_In;

// Normalize 10 contact names
layout_demo_slim :=
record
   ebr_demo_file.process_date;
   ebr_demo_file.FILE_NUMBER;
   ebr_demo_file.SEGMENT_CODE;
   ebr_demo_file.SEQUENCE_NUMBER;
   ebr_demo_file.FISCAL_YR_END_MM;
   string10 exec_title;
   string5   title;
   string20  fname;
   string20  mname;
   string20  lname;
   string5   name_suffix;
   string3   name_score;
   string1 lf;
end;



layout_demo_slim         ebr_norm_names(ebr_demo_file l, integer CTR) := TRANSFORM
self.title := choose(CTR, l.contact_title1, l.contact_title2, l.contact_title3);
self.fname := choose(CTR, l.contact_fname1, l.contact_fname2, l.contact_fname3);
self.mname := choose(CTR, l.contact_mname1, l.contact_mname2, l.contact_mname3);
self.lname := choose(CTR, l.contact_lname1, l.contact_lname2, l.contact_lname3);
self.name_suffix := choose(CTR, l.contact_suffix1, l.contact_suffix2, l.contact_suffix3);
self.name_score := choose(CTR, l.contact_score1, l.contact_score2, l.contact_score3);
self.exec_title := choose(CTR, l.OFFICER_TITLE1, l.OFFICER_TITLE2, l.OFFICER_TITLE3);
self := L;
end;

file_ebr_norm_names := NORMALIZE(ebr_demo_file, 3, ebr_norm_names(LEFT, COUNTER));

layout_demo_join :=
record
   file_ebr_norm_names.process_date;
   file_ebr_norm_names.FILE_NUMBER;
   file_ebr_norm_names.SEGMENT_CODE;
   file_ebr_norm_names.SEQUENCE_NUMBER;
   file_ebr_norm_names.FISCAL_YR_END_MM;
   file_ebr_norm_names.exec_title;
   file_ebr_norm_names.title;
   file_ebr_norm_names.fname;
   file_ebr_norm_names.mname;
   file_ebr_norm_names.lname;
   file_ebr_norm_names.name_suffix;
   file_ebr_norm_names.name_score;
   string8 EXTRACT_DATE_MDY;
   string4 FILE_ESTAB_DATE_MMYY;
   string40 COMPANY_NAME;
   string10 PHONE_NUMBER;
   string10 prim_range;
   string2  predir;
   string28 prim_name;
   string4  addr_suffix;
   string2  postdir;
   string10 unit_desig;
   string8  sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2  st;
   string5  zip5;
   string4  zip4;
   string3  county;
   string10 geo_lat;
   string11 geo_long;
   string4  msa;
end;


// match to header record to get company name and address and phone
layout_demo_join getcompanyinfo(file_ebr_norm_names L, ebr_header_file R) := transform
	self := L;
	self := R;
end;

ebr_contacts_joined := join(file_ebr_norm_names, ebr_header_file, left.FILE_NUMBER = right.FILE_NUMBER
				,getcompanyinfo(LEFT,RIGHT),left outer);


//*************************************************************************
// Translate Contact from dca to Business Contact Format
//*************************************************************************

Business_Header.Layout_Business_Contact_Full Translate_ebr_demo_to_BCF(ebr_contacts_joined l) := TRANSFORM
self.company_title := l.exec_title;
self.vendor_id := L.FILE_NUMBER;
self.source := 'EB';
self.name_score := Business_Header.CleanName(l.fname,l.mname,l.lname, l.name_suffix)[142];
SELF.prim_range := L.prim_range;
SELF.predir := L.predir;
SELF.prim_name := L.prim_name;
SELF.addr_suffix := L.addr_suffix;
SELF.postdir := L.postdir;
SELF.unit_desig := L.unit_desig;
SELF.sec_range := L.sec_range;
SELF.city := L.p_city_name;
SELF.state := L.st;
SELF.zip := (UNSIGNED3)L.zip5;
SELF.zip4 := (UNSIGNED2)L.zip4;
SELF.county := L.county;
SELF.msa := L.msa;
SELF.geo_lat := L.geo_lat;
SELF.geo_long := L.geo_long;
SELF.company_name := stringlib.stringtouppercase(L.COMPANY_NAME);
self.company_source_group := L.FILE_NUMBER;
SELF.company_prim_range := L.prim_range;
SELF.company_predir := L.predir;
SELF.company_prim_name := L.prim_name;
SELF.company_addr_suffix := L.addr_suffix;
SELF.company_postdir := L.postdir;
SELF.company_unit_desig := L.unit_desig;
SELF.company_sec_range := L.sec_range;
SELF.company_city := L.p_city_name;
SELF.company_state := L.st;
SELF.company_zip := (UNSIGNED3)L.zip5;
SELF.company_zip4 := (UNSIGNED2)L.zip4;
self.company_phone := (UNSIGNED6)((UNSIGNED8)L.PHONE_NUMBER);
self.company_fein := 0;
self.phone := (unsigned6)((unsigned8)L.PHONE_NUMBER);
self.email_address := ' ';
SELF.dt_first_seen := if(L.FILE_ESTAB_DATE_MMYY <> '' and 
		(integer)(fixmmyydate(L.FILE_ESTAB_DATE_MMYY)) <= (integer)(stringlib.GetDateYYYYMMDD()[1..6]), 
			(UNSIGNED4)(fixmmyydate(L.FILE_ESTAB_DATE_MMYY) + '01'),
			if(L.EXTRACT_DATE_MDY <> '' and 
				(integer)(fixdate(L.EXTRACT_DATE_MDY)) <= (integer)(stringlib.GetDateYYYYMMDD()),
					(UNSIGNED4)(fixdate(L.EXTRACT_DATE_MDY)),
			0));
SELF.dt_last_seen := self.dt_first_seen;
self.record_type := 'C';
self := l;
end;

//--------------------------------------------
// Normalize names
//--------------------------------------------
ebr_contacts_norm := project(ebr_contacts_joined(trim(lname) <> ''),Translate_ebr_demo_To_BCF(LEFT));

// Removed extra contacts with blank addresses
ebr_contacts_dist := distribute(ebr_contacts_norm, hash(trim(vendor_id), trim(company_name)));

ebr_contacts_sort := sort(ebr_contacts_dist, vendor_id, company_name,
                     fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
					 local);

ebr_contacts_dedup := dedup(ebr_contacts_sort,
                             left.vendor_id = right.vendor_id and
							 left.company_name = right.company_name and
							 left.fname= right.fname and
							 left.mname = right.mname and
							 left.lname = right.lname and
							 left.name_suffix = right.name_suffix and
							 left.company_title = right.company_title and
							 ((left.zip = right.zip and
							 left.prim_name = right.prim_name and
							 left.prim_range = right.prim_range) or
                             (left.zip <> 0 and right.zip = 0)),
							 local);


export EBR_as_Business_Contact := ebr_contacts_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : persist('TEMP::EBR_Contacts_As_BC');

