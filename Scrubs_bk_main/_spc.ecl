MODULE:Scrubs_bk_main
FILENAME:bk_main
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:
//RIDFIELD:
//RECORDS:
//POPULATION:
//NINES:
//Uncomment Process if doing external adl
//PROCESS:

SOURCEFIELD:source

FIELDTYPE:invalid_alpha:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_alnum:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#'):SPACES( <>{}[]):LENGTHS(0..)
FIELDTYPE:invalid_name:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( -,&\/.:;_+):LENGTHS(0..)
FIELDTYPE:invalid_numeric:ALLOW(0123456789):SPACES( -):LENGTHS(0..)
FIELDTYPE:invalid_address:ALLOW(abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'):SPACES( -&/\#.;,):LENGTHS(0..)
FIELDTYPE:invalid_dir:ENUM(N|NW|NE|S|SE|SW|E|W| )
FIELDTYPE:invalid_state:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_date:ALLOW(0123456789):SPACES( ):LENGTHS(8,0)
FIELDTYPE:invalid_ssn:ALLOW(0123456789):LENGTHS(9,0)
FIELDTYPE:invalid_source:ENUM(L|H|S)
FIELDTYPE:invalid_blank:LENGTHS(1..)

FIELD:process_date:0,0
FIELD:tmsid:0,0
FIELD:source:0,0
FIELD:id:0,0
FIELD:seq_number:0,0
FIELD:date_created:LIKE(invalid_date):0,0
FIELD:date_modified:0,0
FIELD:method_dismiss:0,0
FIELD:case_status:0,0
FIELD:court_code:0,0
FIELD:court_name:0,0
FIELD:court_location:0,0
FIELD:case_number:LIKE(invalid_alnum):0,0
FIELD:orig_case_number:LIKE(invalid_alnum):0,0
FIELD:date_filed:LIKE(invalid_date):0,0
FIELD:filing_status:0,0
FIELD:orig_chapter:0,0
FIELD:orig_filing_date:LIKE(invalid_date):0,0
FIELD:assets_no_asset_indicator:0,0
FIELD:filer_type:0,0
FIELD:meeting_date:0,0
FIELD:meeting_time:0,0
FIELD:address_341:0,0
FIELD:claims_deadline:0,0
FIELD:complaint_deadline:0,0
FIELD:judge_name:0,0
FIELD:judges_identification:0,0
FIELD:filing_jurisdiction:0,0
FIELD:assets:0,0
FIELD:liabilities:0,0
FIELD:casetype:0,0
FIELD:assoccode:0,0
FIELD:splitcase:0,0
FIELD:filedinerror:0,0
FIELD:date_last_seen:0,0
FIELD:date_first_seen:0,0
FIELD:date_vendor_first_reported:0,0
FIELD:date_vendor_last_reported:0,0
FIELD:reopen_date:LIKE(invalid_date):0,0
FIELD:case_closing_date:LIKE(invalid_date):0,0
FIELD:datereclosed:0,0
FIELD:trusteename:0,0
FIELD:trusteeaddress:0,0
FIELD:trusteecity:0,0
FIELD:trusteestate:0,0
FIELD:trusteezip:0,0
FIELD:trusteezip4:0,0
FIELD:trusteephone:0,0
FIELD:trusteeid:0,0
FIELD:caseid:0,0
FIELD:bardate:0,0
FIELD:transferin:0,0
FIELD:trusteeemail:0,0
FIELD:planconfdate:0,0
FIELD:confheardate:0,0
FIELD:title:0,0
FIELD:fname:LIKE(invalid_name):0,0
FIELD:mname:LIKE(invalid_name):0,0
FIELD:lname:LIKE(invalid_name):0,0
FIELD:name_suffix:0,0
FIELD:name_score:0,0
FIELD:prim_range:0,0
FIELD:predir:0,0
FIELD:prim_name:0,0
FIELD:addr_suffix:0,0
FIELD:postdir:0,0
FIELD:unit_desig:0,0
FIELD:sec_range:0,0
FIELD:p_city_name:0,0
FIELD:v_city_name:0,0
FIELD:st:0,0
FIELD:zip:0,0
FIELD:zip4:0,0
FIELD:cart:0,0
FIELD:cr_sort_sz:0,0
FIELD:lot:0,0
FIELD:lot_order:0,0
FIELD:dbpc:0,0
FIELD:chk_digit:0,0
FIELD:rec_type:0,0
FIELD:county:0,0
FIELD:geo_lat:0,0
FIELD:geo_long:0,0
FIELD:msa:0,0
FIELD:geo_blk:0,0
FIELD:geo_match:0,0
FIELD:err_stat:0,0
FIELD:did:0,0
FIELD:app_ssn:0,0
FIELD:delete_flag:0,0
FIELD:unique_id:0,0
