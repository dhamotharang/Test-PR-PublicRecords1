OPTIONS:-gn
MODULE:InsuranceHeader_Ingest

FILENAME:Base
IDFIELD:EXISTS:Did
RIDFIELD:RID:GENERATE
SOURCEFIELD:src
//SOURCERIDFIELD:source_id 
INGESTFILE:RAW_ALL:NAMED(InsuranceHeader_Ingest.In_Ingest)

// Source fields may seem special, but still need to be FIELDs to be used in the comparison

FIELD:src:0,0

// RECORDDATE fields are not considered for matching, and will be rolled up

FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
FIELD:dt_vendor_first_reported:RECORDDATE(FIRST):0,0
FIELD:dt_vendor_last_reported:RECORDDATE(LAST):0,0

// Fields DERIVED are not considered for matching, and will receive their "new" value 
// Record defining fields will be considered in dedup all other fileds gets existing base value  

FIELD:source_rid:0,0
//FIELD:ambiguous:0,0
//FIELD:consumer_disclosure:0,0
//FIELD:cleavepenalty:0,0
//FIELD:ssn_ind:0,0
//FIELD:dob_ind:0,0
//FIELD:dlno_ind:0,0
//FIELD:fname_ind:0,0
//FIELD:mname_ind:0,0
//FIELD:lname_ind:0,0
//FIELD:addr_ind:0,0
//FIELD:best_addr_ind:0,0
//FIELD:phone_ind:0,0
FIELD:ssn:0,0
FIELD:dob:0,0
FIELD:dl_nbr:0,0
FIELD:dl_state:0,0
FIELD:title:DERIVED:0,0
FIELD:fname:0,0
FIELD:mname:DERIVED:0,0
FIELD:lname:DERIVED:0,0
FIELD:sname:DERIVED:0,0
FIELD:phone:DERIVED:0,0
//FIELD:occupation:0,0
FIELD:gender:DERIVED:0,0
//FIELD:derived_gender:DERIVED:0,0
//FIELD:address_id:DERIVED:0,0  ?
//FIELD:addr_error_code:DERIVED:0,0 ?

FIELD:prim_range:DERIVED:0,0
FIELD:predir:DERIVED:0,0
FIELD:prim_name:DERIVED:0,0
FIELD:addr_suffix:DERIVED:0,0  // ? 
FIELD:postdir:DERIVED:0,0
FIELD:unit_desig:DERIVED:DERIVED:0,0 // ? 
FIELD:sec_range:DERIVED:0,0
FIELD:city:DERIVED:0,0
FIELD:st:DERIVED:0,0
FIELD:zip:DERIVED:0,0
FIELD:zip4:DERIVED:0,0

//FIELD:addressstatus:TYPE(STRING5):0,0 ? 
//FIELD:addresstype:TYPE(STRING3):0,0 ? 
FIELD:boca_did:DERIVED:0,0
FIELD:vendor_id:DERIVED:0,0
//FIELD:ambest:0,0
//FIELD:policy_number:0,0
//FIELD:insurance_type:TYPE(STRING2):0,0 ? 
//FIELD:claim_number:0,0
