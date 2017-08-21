export Layouts_DL_OH_In := module

//Vendor Update record lenght = 401  - Doc Driver
	export Layout_OH_Update := record
		string9    DBKOLN;
		string9    PINSS4;
		string8    DVNLIC;
		string2    DVCCLS;
		string2    DVCTYP;
		string1    PIFDON;
		string3    PICHCL;
		string3    PICECL;
		string3    PIQWGT;
		string1    PINHFT;
		string2    PINHIN;
		string1    PICSEX;
		string8    DVDDOI;
		string1    DVC2PL;
		string8    DVDEXP;
		string4    DRNAGY;
		string1    DVFOCD;
		string1    DVFOPD; 
		string8    DVNAPP;
		string3    DVCATT;
		string8    DVDNOV; 
		string1    DVCDED;
		string42   DVCGRS;
		string1    DVFDUP;
		string10   DVCGEN;
		string1    DVFLSD;
		string1    DVQDUP;
		string1    DVFOHR; 
		string9    DBKMTK; 
		string1    DVFRCS;
		string2    DVNWBI;
		string4    SYCPGM;
		string16   SYTDA1;
		string6    SYCUID;
		string1    DVFFRD;
		string1    DVCTSA;   //added 6/2014
		string8    DVDTSA;   //added 6/2014
	  string8    DVDTEX;   //added 6/2014
		string1    DVCSCE;   //added 6/2014
		string8    DVDMCE;   //added 6/2014
		string73   FILLER;   //decreased from 99 to 73 - 6/2014
		string35   PIMNAM;
		string30   PIGSTR;
		string15   PIGCTY;
		string2    PIGSTA;
		string11   PIGZIP;
		string2    PINCNT;
		string8    PIDD01;
		string8    PIDDOD;
		string8    PIDAUP;
		string2    CRLF;
    end;

	export Layout_OH_With_ProcessDte := record
		string8 process_date;
		Layout_OH_Update;
	end;
	
  export Layout_OH_Cleaned := record
		Layout_OH_With_ProcessDte;
		string5   title;
		string20  fname;
		string20  mname;
		string20  lname;
		string5   name_suffix;
		string3   cleaning_score;
		string10  prim_range;
		string2   predir;
		string28  prim_name;
		string4   suffix;
		string2   postdir;
		string10  unit_desig;
		string8   sec_range;
		string25  p_city_name;
		string25  v_city_name;
		string2   state;
		string5   zip;
		string4   zip4;
		string4   cart;
		string1   cr_sort_sz;
		string4   lot;
		string1   lot_order;
		string2   dbpc;
		string1   chk_digit;
		string2   rec_type;
		string2   ace_fips_st;
		string3   county;
		string10  geo_lat;
		string11  geo_long;
		string4   msa;
		string7   geo_blk;
		string1   geo_match;
		string4   err_stat;
  end;	
	
	// Layout Conviction Points Raw
	export Layout_OH_CP := record
		string9	  KEY_NUMBER;
		string3	  REC_SEQ_NUM;
		string8	  DRIVER_RECORD_DELETE_DATE;
		string2	  DRIVERS_DETAIL_RECORD_TYPE_CODE;
	    string578 payload;
		string2   crlf;
		
	end;

	export Layout_OH_CP_Pdate := record
		string8 process_date;
		Layout_OH_CP;
	end;
	
	// Layout SUspensions - Doc Withdrawals X
	export Layout_OH_SUSPENSIONS := record
	  string8  process_date;
		string9	 KEY_NUMBER;
		string3	 REC_SEQ_NUM;
		string8	 DRIVER_RECORD_DELETE_DATE;
		string2	 DRIVERS_DETAIL_RECORD_TYPE_CODE;
		string8	 OFFENSE_VIOLATION_DATE;
		string8	 CLEAR_DATE;
		string8	 PROOF_FILING_SHOWN_DATE;
		string8	 RECORD_TYPE_ACTION_DATE;
		string8	 START_DATE_FROM;
		string8	 END_DATE_TO;
		string10 BMV_CASE_NUMBER;
		string16 COURT_CASE_NUMBER;
		string6	 COURT_CODE;
		string3	 DRIVERS_OHIO_OFFENSE_CONVICTION;
		string1	 DRIVERS_COMMERCIAL_VEHICLE_IND;
		string1	 HAZARDOUS_MATERIALS_FLAG;
		string2	 JURISDICTION_CODE;
		string8	 FEE_PAID_DATE;
		string10 DRIVERS_RECEIPT_NUMBER;
		string8	 PLATE_NUMBER;
		string3	 CDL_DISQUALIFICATION_REASON_CODE;
		string3	 CDL_OUT_OF_STATE_DISQUAL_TYPE;
		string1	 DRIVERS_DISQUALIFICATION_EXTEN;
		string8	 DRIVERS_DISQUAL_REASON_REFEREN;
		string18 DRIVERS_REFERENCE_LOCATOR_NUMBER;
		string6	 SCHOOL_DISTRICT_NUMBER;
		string1	 WITHDRAWAL_CLEARANCE_REASON;
		string5	 NAIC_INSURANCE_CODE;
		string1	 INSURANCE_BOND_FILING_INDICATOR;
		string8	 CLEARED_FOR_RESTRICTED_DRIVING;
		string3	 WITHDRAWAL_REASON_CODE;
		string8	 DRIVERS_REMEDIAL_DRIVING_COURSE;
		string8	 DRIVERS_LICENSE_EXAM_DATE;
		string3	 ACD_OFFENSE_CODE;
		string1	 WITHDRAWAL_STATUS_CODE;
		string8	 MODIFIED_DRIVING_DATE;
		string8	 SETTLEMENT_AGREEMENT_DATE;
		string2	 DRIVERS_RESTRICTION_CODE;
		string8	 CONVICTION_DATE;
		string8	 APPEAL_FILED_DATE;
		string8	 APPEAL_DENIED_DATE;
		string8	 APPEAL_GRANTED_DATE;
		string1	 CONVICTION_PLEA_FLAG;
		string1	 DRIVERS_SUSPENSION_REVOCATION;
		string2	 COUNTY_NUMBER;
		string8	 DRIVERS_ARREST_DATE;
		string8	 DRIVERS_LICENSE_NUMBER;
		string9	 MERGED_FROM_KEYNUMBER;
		string8	 DATABASE_RECORD_CREATE_DATE;
		string8	 DRIVERS_LICENSE_RECEIVED_DATE;
		string8	 PLATE_RECEIVED_DATE;
		string8	 FRA_SUSPENSION_START_DATE;
		string8	 FRA_SUSPENSION_END_DATE;
		string8	 DRIVERS_ACCIDENT_DATE;
		string10 RELATED_BMV_CASE_NUMBER_1;
		string1	 NARRATIVE_LITERAL_CODE;
		string1	 FEE_REQUIRED_FLAG;
		string1	 VEHICLE_OWNER_INDICATOR;
		string8	 SOA_CONV_WITHDRAWAL_OFFENSE;
		string8	 RECORD_EXPUNGED_DATE;
		string6	 DRIVERS_BATCH_NUMBER;
		string1	 INQUIRY_REFERRAL_CODE;
		string8	 MODIFIED_DRIVING_END_DATE;
		string1	 APPEAL_SUSPENSION_STAY_FLAG;
		string3	 FEE_RECORD_SEQUENCE_NUM_BMV;
		string3	 FRA_RECORD_SEQUENCE_NUM_BMV;
		string3	 C1_SEQUENCE_NUMBER;
		string3	 WITHDRAWAL_TYPE_DETAIL;
		string1	 HIGHWAY_PATROL_LIC_CANCELLATION;
		string10 BMV_DL_CASE_NUMBER;
		string10 RELATED_BMV_CASE_NUMBER_2;
		string4	 PROGRAM_ID;
		string16 SYSTEM_DATE_TIME_STAMP;
		string6	 USER_IDENTIFICATION_CODE;
		string8	 FIND_PAID_DATE;
		string8	 MAIL_BY_DATE;
		string4	 CHILD_SUPPORT_ENFORCE_AGENCY;
		string10 CHILD_SUPPORT_ENFORCE_CASE_NBR;
		string17 CHILD_SUPPORT_ENFORCE_ORDER_NBR;
		string12 CHILD_SUPP_ENF_PARTICIPANT_NBR;
		string8  SIX_POINT_LETTER_DATE;
		string8  APPEAL_HEARING_DEADLINE_DATE;
		string6  REMEDIAL_DRIVING_SCHOOL_CERTIF;
		string8  COURT_APPEARANCE_EFFECTIVE_DATE;
		string1  SUSPENSION_CLASS_CODE;
		string1  BLOCKING_TYPE_CODE;
		string6  MODIFY_ORDER_BY_CODE;
		string60 FILLER := '';
	end;
	
	// Layout Convictions X
	export Layout_OH_CONVICTIONS := record
	  string8   process_date;
		string9	  KEY_NUMBER;
		string3	  REC_SEQ_NUM;
		string8	  DRIVER_RECORD_DELETE_DATE;
		string2   DRIVERS_DETAIL_RECORD_TYPE_CODE;
		string8	  OFFENSE_VIOLATION_DATE;
		string8	  PLATE_NUMBER;
		string8	  CONVICTION_DATE;
		string6	  COURT_CODE;
		string3	  DRIVERS_OHIO_OFFENSE_CONVICTION;
		string1	  DRIVERS_SENTENCE_CODE;
		string2	  COURT_ASSESSED_POINTS;
		string1	  HAZARDOUS_MATERIALS_FLAG;
		string6	  DRIVERS_BATCH_NUMBER;
		string1	  CONVICTION_PLEA_FLAG;
		string16  COURT_CASE_NUMBER;
		string3	  ACD_OFFENSE_CODE;
		string5	  ACD_CONVICTION_OFFENSE_DETAILS;
		string1	  DRIVERS_COMMERCIAL_VEHICLE_IND;
		string18  DRIVERS_REFERENCE_LOCATOR_NBR;
		string3	  OFFENSE_REDUCED_FROM_CODE;
		string8	  DATABASE_RECORD_CREATE_DATE;
		string9	  MERGED_FROM_KEYNUMBER;
		string10  BMV_S1_CASE_NUMBER;
		string10  BMV_P2_CASE_NUMBER;
		string10  BMV_P3_CASE_NUMBER;
		string10  BMV_DL_CASE_NUMBER;
		string10  BMV_HABITUAL_CASE_NUMBER;
		string8	  PROOF_FILING_SHOWN_DATE;
		string8	  RECORD_EXPUNGED_DATE;
		string2	  JURISDICTION_CODE;
		string8	  SOA_CONVICTION_WITHDRAWL_OFFENSE;
		string4	  COURT_TYPE_CODE;
		string10  BMV_SP_CASE_NUMBER;
		string4	  PROGRAM_ID;
		string16  SYSTEM_DATE_TIME_STAMP;
		string6	  USER_IDENTIFICATION_CODE;
		string25  OUT_OF_STATE_DRIVER_LICENSE_NBR;
		string2	  STATE_OF_ORIGIN;
		string1   SUSPENSION_CLASS_CODE;
		string1   COURT_ORDERED_REMEDIAL_COURSE;
		string326 FILLER := '';
	end;
	
	// Layout Driver Record Information X
	export Layout_OH_DR_INFo := record		
	  string8   process_date;		
		string9	  KEY_NUMBER;
		string3	  REC_SEQ_NUM;
		string8	  DRIVER_RECORD_DELETE_DATE;
		string2	  DRIVERS_DETAIL_RECORD_TYPE_CODE;
		string150 FREE_FORM_NARRATIVE_TEXT;
		string8	  RECORD_TYPE_ACTION_DATE;
		string1	  DRIVERS_COSIGNERS_RELATIONSHIP;
		string35  DRIVERS_COSIGNERS_NAME;
		string8	  COSIGNERS_DRIVERS_LICENSE_NBR;
		string6	  MICROFILM_NUMBER;
		string8	  DATABASE_RECORD_CREATE_DATE;
		string9	  MERGED_FROM_KEYNUMBER;
		string8	  OUT_OF_STATE_DL_DATE_OF_ISSUANCE;
		string2	  PERSONS_NEW_STATE_OF_RECORD;
		string25  OUT_OF_STATE_DL_NBR;
		string8	  DRIVERS_LICENSE_NUMBER;
		string8	  REMEDIAL_REQUIREMENTS_COMPLETE;
		string8	  REMEDIAL_REQUIRE_DENIED_DATE;
		string8	  DOCUMENT_MAILED_DATE;
		string8	  RECORD_EXPUNGED_DATE;
		string10  BMV_CASE_NUMBER;
		string16  COURT_CASE_NUMBER;
		string6	  COURT_CODE;
		string8	  CLEAR_DATE;
		string6	  DRIVERS_BATCH_NUMBER;
		string4	  PROGRAM_ID;
		string16  SYSTEM_DATE_TIME_STAMP;
		string6	  USER_IDENTIFICATION_CODE;
		string8	  WARRANT_BLOCK_EFFECTIVE_DATE;
		string1	  NARRATIVE_RECORD_DISPLAY_FLAG;
		string6   REMEDIAL_DRIVING_SCHOOL_CERTIF;
		string8   RETENTION_DATE;
		string1   COURT_ORDERED_REMEDIAL_COURSE;
		string1   PAYMENT_PLAN_CODE;
		string8   PAYMENT_PLAN_START_DATE;
		string8   PAYMENT_PLAN_END_DATE;
		string8   MODIFIED_DRIVING_DATE;
		string8   MODIFIED_DRIVING_END_DATE;
		string1   NOTIFY_COURT_FLAG;
		string8   PAYMENT_PLAN_TERMINATION_DATE;
		string1   FEE_REQUIRED_FLAG;
		string8   FEE_PAID_DATE;
	  string8   RELEASE_DATE;
		string1   BANKRUPTCY_FLAG;
		string8   FAILURE_TO_REINSTATE_DATE;
		string114 FILLER := '';
	
	end;
	
	// Layout Accident
	export Layout_OH_ACCIDENT := record		
	  string8   process_date;		
		string9	  KEY_NUMBER;
		string3	  REC_SEQ_NUM;
		string8	  DRIVER_RECORD_DELETE_DATE;
		string2	  DRIVERS_DETAIL_RECORD_TYPE_CODE;
		string2	  COUNTY_NUMBER;
		string2	  JURISDICTION_CODE;
		string1	  DRIVERS_ACCIDENT_SEVERITY_IND;
		string8	  DRIVERS_ACCIDENT_DATE;
		string1	  DRIVERS_COMMERCIAL_VEHICLE_IND;
		string1	  HAZARDOUS_MATERIALS_FLAG;
		string18  DRIVERS_REFERENCE_LOCATOR_NBR;
		string8	  DATABASE_RECORD_CREATE_DATE;
		string9	  MERGED_FROM_KEYNUMBER;
		string8	  A1_CHANGED_TO_L1_DATE;
		string10  BMV_CASE_NUMBER;
		string8	  RECORD_EXPUNGED_DATE;
		string4	  PROGRAM_ID;
		string16  SYSTEM_DATE_TIME_STAMP;
		string6	  USER_IDENTIFICATION_CODE;
		string476 FILLER;
	end;
	
	// Layout FRA Insurance - Doc FRA Proof Filing
	export Layout_OH_FRA_INSURANCE := record		
	  string8   process_date;		
		string9	  KEY_NUMBER;
		string3	  REC_SEQ_NUM;
		string3	  DRIVERS_INSURANE_COMPANY_CODE;
		string8	  PROOF_FILING_START_DATE;
		string8	  PROOF_FILING_END_DATE;
		string16  DRIVERS_INSURANCE_POLICY_NBR;
		string8	  DRIVERS_PROOF_OF_INS_CANCELATION;
		string9	  MERGED_FROM_KEYNUMBER;
		string8	  DATABASE_RECORD_CREATE_DATE;
		string4	  PROGRAM_ID;
		string16  SYSTEM_DATE_TIME_STAMP;
		string6	  USER_IDENTIFICATION_CODE;
		string8	  PROOF_FILING_START_DATE_LATEST;
		string8	  DRIVERS_PROOF_CANCEL_POSTED_DATE;
		string8	  DRIVERS_PROOF_FILING_POSTED_DATE;
		string478 FILLER;
	end;

end;