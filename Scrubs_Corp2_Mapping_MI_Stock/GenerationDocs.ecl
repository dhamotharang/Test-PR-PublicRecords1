Generated by SALT V3.0 Gold
File being processed :-
OPTIONS:-gh 
MODULE:Scrubs_Corp2_Mapping_MI_Stock
FILENAME:In_MI
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 3.169299e+264tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields
//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking
//FUZZY can be used to create new types of FUZZY linking
 
//FIELDTYPE DEFINITIONS
FIELDTYPE:invalid_corp_key:ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(4..)
FIELDTYPE:invalid_corp_vendor:ENUM(26)
FIELDTYPE:invalid_state_origin:ENUM(MI)
FIELDTYPE:invalid_mandatory:LENGTHS(1..)
FIELDTYPE:invalid_date:ALLOW(0123456789):CUSTOM(Scrubs.fn_valid_pastDate>0)
FIELDTYPE:invalid_charter_nbr:ALLOW(-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(1..)
FIELDTYPE:invalid_stock_authorized_nbr:ALLOW(0123456789ABDEFGHILMNORSTQUWX )
 
//FIELD DEFINITIONS
FIELD:corp_key:TYPE(STRING30):LIKE(invalid_corp_key):0,0
FIELD:corp_vendor:TYPE(STRING2):LIKE(invalid_corp_vendor):0,0
FIELD:corp_vendor_county:TYPE(STRING3):0,0
FIELD:corp_vendor_subcode:TYPE(STRING5):0,0
FIELD:corp_state_origin:TYPE(STRING2):LIKE(invalid_state_origin):0,0
FIELD:corp_process_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:corp_sos_charter_nbr:TYPE(STRING32):LIKE(invalid_charter_nbr):0,0
FIELD:stock_ticker_symbol:TYPE(STRING5):0,0
FIELD:stock_exchange:TYPE(STRING5):0,0
FIELD:stock_type:TYPE(STRING20):0,0
FIELD:stock_class:TYPE(STRING20):0,0
FIELD:stock_shares_issued:TYPE(STRING15):0,0
FIELD:stock_authorized_nbr:TYPE(STRING50):LIKE(invalid_stock_authorized_nbr):0,0
FIELD:stock_par_value:TYPE(STRING15):0,0
FIELD:stock_nbr_par_shares:TYPE(STRING15):0,0
FIELD:stock_change_ind:TYPE(STRING1):0,0
FIELD:stock_change_date:TYPE(STRING8):LIKE(invalid_date):0,0
FIELD:stock_voting_rights_ind:TYPE(STRING1):0,0
FIELD:stock_convert_ind:TYPE(STRING1):0,0
FIELD:stock_convert_date:TYPE(STRING8):0,0
FIELD:stock_change_in_cap:TYPE(STRING8):0,0
FIELD:stock_tax_capital:TYPE(STRING15):0,0
FIELD:stock_total_capital:TYPE(STRING15):0,0
FIELD:stock_addl_info:TYPE(STRING250):0,0
FIELD:stock_stock_description:TYPE(STRING250):0,0
FIELD:stock_stock_series:TYPE(STRING250):0,0
FIELD:stock_non_par_value_flag:TYPE(STRING1):0,0
FIELD:stock_additional_stock:TYPE(STRING1):0,0
FIELD:stock_shares_proportion_to_ohio_for_foreign_license:TYPE(UNSIGNED8):0,0
FIELD:stock_share_credits:TYPE(UNSIGNED8):0,0
FIELD:stock_authorized_capital:TYPE(UNSIGNED8):0,0
FIELD:stock_stock_paid_in_capital:TYPE(UNSIGNED8):0,0
FIELD:stock_pay_higher_stock_fees:TYPE(STRING1):0,0
FIELD:stock_actual_amt_invested_in_state:TYPE(UNSIGNED8):0,0
FIELD:stock_share_exchange_during_merger:TYPE(STRING1):0,0
FIELD:stock_date_stock_limit_approved:TYPE(STRING8):0,0
FIELD:stock_number_of_shares_paid_for:TYPE(UNSIGNED8):0,0
FIELD:stock_total_value_of_shares_paid_for:TYPE(UNSIGNED8):0,0
FIELD:stock_sharesofbeneficialinterest:TYPE(UNSIGNED8):0,0
FIELD:stock_beneficialsharevalue:TYPE(UNSIGNED8):0,0
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
 
