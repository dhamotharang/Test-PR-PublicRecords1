
MODULE:Scrubs_LiensV2
FILENAME:LiensV2
NAMESCOPE:Party

SOURCEFIELD:source_file

FIELDTYPE:number:LIKE():ALLOW(0123456789):NOQUOTES("'):
FIELDTYPE:alpha:LIKE():ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefqhijklmnopqrstuvwxyz):NOQUOTES("'):SPACES( -,.):
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( <>{}[]-^=!+&,.;/#()_"'):
FIELDTYPE:invalid_only_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( -,.)
FIELDTYPE:invalid_zip:LIKE(NUMBER):SPACES(-):LENGTHS(0,5,9,10)
FIELDTYPE:invalid_date:LIKE(NUMBER):LENGTHS(0,4,6,8)
FIELDTYPE:invalid_phone:LIKE(NUMBER):LENGTHS(0,7,10)
//FIELDTYPE:invalid_number:LIKE(NUMBER)			  
FIELDTYPE:invalid_ssn:ALLOW(0123456789Xx):SPACES(*)
FIELDTYPE:invalid_name_suffix:ENUM(JR|SR|I|II|III|IV|V|VI|VII|VIII|IX|X|XI|XII|XIII|XVII| )
FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'):SPACES( -,.&()):LENGTHS(0,3..)
FIELD:tmsid:0,0
FIELD:rmsid:0,0
FIELD:orig_rmsid:0,0
FIELD:orig_full_debtorname:LIKE(invalid_alpha):0,0
FIELD:orig_name:LIKE(invalid_alpha):0,0
FIELD:orig_lname:LIKE(invalid_name):0,0
FIELD:orig_fname:0,0
FIELD:orig_mname:0,0
FIELD:orig_suffix:LIKE(invalid_name_suffix):0,0
FIELD:tax_id:LIKE(invalid_ssn):0,0
FIELD:ssn:LIKE(invalid_ssn):0,0
FIELD:title:0,0
FIELD:fname:0,0
FIELD:mname:0,0
FIELD:lname:0,0
FIELD:name_suffix:LIKE(invalid_name_suffix):0,0
FIELD:name_score:0,0
FIELD:cname:0,0
FIELD:orig_address1:LIKE(invalid_alpha):0,0
FIELD:orig_address2:LIKE(invalid_alpha):0,0
FIELD:orig_city:LIKE(invalid_only_alpha):0,0
FIELD:orig_state:LIKE(invalid_only_alpha):0,0
FIELD:orig_zip5:LIKE(invalid_zip):0,0
FIELD:orig_zip4:0,0
FIELD:orig_county:LIKE(invalid_only_alpha):0,0
FIELD:orig_country:LIKE(invalid_only_alpha):0,0
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
FIELD:phone:0,0
FIELD:name_type:0,0
FIELD:did:0,0
FIELD:bdid:0,0
FIELD:date_first_seen:LIKE(invalid_date):0,0
FIELD:date_last_seen:LIKE(invalid_date):0,0
FIELD:date_vendor_first_reported:LIKE(invalid_date):0,0
FIELD:date_vendor_last_reported:LIKE(invalid_date):0,0
FIELD:persistent_record_id:0,0
FIELD:source_file:0,0
