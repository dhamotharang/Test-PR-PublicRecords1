OPTIONS:-gn 
MODULE:BIPV2_Ingest 

// -------------------------------------------------------------------
// Ingest
// -------------------------------------------------------------------
FILENAME:BASE
IDFIELD:EXISTS:DOTid
RIDFIELD:rcid:GENERATE
SOURCEFIELD:source
SOURCERIDFIELD:source_record_id
INGESTFILE:bipv2_update:NAMED(BIPV2_Ingest.In_INGEST)


//FIELDTYPE:DEFAULT:LEFTTRIM:NOQUOTES("'):ONFAIL(IGNORE)

FIELDTYPE:EMAIL_FMT:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_+%@.):LENGTHS(0,6..60):ONFAIL(IGNORE):CUSTOM(Email_Pattern)
FIELDTYPE:SSN_FMT:ALLOW(X0123456789'):ONFAIL(IGNORE):CUSTOM(SSN_Pattern)
FIELDTYPE:WORDBAG:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):SPACES( ):ONFAIL(IGNORE)
FIELDTYPE:NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -):ONFAIL(IGNORE)
FIELDTYPE:WORDSTR:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):ONFAIL(IGNORE)
//FIELDTYPE:WORDBAG30:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(0,3..30):ONFAIL(IGNORE)
FIELDTYPE:CORPKEY_FMT:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-):LENGTHS(0,4..30):ONFAIL(IGNORE):CUSTOM(CorpKey_Pattern)
//Example NYC and CHI for 3 letters, WINSTON-SALEM for the "-"                                                                                                          
FIELDTYPE:CITY:LIKE(WORDBAG):LENGTHS(0,3..):ONFAIL(IGNORE) 
FIELDTYPE:fld_contact:ALLOW(TF):LENGTHS(0,1):ONFAIL(IGNORE) 
FIELDTYPE:zip5:ALLOW(0123456789):LENGTHS(0,5):ONFAIL(IGNORE)
FIELDTYPE:hasZip4:ALLOW(0123456789):LENGTHS(0,4):ONFAIL(IGNORE)
FIELDTYPE:alpha_st:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2):ONFAIL(IGNORE)
FIELDTYPE:number:ALLOW(0123456789)
FIELDTYPE:multiword:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( <>{}[]-^=!+&,./):ONFAIL(IGNORE)
FIELDTYPE:Noblanks:LENGTHS(1..):ONFAIL(IGNORE)
FIELDTYPE:number09:ALLOW(0123456789):LENGTHS(0,9):ONFAIL(IGNORE)
FIELDTYPE:number9:ALLOW(0123456789):LENGTHS(0..9):ONFAIL(IGNORE)
FIELDTYPE:alpha02:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0,2):ONFAIL(IGNORE)
// Source fields may seem special, but still need to be FIELDs to be used in the comparison
FIELD:source:0,0
FIELD:source_record_id:0,0


// Omitted fields are not considered for matching, and will retain their "old" value (i.e. base file)
// FIELD:empid:0,0
// FIELD:powid:0,0
// FIELD:seleid:0,0
// FIELD:proxid:0,0
// FIELD:orgid:0,0
// FIELD:ultid:0,0


// RECORDDATE fields are not considered for matching, and will be rolled up
FIELD:dt_first_seen:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen:RECORDDATE(LAST):0,0
FIELD:dt_vendor_first_reported:RECORDDATE(FIRST):0,0
FIELD:dt_vendor_last_reported:RECORDDATE(LAST):0,0
FIELD:dt_first_seen_company_name:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen_company_name:RECORDDATE(LAST):0,0
FIELD:dt_first_seen_company_address:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen_company_address:RECORDDATE(LAST):0,0
FIELD:dt_first_seen_contact:RECORDDATE(FIRST):0,0
FIELD:dt_last_seen_contact:RECORDDATE(LAST):0,0


// Fields DERIVED by the linking team are not considered for matching, and will receive their "new" value (i.e. ingest file)
//FIELD:iscontact:DERIVED:0,0
FIELD:isContact:LIKE(fld_contact):DERIVED:0,0
FIELD:iscorp:DERIVED:0,0
FIELD:cnp_hasnumber:DERIVED:0,0
FIELD:cnp_name:DERIVED:0,0
FIELD:cnp_number:DERIVED:0,0
FIELD:cnp_btype:DERIVED:0,0
FIELD:cnp_lowv:DERIVED:0,0
FIELD:cnp_translated:DERIVED:0,0
FIELD:cnp_classid:DERIVED:0,0
FIELD:company_aceaid:DERIVED:0,0
FIELD:corp_legal_name:DERIVED:0,0
FIELD:dba_name:DERIVED:0,0
//FIELD:active_duns_number:DERIVED:0,0
FIELD:active_duns_number:like(number09):DERIVED:0,0
FIELD:hist_duns_number:DERIVED:0,0
//FIELD:active_enterprise_number:DERIVED:0,0
FIELD:active_enterprise_number:like(number9):DERIVED:0,0
FIELD:hist_enterprise_number:DERIVED:0,0
//FIELD:ebr_file_number:DERIVED:0,0
FIELD:ebr_file_number:like(number09):DERIVED:0,0
//FIELD:active_domestic_corp_key:DERIVED:0,0
FIELD:active_domestic_corp_key:like(CORPKEY_FMT):DERIVED:0,0
FIELD:hist_domestic_corp_key:DERIVED:0,0
//FIELD:foreign_corp_key:DERIVED:0,0
FIELD:foreign_corp_key:like(CORPKEY_FMT):DERIVED:0,0
FIELD:unk_corp_key:DERIVED:0,0


// For now this is always blank.  Someday it'll be populated.  Once it is, it should become a regular field.
FIELD:source_docid:DERIVED:0,0


// The rest of these come from the data team, a few of which we decided to mark DERIVED anyway
FIELD:title:0,0
//FIELD:fname:0,0
//FIELD:mname:0,0
//FIELD:lname:0,0
//FIELD:name_suffix:0,0
FIELD:fname:like(NAME):0,0
FIELD:mname:like(NAME):0,0
FIELD:lname:like(NAME):0,0
FIELD:name_suffix:like(WORDSTR):0,0
FIELD:name_score:DERIVED:0,0
//FIELD:company_name:0,0
FIELD:company_name:LIKE(multiword):LIKE(Noblanks):0,0
FIELD:company_name_type_raw:0,0
FIELD:company_name_type_derived:DERIVED:0,0
FIELD:company_rawaid:DERIVED:0,0
FIELD:prim_range:0,0
FIELD:predir:0,0
FIELD:prim_name:0,0
FIELD:addr_suffix:DERIVED:0,0
FIELD:postdir:0,0
FIELD:unit_desig:DERIVED:0,0
FIELD:sec_range:0,0
FIELD:p_city_name:DERIVED:0,0
//FIELD:v_city_name:0,0
FIELD:v_city_name:like(CITY):0,0
//FIELD:st:0,0
//FIELD:zip:0,0
//FIELD:zip4:0,0
FIELD:st:LIKE(alpha_st):0,0
FIELD:zip:LIKE(zip5):0,0
FIELD:zip4:like(hasZip4):CONTEXT(zip):0,0  
FIELD:cart:DERIVED:0,0
FIELD:cr_sort_sz:DERIVED:0,0
FIELD:lot:DERIVED:0,0
FIELD:lot_order:DERIVED:0,0
FIELD:dbpc:DERIVED:0,0
FIELD:chk_digit:DERIVED:0,0
FIELD:rec_type:DERIVED:0,0
FIELD:fips_state:DERIVED:0,0
FIELD:fips_county:DERIVED:0,0
FIELD:geo_lat:DERIVED:0,0
FIELD:geo_long:DERIVED:0,0
FIELD:msa:DERIVED:0,0
FIELD:geo_blk:DERIVED:0,0
FIELD:geo_match:DERIVED:0,0
FIELD:err_stat:DERIVED:0,0
FIELD:company_bdid:DERIVED:0,0
FIELD:company_address_type_raw:0,0
//FIELD:company_fein:0,0
FIELD:company_fein:like(number):0,0
FIELD:best_fein_indicator:0,0
//FIELD:company_phone:0,0
FIELD:company_phone:like(number):0,0
FIELD:phone_type:0,0
FIELD:phone_score:0,0
FIELD:company_org_structure_raw:0,0
FIELD:company_incorporation_date:DERIVED:0,0
FIELD:company_sic_code1:0,0
FIELD:company_sic_code2:0,0
FIELD:company_sic_code3:0,0
FIELD:company_sic_code4:0,0
FIELD:company_sic_code5:0,0
FIELD:company_naics_code1:0,0
FIELD:company_naics_code2:0,0
FIELD:company_naics_code3:0,0
FIELD:company_naics_code4:0,0
FIELD:company_naics_code5:0,0
FIELD:company_ticker:0,0
FIELD:company_ticker_exchange:0,0
FIELD:company_foreign_domestic:DERIVED:0,0 // HACK - this DERIVED may be temporary
FIELD:company_url:0,0
//FIELD:company_inc_state:0,0
FIELD:company_inc_state:like(alpha02):0,0
//FIELD:company_charter_number:0,0
FIELD:company_charter_number:like(NAME):0,0
FIELD:company_filing_date:DERIVED:0,0
FIELD:company_status_date:DERIVED:0,0
FIELD:company_foreign_date:DERIVED:0,0
FIELD:event_filing_date:DERIVED:0,0
FIELD:company_name_status_raw:0,0
FIELD:company_status_raw:0,0
FIELD:vl_id:0,0
FIELD:current:DERIVED:0,0
FIELD:contact_did:DERIVED:0,0
FIELD:contact_type_raw:0,0
FIELD:contact_job_title_raw:0,0
//FIELD:contact_ssn:0,0
//Use number or the following
FIELD:contact_ssn:LIKE(SSN_FMT):0,0
FIELD:contact_dob:0,0
FIELD:contact_status_raw:0,0
//FIELD:contact_email:0,0
FIELD:contact_email:like(EMAIL_FMT):0,0
FIELD:contact_email_username:DERIVED:0,0
FIELD:contact_email_domain:DERIVED:0,0
FIELD:contact_phone:0,0
FIELD:from_hdr:0,0
FIELD:company_department:0,0
FIELD:company_address_type_derived:DERIVED:0,0
FIELD:company_org_structure_derived:DERIVED:0,0
FIELD:company_name_status_derived:DERIVED:0,0
FIELD:company_status_derived:DERIVED:0,0
FIELD:contact_type_derived:DERIVED:0,0
FIELD:contact_job_title_derived:DERIVED:0,0
FIELD:contact_status_derived:DERIVED:0,0
