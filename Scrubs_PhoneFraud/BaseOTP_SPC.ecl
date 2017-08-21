MODULE:Scrubs_PhoneFraud
FILENAME:PhoneFraud
NAMESCOPE:BaseOTP

FIELDTYPE:Invalid_Trans_ID:ALLOW(0123456789R):LENGTHS(1..):ONFAIL(REJECT)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Num:ALLOW(0123456789- Speakout)
FIELDTYPE:Invalid_Phone:ALLOW(0123456789):LENGTHS(0,10)
FIELDTYPE:Invalid_Function:ENUM(MFAVerifyOTP|MFAUpdVerifySubj|MFAUpdateSubject|MFAUpdVfySubj_GB|MFAUpdVfySubj_FR|MFAUpdVfySubj_JP|MFAUpdVfySubj_HK|MFAUpdVfySubj_MX|MFAUpdVfySubj_ES|MFAUpdVfySubj_AU|MFAUpdVfySubj_PR|MFAUpdVfySubj_TH|MFAUpdVfySubj_CN|MFAUpdVfySubj_DE|MFAUpdVfySubj_MY|MFAUpdVfySubj_CA|MFAUpdVfySubj_IT|MFAUpdVfySubj_IE|MFAUpdVfySubj_TW|MFAUpdVfySubj_CH|MFAUpdVfySubj_VN|MFAUpdVfySubj_BE|MFAUpdVfySubj_PH|MFAUpdVfySubj_NL|MFAUpdVfySubj_KR|MFAUpdVfySubj_ID|MFAUpdVfySubj_ZA|MFAUpdVfySubj_IN|UpdVerifySubj|)
FIELDTYPE:Non_Blank:LENGTHS(1..)
FIELDTYPE:Invalid_Delivery:ENUM(T|2|M|E|3|N|6|H|W|5|4|F|)
FIELDTYPE:Invalid_OTP_Length:ALLOW(-0123456789)
FIELDTYPE:Invalid_OTP_Type:ALLOW(NMA6 )
FIELDTYPE:Invalid_OTP_Language:ENUM(EN|ES|FR|ZH|RU|)
FIELDTYPE:Invalid_Country:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ )

FIELD:date_file_loaded:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:transaction_id:LIKE(Invalid_Trans_ID):TYPE(STRING20):0,0
FIELD:event_date:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:event_time:LIKE(Invalid_Num):TYPE(STRING6):0,0
FIELD:function_name:LIKE(Invalid_Function):TYPE(STRING30):0,0
FIELD:account_id:LIKE(Invalid_Num):TYPE(STRING30):0,0
FIELD:subject_id:LIKE(Invalid_Num):TYPE(STRING30):0,0
FIELD:customer_subject_id:LIKE(Non_Blank):TYPE(STRING30):0,0
FIELD:otp_id:LIKE(Invalid_Num):TYPE(STRING20):0,0
FIELD:verify_passed:LIKE(Non_Blank):TYPE(BOOLEAN1):0,0
FIELD:otp_delivery_method:LIKE(Invalid_Delivery):TYPE(STRING2):0,0
FIELD:otp_preferred_delivery:LIKE(Invalid_Delivery):TYPE(STRING2):0,0
FIELD:otp_phone:LIKE(Invalid_Num):TYPE(STRING20):0,0
FIELD:otp_email:TYPE(STRING128):0,0
FIELD:reference_code:TYPE(STRING60):0,0
FIELD:product_id:TYPE(INTEGER5):0,0
FIELD:sub_product_id:TYPE(INTEGER5):0,0
FIELD:subject_unique_id:TYPE(STRING30):0,0
FIELD:first_name:TYPE(STRING50):0,0
FIELD:last_name:TYPE(STRING50):0,0
FIELD:country:TYPE(STRING30):0,0
FIELD:state:TYPE(STRING30):0,0
FIELD:otp_type:LIKE(Invalid_OTP_Type):TYPE(STRING2):0,0
FIELD:otp_length:LIKE(Invalid_OTP_Length):TYPE(INTEGER1):0,0
FIELD:mobile_phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0
FIELD:mobile_phone_country:LIKE(Invalid_Country):TYPE(STRING2):0,0
FIELD:mobile_phone_carrier:LIKE(Invalid_Num):TYPE(STRING20):0,0
FIELD:work_phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0
FIELD:work_phone_country:LIKE(Invalid_Country):TYPE(STRING2):0,0
FIELD:home_phone:LIKE(Invalid_Phone):TYPE(STRING10):0,0
FIELD:home_phone_country:LIKE(Invalid_Country):TYPE(STRING2):0,0
FIELD:otp_language:LIKE(Invalid_OTP_Language):TYPE(STRING2):0,0
FIELD:date_added:TYPE(STRING8):0,0
FIELD:time_added:TYPE(STRING6):0,0
//CONCEPT statements should be used to group together interellated fields; such as address
//RELATIONSHIP is used to find non-obvious relationships between the clusters
//SOURCEFIELD is used if a field of the file denotes a source of the records in that file
//LINKPATH is used to define access paths for external linking
