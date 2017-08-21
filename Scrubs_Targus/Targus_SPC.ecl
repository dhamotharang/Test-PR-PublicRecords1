MODULE:Scrubs_Targus
FILENAME:Targus

//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking

FIELDTYPE:invalid_record_id:ALLOW(0123456789):LENGTHS(7..12)
FIELDTYPE:invalid_pubdate:ALLOW(0123456789):LENGTHS(6,0)
FIELDTYPE:invalid_yppa_code:ALLOW(0123456789):LENGTHS(6)
FIELDTYPE:invalid_book_code:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):LENGTHS(3,0)
FIELDTYPE:invalid_page_number:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_record_number:ALLOW(0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_phone_number:ALLOW(0123456789X):LENGTHS(10)
FIELDTYPE:invalid_phone_type:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1,0)
FIELDTYPE:invalid_record_type:ENUM(R|O|P|S)
FIELDTYPE:invalid_no_solicitation_code:ENUM(T|N|*|)
FIELDTYPE:invalid_raw_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¢Ã©Ã¶Ã¸abcdefghijklmnopqrstuvwxyz0123456789):SPACES( /\@Â¸:+$?_;,=![]-'`"()&.*#)
FIELDTYPE:invalid_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ…Ã‰Ã‘ÃšÃœÃÃ¶Ã©):SPACES( -0123456789?)
FIELDTYPE:invalid_job_title:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( /\-$")
FIELDTYPE:invalid_house_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( /\-.)
FIELDTYPE:invalid_street_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( /\.-&#)
FIELDTYPE:invalid_street_type:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( /\.-&#)
FIELDTYPE:invalid_apt_type:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz):SPACES( #)
FIELDTYPE:invalid_apt_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( /\-.)
FIELDTYPE:invalid_box_number:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( /\()-&)
FIELDTYPE:invalid_delivery_point_code:ALLOW(0123456789):LENGTHS(3,0)
FIELDTYPE:invalid_carrier_route:ALLOW(BCGHR0123456789):LENGTHS(4,0)
FIELDTYPE:invalid_gnrl_address_return_code:LENGTHS(0)
FIELDTYPE:invalid_address_flag:ALLOW(DN):LENGTHS(1)
FIELDTYPE:invalid_validation_flag:ALLOW(C):SPACES( ):LENGTHS(1,0)
FIELDTYPE:invalid_postal_city_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( /\()*-.')
FIELDTYPE:invalid_county_code_:ALLOW(0123456789):LENGTHS(5,0)
FIELDTYPE:invalid_rec_type:ALLOW(12):LENGTHS(1)
FIELDTYPE:invalid_prim_range:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( ./\Â½-)
FIELDTYPE:invalid_predir:ALLOW(NSEW):LENGTHS(0..2)
FIELDTYPE:invalid_prim_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Ã‘):SPACES( -/\'.&)
FIELDTYPE:invalid_suffix:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_postdir:ALLOW(NSEW):LENGTHS(0..2)
FIELDTYPE:invalid_unit_desig:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -.'#)
FIELDTYPE:invalid_sec_range:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( -.'#/&)
FIELDTYPE:invalid_city_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( /\-.')
FIELDTYPE:invalid_st:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(2,0)
FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,0)
FIELDTYPE:invalid_zip4:ALLOW(0123456789):LENGTHS(4,1,0)
FIELDTYPE:invalid_county:ALLOW(0123456789):LENGTHS(3,0)
FIELDTYPE:invalid_cbsa:ALLOW(0123456789):LENGTHS(5):SPACES( )
FIELDTYPE:invalid_geo_blk:ALLOW(0123456789):LENGTHS(7,0)
FIELDTYPE:invalid_address:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZÃ‘Ã0123456789):SPACES( ,-.()':;"&#/)
FIELDTYPE:invalid_longdate:ALLOW(0123456789):LENGTHS(8,0)
FIELDTYPE:invalid_shortdate:ALLOW(0123456789):LENGTHS(6,1)
FIELDTYPE:invalid_cleanaddress:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789):SPACES( /\&()#*-.')

FIELD:record_id:LIKE(invalid_record_id):TYPE(STRING12):0,0
FIELD:pubdate:LIKE(invalid_pubdate):TYPE(STRING6):0,0
FIELD:filler:TYPE(STRING2):0,0
FIELD:yppa_code:LIKE(invalid_yppa_code):TYPE(STRING6):0,0
FIELD:book_code:LIKE(invalid_book_code):TYPE(STRING3):0,0
FIELD:page_number:LIKE(invalid_page_number):TYPE(STRING4):0,0
FIELD:record_number:LIKE(invalid_record_number):TYPE(STRING4):0,0
FIELD:phone_number:LIKE(invalid_phone_number):TYPE(STRING10):0,0
FIELD:phone_type:LIKE(invalid_phone_type):TYPE(STRING1):0,0
FIELD:record_type:LIKE(invalid_record_type):TYPE(STRING1):0,0
FIELD:no_solicitation_code:LIKE(invalid_no_solicitation_code):TYPE(STRING1):0,0
FIELD:title:LIKE(invalid_name):TYPE(STRING4):0,0
FIELD:first_name:LIKE(invalid_raw_name):TYPE(STRING20):0,0
FIELD:middle_name:LIKE(invalid_raw_name):TYPE(STRING20):0,0
FIELD:last_name:LIKE(invalid_raw_name):TYPE(STRING30):0,0
FIELD:last_name_suffix:LIKE(invalid_raw_name):TYPE(STRING3):0,0
FIELD:job_title:LIKE(invalid_job_title):TYPE(STRING40):0,0
FIELD:secondary_name_title:LIKE(invalid_raw_name):TYPE(STRING4):0,0
FIELD:secondary_first_name:LIKE(invalid_raw_name):TYPE(STRING20):0,0
FIELD:secondary_middle_name:LIKE(invalid_raw_name):TYPE(STRING20):0,0
FIELD:secondary_name_suffix:LIKE(invalid_raw_name):TYPE(STRING3):0,0
FIELD:house_number:LIKE(invalid_house_number):TYPE(STRING10):0,0
FIELD:pre_direction:LIKE(invalid_predir):TYPE(STRING2):0,0
FIELD:street_name:LIKE(invalid_street_name):TYPE(STRING28):0,0
FIELD:street_type:LIKE(invalid_street_type):TYPE(STRING4):0,0
FIELD:post_direction:LIKE(invalid_predir):TYPE(STRING2):0,0
FIELD:apt_type:LIKE(invalid_apt_type):TYPE(STRING4):0,0
FIELD:apt_number:LIKE(invalid_apt_number):TYPE(STRING8):0,0
FIELD:box_number:LIKE(invalid_box_number):TYPE(STRING10):0,0
FIELD:expanded_pub_city_name:LIKE(invalid_postal_city_name):TYPE(STRING28):0,0
FIELD:postal_city_name:LIKE(invalid_postal_city_name):TYPE(STRING28):0,0
FIELD:state:LIKE(invalid_st):TYPE(STRING2):0,0
FIELD:z5:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:plus4:LIKE(invalid_zip4):TYPE(STRING4):0,0
FIELD:delivery_point_code:LIKE(invalid_delivery_point_code):TYPE(STRING3):0,0
FIELD:carrier_route:LIKE(invalid_carrier_route):TYPE(STRING4):0,0
FIELD:county_code_:LIKE(invalid_county_code_):TYPE(STRING5):0,0
FIELD:gnrl_address_return_code:LIKE(invalid_gnrl_address_return_code):TYPE(STRING1):0,0
FIELD:house_number_usage_flag:LIKE(invalid_address_flag):TYPE(STRING1):0,0
FIELD:pre_direction_usage_flag:LIKE(invalid_address_flag):TYPE(STRING1):0,0
FIELD:street_name_usage_flag:LIKE(invalid_address_flag):TYPE(STRING1):0,0
FIELD:street_type_usage_flag:LIKE(invalid_address_flag):TYPE(STRING1):0,0
FIELD:post_direction_usage_flag:LIKE(invalid_address_flag):TYPE(STRING1):0,0
FIELD:apt_number_usage_flag:LIKE(invalid_address_flag):TYPE(STRING1):0,0
FIELD:validation_date:LIKE(invalid_longdate):TYPE(STRING8):0,0
FIELD:validation_flag:LIKE(invalid_validation_flag):TYPE(STRING1):0,0
FIELD:filler1:TYPE(STRING34):0,0
FIELD:dt_first_seen:LIKE(invalid_shortdate):TYPE(UNSIGNED3):0,0
FIELD:dt_last_seen:LIKE(invalid_shortdate):TYPE(UNSIGNED3):0,0
FIELD:dt_vendor_last_reported:LIKE(invalid_shortdate):TYPE(UNSIGNED3):0,0
FIELD:dt_vendor_first_reported:LIKE(invalid_shortdate):TYPE(UNSIGNED3):0,0
FIELD:rec_type:LIKE(invalid_rec_type):TYPE(STRING1):0,0
FIELD:hhid:TYPE(UNSIGNED6):0,0
FIELD:did:TYPE(UNSIGNED6):0,0
FIELD:did_score:TYPE(UNSIGNED1):0,0
FIELD:fname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:minit:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:lname:LIKE(invalid_name):TYPE(STRING20):0,0
FIELD:name_suffix:LIKE(invalid_name):TYPE(STRING5):0,0
FIELD:prim_range:LIKE(invalid_prim_range):TYPE(STRING10):0,0
FIELD:predir:LIKE(invalid_predir):TYPE(STRING2):0,0
FIELD:prim_name:LIKE(invalid_prim_name):TYPE(STRING28):0,0
FIELD:suffix:LIKE(invalid_suffix):TYPE(STRING4):0,0
FIELD:postdir:LIKE(invalid_postdir):TYPE(STRING2):0,0
FIELD:unit_desig:LIKE(invalid_unit_desig):TYPE(STRING10):0,0
FIELD:sec_range:LIKE(invalid_sec_range):TYPE(STRING8):0,0
FIELD:city_name:LIKE(invalid_city_name):TYPE(STRING25):0,0
FIELD:st:LIKE(invalid_st):TYPE(STRING2):0,0
FIELD:zip:LIKE(invalid_zip):TYPE(STRING5):0,0
FIELD:zip4:LIKE(invalid_zip4):TYPE(STRING4):0,0
FIELD:county:LIKE(invalid_county):TYPE(STRING3):0,0
FIELD:cbsa:LIKE(invalid_cbsa):TYPE(STRING5):0,0
FIELD:geo_blk:LIKE(invalid_geo_blk):TYPE(STRING7):0,0
FIELD:cleanname:LIKE(invalid_raw_name):TYPE(QSTRING55):0,0
FIELD:cleanaddress:LIKE(invalid_cleanaddress):TYPE(QSTRING137):0,0
FIELD:active:TYPE(BOOLEAN1):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
RECORDTYPE:invalid_vendor_dates:CONDITION(dt_vendor_first_reported,<=,dt_vendor_last_reported):VALID(dt_vendor_first_reported,dt_vendor_last_reported)
RECORDTYPE:invalid_seen_dates:CONDITION(dt_first_seen,<=,dt_last_seen):VALID(dt_first_seen,dt_last_seen)
