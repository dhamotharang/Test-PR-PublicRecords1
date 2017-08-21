/*2009-06-04T17:13:47Z (bob_p vanheusen)

*/
export layout_cross_case_detail := RECORD
string10 	CADE_ID;
STRING8 	CASE_DT_C;// Critical Field
String1 	CASE_SUFFIX_FLG;
String2 	CASE_CATEGORY_CD_C;// Critical Field
String4 	CASE_YEAR;
String20 	DOCKET_SEQ_F;     // Future USE Field
String100 ORIG_SOURCE_DIVISION_NAME;
String100 DOCUMENT_NUMBER_F;// Future USE Field
String1 	SUBJECT_STATUS_FLG;
String25 	SUBJECT_ID;   // ID Field
String30 	SUBJECT_TYPE;
String9 	SUBJECT_SSN_C;// Critical Field
STRING8 	SUBJECT_DOB_C;// Critical Field
String1 	SUBJECT_SEX_CD_C;// Critical Field
String1 	SUBJECT_RACE_CD_C;// Critical Field
String70 	SUBJECT_ADDRESS_LINE_1_C;// Critical Field
String40 	SUBJECT_ADDRESS_LINE_2_C;// Critical Field
String30 	SUBJECT_CITY_NAME_C;// Critical Field
String2 	SUBJECT_STATE_CD_C;// Critical Field
String5 	SUBJECT_ZIP_CD_C;// Critical Field
String4 	SUBJECT_ZIP_4;
String30 	CASE_DISPOSITION_MESSAGE;
string10 	CRSU_CRSU_ID; // ID Fields
STRING8 	SENTENCE_DISPOSITION_MOD_DT_F;// Future Field
STRING8 	CASE_DISPOSITION_DT_C;// Critical Field
String15 	CREATED_BY;
STRING8 	CREATION_DT;
String15 	LAST_UPDATED_BY;
STRING8 	LAST_UPDATE_DT;
String4 	RECORD_SUPPLIER_CD;
string10 	BATCH_NUMBER;
String7 	SUBJECT_HEIGHT_C;// Critical Field
String7 	SUBJECT_WEIGHT_C;// Critical Field
String15 	SUBJECT_EYE_C;// Critical Field
String15 	SUBJECT_HAIR_C;// Critical Field
// -- Important
STRING8 	SENTENCE_EXPIRATION_DT_C;// *** Note THIS IS INDICATED AS FIELD OF TABLE CRIMINAL CHARGES
         // IN the Required Fields Table 
String10 	FINGER_PRINT;
String4 	OLD_RECORD_SUPPLIER_CD;
String15 	SUBJECT_SKIN;
String15 	SUBJECT_PHONE;
String15 	SUBJECT_AGE_C;// Critical Field -- Ask CP to calc
String100 PERSONAL_INFO;
String1000 OTH_PERSONAL_INFO;
String20 	NC_CASE_DT;
String20 	NC_SUBJECT_DOB;
String100 SCAR_TATTOO;
String20 	ETHNICITY;
String20 	CASE_BUILD;
//Standard LN Source Fields
layout_common_LN_source_fields;
END;