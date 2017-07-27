EXPORT Layout_Business_Contact := RECORD
unsigned6 bdid := 0;       // BDID from Business Headers
unsigned6 did := 0;        // DID from Headers
unsigned1 contact_score := 0;
qstring34 vendor_id := ''; // Vendor key
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
string60 email_address;
unsigned4 ssn := 0;
END;