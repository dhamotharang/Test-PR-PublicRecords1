
import crim_cp_ln;

export layout_cross_additional_information := RECORD
INTEGER 	ADIN_ID;
String600 NARRATIVE_INFORMATION;
string10 	CADE_CADE_ID;
String15	CREATED_BY;
STRING8 	CREATION_DT;
String15 	LAST_UPDATED_BY;
STRING8 	LAST_UPDATE_DT;
String4 	RECORD_SUPPLIER_CD;
string10 	BATCH_NUMBER;
String4   OLD_RECORD_SUPPLIER_CD;
//Standard LN Source Fields
crim_cp_ln.layout_common_LN_source_fields;
END;