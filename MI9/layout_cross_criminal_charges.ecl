
import crim_cp_ln;

/*2009-06-04T17:12:46Z (bob_p vanheusen)

*/
export layout_cross_criminal_charges := RECORD
string10 		CRCH_ID_C;// Critical Field
String30 		ORIGINAL_CHARGE_C_A_X;
string10 		ORIGINAL_CHARGE_NUMBER_OCCUR;
String200 	ORIGINAL_CHARGE_F;// Future Use Field
String15 		ORIGINAL_CHARGE_SHORT;
String30 		ORIGINAL_CODE_SECTION;
String2 		ORIGINAL_CASE_TYPE_C;// Critical Field
String1 		ORIGINAL_CHARGE_QUALIFIER_FLG;
String1 		ORIGINAL_CHARGE_CLASS_FLG_F;// Future Use Field
String30 		AMENDED_CHARGE_C_A_X;
string10 		AMENDED_CHARGE_NUMBER_OCCUR;
String1000 	AMENDED_CHARGE_C;// Critical Field
String15 		AMENDED_CHARGE_SHORT;
String30 		AMENDED_CODE_SECTION;
String2 		AMENDED_CASE_TYPE;
String1 		AMENDED_CHARGE_QUALIFIER_FLG;
String1 		AMENDED_CHARGE_CLASS_FLG;
String1 		CHARGE_DELETION_FLG;
String100	 	DISPOSITION;
STRING8 		DISPOSITION_DT;
String2100 	DISPOSITION_MSG;
String50 		COUNT_TYPE;
string10 		CHARGE_COUNT;
STRING8 		APPEAL_DT_F;// Future Use Field
STRING8 		OFFENSE_DT_C;// Critical Field
String35 		OFFENSE_TOWN_C;// Critical Field
String50 		OFFENSE_DESCRIPTION_C;// Critical Field
string10 		OFFENSE_LEVEL_NUM;
String2 		ORIG_PLEA_CD;
STRING8 		ORIG_PLEA_DT;
STRING8 		PLEA_WITHDRAWN_DT;
String2 		NEW_PLEA_CD;
String45 		CONCLUDED_BY_CD;
String25 		DRIVERS_LICENSE_NUMBER_F;// Future Use Field
String2 		DRIVERS_LICENSE_STATE_CD_F;// Future Use Field
String50 		CAMA_CASE_NUM;
string50 		CAMA_SOURCE_UID;
String10 		CAMA_CASE_SUBJECT_SEQ;
String15 		CREATED_BY;
STRING8 		CREATION_DT;
String15 		LAST_UPDATED_BY;
STRING8 		LAST_UPDATE_DT;
String4 		RECORD_SUPPLIER_CD_C;// Critical Field
string10 		BATCH_NUMBER;
STRING8 		ARREST_DISPOSITION_DT_F;// Future Use Field
String100 	ARREST_DISPOSITION_MSG_F;// Future Use Field
String30 		COURT_LOCATION_C;// Critical Field
String20 		CAUSE_NUMBER_C;// Critical Field
String100		COURT_PROVISION_C;// Critical Field
String40 		DISPOSITION_DURING_APPEAL;
String25		FINAL_DECISION_ON_APPEAL;
STRING8 		SENTENCE_STATUS_CHG_DT_C;// Critical Field
String29 		AGENCY_RECEIVING_CUSTODY;
String30 		PROSECUTOR_LOCATION;
String30 		PROSECUTOR_CASE_REFFER_TO;
STRING8 		CHARGE_REJECTED_DT;
String100 	PROSECUTOR_ACTION;
String100 	PROSECUTOR_OFFENSE;
String2 		PROSECUTION_CASE_TYPE;
String30 		PROSECUTE_GENERAL_OFFENSE_CHAR;
String100 	OTHER_CONVICTION_OFFENSE;
String100 	PRIM_INDICTMENT_OFFENSE;
String20 		PRIM_INDICTMENT_CLASS;
String50 		ARRAIGNED_OFFENSE;
String2 		ARRAIGNED_CASE_TYPE_C;// Critical Field
String20 		ARRAIGNED_CODE_SECTION_C;// Critical Field
STRING8 		CALLED_AND_FAILED_DT;
STRING8 		FAILURE_TO_APPEAR_DT;
String2 		METHOD_OF_DISPOSITION_CD;
STRING8 		NON_MV_FAIL_TO_COMPLY_DT;
STRING8 		MV_FAILURE_TO_COMPLY_DT;
STRING8 		SHOW_CAUSE_ORDER_DT;
String15 		OFFENDER_TYPE;
String4 		OLD_RECORD_SUPPLIER_CD;
STRING8 		CHARGE_FILE_DT;
String20 		PROSECUTOR_CODE_SECTION;
STRING8 		CAPIAS_DT;
STRING8 		REARREST_DT;
STRING8 		BOND_HEARING_DT;
STRING8 		PROS_DECISION_DT;
STRING8 		CHARGE_REOPEN_DT;
STRING8 		CHG_REOPEN_CLOSE_DT;
String15 		PRIM_INDICTMENT_NUMBER;
String100 	REOPEN_REASON;
STRING8 		CHECKED_DT_C;// Critical Field
STRING8 		CLOSEOUT_DT_C;// Critical Field
String15 		REFERENCE_INFO;
STRING8 		CUSTODY_DT_C;// Critical Field
STRING8 		ADMIT_DT_C;// Critical Field
STRING8 		RELEASE_DT_C;// Critical Field
STRING8 		CONVICT_DT_C;// Critical Field
String20 		NC_OFFENSE_DT;
String20 		NC_DISPOSITION_DT;
String1000 	CHARGE_INFO;
String1000 	CUSTODY_INFO;
String40 		OFFENSE_STATUS;
//Standard LN Source Fields
crim_cp_ln.layout_common_LN_source_fields;
END;