export layout_payload_booking := RECORD , MAXLENGTH(28000)
STRING10 action;// {XPATH('@action')};// {XPATH('@action')};
string15 primaryKey;// {XPATH('@primaryValue')}; //data attribute
string15 agencyKey ;//{XPATH('@agencyKey')};  
string30 maxQueueSid ;//{XPATH('@maxQueueSid')};  
string25 delete_info;// {XPATH('DATASOURCE_AGENCY/ORI_NBR')};
string15 booking_sid;//{XPATH('BOOKING_SID')};
String10 site_id;//{XPATH('SITE_ID')};
String5 agency;//{XPATH('AGENCY')};
String2 state_cd;//{XPATH('STATE_CD')};
string50 booking_nbr;//{XPATH('BOOKING_NBR')};
String30 inmate_nbr;//{XPATH('INMATE_NBR')};
String30 state_id;//{XPATH('STATE_ID')};
String30 oid;//{XPATH('OID')};
String20 creation_ts;//{XPATH('CREATION_TS')};
String10 last_change_session_sid;//{XPATH('LAST_CHANGE_SESSION_SID')};
String10 last_change_file_nbr;//{XPATH('LAST_CHANGE_FILE_NBR')};
String20 last_change_ts;//{XPATH('LAST_CHANGE_TS')};
String11 ap_ssn;//{XPATH('SSN')};
String15 ap_ssn_dash;//{XPATH('SSN_DASH')};
String50 ap_lname;//{XPATH('LNAME')};
String50 ap_fname;//{XPATH('FNAME')};
String50 ap_mname;//{XPATH('MNAME')};
String8  arrest_date;//{XPATH('ARREST_DATE')};
String25 arrest_ts;//{XPATH('ARREST_TS')};
String20 booking_ts_raw;//{XPATH('BOOKING_TS_RAW')};
String8  booking_date;//{XPATH('BOOKING_DATE')};
String25 booking_ts;//{XPATH('BOOKING_TS')};
String8  release_date;//{XPATH('RELEASE_DATE')};
String25 release_ts;//{XPATH('RELEASE_TS')};
String8  date_of_birth;//{XPATH('DATE_OF_BIRTH')};
String20 dob;//{XPATH('DOB')};
String15 race;//{XPATH('RACE')};
String15 gender;//{XPATH('GENDER')};
String15  hgt;//{XPATH('HGT')};
String15  wgt;//{XPATH('WGT')};
String15 hair;//{XPATH('HAIR')};
String15 eye;//{XPATH('EYE')};
String10 handed;//{XPATH('HANDED')};
String12 mstatus;//{XPATH('MSTATUS')};
String1 released_ind;//{XPATH('RELEASED_IND')};
String1 incident_ind;//{XPATH('INCIDENT_IND')};
String1 juvenile_ind;//{XPATH('JUVENILE_IND')};
String50 rreason;//{XPATH('RREASON')};
String5 custody_status_cd;//{XPATH('CUSTODY_STATUS_CD')};
String3 key_race;//{XPATH('KEY_RACE')};
String10 key_gender;//{XPATH('KEY_GENDER')};
String3 key_hgt;//{XPATH('KEY_HGT')};
String2 hgt_cd;//{XPATH('HGT_CD')};
String3 key_wgt;//{XPATH('KEY_WGT')};
String2 wgt_cd;//{XPATH('WGT_CD')};
String5 key_hair;//{XPATH('KEY_HAIR')};
String5 key_eye;//{XPATH('KEY_EYE')};
String7 key_mstatus;//{XPATH('KEY_MSTATUS')};
String3 key_handed;//{XPATH('KEY_HANDED')};
String70 ap_address1;//{XPATH('ADDRESS1')};
String50 ap_address2;//{XPATH('ADDRESS2')};
String50 ap_city;//{XPATH('CITY')};
String35 ap_state;//{XPATH('STATE')};
String10 ap_zipcode;//{XPATH('ZIPCODE')};
String10 complex;//{XPATH('COMPLEX')};
String25 dlnumber;//{XPATH('DLNUMBER')};
String25 dlstate;//{XPATH('DLSTATE')};
String35 pob;//{XPATH('POB')};
String1 citizen_ind;//{XPATH('CITIZEN_IND')};
String1 weekender_ind;//{XPATH('WEEKENDER_IND')};
String1 correct_lenses_ind;//{XPATH('CORRECT_LENSES_IND')};
String180 marks_scars_tatoos;//{XPATH('MARKS_SCARS_TATOOS')};
String170 other_phy_features;//{XPATH('OTHER_PHY_FEATURES')};
String150 warnings_cautions;//{XPATH('WARNINGS_CAUTIONS')};
String85 front_image;//{XPATH('FRONT_IMAGE')};
String85 profile_image;//{XPATH('PROFILE_IMAGE')};
String25 home_phone;//{XPATH('HOME_PHONE')};
String30 employer;//{XPATH('EMPLOYER')};
String25 work_phone;//{XPATH('WORK_PHONE')};
String35 occupation;//{XPATH('OCCUPATION')};
String25 language_spoken;//{XPATH('LANGUAGE_SPOKEN')};
String25 language_read;//{XPATH('LANGUAGE_READ')};
String25 language_written;//{XPATH('LANGUAGE_WRITTEN')};
String25 blood_type;//{XPATH('BLOOD_TYPE')};
String40 medical_alert;//{XPATH('MEDICAL_ALERT')};
String1  violent_behavior_ind;//{XPATH('VIOLENT_BEHAVIOR_IND')};
String1 suicide_risk_ind;//{XPATH('SUICIDE_RISK_IND')};
String1 escape_risk_ind;//{XPATH('ESCAPE_RISK_IND')};
String1 foreign_born_ind;//{XPATH('FOREIGN_BORN_IND')};
String1 sex_offender_ind;//{XPATH('SEX_OFFENDER_IND')};
String1 mental_illness_ind;//{XPATH('MENTAL_ILLNESS_IND')};
String25 gang;//{XPATH('GANG')};
String10 military;//{XPATH('MILITARY')};
String2  parole_class;//{XPATH('PAROLE_CLASS')};
String25 fbi_nbr;//{XPATH('FBI_NBR')};
String28 education_yrs;//{XPATH('EDUCATION_YRS')};
String100 ap_full_name;//{XPATH('FULL_NAME')};
String55 agency_description;//{XPATH('AGENCY_DESCRIPTION')};
String20 agency_ori;//{XPATH('AGENCY_ORI')};
String1 dep_no_suppress_web_display_ind;//{XPATH('DEP_NO_SUPPRESS_WEB_DISPLAY_IND')};
String1 dep_no_suppress_inquiry_ind;//{XPATH('DEP_NO_SUPPRESS_INQUIRY_IND')};
String15 ethnicity_cd;//{XPATH('ETHNICITY_CD')};
String50 key_ethnicity_cd;//{XPATH('KEY_ETHNICITY_CD')};
String20 ap_name_suffix;//{XPATH('NAME_SUFFIX')};
String15 nationality;//{XPATH('NATIONALITY')};
String8  offense_date;//{XPATH('OFFENSE_DATE')};
String20 offense_ts;//{XPATH('OFFENSE_TS')};
String8  scheduled_release_date;//{XPATH('SCHEDULED_RELEASE_DATE')};
String8  sentence_exp_date;//{XPATH('SENTENCE_EXP_DATE')};
String195 scar;//{XPATH('SCAR')};
String100 mark;//{XPATH('MARK')};
String100 tattoo;//{XPATH('TATTOO')};
String1 facial_hair_ind;//{XPATH('FACIAL_HAIR_IND')};
String1 hearing_problem_ind;//{XPATH('HEARING_PROBLEM_IND')};
String20 religion;//{XPATH('RELIGION')};
String20 passport_visa_nbr;//{XPATH('PASSPORT_VISA_NBR')};
String15 ins_reg_nbr;//{XPATH('INS_REG_NBR')};
String5  holding_facility;//{XPATH('HOLDING_FACILITY')};
String10 complexion;//{XPATH('COMPLEXION')};
String10 dlclass_txt;//{XPATH('DLCLASS_TXT')};
String10 residency_status_txt;//{XPATH('RESIDENCY_STATUS_TXT')};
String5 primary_language_txt;//{XPATH('PRIMARY_LANGUAGE_TXT')};
String1 english_understood_ind;//{XPATH('ENGLISH_UNDERSTOOD_IND')};
String1 dna_sample_taken_ind;//{XPATH('DNA_SAMPLE_TAKEN_IND')};
String20 afis_id;//{XPATH('AFIS_ID')};
String20 arresting_ori_nbr;//{XPATH('ARRESTING_ORI_NBR')};
String70 arresting_agency_name;//{XPATH('ARRESTING_AGENCY_NAME')};
String15 arresting_agency_phone;//{XPATH('ARRESTING_AGENCY_PHONE')};
String100 holding_facility_desc;//{XPATH('HOLDING_FACILITY_DESC')};
String20 holding_facility_ori;//{XPATH('HOLDING_FACILITY_ORI')};
String15 subject_search_sid;//{XPATH('SUBJECT_SEARCH_SID')};
String15 subject_person_sid;//{XPATH('SUBJECT_PERSON_SID')};
String15 subject_group_sid;//{XPATH('SUBJECT_GROUP_SID')};
String5 group_rule_version;//{XPATH('GROUP_RULE_VERSION')};
String5 key_complex;//{XPATH('KEY_COMPLEX')};
String1 display_extra_images_ind;//{XPATH('DISPLAY_EXTRA_IMAGES_IND')};
String7 days_incarcerated;//{XPATH('DAYS_INCARCERATED')};
// Added Fields
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		addr_suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		state;
	string5		zip5;
	string4		zip4;
	string4		cart;
	string1		cr_sort_sz;
	string4		lot;
	string1		lot_order;
	string2		dpbc;
	string1		chk_digit;
	string2		rec_type;
	string2		ace_fips_st;
	string3		ace_fips_county;
	string10	geo_lat;
	string11	geo_long;
	string4		msa;
	string7		geo_blk;
	string1		geo_match;
	string4		err_stat;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string3		name_score;
	string9		ssn;
	unsigned8 did;
END;
