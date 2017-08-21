MODULE:Scrubs_PhonesInfo
FILENAME:PhonesInfo
NAMESCOPE:BaseFile

FIELDTYPE:Invalid_Phone:ALLOW(0123456789)
FIELDTYPE:Invalid_Source:ENUM(PX|PK|PJ|PO|PB):LENGTHS(1..)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Future_Date:CUSTOM(Scrubs.fn_valid_date>0,'future')
FIELDTYPE:Invalid_Phone_Type:ENUM(LC|CL| )
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Num_Blank:ALLOW(0123456789 \t )
FIELDTYPE:Invalid_Char:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&/_;'"()!+,@|#)
FIELDTYPE:Invalid_State:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz )
FIELDTYPE:Invalid_Dial_Type:ALLOW(TBN )
FIELDTYPE:Invalid_ISO2:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:Invalid_Zero_Three:ALLOW(0123)
FIELDTYPE:Invalid_Deact:ENUM(DE|SU| )
FIELDTYPE:Invalid_Num_In_Service:ALLOW(0123456789AIU)
FIELDTYPE:Invalid_YN:ALLOW(PYN0123456789 )


FIELD:reference_id:TYPE(STRING30):0,0
FIELD:source:LIKE(Invalid_Source):TYPE(STRING5):0,0
FIELD:dt_first_reported:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:dt_last_reported:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0
FIELD:phonetype:LIKE(Invalid_Phone_Type):TYPE(STRING2):0,0
FIELD:reply_code:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:local_routing_number:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:account_owner:LIKE(Invalid_Char):TYPE(STRING6):0,0
FIELD:carrier_name:LIKE(Invalid_Char):TYPE(STRING60):0,0
FIELD:carrier_category:LIKE(Invalid_Char):TYPE(STRING10):0,0
FIELD:local_area_transport_area:LIKE(Invalid_Num):TYPE(STRING5):0,0
FIELD:point_code:TYPE(STRING10):0,0
FIELD:country_code:LIKE(Invalid_Num):TYPE(STRING3):0,0
FIELD:dial_type:LIKE(Invalid_Dial_Type):TYPE(STRING1):0,0
FIELD:routing_code:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:porting_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:porting_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:country_abbr:LIKE(Invalid_ISO2):TYPE(STRING2):0,0
FIELD:vendor_first_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:vendor_first_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:vendor_last_reported_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:vendor_last_reported_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:port_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:port_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:port_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0
FIELD:port_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:remove_port_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0
FIELD:is_ported:TYPE(BOOLEAN1):0,0
FIELD:serv:LIKE(Invalid_Zero_Three):TYPE(STRING1):0,0
FIELD:line:LIKE(Invalid_Zero_Three):TYPE(STRING1):0,0
FIELD:spid:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:operator_fullname:LIKE(Invalid_Char):TYPE(STRING60):0,0
FIELD:number_in_service:LIKE(Invalid_Num_In_Service):TYPE(STRING5):0,0
FIELD:high_risk_indicator:LIKE(Invalid_YN):TYPE(STRING2):0,0
FIELD:prepaid:LIKE(Invalid_YN):TYPE(STRING2):0,0
FIELD:phone_swap:LIKE(Invalid_Num):TYPE(STRING10):0,0
FIELD:swap_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:swap_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:swap_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0
FIELD:swap_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:deact_code:LIKE(Invalid_Deact):TYPE(STRING2):0,0
FIELD:deact_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:deact_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:deact_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0
FIELD:deact_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:react_start_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:react_start_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:react_end_dt:LIKE(Invalid_Future_Date):TYPE(UNSIGNED8):0,0
FIELD:react_end_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:is_deact:LIKE(Invalid_YN):TYPE(STRING2):0,0
FIELD:is_react:Like(Invalid_YN):TYPE(STRING2):0,0
FIELD:call_forward_dt:LIKE(Invalid_Date):TYPE(UNSIGNED8):0,0
FIELD:caller_id:LIKE(Invalid_Char):TYPE(STRING15):0,0
FIELD:subpoena_company_name:LIKE(Invalid_Char):TYPE(STRING60):0,0
FIELD:subpoena_contact_name:LIKE(Invalid_Char):TYPE(STRING60):0,0
FIELD:subpoena_carrier_address:LIKE(Invalid_Char):TYPE(STRING60):0,0
FIELD:subpoena_carrier_city:LIKE(Invalid_Char):TYPE(STRING20):0,0
FIELD:subpoena_carrier_state:LIKE(Invalid_State):TYPE(STRING20):0,0
FIELD:subpoena_carrier_zip:LIKE(Invalid_Num_Blank):TYPE(STRING5):0,0
FIELD:subpoena_email:LIKE(Invalid_Char):TYPE(STRING30):0,0
FIELD:subpoena_contact_phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0
FIELD:subpoena_contact_fax:LIKE(Invalid_Phone):TYPE(STRING10):0,0
