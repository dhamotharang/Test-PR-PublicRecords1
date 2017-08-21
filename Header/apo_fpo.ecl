import header,mdr,lib_datalib,ut;
#workunit ('name', 'APO FPO');

h := dataset('~thor_data400::base::header_m_20040720',header.Layout_Header,flat);


MyFields := record	
  h.st;
  h.dt_last_seen;
  h.did;
end;


slim_hdr := table(h,MyFields);
dist_file := DISTRIBUTE(slim_hdr(st = 'AA' or st = 'AE' or st = 'AP'), hash(did));
sort_file := SORT(dist_file, did,LOCAL);
unique_by_did := DEDUP(sort_file, did, LOCAL);


dist_hdr_file := DISTRIBUTE(h(st = 'FL' AND dt_last_seen > 200208), hash(did));
sort_hdr_file := SORT(dist_hdr_file, did, -dt_last_seen, LOCAL);
unique_hdr_by_did := DEDUP(sort_hdr_file, did, LOCAL);


header.Layout_Header join_to_header(unique_by_did apo, unique_hdr_by_did hdr) := transform
	self := hdr;
end;

int_header := join(unique_by_did, unique_hdr_by_did,
					left.did = right.did, 
					join_to_header(left,right), local);

count(unique_by_did);
count(unique_hdr_by_did);
count(int_header);


string6 convert_date6(integer4 date) := 
   MAP(date = 0 => '', 
       date % 100 = 0 => (string4)( date div 100 ) + '  ',
       (string6)date );


//-- Convert 8 digit
// integer date into 8 character string
//	 If date = 0, return empty string
//	 If date has only 6 digits (missing DD), multiply by 100 (add 00)

string8 convert_date8(integer4 date) := 
	map(date = 0 => '',
	    date > 100000 and date < 1000000 => (string8)(date * 100),
		(string8)date);


string_rec2 := record
//-- These 2 are integers being put into strings
	string12 	did := intformat(int_header.did,12,1);	//converted from int
	//string12 	preGLB_did := intformat(int_header.preGLB_did,12,1);	//converted from int
	string12 	rid := intformat(int_header.rid,12,1);  //converted from int

    string2     src := map(mdr.source_is_on_Probation(int_header.src) => 'P',
						   mdr.Source_is_DPPA(int_header.src) => 'A', 
						   mdr.Source_is_Utility(int_header.src) => 'U',
						   '');
//--  These next five need to be converted
	string6 	dt_first_seen := convert_date6(int_header.dt_first_seen);
	string6     dt_last_seen := convert_date6(int_header.dt_last_seen);
	string6     dt_vendor_last_reported := 
      IF ( mdr.Source_is_DPPA(int_header.src) and int_header.dt_last_seen<>0,
           convert_date6(int_header.dt_last_seen),
           convert_date6(int_header.dt_vendor_last_reported));
	string6     dt_vendor_first_reported := 
      IF ( mdr.Source_is_DPPA(int_header.src) and int_header.dt_first_seen<>0,
           convert_date6(int_header.dt_first_seen),
           convert_date6(int_header.dt_vendor_first_reported));
	string6     dt_nonglb_last_seen := convert_date6(int_header.dt_nonglb_last_seen);

	string1     rec_type := int_header.rec_type;
	string18    vendor_id := if(mdr.Source_is_DPPA(int_header.src),
							    mdr.get_DPPA_st(int_header.src, int_header.st) + int_header.vendor_id,
							    int_header.vendor_id);
	string10    phone := int_header.phone;
	string9     ssn := if(int_header.ssn= '' or int_header.pflag3<>'' , '', intformat((integer)int_header.ssn,9,1));
//-- This one needs to be converted
	string8     dob := if((convert_date8(int_header.dob))[1]='*','',convert_date8(int_header.dob));

	string5     title := int_header.title;
	string20    fname := int_header.fname;
	string20    mname := int_header.mname;
	string20    lname := int_header.lname;
	string5     name_suffix := if (ut.is_unk(int_header.name_suffix),'',int_header.name_suffix);
	string10    prim_range := int_header.prim_range;
	string2     predir := int_header.predir;
	string28    prim_name := if(int_header.src not in ['DE', 'DS'], int_header.prim_name, '');
	string4     suffix := int_header.suffix;
	string2     postdir := int_header.postdir;
	string10    unit_desig := int_header.unit_desig;
	string8     sec_range := int_header.sec_range;
	string25    city_name := int_header.city_name;
	string2     st := int_header.st;
	string5     zip := if(int_header.zip = '', '', intformat((integer)int_header.zip,5,1));
	string4     zip4 := if(int_header.zip4 = '', '', intformat((integer)int_header.zip4,4,1));
	string3     county := int_header.county;
	string4     msa := if((integer)int_header.cbsa=0,'0000',int_header.cbsa[1..4]);
	string1     tnt := if(int_header.tnt = 'P' or header.isMonthsFromNew(int_header.dt_last_seen, 3), 
						  'Y', 
						  int_header.tnt );  
	string1		valid_ssn := int_header.valid_ssn;

end;


apo_fpo_file := table(int_header,string_rec2);
output(apo_fpo_file,,'out::apo_file');