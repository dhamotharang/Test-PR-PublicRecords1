import crim_cp_ln;

/*2012-04-24T16:29:06Z (Judy Tao_prod)

*/
export layout_cross_criminal_sentences := RECORD
//string10 	CRSE_ID;
integer CRSE_ID;
string10 	SENTENCE_AMT_C;// CRITICAL FIELD
String2000 SENTENCE_COMMENT_C;// CRITICAL FIELD
string10 	CRCH_CRCH_ID;
String2 	SETY_SENTENCE_TYPE_CD_C;// CRITICAL FIELD
String15 	CREATED_BY;
STRING8 	CREATION_DT;
String15 	LAST_UPDATED_BY;
STRING8 	LAST_UPDATE_DT;
String4 	RECORD_SUPPLIER_CD;
string10 	BATCH_NUMBER;
String4 	OLD_RECORD_SUPPLIER_CD;
//Standard LN Source Fields
crim_cp_ln.layout_common_LN_source_fields;
END;