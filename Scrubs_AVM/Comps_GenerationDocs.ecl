﻿Generated by SALT V3.8.0
Command line options: -MScrubs_AVM -eC:\Users\dittda01\AppData\Local\Temp\TFR9206.tmp 
File being processed :-
OPTIONS:-gh
MODULE:Scrubs_AVM
FILENAME:AVM
NAMESCOPE:Comps
 
FIELDTYPE:Invalid_Date:CUSTOM(Scrubs.fn_valid_date>0)
FIELDTYPE:Invalid_AlphaNum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789)
FIELDTYPE:Invalid_Chars:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .+)
FIELDTYPE:Invalid_Alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz)
FIELDTYPE:Invalid_Num:ALLOW(0123456789)
FIELDTYPE:Invalid_Comps:ALLOW(0123456789OAD)
FIELDTYPE:Invalid_SalesPriceCode:ENUM(A|Q|U|F|Z|D|C|P|X|)
FIELDTYPE:Invalid_LandUseCode:ENUM(1|2|)
 
FIELD:seq:LIKE(Invalid_Num):TYPE(UNSIGNED8):0,0
FIELD:ln_fares_id:LIKE(Invalid_Comps):TYPE(STRING12):0,0
FIELD:unformatted_apn:LIKE(Invalid_AlphaNum):TYPE(STRING45):0,0
FIELD:prim_range:TYPE(STRING10):0,0
FIELD:predir:TYPE(STRING2):0,0
FIELD:prim_name:TYPE(STRING28):0,0
FIELD:suffix:TYPE(STRING4):0,0
FIELD:postdir:TYPE(STRING2):0,0
FIELD:unit_desig:TYPE(STRING10):0,0
FIELD:sec_range:TYPE(STRING8):0,0
FIELD:p_city_name:TYPE(STRING25):0,0
FIELD:st:LIKE(Invalid_Alpha):TYPE(STRING2):0,0
FIELD:zip:LIKE(Invalid_Num):TYPE(STRING5):0,0
FIELD:zip4:LIKE(Invalid_Num):TYPE(STRING4):0,0
FIELD:lat:TYPE(STRING10):0,0
FIELD:long:TYPE(STRING11):0,0
FIELD:geo_blk:TYPE(STRING7):0,0
FIELD:fips_code:LIKE(Invalid_Num):TYPE(STRING5):0,0
FIELD:land_use_code:LIKE(Invalid_LandUseCode):TYPE(STRING4):0,0
FIELD:sales_price:LIKE(Invalid_Num):TYPE(STRING11):0,0
FIELD:sales_price_code:LIKE(Invalid_SalesPriceCode):TYPE(STRING1):0,0
FIELD:recording_date:LIKE(Invalid_Date):TYPE(STRING8):0,0
FIELD:assessed_value_year:LIKE(Invalid_Num):TYPE(STRING4):0,0
FIELD:assessed_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0
FIELD:market_total_value:LIKE(Invalid_Num):TYPE(STRING11):0,0
FIELD:lot_size:LIKE(Invalid_Chars):TYPE(STRING30):0,0
FIELD:building_area:LIKE(Invalid_Num):TYPE(STRING9):0,0
FIELD:year_built:LIKE(Invalid_Num):TYPE(STRING4):0,0
FIELD:no_of_stories:LIKE(Invalid_Chars):TYPE(STRING5):0,0
FIELD:no_of_rooms:LIKE(Invalid_Num):TYPE(STRING5):0,0
FIELD:no_of_bedrooms:LIKE(Invalid_Num):TYPE(STRING5):0,0
FIELD:no_of_baths:LIKE(Invalid_Num):TYPE(STRING7):0,0
 
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
 
