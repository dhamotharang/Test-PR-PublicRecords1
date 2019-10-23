import header;
EXPORT Layout_Hdr := record
unsigned6    did := 0;
unsigned6    rid;
string1 	 pflag1 := '';		//for original pflag purposes
string1		 pflag2 := '';		//for phone number related work
string1		 pflag3 := '';		//for marking records that will have to be split into multiples for despray
string2      src;
unsigned3    dt_first_seen;
unsigned3    dt_last_seen;
unsigned3    dt_vendor_last_reported;
unsigned3    dt_vendor_first_reported;
unsigned3    dt_nonglb_last_seen;
string1      rec_type;
qstring10    phone;
qstring9     ssn;
integer4     dob;
qstring5     title;
qstring20    fname;
qstring20    mname;
qstring20    lname;
qstring5     name_suffix;
qstring10    prim_range;
string2      predir;
qstring28    prim_name;
qstring4     suffix;
string2      postdir;
qstring10    unit_desig;
qstring8     sec_range;
qstring25    city_name;
string2      st;
qstring5     zip;
qstring4     zip4;
string1      tnt := ' ';
string1	   valid_SSN := '';
string1	   jflag1 := '';  //valid_DOB
string1      jflag2 := '';
string1	   jflag3 := ''; //ssn confirmed from EQ
unsigned8   RawAID := 0; 
string5    Dodgy_tracking:= '';  // UNK's from name_suffix
unsigned2  address_ind:=0;  // address indicator bitmap
unsigned2  name_ind:=0;  // name indicator bitmap
unsigned8 persistent_record_ID := 0; //tracking the record between full header and individual dataset
end;

//see header.layout_header_v2;
