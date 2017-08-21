Generated by SALT V3.2.0
Command line options: -gh 
File being processed :-
MODULE:SCRUBS_IDM_QUIZ
FILENAME:IN_QUIZ
//UNCOMMENT UP TO NINES FOR INTERNAL OR EXTERNAL ADL
//IDFIELD:EXISTS:<NAMEOFIDFIELD>
//RIDFIELD:<NAMEOFRIDFIELD>
//RECORDS:<NUMBEROFRECORDSINDATAFILE>
//POPULATION:<EXPECTEDNUMBEROFENTITIESINDATAFILE>
//NINES:<PRECISION REQUIRED 3 = 99.9%, 2 = 99% ETC>
//UNCOMMENT PROCESS IF DOING EXTERNAL ADL
//PROCESS:<PROCESSNAME>
//FIELDTYPE STATEMENTS CAN BE USED TO CLEAN UP (OR CHECK THE CLEANING) OF INDIVIDUAL FIELDS
//FIELDTYPE:invalid_alphanum:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_;,"*):LENGTHS(0..)
FIELDTYPE:invalid_alpha:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0..)
FIELDTYPE:INVALID_UNIQUE_IDENTITY_COUNT:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:INVALID_Auth_Fail:ALLOW(01):LENGTHS(1)
FIELDTYPE:INVALID_AUTH_FAIL_STATUS:ALLOW(01):LENGTHS(1)
FIELDTYPE:invalid_QUIZ_STATUS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0..)
FIELDTYPE:invalid_AUTH_STATUS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0..)
FIELDTYPE:invalid_VERIF_STATUS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):LENGTHS(0..)
FIELDTYPE:INVALID_auth_score:ALLOW(0123456789):LENGTHS(0..)
FIELDTYPE:INVALID_SUB_PRODUCT_NAME:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -,.)
FIELDTYPE:INVALID_ID_DISCOVERY_Link_ID:ALLOW(0123456789):LENGTHS(12)
FIELDTYPE:INVALID_PROID_Link_ID:ALLOW(0123456789):LENGTHS(12)
FIELDTYPE:INVALID_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):SPACES( -,.)
FIELDTYPE:INVALID_SSN:ALLOW(0123456789):LENGTHS(9,4,0)
//BESTTYPE STATEMENTS DECLARE METHODS OF GENERATING THE BEST VALUE FOR A GIVEN CLUSTER; THIS CAN ALSO IMPROVE LINKING
//FUZZY CAN BE USED TO CREATE NEW TYPES OF FUZZY LINKING
FIELD:TRANS_NUM_ID:TYPE(STRING):0,0
FIELD:TRANSACTION_DATE:TYPE(STRING):0,0
FIELD:ACCOUNT:TYPE(STRING):0,0
FIELD:OPER_USERNAME:TYPE(STRING):0,0
FIELD:TRANS_CLIENT_ID:TYPE(STRING):0,0
FIELD:INPUTED_FIRST_NAME:TYPE(STRING):0,0
FIELD:INPUTED_LAST_NAME:TYPE(STRING):0,0
FIELD:INPUTED_SSN:TYPE(STRING):0,0
FIELD:INPUTED_STREET:TYPE(STRING):0,0
FIELD:INPUTED_CITY:TYPE(STRING):0,0
FIELD:INPUTED_STATE:TYPE(STRING):0,0
FIELD:INPUTED_ZIP:TYPE(STRING):0,0
FIELD:INPUTED_DOB:TYPE(STRING):0,0
FIELD:UNIQUE_IDENTITY_COUNT:LIKE(invalid_UNIQUE_IDENTITY_COUNT):TYPE(STRING):0,0
FIELD:IDENTITY_LOCATED:TYPE(STRING):0,0
FIELD:IDENTITY_NOT_LOCATED:TYPE(STRING):0,0
FIELD:SELECTED_FIRST_NAME:TYPE(STRING):0,0
FIELD:SELECTED_LAST_NAME:TYPE(STRING):0,0
FIELD:SELECTED_SSN:LIKE(INVALID_SSN):TYPE(STRING):0,0
FIELD:SELECTED_DOB:TYPE(STRING):0,0
FIELD:SELECTED_STREET:TYPE(STRING):0,0
FIELD:SELECTED_CITY:TYPE(STRING):0,0
FIELD:SELECTED_STATE:TYPE(STRING):0,0
FIELD:SELECTED_ZIP:TYPE(STRING):0,0
FIELD:VERIF_PASS:TYPE(STRING):0,0
FIELD:VERIF_FAIL:TYPE(STRING):0,0
FIELD:VERIF_ERROR:TYPE(STRING):0,0
FIELD:VERIF_NO_DATA_FOUND:TYPE(STRING):0,0
FIELD:NUM_VERIF_CHKS:TYPE(STRING):0,0
FIELD:NUM_VERIF_CHKS_PASS:TYPE(STRING):0,0
FIELD:AUTH_SCORE:LIKE(INVALID_AUTH_SCORE):TYPE(STRING):0,0
FIELD:AUTH_REQU_SCORE:TYPE(STRING):0,0
FIELD:AUTH_PASS:TYPE(STRING):0,0
FIELD:AUTH_FAIL:LIKE(INVALID_AUTH_FAIL):TYPE(STRING):0,0
FIELD:AUTH_OPT_OUT:TYPE(STRING):0,0
FIELD:AUTH_UNABLE_TO_GEN:TYPE(STRING):0,0
FIELD:AUTH_ERROR:TYPE(STRING):0,0
FIELD:AUTH_QUIZ_EXPIRE:TYPE(STRING):0,0
FIELD:CLIENT_REFERENCE_ID:TYPE(STRING):0,0
FIELD:AUTH_RESPONSE_TIME:TYPE(STRING):0,0
FIELD:VERIF_RESPONSE_TIME:TYPE(STRING):0,0
FIELD:NAME:LIKE(INVALID_NAME):TYPE(STRING):0,0
FIELD:IS_VERIFICATION:TYPE(STRING):0,0
FIELD:IS_AUTHENTICATION:TYPE(STRING):0,0
FIELD:ITEM_STATUS:TYPE(STRING):0,0
FIELD:AUTH_STATUS:LIKE(INVALID_AUTH_STATUS):TYPE(STRING):0,0
FIELD:VERIF_STATUS:LIKE(INVALID_VERIF_STATUS):TYPE(STRING):0,0
FIELD:PROID_ALIAS:TYPE(STRING):0,0
FIELD:PROCHECK_ALIAS:TYPE(STRING):0,0
FIELD:ID_DISCOVERY_ALIAS:TYPE(STRING):0,0
FIELD:QUIZ1_STATUS:TYPE(STRING):0,0
FIELD:QUIZ2_STATUS:TYPE(STRING):0,0
FIELD:ALIAS_NAME:TYPE(STRING):0,0
FIELD:PRODUCT_SEQUENCE:TYPE(STRING):0,0
FIELD:QUIZ_STATUS:LIKE(INVALID_QUIZ_STATUS):TYPE(STRING):0,0
FIELD:IS_RESERVED:TYPE(STRING):0,0
FIELD:INPUTED_LINK_ID:TYPE(STRING):0,0
FIELD:SELECTED_LINK_ID:TYPE(STRING):0,0
FIELD:ID_DISCOVERY_LINK_ID:LIKE(INVALID_ID_DISCOVERY_LINK_ID):TYPE(STRING):0,0
FIELD:PROCHECK_LINK_ID:TYPE(STRING):0,0
FIELD:PROID_LINK_ID:LIKE(INVALID_PROID_LINK_ID):TYPE(STRING):0,0
FIELD:INPUTED_PHONE_NUMBER:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_PASS:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_FAIL:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_ERROR:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_NO_DATA_FOUND:TYPE(STRING):0,0
FIELD:ACCOUNT_NUM_VERIF_CHKS:TYPE(STRING):0,0
FIELD:ACCOUNT_NUM_VERIF_CHKS_PASS:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_RESPONSE_TIME:TYPE(STRING):0,0
FIELD:IS_ACCOUNT_VERIFICATION:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_STATUS:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIFICATION_ALIAS:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_LINK_ID:TYPE(STRING):0,0
FIELD:BUSINESS_NAME:TYPE(STRING):0,0
FIELD:FEIN:TYPE(STRING):0,0
FIELD:TAXID:TYPE(STRING):0,0
FIELD:GROUP_NAME:TYPE(STRING):0,0
FIELD:GROUP_SEQUENCE:TYPE(STRING):0,0
FIELD:SUB_PRODUCT_NAME:LIKE(INVALID_SUB_PRODUCT_NAME):TYPE(STRING):0,0
FIELD:SUB_PRODUCT_SEQUENCE:TYPE(STRING):0,0
FIELD:IS_SURVEY:TYPE(STRING):0,0
FIELD:SURVEY_STATUS:TYPE(STRING):0,0
FIELD:SURVEY_QUESTION:TYPE(STRING):0,0
FIELD:QUESTION_SEQUENCE:TYPE(STRING):0,0
FIELD:QUESTION_CHOICE:TYPE(STRING):0,0
FIELD:CHOICE_SEQUENCE:TYPE(STRING):0,0
FIELD:USER_CHOICE:TYPE(STRING):0,0
FIELD:ACTUAL_PROID_ALIAS:TYPE(STRING):0,0
FIELD:ACTUAL_PROCHECK_ALIAS:TYPE(STRING):0,0
FIELD:ACTUAL_ID_DISCOVERY_ALIAS:TYPE(STRING):0,0
FIELD:REAL_PROID_ALIAS:TYPE(STRING):0,0
FIELD:REAL_PROCHECK_ALIAS:TYPE(STRING):0,0
FIELD:REAL_ID_DISCOVERY_ALIAS:TYPE(STRING):0,0
FIELD:IS_CUSTOM:TYPE(STRING):0,0
FIELD:SOURCE_IP:TYPE(STRING):0,0
FIELD:IDENTITY_LOCATED_STATUS:TYPE(STRING):0,0
FIELD:IDENTITY_NOT_LOCATED_STATUS:TYPE(STRING):0,0
FIELD:VERIF_ERROR_STATUS:TYPE(STRING):0,0
FIELD:VERIF_NO_DATA_FOUND_STATUS:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_ERROR_STATUS:TYPE(STRING):0,0
FIELD:ACCOUNT_VERIF_NO_DATA_FOUND_STATUS:TYPE(STRING):0,0
FIELD:AUTH_FAIL_STATUS:LIKE(INVALID_AUTH_FAIL_STATUS):TYPE(STRING):0,0
FIELD:AUTH_STATUS_CODE:TYPE(STRING):0,0
FIELD:QUIZ_STATUS_CODE:TYPE(STRING):0,0
FIELD:CONVERSATION_ID:TYPE(STRING):0,0
FIELD:CUST_USERNAME:TYPE(STRING):0,0
//CONCEPT STATEMENTS SHOULD BE USED TO GROUP TOGETHER INTERELLATED FIELDS; SUCH AS ADDRESS
//RELATIONSHIP IS USED TO FIND NON-OBVIOUS RELATIONSHIPS BETWEEN THE CLUSTERS
//SOURCEFIELD IS USED IF A FIELD OF THE FILE DENOTES A SOURCE OF THE RECORDS IN THAT FILE
//LINKPATH IS USED TO DEFINE ACCESS PATHS FOR EXTERNAL LINKING
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
