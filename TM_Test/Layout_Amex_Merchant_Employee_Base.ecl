export Layout_Amex_Merchant_Employee_Base := record
unsigned4 rid;
unsigned4 seq;
unsigned6 group_id := 0;
unsigned6 bdid := 0;
// From Business Contact File
unsigned6 did := 0;        // DID from Headers
unsigned4 dt_first_seen;   // From contact info if available
unsigned4 dt_last_seen;    // From contact infor if available
string2   source;          // Source file type
string1   record_type;     // 'C' = Current, 'H' = Historical
string1   from_hdr := 'N'; // 'Y' if contact is from address 
						   // match with person headers.
BOOLEAN   glb := false;    // GLB restricted record (only possible
						   // for contacts pulled from header)
BOOLEAN	  dppa := false;   // DPPA restricted record
qstring35 company_title;   // Title of Contact at Company if available
qstring35 company_department := '';
qstring5  title;
qstring20 fname;
qstring20 mname;
qstring20 lname;
qstring5  name_suffix;
string1   name_score;
qstring10 prim_range;
string2   predir;
qstring28 prim_name;
qstring4  addr_suffix;
string2   postdir;
qstring5  unit_desig;
qstring8  sec_range;
qstring25 city;
string2   state;
unsigned3 zip;
unsigned2 zip4;
string3   county;
string4   msa;
qstring10 geo_lat;
qstring11 geo_long;
unsigned6 phone;
string60  email_address;
unsigned4 ssn := 0;
// From Best nonglb file
qstring10 emp_phone := '';
qstring9  emp_ssn := '';
integer4  emp_dob := 0;
qstring20 emp_fname := '';
qstring20 emp_mname := '';
qstring20 emp_lname := '';
qstring5  emp_name_suffix := '';
qstring10 emp_prim_range := '';
string2   emp_predir := '';
qstring28 emp_prim_name := '';
qstring4  emp_suffix := '';
string2   emp_postdir := '';
qstring10 emp_unit_desig := '';
qstring8  emp_sec_range := '';
qstring25 emp_city_name := '';
string2   emp_st := '';
qstring5  emp_zip := '';
qstring4  emp_zip4 := '';
unsigned3 emp_addr_dt_last_seen := 0;
string1   emp_po_box_replaced := 'N';  // if 'Y', best address was a PO Box and replaced if street address available
end;