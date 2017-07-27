/** SALT Macro to fetch DIDs + Score when input other than DID provided by user **/
EXPORT FetchDIDsSALT(DATASET(layouts.layout_cleaner) in_criteria) := FUNCTION

IdentityManagement_Services.MAC_SALT_search(
in_criteria,
DID,
, // Input_SNAME
tname.fname,tname.mname,tname.lname,
,, // Gender
taddress.prim_name,taddress.prim_range,taddress.sec_range,
taddress.city,taddress.state,taddress.zip5,
tssn.ssn,
tdob.dob,
tphone.phone10,  // not available
tdl.dl_st, // DL State
tdl.dl_num, // DL Number
, // Input_SRC
, // Input_SOURCE_RID
match_code_out);

RETURN match_code_out;
END;