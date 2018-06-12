﻿EXPORT	Layout_States	:=
MODULE
		
	// California Death Records
	EXPORT California := 
	RECORD
		STRING		fname;
		STRING 		mname;
		STRING		lname;
		STRING1		gender;
		STRING		dob;
		STRING		POB_StateOrCountry;
		STRING		dod;
		STRING		POD_Facility_Name_Location;
		STRING		POD_StreetNumber;
		STRING		POD_StreetAddress;
		STRING		POD_City;
		STRING		POD_County;
		STRING		lname_father;
	END;
		
	EXPORT California_20170409 := 
	RECORD
		STRING		fname;
		STRING 		mname;
		STRING		lname;
		STRING1		gender;
		STRING		dob;
		STRING		POB_StateOrCountry;
		STRING		dod;
		STRING		POD_Facility_Name_Location;
		STRING		POD_StreetNumber;
		STRING		POD_StreetAddress;
		STRING		POD_City;
		STRING		POD_County;
		STRING		lname_father;
		STRING		lname_mother;	//Maiden
		STRING9		ssn;
	END;
		
	// California Death Records
	EXPORT California_20150831 := 
	RECORD
		STRING		fname;
		STRING 		mname;
		STRING		lname;
		STRING1		gender;
		STRING		dob;
		STRING		POB_StateOrCountry;
		STRING		dod;
		UNSIGNED1	HospitalStatus;
		STRING		POD_StreetNumber;
		STRING		POD_StreetAddress;
		STRING		POD_City;
		STRING		POD_County;
		STRING		lname_father;
		STRING		lname_mother;	//Maiden
		STRING9		ssn;
	END;
		
	// California Death Records From 20150811 and earlier
	EXPORT California_20150811 := 
	RECORD
		STRING		StateFN;
		STRING		amendment_flag;
		STRING		certi_barcode_page_indicator;
		STRING		fname;
		STRING 		mname;
		STRING		lname;
		STRING		ssn;
		STRING		fname_father;
		STRING		mname_father;
		STRING		lname_father;
		STRING		fname_mother;
		STRING		mname_mother;
		STRING		lname_mother;	//Maiden
		STRING		street_address;
		STRING		city;
		STRING		county_text;
		STRING		county_code;
		STRING		zip5;
		STRING		zip4;
		STRING		foreign_country_code;
		STRING		foreign_country;
		STRING		dob;
		STRING		gender;
		STRING		dod;
	END;
	
	// California Death Records From 20140313 and earlier
	EXPORT California_20140313 := 
	RECORD
		STRING		lname;
		STRING		fname;
		STRING 		mname;
		STRING		gender;
		STRING10	dob;
		STRING10	dod;
		STRING		birthplace;
		STRING		county_death;
		STRING9		ssn;
		STRING		lname_mother;
		STRING		lname_father;
	END;

	// Connecticut Death Records
	EXPORT Connecticut := 
	RECORD	
		STRING		DOD_Yr;
		UNSIGNED4	StateFN;
		STRING		fname;
		STRING		mname;
		STRING		lname;
		UNSIGNED1	sex;
		STRING		DOD_MthDay;
		STRING		DOD_Mth;
		STRING		DOD_Day;
		STRING		DOD_Time;
		STRING		DOD_Time_AP;
		UNSIGNED1	age;
		STRING		AgeUnit;
		STRING		AgeUnit_NumberOfUnits;
		STRING8	dob;
		STRING		DOB_Mth;
		STRING		DOB_Day;
		STRING		DOB_Yr;
		UNSIGNED1	POB_StateOrCountry;
		STRING		POB_Town;
		STRING2		POB_Country_FIPS;
		STRING2		POB_State_FIPS;
		UNSIGNED2	POB_County_FIPS;
		UNSIGNED3	POB_Town_FIPS;
		UNSIGNED1	POD_State;
		UNSIGNED1	POD_County;
		UNSIGNED1	POD_Town;
		STRING2		POD_Country_FIPS;
		STRING2		POD_State_FIPS;
		UNSIGNED1	POD_County_FIPS;
		UNSIGNED3	POD_Town_FIPS;
		UNSIGNED3	POD_Zip;
		UNSIGNED1	Hospital;
		UNSIGNED1	HospitalStatus;
		UNSIGNED1	POR_StateOrCountry;
		UNSIGNED1	POR_County;
		UNSIGNED2	POR_Town;
		STRING2		POR_Country_FIPS;
		STRING2		POR_State_FIPS;
		UNSIGNED2	POR_County_FIPS;
		UNSIGNED3	POR_Town_FIPS;
		STRING		POR_HouseNumber;
		STRING		POR_StreetName;
		STRING		POR_StreetType;
		STRING		POR_ApartmentNumber;
		UNSIGNED3	POR_Zip;
		UNSIGNED1	MaritalStatus;
		STRING		fname_spouse;
		STRING		lname_father;
		STRING4		underlying_cause_of_death;
		STRING4		COD1;
		STRING4		COD2;
		STRING4		COD3;
		STRING4		COD4;
		STRING4		COD5;
		STRING4		COD6;
		STRING4		COD7;
		STRING4		COD8;
		STRING4		COD9;
		STRING4		COD10;
		STRING4		COD11;
		STRING4		COD12;
		STRING4		COD13;
		STRING4		COD14;
		STRING4		COD15;
		STRING4		COD16;
		STRING4		COD17;
		STRING4		COD18;
		STRING4		COD19;
		STRING4		COD20;
		STRING		MethodOfDisposition;
		UNSIGNED1		MedicalExaminerContacted;
		UNSIGNED1	Autopsy;
		UNSIGNED1	MannerOfDeath;
		UNSIGNED1	InjuryAtWork;		
		UNSIGNED1	race;
		STRING1		Tobacco;
		UNSIGNED1	Pregnancy;
		UNSIGNED3	DateRecordedModified;
		UNSIGNED3	BirthCertificateNumber;
		UNSIGNED1	Err;
		UNSIGNED1	AgeYrs;
		UNSIGNED1	NEWETH;
		STRING3			ShareYN;
		UNSIGNED3	BirthCertificateNumberForCohortLinkage;
		STRING6			BirthCertificateNumberN;
		STRING17		GeoCoder;
		UNSIGNED4	twnres;
		STRING1			FIPS;
		UNSIGNED4	TRACT10;
		UNSIGNED4	BLKGP10;
		UNSIGNED4	BLOCK10;
		UNSIGNED1	geostatus;
		STRING1			geoscore;
		UNSIGNED4	X_SP;
		UNSIGNED4	Y_SP;
		UNSIGNED4	TRACT00;
		UNSIGNED4	BLKGP00;
		UNSIGNED4	BLOCK00;
		STRING1			TWNRES_Recode;
		STRING1			CTYRES_evrs;
		STRING1			CTYRES_recode;
	END;

	// Florida Death Records
	EXPORT Florida := RECORD
		STRING8		place_of_death_state;
		STRING13	place_of_death_county;
		STRING26	place_of_death_city;
		STRING81	fname;
		STRING81	mname;
		STRING81	lname;
		STRING7		name_suffix;
		STRING2		gender;
		STRING10	ssn;
		STRING2		ssa_verification_flag;
		STRING4		age_death_value;
		STRING8		age_death_units;
		STRING9		dob;
		STRING41	place_of_birth_country;
		STRING21	place_of_birth_state;
		STRING9		dod;
		STRING41	residence_country;
		STRING21	residence_state;
		STRING51	residence_county;
		STRING51	residence_city;
		STRING51	residence_address;
		STRING11	residence_apartment;
		STRING6		residence_zip;
		STRING36	education;
		STRING23	marital_status;
		STRING41	fname_spouse;
		STRING41	mname_spouse;
		STRING41	lname_spouse;
		STRING7		name_suffix_spouse;
		STRING41	fname_father;
		STRING41	mname_father;
		STRING41	lname_father;
		STRING7		name_suffix_father;
		STRING41	fname_mother;
		STRING41	mname_mother;
		STRING41	lname_mother;
		STRING35	place_of_death_type;
		STRING19	disposition_type;
		STRING17	certifier_type;
		STRING27	hispanic_origin;
		STRING19	race;
		STRING2		us_armed_forces;
		STRING10	StateFN;
		STRING2		crlf;
	END;

	// Georgia Death Records
	EXPORT Georgia := RECORD
		STRING10	dod;
		STRING10	dob;
		UNSIGNED2	age;
		STRING		fname;
		STRING		mname;
		STRING		lname;	
		UNSIGNED1	Race_White;
		UNSIGNED1	Race_Guamanian_or_Chamorro;
		UNSIGNED1	Race_Filipino;
		UNSIGNED1	Race_African_American;
		UNSIGNED1	Race_Japanese;
		UNSIGNED1	Race_Samoan;
		UNSIGNED1	Race_American_Indian_or_Alaska_Native;
		STRING		Race_First_American_Indian_or_Alaska_Native_Literal;
		STRING		Race_Second_American_Indian_or_Alaska_Native_Literal;
		UNSIGNED1	Race_Korean;
		UNSIGNED1	Race_Other_Pacific_Islander;
		STRING		Race_First_Other_Pacific_Islander_Literal;
		STRING		Race_Second_Other_Pacific_Islander_Literal;
		UNSIGNED1	Race_Vietnamese;
		UNSIGNED1	Race_Asian_Indian;
		UNSIGNED1	Race_Chinese;
		UNSIGNED1	Race_Native_Hawaiian;
		UNSIGNED1	Race_Other_Asian;
		STRING		Race_First_Other_Asian_Literal;
		STRING		Race_Second_Other_Asian_Literal;
		UNSIGNED1	Race_Other;
		STRING		Race_First_Other_Literal;
		STRING		Race_Second_Other_Literal;
		UNSIGNED1	Race_Unknown;
		UNSIGNED1	Race_Refused;
		UNSIGNED1	Race_Not_Obtainable;
		STRING1		gender_code;
		STRING		gender;
		STRING4  	ssn_last_4;
		STRING		resident_state;
		STRING5		resident_county_fips;
		STRING60	resident_county;
		STRING40	residence_street_address;
		STRING27	resident_city;
		STRING25	lname_father;
	END;

	// Kentucky Death Records
	EXPORT Kentucky := RECORD
		STRING		death_count;
		STRING		death_year;
		STRING		dod;
		STRING		fname;
		STRING		lname;
		STRING		mname;
		STRING		county_of_death;
	END;

	// Massachusetts Death Records
	EXPORT Massachusetts := RECORD	
		STRING10	dob;
		STRING		fname;
		STRING		lname;
		STRING1		sex;
		STRING		residence_city;
		STRING		residence_county;
		STRING		residence_state;
		STRING10	dod;
		STRING		POR_StreetName;
		STRING		POR_HouseNumber;
		STRING		POR_StreetPrefix;
		STRING		POR_StreetType;
		STRING		POR_StreetSuffix;
		STRING		decedent_race;
		STRING2		crlf;

/*
		STRING15	fname;
		STRING1		filler_1;
		STRING20	lname;
		// STRING10	mname;
		STRING1		filler_2;
		// STRING30	residence_street_address;
		STRING5		POR_HouseNumber;
		STRING23	POR_StreetName;
		STRING2		POR_StreetType;
		STRING1		filler_3;
		STRING3		residence_city;
		STRING1		filler_4;
		STRING5		residence_zip;
		STRING1		filler_5;
		STRING2		residence_county;
		STRING1		filler_6;
		STRING8		dob;
		STRING1		filler_7;
		STRING2		decedent_race;
		STRING1		filler_8;
		STRING1		sex;
		STRING1		filler_9;
		STRING1		decedent_age_code;
		STRING2		age;
		STRING1		filler_10;
		STRING8		dod;
		// STRING4		filler_10;
		STRING2		crlf;
*/
	END;
	
	// Michigan Death Records
	EXPORT Michigan := RECORD
		STRING6		fileno;
		STRING3		occurrence_state;
		STRING2		occurrence_county;
		STRING4		occurrence_civil_division;
		STRING3		residence_state;
		STRING2		residence_county;
		STRING4		residence_civil_division;
		STRING15	lname;
		STRING10	fname;
		STRING10	mname;
		STRING1		alias_code;
		STRING4		dod_yr;
		STRING2		dod_mth;
		STRING2		dod_day;
		STRING4		dob_yr;
		STRING2		dob_mth;
		STRING2		dob_day;
		STRING1		decedent_sex;
		STRING9		ssn;
		STRING25	addr;
		STRING15	city;
		STRING2		state;
		STRING15	father_surname;
		STRING2		crlf;
	END;

	// Minnesota Death Records
	EXPORT Minnesota := RECORD	
		STRING6		certificate_number;
		STRING50	fname;
		STRING50	mname;
		STRING50	lname;
		STRING9		ssn;
		STRING1		sex;
		STRING8		dod;
		STRING8		dob;
		STRING40	occupation;
		STRING40	industry;
		STRING28	residence_state;
		STRING28	residence_county;
		STRING28	residence_city;
		STRING50	residence_street;
		STRING9		residence_zip;
		STRING1		residence_township;
		STRING40	city_of_death;
		STRING28	county_of_death;
		STRING1		Race_White;
		STRING1		Race_African_American;
		STRING1		Race_Somalian;
		STRING1		Race_Ethiopian;
		STRING1		Race_Liberian;
		STRING1		Race_Kenyan;
		STRING1		Race_Sudanese;
		STRING1		Race_Nigerian;
		STRING1		Race_Ghanian;
		STRING1		Race_Other_African;
		STRING30	Race_First_Other_African_Literal;
		STRING1		Race_American_Indian_or_Alaska_Native;
		STRING30	Race_First_American_Indian_or_Alaska_Native_Literal;
		STRING30	Race_Second_American_Indian_or_Alaska_Native_Literal;
		STRING1		Race_Asian_Indian;
		STRING1		Race_Chinese;
		STRING1		Race_Filipino;
		STRING1		Race_Japanese;
		STRING1		Race_Korean;
		STRING1		Race_Vietnamese;
		STRING1		Race_Hmong;
		STRING1		Race_Cambodian;
		STRING1		Race_Laotian;
		STRING1		Race_Other_Asian;
		STRING30	Race_First_Other_Asian_Literal;
		STRING30	Race_Second_Other_Asian_Literal;
		STRING1		Race_Native_Hawaiian;
		STRING1		Race_Guamanian_or_Chamorro;
		STRING1		Race_Samoan;
		STRING1		Race_Other_Pacific_Islander;
		STRING30	Race_First_Other_Pacific_Islander_Literal;
		STRING30	Race_Second_Other_Pacific_Islander_Literal;
		STRING1		Race_Other;
		STRING30	Race_First_Other_Literal;
		STRING30	Race_Second_Other_Literal;
		STRING1		Race_Unknown;
		STRING1		Race_Not_Obtainable;
		STRING1		Race_Refused;
		STRING1		Hispanic_Origin_Mexican;
		STRING1		Hispanic_Origin_PuertoRican;
		STRING1		Hispanic_Origin_Cuban;
		STRING1		Hispanic_Origin_Other;
		STRING20	Hispanic_Origin_Other_Literal;
		STRING1		Hispanic_Origin_Not_Hispanic;
		STRING1		Hispanic_Origin_Refused_To_State_Hispanic_Origin;
		STRING1		Hispanic_Origin_Unknown_Hispanic_Origin;   
		STRING1		Hispanic_Origin_Not_Obtainable;
		STRING1		lf;
	END;

	// Montana Death Records
	EXPORT Montana := RECORD
		UNSIGNED4	rowNo;
		STRING		fname;
		STRING 		mname;
		STRING		lname;
		STRING9		ssn;
		STRING		gender;
		STRING2		dod_mth;
		STRING2		dod_day;
		STRING4		dod_yr;
		STRING2		dob_mth;
		STRING2		dob_day;
		STRING4		dob_yr;
		STRING		state;
		STRING		county;
		STRING		city;
		STRING		addr_1;
		STRING		addr_2;
		STRING		zip;
	END;
	
	// Nevada Death Records
	EXPORT Nevada := RECORD
		STRING		fname;
		STRING		mname;
		STRING 		lname;
		STRING 		name_suffix;
		STRING10	dob;
		STRING10	dod;
	END;
	
	// North Carolina Death Records
	EXPORT NorthCarolina := RECORD	
		STRING4		DOD_Yr;
		STRING2		POD_State;
		STRING6		filler_1;
		STRING1		void_flag;
		STRING12	filler_2;
		STRING1		source_flag;
		STRING50	fname;
		STRING1		middle_initial;
		STRING50	lname;
		STRING10	name_suffix;
		STRING1		alias_flag;
		STRING50	lname_father;
		STRING1		gender;
		STRING1		filler_3;
		STRING9		ssn;
		STRING1		age_code;
		STRING3		age_units;
		STRING1		filler_4;
		STRING4		DOB_Yr;
		STRING2		DOB_Mth;
		STRING2		DOB_Day;
		STRING2		POB_Country;
		STRING2		POB_State;
		STRING5		POR_City;
		STRING3		POR_County;
		STRING2		POR_State;
		STRING2		POR_Country;
		STRING1		POR_CityLimitsFlag;
		STRING1		MaritalStatus;
		STRING1		filler_5;
		STRING1		PlaceOfDeath;
		STRING3		Facility_County;
		STRING1		MethodOfDisposition;
		STRING2		DOD_Mth;
		STRING2		DOD_Day;
		STRING4		DOD_Time;
		STRING1		education;
		STRING1		filler_6;
		STRING1		Hispanic_Origin_Mexican;
		STRING1		Hispanic_Origin_PuertoRican;
		STRING1		Hispanic_Origin_Cuban;
		STRING1		Hispanic_Origin_Other;
		STRING20	Hispanic_Origin_Other_Literal;
		STRING1		Race_White;
		STRING1		Race_African_American;
		STRING1		Race_American_Indian_or_Alaska_Native;
		STRING1		Race_Asian_Indian;
		STRING1		Race_Chinese;
		STRING1		Race_Filipino;
		STRING1		Race_Japanese;
		STRING1		Race_Korean;
		STRING1		Race_Vietnamese;
		STRING1		Race_Other_Asian;
		STRING1		Race_Native_Hawaiian;
		STRING1		Race_Guamanian_or_Chamorro;
		STRING1		Race_Samoan;
		STRING1		Race_Other_Pacific_Islander;
		STRING1		Race_Other;
		STRING30	Race_First_American_Indian_or_Alaska_Native_Literal;
		STRING30	Race_Second_American_Indian_or_Alaska_Native_Literal;
		STRING30	Race_First_Other_Asian_Literal;
		STRING30	Race_Second_Other_Asian_Literal;
		STRING30	Race_First_Other_Pacific_Islander_Literal;
		STRING30	Race_Second_Other_Pacific_Islander_Literal;
		STRING30	Race_First_Other_Literal;
		STRING30	Race_Second_Other_Literal;
		STRING175	filler_7;
		STRING10	POR_StreetNumber;
		STRING2		POR_PreDirection;
		STRING40	POR_StreetName;
		STRING5		POR_StreetSuffix;
		STRING2		POR_PostDirection;
		STRING10	POR_ApartmentNumber;
		STRING5		POR_zip;
		STRING3		POB_County;
		STRING50	Facility_Name;
		STRING5		Facility_City;
		STRING1		Veteran_Flag;
		STRING50	maiden_name;
		STRING50	fname_father;
		STRING1		mname_father;
		STRING50	fname_mother;
		STRING1		mname_mother;
		STRING50	lname_mother;
		STRING1		referred_to_MedicalExaminer;
		STRING1		declined_by_MedicalExaminer;
		STRING4		registered_by_state_year;
		STRING2		registered_by_state_mth;
		STRING2		registered_by_state_day;
		STRING9		filler_8;
		STRING4		local_registrar_filedate_year;
		STRING2		local_registrar_filedate_mth;
		STRING2		local_registrar_filedate_day;
		STRING50	funeral_home_name;
		STRING30	funeral_home_street_address;
		STRING30	funeral_home_city;
		STRING2		funeral_home_state;
		STRING12	filler_9;
		STRING24	POD_Literal;
		STRING50	mname;
		STRING29	POR_City_Literal;
		STRING1		cert_code;
		STRING9		filler_10;
		STRING1		MannerOfDeath;
		STRING1		place_of_injury;
		STRING5		icd10_manual_underlying_cause_of_death;
		STRING5		acme_underlying_cause_of_death;
		STRING5		first_mentioned_cause_of_death;
		STRING5		second_mentioned_cause_of_death;
		STRING5		third_mentioned_cause_of_death;
		STRING5		fourth_mentioned_cause_of_death;
		STRING5		fifth_mentioned_cause_of_death;
		STRING5		sixth_mentioned_cause_of_death;
		STRING5		seventh_mentioned_cause_of_death;
		STRING5		eighth_mentioned_cause_of_death;
		STRING5		ninth_mentioned_cause_of_death;
		STRING5		tenth_mentioned_cause_of_death;
		STRING5		eleventh_mentioned_cause_of_death;
		STRING5		twelfth_mentioned_cause_of_death;
		STRING5		thirteenth_mentioned_cause_of_death;
		STRING5		fourteenth_mentioned_cause_of_death;
		STRING5		fifteenth_mentioned_cause_of_death;
		STRING5		sixteenth_mentioned_cause_of_death;
		STRING5		seventeenth_mentioned_cause_of_death;
		STRING5		eighteenth_mentioned_cause_of_death;
		STRING5		ninteenth_mentioned_cause_of_death;
		STRING5		twentieth_mentioned_cause_of_death;
		STRING1		autopsy;
		STRING1		AutopsyFindingsAvailable;
		STRING1		Tobacco;
		STRING1		Pregnancy;
		STRING1		InjuryAtWork;
		STRING34	filler_11;
		STRING2		crlf;
	END;
	
	// Ohio Death Records
	EXPORT Ohio := RECORD
		STRING19	lname;
		STRING17	fname;
		STRING22	mname;
		STRING3		name_suffix;
		STRING1		decedent_sex;
		STRING4		ssn_last_4;
		STRING20	birthplace;
		STRING10	dob;
		STRING10	dod;
		STRING28	res_addr;
		STRING45	res_city;
		STRING5		res_zip;
		STRING10	res_county;
		// STRING54	funeral_home_name := '';
	END;
	
	// Virginia Death Records
	EXPORT Virginia := 
	RECORD
		STRING		fname;
		STRING 		mname;
		STRING		lname;
		STRING		dod;
		STRING		place_of_death;
		STRING		dob;
		STRING		address;
		STRING		zip;
	END;

	// Ab Initio Layout
	EXPORT States_Supplemental	:= RECORD
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
		STRING4		DEATH_YEAR; // Unique to States_Supplmental Layout
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
		STRING1		lf;
	END;

	EXPORT Death_Master_Base := RECORD
		STRING8		filedate;
		STRING1		rec_type;
		STRING1		rec_type_orig;
		STRING9		ssn;
		STRING20	lname;
		STRING4		name_suffix;
		STRING15	fname;
		STRING15	mname;
		STRING1		VorP_code;
		STRING8		dod8;
		STRING8		dob8;
		STRING2		st_country_code;
		STRING5		zip_lastres;
		STRING5		zip_lastpayment;
		STRING2		state;
		STRING3		fipscounty;
		STRING5		clean_title;
		STRING20	clean_fname;
		STRING20	clean_mname;
		STRING20	clean_lname;
		STRING5		clean_name_suffix;
		STRING3		clean_name_score;
		STRING2		crlf;
    UNSIGNED8	ScrubsBits1;
	END;

END;

