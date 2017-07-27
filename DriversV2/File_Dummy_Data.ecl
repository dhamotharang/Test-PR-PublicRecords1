import ut;

dInlineDummyData_Input
 :=
  dataset([
	// ******************************************** Record 1 ********************************************
	{0,                                             //unsigned6 dl_seq
	 999999000001,									//unsigned6	did
	 0,												//unsigned6	Preglb_did
	 199201,										//unsigned3	dt_first_seen
	 199902,										//unsigned3	dt_last_seen
	 200101,										//unsigned3	dt_vendor_first_reported
	 0,												//unsigned3	dt_vendor_last_reported
	 '',                                            //string14  DLCP_Key
	 'MI',											//string2	orig_state
	 'AD',											//string2	source_code
	 '',											//string1	history
	 'AARDVARK JOHN',								//qstring52	name
	 '',                                            //string1   addr_type
	 '10 S NORTH STREET APT 206',					//qstring40	addr1
	 'ANN ARBOR',									//qstring20	city
	 'MI',											//qstring2	state
	 '48103',										//qstring5	zip
	 '',                                            //string2   province
	 '',                                            //string3   country
	 '',                                            //string10  postal_code
	 19600112,										//unsigned4	dob
	 '',											//string1	race
	 'M',											//string1	sex_flag
	 '',											//string2	license_class
	 'D',											//qstring4	license_type
	 '',											//qstring14	attention_flag
	 '',											//qstring8	dod
	 '',											//qstring42	restrictions
	 '',											//qstring42	restrictions_delimited
	 '',											//unsigned4	orig_expiration_date
	 '',											//unsigned4	orig_issue_date
	 '',											//unsigned4	lic_issue_date
	 '',											//unsigned4	expiration_date
	 '',											//unsigned3	active_date
	 '',											//unsigned3	inactive_date
	 '',											//qstring10	lic_endorsement
	 '',											//qstring4	motorcycle_code
	 'D0001',										//qstring14	dl_number
	 '263124372',									//qstring9	ssn
	 '263124372',									//qstring9	ssn_safe
	 '',											//qstring3	age
	 '',											//string1	privacy_flag
	 '',											//string1	driver_edu_code
	 '',											//string1	dup_lic_count
	 '',											//string1	rcd_stat_flag
	 '',											//qstring3	height
	 '',											//qstring3	hair_color
	 '',											//qstring3	eye_color
	 '',											//qstring3	weight
	 '',											//qstring25	oos_previous_dl_number
	 '',											//string2	oos_previous_st
	 'MR',											//qstring5	title
	 'JOHN',										//qstring20	fname
	 '',											//qstring20	mname
	 'AARDVARK',									//qstring20	lname
	 '',											//qstring5	name_suffix
	 '91',											//qstring3	cleaning_score
	 '',											//string1	addr_fix_flag
	 '10',											//qstring10	prim_range
	 'S',											//qstring2	predir
	 'NORTH',										//qstring28	prim_name
	 'ST',											//qstring4	suffix
	 '',											//qstring2	postdir
	 'APT',											//qstring10	unit_desig
	 '206',											//qstring8	sec_range
	 'ANN ARBOR',									//qstring25	p_city_name
	 'ANN ARBOR',									//qstring25	v_city_name
	 'MI',											//qstring2	st
	 '48103',										//qstring5	zip5
	 '',											//qstring4	zip4
	 '',											//qstring4	cart
	 '',											//string1	cr_sort_sz
	 '',											//qstring4	lot
	 '',											//string1	lot_order
	 '',											//string2	dpbc
	 '',											//string1	chk_digit
	 'S',											//string2	rec_type
	 '26',											//string2	ace_fips_st
	 '161',											//qstring3	county
	 '42.584598',									//qstring10	geo_lat
	 '-84.806365',									//qstring11	geo_long
	 '4040',										//qstring4	msa
	 '210004',										//qstring7	geo_blk
	 '1',											//string1	geo_match
	 'S810',										//qstring4	err_stat
	 '',											//string1	status
	 '',											//qstring2	issuance
	 '',											//qstring8	address_change
	 '',											//string1	name_change
	 '',											//string1	dob_change
	 '',											//string1	sex_change
	 '',											//qstring14	old_dl_number
	 '',											//qstring9	dl_key_number
	 ''                                             //string3   CDL_status	 
	},
	// ******************************************** Record 2 ********************************************
	{0,                                             //unsigned6 dl_seq
	 999999000012,									//unsigned6	did
	 0,												//unsigned6	Preglb_did
	 199201,										//unsigned3	dt_first_seen
	 199902,										//unsigned3	dt_last_seen
	 200101,										//unsigned3	dt_vendor_first_reported
	 0,												//unsigned3	dt_vendor_last_reported
	 '',                                            //string14  DLCP_Key
	 'MI',											//string2	orig_state
	 'AD',											//string2	source_code
	 '',											//string1	history
	 'AARDVARK JOAN',								//qstring52	name
	 '',                                            //string1   addr_type
	 '20 N SOUTH ST APT 108',						//qstring40	addr1
	 'YPSILANTI',									//qstring20	city
	 'MI',											//qstring2	state
	 '48197',										//qstring5	zip
	 '',                                            //string2   province
	 '',                                            //string3   country
	 '',                                            //string10  postal_code
	 19630215,										//unsigned4	dob
	 '',											//string1	race
	 'F',											//string1	sex_flag
	 '',											//string2	license_class
	 'D',											//qstring4	license_type
	 '',											//qstring14	attention_flag
	 '',											//qstring8	dod
	 '',											//qstring42	restrictions
	 '',											//qstring42	restrictions_delimited
	 0,												//unsigned4	orig_expiration_date
	 0,												//unsigned4	orig_issue_date
	 0,												//unsigned4	lic_issue_date
	 0,												//unsigned4	expiration_date
	 0,												//unsigned3	active_date
	 0,												//unsigned3	inactive_date
	 '',											//qstring10	lic_endorsement
	 '',											//qstring4	motorcycle_code
	 'D0012',										//qstring14	dl_number
	 '351762209',									//qstring9	ssn
	 '351762209',									//qstring9	ssn_safe
	 '',											//qstring3	age
	 '',											//string1	privacy_flag
	 '',											//string1	driver_edu_code
	 '',											//string1	dup_lic_count
	 '',											//string1	rcd_stat_flag
	 '',											//qstring3	height
	 '',											//qstring3	hair_color
	 '',											//qstring3	eye_color
	 '',											//qstring3	weight
	 '',											//qstring25	oos_previous_dl_number
	 '',											//string2	oos_previous_st
	 '',											//qstring5	title
	 'JOAN',										//qstring20	fname
	 '',											//qstring20	mname
	 'AARDVARK',									//qstring20	lname
	 '',											//qstring5	name_suffix
	 '91',											//qstring3	cleaning_score
	 '',											//string1	addr_fix_flag
	 '20',											//qstring10	prim_range
	 'N',											//qstring2	predir
	 'SOUTH',										//qstring28	prim_name
	 'ST',											//qstring4	suffix
	 '',											//qstring2	postdir
	 'APT',											//qstring10	unit_desig
	 '108',											//qstring8	sec_range
	 'YPSILANTI',									//qstring25	p_city_name
	 'YPSILANTI',									//qstring25	v_city_name
	 'MI',											//qstring2	st
	 '48197',										//qstring5	zip5
	 '',											//qstring4	zip4
	 '',											//qstring4	cart
	 '',											//string1	cr_sort_sz
	 '',											//qstring4	lot
	 '',											//string1	lot_order
	 '',											//string2	dpbc
	 '',											//string1	chk_digit
	 'S',											//string2	rec_type
	 '26',											//string2	ace_fips_st
	 '161',											//qstring3	county
	 '42.584598',									//qstring10	geo_lat
	 '-84.806365',									//qstring11	geo_long
	 '4040',										//qstring4	msa
	 '210004',										//qstring7	geo_blk
	 '1',											//string1	geo_match
	 'S810',										//qstring4	err_stat
	 '',											//string1	status
	 '',											//qstring2	issuance
	 '',											//qstring8	address_change
	 '',											//string1	name_change
	 '',											//string1	dob_change
	 '',											//string1	sex_change
	 '',											//qstring14	old_dl_number
	 '',											//qstring9	dl_key_number
	 ''                                             //string3   CDL_status
	},
	// ******************************************** Record 3 ********************************************
	{0,                                             //unsigned6 dl_seq
	 999999001001,									//unsigned6	did
	 0,												//unsigned6	Preglb_did
	 199909,										//unsigned3	dt_first_seen
	 0,												//unsigned3	dt_last_seen
	 200101,										//unsigned3	dt_vendor_first_reported
	 0,												//unsigned3	dt_vendor_last_reported
	 '',                                            //string14  DLCP_Key
	 'MI',											//string2	orig_state
	 'AD',											//string2	source_code
	 '',											//string1	history
	 'MARSUPIAL MARK',								//qstring52	name
	 '',                                            //string1   addr_type
	 '401 NORTH LAZY ROAD',							//qstring40	addr1
	 'ANN ARBOR',									//qstring20	city
	 'MI',											//qstring2	state
	 '48104',										//qstring5	zip
	 '',                                            //string2   province
	 '',                                            //string3   country
	 '',                                            //string10  postal_code
	 19750415,										//unsigned4	dob
	 '',											//string1	race
	 'M',											//string1	sex_flag
	 '',											//string2	license_class
	 'D',											//qstring4	license_type
	 '',											//qstring14	attention_flag
	 '',											//qstring8	dod
	 '',											//qstring42	restrictions
	 '',											//qstring42	restrictions_delimited
	 0,												//unsigned4	orig_expiration_date
	 0,												//unsigned4	orig_issue_date
	 0,												//unsigned4	lic_issue_date
	 0,												//unsigned4	expiration_date
	 0,												//unsigned3	active_date
	 0,												//unsigned3	inactive_date
	 '',											//qstring10	lic_endorsement
	 '',											//qstring4	motorcycle_code
	 'D1001',										//qstring14	dl_number
	 '351762213',									//qstring9	ssn
	 '351762213',									//qstring9	ssn_safe
	 '',											//qstring3	age
	 '',											//string1	privacy_flag
	 '',											//string1	driver_edu_code
	 '',											//string1	dup_lic_count
	 '',											//string1	rcd_stat_flag
	 '',											//qstring3	height
	 '',											//qstring3	hair_color
	 '',											//qstring3	eye_color
	 '',											//qstring3	weight
	 '',											//qstring25	oos_previous_dl_number
	 '',											//string2	oos_previous_st
	 'MR',											//qstring5	title
	 'MARK',										//qstring20	fname
	 '',											//qstring20	mname
	 'MARSUPIAL',									//qstring20	lname
	 '',											//qstring5	name_suffix
	 '91',											//qstring3	cleaning_score
	 '',											//string1	addr_fix_flag
	 '401',											//qstring10	prim_range
	 'N',											//qstring2	predir
	 'LAZY DRIVE',									//qstring28	prim_name
	 'RD',											//qstring4	suffix
	 '',											//qstring2	postdir
	 '',											//qstring10	unit_desig
	 '',											//qstring8	sec_range
	 'ANN ARBOR',									//qstring25	p_city_name
	 'ANN ARBOR',									//qstring25	v_city_name
	 'MI',											//qstring2	st
	 '48104',										//qstring5	zip5
	 '',											//qstring4	zip4
	 '',											//qstring4	cart
	 '',											//string1	cr_sort_sz
	 '',											//qstring4	lot
	 '',											//string1	lot_order
	 '',											//string2	dpbc
	 '',											//string1	chk_digit
	 'S',											//string2	rec_type
	 '26',											//string2	ace_fips_st
	 '161',											//qstring3	county
	 '42.584598',									//qstring10	geo_lat
	 '-84.806365',									//qstring11	geo_long
	 '4040',										//qstring4	msa
	 '210004',										//qstring7	geo_blk
	 '1',											//string1	geo_match
	 'S810',										//qstring4	err_stat
	 '',											//string1	status
	 '',											//qstring2	issuance
	 '',											//qstring8	address_change
	 '',											//string1	name_change
	 '',											//string1	dob_change
	 '',											//string1	sex_change
	 '',											//qstring14	old_dl_number
	 '',											//qstring9	dl_key_number
	 ''                                             //string3   CDL_status	 
	}
  ],
  DriversV2.Layout_DL
  )
 ;

DriversV2.Layout_DL_Extended	tFixDummyDates(dInlineDummyData_Input pInput)
 :=
  transform
	self.dt_first_seen						:=	if(pInput.dt_first_seen = 0,			(unsigned3)((string6)Driversv2.version_Development[1..6]),pInput.dt_first_seen);
	self.dt_last_seen							:=	if(pInput.dt_last_seen = 0,				(unsigned3)((string6)Driversv2.version_Development[1..6]),pInput.dt_last_seen);
	self.dt_vendor_first_reported	:=	if(pInput.dt_vendor_first_reported = 0,	(unsigned3)((string6)Driversv2.version_Development[1..6]),pInput.dt_vendor_first_reported);
	self.dt_vendor_last_reported	:=	if(pInput.dt_vendor_last_reported = 0,	(unsigned3)((string6)Driversv2.version_Development[1..6]),pInput.dt_vendor_last_reported);
	self.OrigLicenseClass					:=	pInput.License_class;
	self.OrigLicenseType					:=	pInput.License_Type;
	self													:=	pInput;	
  end
 ;

export File_Dummy_Data := project(dInlineDummyData_Input,tFixDummyDates(left));
