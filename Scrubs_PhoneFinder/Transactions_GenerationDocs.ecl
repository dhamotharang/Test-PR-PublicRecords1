﻿Generated by SALT V3.11.11
Command line options: -MScrubs_PhoneFinder -eC:\Users\taojx\AppData\Local\Temp\TFR3112.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_PhoneFinder
FILENAME:PhoneFinder
NAMESCOPE:Transactions
 
FIELDTYPE:Invalid_Binary:ALLOW(01\\N)
FIELDTYPE:Invalid_No:ALLOW(0123456789\\N)
FIELDTYPE:Invalid_ID:ALLOW(0123456789R\\N)
FIELDTYPE:Invalid_Code:ALLOW(0123456789\(\). -\\N)
FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\\ )
FIELDTYPE:Invalid_AlphaChar:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\(\\)_[] .,:;#/-&\\'*)
FIELDTYPE:Invalid_Risk:ENUM(PASS|FAIL|WARN|\\N|)
FIELDTYPE:Invalid_Phone_Type:ENUM(POSSIBLE WIRELESS|LANDLINE|POSSIBLE VOIP|OTHER UNKNOWN|PAGER|CABLE|OTHER/UNKNOWN|\\N|)
FIELDTYPE:Invalid_Phone_Status:ENUM(ACTIVE|INACTIVE|NOT AVAILABLE|\\N|)
FIELDTYPE:Invalid_Forward:ENUM(FORWARDED|NOT FORWARDED|\\N|)
FIELDTYPE:Invalid_State:LIKE(Invalid_Alpha):LENGTHS(0,2)
FIELDTYPE:Invalid_Zip:LIKE(Invalid_No):LENGTHS(0,2,5)
FIELDTYPE:Invalid_Phone:LIKE(Invalid_No):LENGTHS(0,2,9,10)
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs_PhoneFinder.Functions.Split_Date > 0)
FIELDTYPE:Invalid_File:CUSTOM(Scrubs_PhoneFinder.Functions.Check_File > 0)
 
FIELD:transaction_id:TYPE(STRING16):LIKE(Invalid_ID):0,0
FIELD:transaction_date:TYPE(STRING20):LIKE(Invalid_Date):0,0
FIELD:user_id:TYPE(STRING60):0,0
FIELD:product_code:TYPE(STRING8):LIKE(Invalid_Alpha):0,0
FIELD:company_id:TYPE(STRING16):LIKE(Invalid_No):0,0
FIELD:source_code:TYPE(STRING8):LIKE(Invalid_Code):0,0
FIELD:batch_job_id:TYPE(STRING20):LIKE(Invalid_Code):0,0
FIELD:batch_acctno:TYPE(INTEGER5):LIKE(Invalid_No):0,0
FIELD:response_time:TYPE(INTEGER5):LIKE(Invalid_No):0,0
FIELD:reference_code:TYPE(STRING60):LIKE(Invalid_AlphaChar):0,0
FIELD:phonefinder_type:TYPE(STRING32):LIKE(Invalid_Alpha):0,0
FIELD:submitted_lexid:TYPE(STRING32):LIKE(Invalid_Code):0,0
FIELD:submitted_phonenumber:TYPE(STRING15):LIKE(Invalid_Code):0,0
FIELD:submitted_firstname:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0
FIELD:submitted_lastname:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0
FIELD:submitted_middlename:TYPE(STRING20):LIKE(Invalid_AlphaChar):0,0
FIELD:submitted_streetaddress1:TYPE(STRING128):0,0
FIELD:submitted_city:TYPE(STRING64):LIKE(Invalid_AlphaChar):0,0
FIELD:submitted_state:TYPE(STRING16):LIKE(Invalid_State):0,0
FIELD:submitted_zip:TYPE(STRING10):LIKE(Invalid_Zip):0,0
FIELD:phonenumber:TYPE(STRING15):LIKE(Invalid_Phone):0,0
FIELD:data_source:TYPE(STRING30):LIKE(Invalid_Binary):0,0
FIELD:royalty_used:TYPE(STRING30):LIKE(Invalid_Alpha):0,0
FIELD:carrier:TYPE(STRING30):LIKE(Invalid_AlphaChar):0,0
FIELD:risk_indicator:TYPE(STRING16):LIKE(Invalid_Risk):0,0
FIELD:phone_type:TYPE(STRING32):LIKE(Invalid_Phone_Type):0,0
FIELD:phone_status:TYPE(STRING32):LIKE(Invalid_Phone_Status):0,0
FIELD:ported_count:TYPE(INTEGER5):LIKE(Invalid_No):0,0
FIELD:last_ported_date:TYPE(STRING20):LIKE(Invalid_Date):0,0
FIELD:otp_count:TYPE(INTEGER5):LIKE(Invalid_No):0,0
FIELD:last_otp_date:TYPE(STRING20):LIKE(Invalid_Date):0,0
FIELD:spoof_count:TYPE(INTEGER5):LIKE(Invalid_No):0,0
FIELD:last_spoof_date:TYPE(STRING20):LIKE(Invalid_Date):0,0
FIELD:phone_forwarded:TYPE(STRING32):LIKE(Invalid_Forward):0,0
FIELD:date_added:TYPE(STRING20):LIKE(Invalid_Date):0,0
FIELD:filename:TYPE(STRING255):LIKE(Invalid_File):0,0
 
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
 
