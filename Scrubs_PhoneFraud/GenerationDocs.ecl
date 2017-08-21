Generated by SALT V3.6.1
Command line options: -MScrubs_PhoneFraud -eC:\Users\dittda01\AppData\Local\Temp\TFRB334.tmp 
File being processed :-
OPTIONS:-gh  
MODULE:Scrubs_PhoneFraud
FILENAME:PhoneFraud
NAMESCOPE:BaseOTP
 
FIELDTYPE:Invalid_Trans_ID:ALLOW(0123456789R):LENGTHS(1..):ONFAIL(REJECT)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_Num:ALLOW(0123456789- Speakout)
FIELDTYPE:Invalid_Carrier:WITHIN(Scrubs_PhoneFraud.Lookup_Lists.Carrier_List,entry)
FIELDTYPE:Invalid_Phone:ALLOW(0123456789):LENGTHS(0,10)
FIELDTYPE:Invalid_Function:WITHIN(Scrubs_PhoneFraud.Lookup_Lists.Function_List,entry)
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
FIELD:mobile_phone_carrier:LIKE(Invalid_Carrier):TYPE(STRING20):0,0
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
 
Total available specificity:0
Search Threshold set at -4
Use of PERSISTs in code set at:3
 
__Glossary__
Edit Distance: An edit distance of (say) one implies that one string can be converted into another by doing one of
  - Changing one character
  - Deleting one character
  - Transposing two characters
 
Forcing Criteria: In addition to the general 'best match' logic it is possible to insist that
one particular field must match to some degree or the whole record is considered a bad match.
The criterial applied to that one field is the forcing criteria.
 
Cascade: Best Type rules are applied in such a way that the rules are applied one by one UNTIL the first rule succeeds; subsequent rules are then skipped.
 
__General Notes__
How is it decided how much to subtract for a bad match?
SALT computes for each field the percentage likelihood that a valid cluster will have two or more values for a given field
this value (called the switch value in the SALT literature) is then used to produce the subtraction value from the match value.
The value in this document is the one typed into the SPC file; the code will use a value computed at run-time.
 
