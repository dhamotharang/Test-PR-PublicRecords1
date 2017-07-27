IMPORT Business_Header, ut;

/////////////////////////////////////////////////////////////
//Vendor ID must depend on the license type since some fields are blank for certain license types
//and the unique_id field is too large to fit in the vendor_id field
/////////////////////////////////////////////////////////////
string70 getvendorid(string3 ltype, string10 csign, string50 name, string15 fnumber, string40 dbaname) :=
MAP(trim(ltype) = 'MKT' or trim(ltype) = 'MW' or trim(ltype) = 'WTB' or 
	trim(ltype) = 'PAG' or trim(ltype) = 'CEL' => 	trim(ltype) + '-' + trim(csign)   + '-' + trim(name),
	trim(ltype) = 'PEN' 				   => 	trim(ltype) + '-' + trim(fnumber) + '-' + trim(name),
	trim(ltype) = 'BX' 					   => 	trim(ltype) + '-' + trim(csign)   + '-' + trim(dbaname),
											trim(ltype) + '-' + trim(csign)   + '-' + trim(name));
string8 validatedate(string8 mydate) :=
map(mydate = '' or (integer)mydate > (integer)(stringlib.GetDateYYYYMMDD()) or (integer)mydate < 16000101 => '',
	mydate);

string8 choosedate(string8 process_date, string8 date_issued, string8 date_change) :=
map( validatedate(date_issued) <> '' => validatedate(date_issued),
	validatedate(date_change) <> '' => validatedate(date_change),
								'');

FCC_Licenses_base := FCC.File_FCC_licenses_in;

//normalize contacts to two records
Layout_FCC_Licenses_slim := record
   string8 process_date;
   string3 license_type;
   string15 file_number;
   string10 callsign_of_license;
   string50 licensees_name;
   string40 DBA_name;
   string35 licensees_attention_line;
   string10 licensees_phone;
   string8 date_application_received_at_FCC;
   string8 date_license_issued;
   string8 date_license_expires;
   string8 date_of_last_change;
   string5   title;
   string20  fname;
   string20  mname;
   string20  lname;
   string5   name_suffix;
string10        prim_range;
string2         predir;
string28        prim_name;
string4         addr_suffix;
string2         postdir;
string10        unit_desig;
string8         sec_range;
string25        p_city_name;
string25        v_city_name;
string2         st;
string5         zip5;
string4         zip4;
string3         county;
string10        geo_lat;
string11        geo_long;
string4         msa;
string7         geo_blk;
string1         geo_match;
end;


Layout_FCC_Licenses_slim Norm_FCC_contacts(FCC_Licenses_base L, integer CTR) := transform
  self.title         := choose(CTR, L.licensee_title, 		L.attention_title);
  self.fname         := choose(CTR, L.licensee_fname, 		L.attention_fname);
  self.mname         := choose(CTR, L.licensee_mname, 		L.attention_mname);
  self.lname         := choose(CTR, L.licensee_lname, 		L.attention_lname);
  self.name_suffix   := choose(CTR, L.licensee_name_suffix, L.attention_name_suffix);
  self               := L;
end;

fcc_lic_norm := normalize(FCC_Licenses_base,2, Norm_FCC_contacts(left,counter));

//*************************************************************************
// Translate Contact from fcc_lic to Business Contact Format
//*************************************************************************

Business_Header.Layout_Business_Contact_Full Translate_fcc_to_BCF(Layout_FCC_Licenses_slim l, integer CTR) := TRANSFORM
self.company_title := ''; 
self.vendor_id := getvendorid(L.license_type,L.callsign_of_license,L.licensees_name,L.file_number,L.DBA_name)[1..34];
self.source := 'FC';
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
SELF.company_name := choose(CTR,stringlib.stringtouppercase(L.licensees_name), stringlib.stringtouppercase(L.DBA_name));
self.company_source_group := '';
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
self.company_phone := (UNSIGNED6)((UNSIGNED8)L.licensees_phone);
self.company_fein := 0;
self.phone := (unsigned6)((unsigned8)L.licensees_phone);
self.email_address := '';
SELF.dt_first_seen := (UNSIGNED4)choosedate(L.process_date, L.date_license_issued, L.date_of_last_change);
SELF.dt_last_seen := self.dt_first_seen;
self.record_type := 'C';
self := l;
end;

//--------------------------------------------
// Normalize names
//--------------------------------------------
from_fcc_lic_norm := NORMALIZE(fcc_lic_norm, 
				2, Translate_fcc_To_BCF(LEFT, COUNTER));

// Removed extra contacts with blank addresses
from_fcc_lic_dist := distribute(from_fcc_lic_norm(company_name <> '' and Datalib.CompanyClean(company_name)[41..120] <> ''), hash(trim(vendor_id), trim(company_name)));

from_fcc_lic_sort := sort(from_fcc_lic_dist, vendor_id, company_name,
                     fname, mname, lname, name_suffix, company_title, phone, if(zip <> 0, 0, 1), zip, prim_name, prim_range, 
					 local);

from_fcc_lic_dedup := dedup(from_fcc_lic_sort,
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


export FCC_Licenses_as_Business_Contact := from_fcc_lic_dedup((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix), 
(INTEGER)(AddrCleanLib.CleanPerson73(fname + ' ' + mname + ' ' + lname + ' ' + name_suffix)[71..73]) >= 85) : persist('TEMP::fcc_lic_Contacts_As_BC');
