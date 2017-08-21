IMPORT HEADER,standard;
EXPORT layouts := MODULE

	EXPORT Layout_Did_Death_MasterV2 := HEADER.Layout_Did_Death_MasterV2;
	
	EXPORT Layout_Death_Master := RECORD
		STRING8  filedate;
		STRING1  rec_type;
		STRING1  rec_type_orig;
		STRING9  ssn;
		STRING20 lname;
		STRING4  name_suffix;
		STRING15 fname;
		STRING15 mname;
		STRING1  VorP_code;
		STRING8  dod8;
		STRING8  dob8;
		STRING2  st_country_code;
		STRING5  zip_lastres;
		STRING5  zip_lastpayment;
		STRING2	 state;
		STRING3	 fipscounty;
		STRING2  crlf;
		STRING1  state_death_flag := '';
		STRING3	 death_rec_src := '';
	end;

	EXPORT Layout_Did_Death_Master := RECORD
		STRING12 did,
		UNSIGNED1 did_score,
		layout_death_master
	END;
	EXPORT layout_death_master_supplemental := RECORD
		STRING8		PROCESS_DATE;
		STRING2		SOURCE_STATE;
		STRING3		CERTIFICATE_VOL_NO;
		STRING4		CERTIFICATE_VOL_YEAR;
		STRING28	PUBLICATION;
		STRING44	DECEDENT_NAME;
		STRING93	DECEDENT_RACE;
		STRING69	DECEDENT_ORIGIN;
		STRING12	DECEDENT_SEX;
		STRING34	DECEDENT_AGE;
		STRING26	EDUCATION;
		STRING74	OCCUPATION;
		STRING62	WHERE_WORKED;
		STRING289	CAUSE;
		STRING9		SSN;
		STRING8		DOB;
		STRING8		DOD;
		STRING35	BIRTHPLACE;
		STRING38	MARITAL_STATUS;
		STRING44	FATHER;
		STRING44	MOTHER;
		STRING8		FILED_DATE;
		STRING4		YEAR;
		STRING77	COUNTY_RESIDENCE;
		STRING23	COUNTY_DEATH;
		STRING76	ADDRESS;
		STRING7		AUTOPSY;
		STRING44	AUTOPSY_FINDINGS;
		STRING4		PRIMARY_CAUSE_OF_DEATH;
		STRING50	UNDERLYING_CAUSE_OF_DEATH;
		STRING3		MED_EXAM;
		STRING6		EST_LIC_NO;
		STRING22	DISPOSITION;
		STRING8		DISPOSITION_DATE;
		STRING9		WORK_INJURY;
		STRING8		INJURY_DATE;
		STRING23	INJURY_TYPE;
		STRING50	INJURY_LOCATION;
		STRING7		SURG_PERFORMED;
		STRING8		SURGERY_DATE;
		STRING120	HOSPITAL_STATUS;
		STRING14	PREGNANCY;
		STRING70	FACILITY_DEATH;
		STRING6		EMBALMER_LIC_NO;
		STRING21	DEATH_TYPE;
		STRING5		TIME_DEATH;
		STRING12	BIRTH_CERT;
		STRING31	CERTIFIER;
		STRING20	CERT_NUMBER;
		STRING4		BIRTH_VOL_YEAR;
		STRING5		LOCAL_FILE_NO;
		STRING39	VDI;
		STRING28	CITE_ID;
		STRING5		FILE_ID;
		STRING8		DATE_LAST_TRANS;
		STRING1		AMENDMENT_CODE;
		STRING2		AMENDMENT_YEAR;
		STRING10	_ON_LEXIS;
		STRING9		_FS_PROFILE;
		STRING3		US_ARMED_FORCES;
		STRING49	PLACE_OF_DEATH;
		STRING16	state_death_id;
		STRING1		state_death_flag;
		STRING5		title;
		STRING20	fname;
		STRING20	mname;
		STRING20	lname;
		STRING5		name_suffix;
		STRING3		name_score;
		STRING10	prim_range;
		STRING2		predir;
		STRING28	prim_name;
		STRING4		addr_suffix;
		STRING2		postdir;
		STRING10	unit_desig;
		STRING8		sec_range;
		STRING25	p_city_name;
		STRING25	v_city_name;
		STRING2		state;
		STRING5		zip5;
		STRING4		zip4;
		STRING4		cart;
		STRING1		cr_sort_sz;
		STRING4		lot;
		STRING1		lot_order;
		STRING2		dpbc;
		STRING1		chk_digit;
		STRING2		rec_type;
		STRING2		fips_state;
		STRING3		fips_county;
		STRING10	geo_lat;
		STRING11	geo_long;
		STRING4		msa;
		STRING7		geo_blk;
		STRING1		geo_match;
		STRING4		err_stat;
		UNSIGNED8	rawaid				:=	0;
		STRING76	orig_address1	:=	'';
		STRING76	orig_address2	:=	'';
		STRING16	statefn				:=	'';	// State File Number used to associate this record with a state
		STRING1		lf;
		UNSIGNED8	ScrubsBits1		:=	0;
		UNSIGNED8	ScrubsBits2		:=	0;
		UNSIGNED8	ScrubsBits3		:=	0;
	END;
	
	EXPORT layout_death_master_slim_supplemental := RECORD
		layout_death_master_supplemental AND NOT 
		[
			rawaid, 
			orig_address1, 
			orig_address2, 
			statefn, 
			ScrubsBits1, 
			ScrubsBits2, 
			ScrubsBits3
		];
	END;
	EXPORT	layout_death_master_base := record
		STRING12 did;
		UNSIGNED1 did_score;
		STRING8 filedate;
		STRING1 rec_type;
		STRING1 rec_type_orig;
		STRING9 ssn;
		STRING20 lname;
		STRING4 name_suffix;
		STRING15 fname;
		STRING15 mname;
		STRING1 vorp_code;
		STRING8 dod8;
		STRING8 dob8;
		STRING2 st_country_code;
		STRING5 zip_lastres;
		STRING5 zip_lastpayment;
		STRING2 state;
		STRING3 fipscounty;
		STRING2 crlf;
		STRING1 state_death_flag;
		STRING3 death_rec_src;
		STRING state_death_id;
		STRING src;
		STRING glb_flag;
		STRING process_date;
		STRING source_state;
		STRING certificate_vol_no;
		STRING certificate_vol_year;
		STRING publication;
		STRING decedent_name;
		STRING decedent_race;
		STRING decedent_origin;
		STRING decedent_sex;
		STRING decedent_age;
		STRING education;
		STRING occupation;
		STRING where_worked;
		STRING cause;
		STRING dob;
		STRING dod;
		STRING birthplace;
		STRING marital_status;
		STRING father;
		STRING mother;
		STRING filed_date;
		STRING year;
		STRING county_residence;
		STRING county_death;
		STRING address;
		STRING autopsy;
		STRING autopsy_findings;
		STRING primary_cause_of_death;
		STRING underlying_cause_of_death;
		STRING med_exam;
		STRING est_lic_no;
		STRING disposition;
		STRING disposition_date;
		STRING work_injury;
		STRING injury_date;
		STRING injury_type;
		STRING injury_location;
		STRING surg_performed;
		STRING surgery_date;
		STRING hospital_status;
		STRING pregnancy;
		STRING facility_death;
		STRING embalmer_lic_no;
		STRING death_type;
		STRING time_death;
		STRING birth_cert;
		STRING certifier;
		STRING cert_number;
		STRING birth_vol_year;
		STRING local_file_no;
		STRING vdi;
		STRING cite_id;
		STRING file_id;
		STRING date_last_trans;
		STRING amendment_code;
		STRING amendment_year;
		STRING _on_lexis;
		STRING _fs_profile;
		STRING us_armed_forces;
		STRING place_of_death;
		STRING title;
		STRING name_score;
		STRING prim_range;
		STRING predir;
		STRING prim_name;
		STRING addr_suffix;
		STRING postdir;
		STRING unit_desig;
		STRING sec_range;
		STRING p_city_name;
		STRING v_city_name;
		STRING zip5;
		STRING zip4;
		STRING cart;
		STRING cr_sort_sz;
		STRING lot;
		STRING lot_order;
		STRING dpbc;
		STRING chk_digit;
		STRING fips_state;
		STRING fips_county;
		STRING geo_lat;
		STRING geo_long;
		STRING msa;
		STRING geo_blk;
		STRING geo_match;
		STRING err_stat;
		STRING rawaid;
		STRING orig_address1;
		STRING orig_address2;
		STRING statefn;
		STRING lf;
		STRING county_name;
		STRING __internal_fpos__;
		STRING l_did;
		STRING dph_lname;
		STRING pfname;
		STRING bug_num;
		STRING append_row_id;
		STRING cust_name;
    STRING9  link_ssn;
		STRING8  link_dob;    
    
    
    
	END;

	EXPORT rec_dod := RECORD
		HEADER.Layout_Did_Death_MasterV3.dod8;
		HEADER.Layout_Did_Death_MasterV3.state;
		STRING20 dph_lname;
		STRING25 pfname;
		HEADER.Layout_Did_Death_MasterV3.state_death_id;
	END;

	EXPORT  Layout_Death_Record_Building := RECORD
		HEADER.Layout_Did_Death_MasterV3;
		STRING18 county_name := '';
	END;
	
	EXPORT REC_DOB := record
		Layout_Death_Record_Building.dob8;
		Layout_Death_Record_Building.state;
		STRING20 dph_lname;
		STRING25 pfname;
		Layout_Death_Record_Building.state_death_id;
	END;
	EXPORT Death_Record_DID := record
		Layout_Did_Death_Master;
		STRING18 county_name := '';
	END;
	EXPORT rec_autokey_ssa := RECORD
		UNSIGNED6 did;
		Layout_Death_Record_Building.ssn;
		STRING8 dob;
		standard.Addr addr;
		Layout_Death_Record_Building.fname;
		Layout_Death_Record_Building.mname;
		Layout_Death_Record_Building.lname;
		Layout_Death_Record_Building.state_death_id;
		UNSIGNED1 zero := 0;
		STRING1  blank:='';
		STRING2 src := '';
		STRING1 glb_flag := '';
	end;
END;