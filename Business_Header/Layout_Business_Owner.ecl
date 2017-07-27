export Layout_Business_Owner := RECORD
unsigned6 did;
string1   record_type;         // 'C' = Current, 'H' = Historical
string2   source;              // 
unsigned4 dt_last_seen;        // From contact infor if available
boolean owner_flag;            // title contains 'OWNER'
boolean officer_flag;          // company_title_rank = 1, but not 'OWNER'
unsigned1 company_title_rank;  // 1=Owner, Principal, Partner, or key officer
qstring35 company_title;
END;