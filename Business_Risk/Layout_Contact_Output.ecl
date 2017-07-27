import Risk_Indicators;

r	:= risk_indicators.Layout_Desc;

export Layout_Contact_Output := record
// Information from InstantID_Function
Risk_Indicators.Layout_Output;
// Instant ID codes
STRING1 verify_addr;
STRING1 verify_dob;
INTEGER1 NAS_Summary;
INTEGER1 NAP_Summary;
INTEGER1 CVI;
DATASET(r) ri;												
DATASET(r) fua;
// Information from Business Contact record
unsigned6 bdid;
unsigned1 contact_score;
string34 vendor_id;
unsigned4 contact_dt_first_seen; 
unsigned4 contact_dt_last_seen;
string2   source;
string1   record_type;
string1   from_hdr;
BOOLEAN   glb;
BOOLEAN	  dppa;
string35 company_title;
string35 company_department;
string34 company_source_group;
string120 company_name;
string10 company_prim_range;
string2   company_predir;
string28 company_prim_name;
string4  company_addr_suffix;
string2   company_postdir;
string5  company_unit_desig;
string8  company_sec_range;
string25 company_city;
string2   company_state;
unsigned3 company_zip;
unsigned2 company_zip4;
unsigned6 company_phone;
unsigned4 company_fein;
// Business Owner Information
boolean owner_flag := false;         // title contains 'OWNER'
boolean officer_flag := false;       // company_title_rank = 1, but not 'OWNER'
unsigned1 company_title_rank := 0;  // 1=Owner, Principal, Partner, or key officer
end;