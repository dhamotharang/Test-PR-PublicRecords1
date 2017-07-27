import VehLic_VISF, VehicleCodes, Lib_StringLib, Address;

string8	fFixDate(string10 pDateIn)
 :=	if(Lib_StringLib.StringLib.StringFilter(pDateIn,'/') = '//',
	   intformat((unsigned4)regexfind('([0-9]+)/([0-9]+)/([0-9]+)',pDateIn,3),4,1)
	 + intformat((unsigned4)regexfind('([0-9]+)/([0-9]+)/([0-9]+)',pDateIn,1),2,1)
	 + intformat((unsigned4)regexfind('([0-9]+)/([0-9]+)/([0-9]+)',pDateIn,2),2,1),
	   ''
	  );

string10	fFixZip(string5 pZip5, string4 pZip4)
 :=	pZip5 + if((integer4)pZip4 <> 0,
			   '-' + pZip4,
			   ''
			  );

string3 fColorCodeFromString(string pColorString)
 :=	case(trim(pColorString),
		 'UNKNOWN'								=>	'UNK',
		 'OTHER'								=>	'OTH',
		 'WHITE'								=>	'WHI',
		 'RED'									=>	'RED',
		 'BLUE'									=>	'BLU',
		 'BLACK'								=>	'BLK',
		 'GREEN'								=>	'GRN',
		 'GRAY'									=>	'GRY',
		 'YELLOW'								=>	'YEL',
		 'SILVER, ALUMINUM, STAINLESS STEEL'	=>	'SIL',
		 'BROWN'								=>	'BRO',
		 'TAN'									=>	'TAN',
		 'BURGUNDY OR MAROON'					=>	'MAR',
		 'BEIGE'								=>	'BGE',
		 'ROSE'									=>	'RSE',
		 'GOLD'									=>	'GLD',
		 'PURPLE OR PLUM'						=>	'PLE',
		 'LAVENDAR'								=>	'LAV',
		 'TURQOISE'								=>	'TRQ',
		 'ORANGE'								=>	'ONG',
		 'CREAM OR IVORY'						=>	'CRM',
		 'MULTI-COLOR'							=>	'MUL',
		 'BRONZE'								=>	'BRZ',
		 'PINK'									=>	'PNK',
		 'AQUAMARINE'							=>	'AQM',
		 'IVORY'								=>	'CRM',
		 'COPPER'								=>	'CPR',
		 'CORAL'								=>	'CRL',
		 'CAMOUFLAGE'							=>	'CAM',
		 ''
		);

string4 fVehicleTypeFromString(string pVehicleTypeString)
 :=	case(trim(pVehicleTypeString),
		 'PASSENGER CAR/LIGHT TRUCK'	=>	'PASS',
		 'UNKNOWN'						=>	'UNK ',
		 'TRAILER'						=>	'TRLR',
		 'HEAVY TRUCK'					=>	'HTRK',
		 'MOTORCYCLE'					=>	'MOTO',
		 'RECREATIONAL VEHICLE'			=>	'RV  ',
		 'ATV'							=>	'ATV ',
		 'AGRICULTURE'					=>	'AGRI',
		 'OFF-ROAD/CONSTRUCTION'		=>	'CNST',
		 'BOAT/WATERCRAFT'				=>	'WATR',
		 ''
		);

string2 fOrigStateFromFileNo(string pFileNo)
 := case((integer)pFileNo,
 		 01	=>	'CT',
		 02	=>	'CT',
		 03	=>	'CT',
		 04	=>	'CT',
		 05	=>	'CT',
		 06	=>	'MD',
		 07	=>	'MD',
		 08	=>	'MD',
		 09	=>	'MD',
		 10	=>	'MD',
		 11	=>	'MD',
		 12	=>	'MD',
		 13	=>	'MD',
		 14	=>	'MD',
		 15	=>	'MD',
		 16	=>	'CT',
		 17	=>	'OR',
		 18	=>	'OK',
		 19	=>	'OK',
		 20	=>	'OK',
		 21	=>	'OK',
		 22	=>	'OK',
		 23	=>	'OK',
		 24	=>	'OK',
		 25	=>	'OK',
		 26	=>	'OK',
		 27	=>	'AL',
		 28	=>	'AL',
		 29	=>	'AL',
		 30	=>	'AL',
		 31	=>	'AL',
		 32	=>	'AL',
		 33	=>	'AL',
		 34	=>	'AL',
		 35	=>	'AL',
		 36	=>	'AL',
		 37	=>	'AL',
		 38	=>	'SC',
		 39	=>	'SC',
		 40	=>	'SC',
		 41	=>	'SC',
		 42	=>	'SC',
		 43	=>	'SC',
		 44	=>	'SC',
		 45	=>	'SC',
		 46	=>	'DE',
		 47	=>	'DE',
		 48	=>	'OR',
		 49	=>	'OR',
		 50	=>	'OR',
		 51	=>	'OR',
		 52	=>	'OR',
		 53	=>	'SC',
		 54	=>	'SC',
		 55	=>	'SC',
		 56	=>	'SC',
		 57	=>	'MD',
		 58 =>	'OR',
		 ''
		);

string8 fProcessDateByState(string pState)
 := case(pState,
		 'AL'	=> '20020301',
		 'CT'	=> '20010710',
		 'DE'	=> '20001213',
		 'MD'	=> '20000504',
		 'OK'	=> '20011119',
		 'OR'	=> '19970820',
		 'SC'	=> '20011220',
		 ''
		);

unsigned3 fEarliestDateSeenByState(string pState)
 :=	case(pState,
		 'AL'	=> 199509,
		 'CT'	=> 199601,
		 'DE'	=> 199601,
		 'MD'	=> 199512,
		 'OK'	=> 199301,
		 'OR'	=> 199601,
		 'SC'	=> 199301,
		 0
		);

unsigned3 fBestSeenDate(string2 pState, string8 pRegDate, string8 pTitleDate)
 :=
  function
	unsigned3	lRegDate		:=	(unsigned8)pRegDate div 100;
	unsigned3	lTitleDate		:=	(unsigned8)pTitleDate div 100;
	unsigned3	lProcessDate	:=	(unsigned8)fProcessDateByState(pState);
	unsigned3	lEariestDateSeen:=	fEarliestDateSeenByState(pState);
	unsigned3	lReturnValue	:=	if(lRegDate <= lProcessDate and lRegDate >= lEariestDateSeen,
									   lRegDate,
									   if(lTitleDate <= lProcessDate and lTitleDate >= lEariestDateSeen,
										  lTitleDate,
										  0
										 )
									  );
	return lReturnValue;
  end
 ;
		
string3 fPlateTypeCodeFromString(string pPlateTypeString)
 :=	case(trim(pPlateTypeString),
		 'AGRICULTURE'					=>	'AGR',
		 'ANTIQUE'						=>	'ANT',
		 'COMMERCIAL'					=>	'COM',
		 'DEALER'						=>	'DLR',
		 'DISABLED VETERAN'				=>	'DV ',
		 'EDUCATIONAL AFFILIATION'		=>	'EDU',
		 'EMERGENCY'					=>	'EME',
		 'ENVIRONMENTAL'				=>	'ENV',
		 'EXEMPT'						=>	'EXE',
		 'FEDERAL GOVERNMENT'			=>	'FGV',
		 'FUNERAL'						=>	'FUN',
		 'AMATEUR RADIO'				=>	'HAM',
		 'HANDICAPPED'					=>	'HAN',
		 'MILITARY HONOR'				=>	'HON',
		 'LOCAL GOVERNMENT'				=>	'LGV',
		 'LIVERY'						=>	'LIV',
		 'MILITARY'						=>	'MIL',
		 'MOTORCYCLE'					=>	'MOT',
		 'OTHER'						=>	'OTH',
		 'PRIVATE'						=>	'PRI',
		 'RECREATIONAL VEHICLE'			=>	'REC',
		 'OFFICIAL REPRESENTATIVE'		=>	'REP',
		 'SCHOOL BUS'					=>	'SCH',
		 'STATE GOVERNMENT'				=>	'SGV',
		 'TAXI'							=>	'TAX',
		 'TRAILER'						=>	'TRL',
		 'VANITY'						=>	'VAN',
		 ''								=>	'   ',
		 ''
		);

string3 fMajorColorFromColor(string pColor)
 :=	fColorCodeFromString(if(Lib_StringLib.StringLib.stringfind(pColor,'/',1) <> 0,
							regexfind('^([^/]*)/(.*)$',pColor,1),
							pColor
						   )
						);

string3 fMinorColorFromColor(string pColor)
 :=	fColorCodeFromString(if(lib_stringlib.StringLib.stringfind(pColor,'/',1) <> 0,
							regexfind('^([^/]*)/(.*)$',pColor,2),
							''
						   )
						);

dNameDist				:=	distribute(Vehlic_VISF.File_Main_Name,hash(file_no,seq_no));
dNameSort				:=	sort(dNameDist,file_no,seq_no,name_type,local);
dAddressDist			:=	distribute(Vehlic_VISF.File_Main_Address,hash(file_no,seq_no));
dAddressSort			:=	sort(dAddressDist,file_no,seq_no,addr_type,local);
dOrigDist				:=	distribute(VehLic_VISF.File_Main_Orig,hash(file_no,seq_no));
dOrigSort				:=	sort(dOrigDist,file_no,seq_no,local);

rNameAddressJoined
 :=
  record
	string2		FILE_NO;
	string10	SEQ_NO;                               
	string20	NAME_TYPE;
	string170	ORIG_NAME;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string3		name_score;
	string170	CNAME;
	string20	ADDR_TYPE;
	string150	ADDRESS1_LINE1;
	string150	ADDRESS1_LINE2;
	string150	COUNTY;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		st;
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
  end
 ;

rNameAddressJoined	tJoinNameAddress(dNameSort pName, dAddressSort pAddress)
 :=
  transform
	self.FILE_NO			:=	pName.FILE_NO;
	self.SEQ_NO				:=	pName.SEQ_NO;
	self.NAME_TYPE			:=	pName.NAME_TYPE;
	self.ORIG_NAME			:=	pName.ORIG_NAME;
	self.title				:=	pName.title;
	self.fname				:=	pName.fname;
	self.mname				:=	pName.mname;
	self.lname				:=	pName.lname;
	self.name_suffix		:=	pName.name_suffix;
	self.name_score			:=	pName.name_score;
	self.CNAME				:=	pName.CNAME;
	self.ADDR_TYPE			:=	pAddress.ADDR_TYPE;
	self.ADDRESS1_LINE1		:=	pAddress.ADDRESS1_LINE1;
	self.ADDRESS1_LINE2		:=	pAddress.ADDRESS1_LINE2;
	self.COUNTY				:=	pAddress.COUNTY;
	self.prim_range			:=	pAddress.prim_range;
	self.predir				:=	pAddress.predir;
	self.prim_name			:=	pAddress.prim_name;
	self.suffix				:=	pAddress.suffix;
	self.postdir			:=	pAddress.postdir;
	self.unit_desig			:=	pAddress.unit_desig;
	self.sec_range			:=	pAddress.sec_range;
	self.p_city_name		:=	pAddress.p_city_name;
	self.v_city_name		:=	pAddress.v_city_name;
	self.st					:=	pAddress.st;
	self.zip5				:=	pAddress.zip5;
	self.zip4				:=	pAddress.zip4;
	self.cart				:=	pAddress.cart;
	self.cr_sort_sz			:=	pAddress.cr_sort_sz;
	self.lot				:=	pAddress.lot;
	self.lot_order			:=	pAddress.lot_order;
	self.dpbc				:=	pAddress.dpbc;
	self.chk_digit			:=	pAddress.chk_digit;
	self.rec_type			:=	pAddress.rec_type;
	self.ace_fips_st		:=	pAddress.ace_fips_st;
	self.ace_fips_county	:=	pAddress.ace_fips_county;
	self.geo_lat			:=	pAddress.geo_lat;
	self.geo_long			:=	pAddress.geo_long;
	self.msa				:=	pAddress.msa;
	self.geo_blk			:=	pAddress.geo_blk;
	self.geo_match			:=	pAddress.geo_match;
	self.err_stat			:=	pAddress.err_stat;
  end
 ;

dNameAddressJoined	:=	join(dNameSort,dAddressSort,
							 left.FILE_NO	= right.FILE_NO
						 and left.SEQ_NO	= right.SEQ_NO
						 and left.NAME_TYPE	= right.ADDR_TYPE,
							 tJoinNameAddress(left,right),
							 left outer,
							 local
							);

rTempLayoutVehicles
 :=
  record
	VehLic.Layout_Vehicles;
	string2		temp_FILE_NO;
	string10	temp_SEQ_NO;
  end
 ;

rTempLayoutVehicles tNonUpdatingAsVehicles(dOrigSort pInput)
 :=
  transform
	string2		lOrigState			:=	fOrigStateFromFileNo(pInput.FILE_NO);
	unsigned8	lProcessDate		:=	(unsigned8)(fProcessDateByState(lOrigState));
	self.temp_FILE_NO				:=	pInput.FILE_NO;
	self.temp_SEQ_NO				:=	pInput.SEQ_NO;
	self.orig_state					:=	lOrigState;
	self.source_code				:=	'AE';
	self.dt_first_seen				:=	fBestSeenDate(lOrigState,fFixDate(pInput.REGISTRATION_DATE),fFixDate(pInput.TITLE_TRANS_DATE));
	self.dt_last_seen				:=	fBestSeenDate(lOrigState,fFixDate(pInput.REGISTRATION_DATE),fFixDate(pInput.TITLE_TRANS_DATE));
	self.dt_vendor_first_reported	:=	(unsigned8)(lProcessDate[1..6]);
	self.dt_vendor_last_reported	:=	(unsigned8)(lProcessDate[1..6]);
	self.VEHICLE_NUMBERxBG1			:=	if(length(trim(pInput.VIN)) < 11
										or Lib_StringLib.stringlib.stringfilterout(pInput.VIN,'0') = ''
										or pInput.VIN[1..4] = 'HOME'
										or pInput.VIN[1..4] = 'HMDE',
										   trim(pInput.VIN) + trim(pInput.TITLE_NUMBER) + trim(pInput.REGISTRATION_DATE) + trim(pInput.PLATE_NUMBER),
										   pInput.VIN
										  );
	self.ORIG_VIN					:=	pInput.VIN;
	self.YEAR_MAKE					:=	if((integer2)pInput.MODEL_YEAR = 0,
										   '', // 
										   if(pInput.MODEL_YEAR > '2003',
											  '19' + pInput.MODEL_YEAR[3..4],
											  pInput.MODEL_YEAR
											 )
										  );
	self.MAKE_DESCRIPTION			:=	VehLic.proper_case(pInput.MANUFACTURER);
	self.MODEL_DESCRIPTION			:=	VehLic.proper_case(pInput.VEHICLE_SERIES);
	self.BODY_STYLE_DESCRIPTION		:=	VehicleCodes.getBodyType(pInput.BODY_STYLE);	// setting it here forces later transform to use description
	self.MAJOR_COLOR_CODE			:=	fColorCodeFromString(fMajorColorFromColor(pInput.COLOR));
	self.MINOR_COLOR_CODE			:=	fColorCodeFromString(fMinorColorFromColor(pInput.COLOR));
	self.NET_WEIGHT					:=	Lib_StringLib.StringLib.StringFilter(pInput.VEH_WEIGHT,'0123456789');
	self.LICENSE_PLATE_NUMBERxBG4	:=	pInput.PLATE_NUMBER;
	self.TRUE_LICENSE_PLSTE_NUMBER	:=	pInput.PLATE_NUMBER;
	self.LICENSE_PLATE_CODE			:=	fPlateTypeCodeFromString(pInput.PLATE_TYPE);
	self.REGISTRATION_EXPIRATION_DATE	:= fFixDate(pInput.REGIST_EXP_DATE);
	self.FIRST_REGISTRATION_DATE	:=	fFixDate(pInput.REGIST_DATE_ORIG);
	self.REGISTRATION_EFFECTIVE_DATE	:=	fFixDate(pInput.REGISTRATION_DATE);
	self.TITLE_NUMBERxBG9			:=	pInput.TITLE_NUMBER;
	self.TITLE_ISSUE_DATE			:=	fFixDate(pInput.TITLE_TRANS_DATE);
	self.PREVIOUS_TITLE_ISSUE_DATE	:=	fFixDate(pInput.TITLE_DATE_ORIG);
	self.VEHICLE_TYPE				:=	fVehicleTypeFromString(pInput.VEH_CLASS_DESC);
	self.OWN_1_DOB					:=	fFixDate(pInput.OWNER_DOB);
	self.REG_1_DOB					:=	fFixDate(pInput.REGISTRANT_DOB);
  end
 ;

dTempOrigAsVehicles		:=	project(dOrigSort,tNonUpdatingAsVehicles(left));
dTempOrigAsVehiclesDist	:=	distribute(dTempOrigAsVehicles,hash(temp_FILE_NO,temp_SEQ_NO));
dTempOrigAsVehiclesSort	:=	sort(dTempOrigAsVehiclesDist,temp_FILE_NO,temp_SEQ_NO,local);

rTempLayoutVehicles	tGetOwner(dTempOrigAsVehiclesSort pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	boolean lOwnerIsBusiness		:=	if(pNameAddress.CName <> '',
										   true,
										   false
										  );
	boolean lOwnerIsIndividual		:=	if(pNameAddress.lname <> '',
										   true,
										   false
										  );
	self.OWNER_1_CUSTOMER_TYPExBG3	:=	if(lOwnerIsBusiness,
										   'B',
										   if(lOwnerIsIndividual,
											  'I',
											  ''
											 )
										  );
	self.OWN_1_CUSTOMER_NAME		:=	pNameAddress.ORIG_NAME;
    self.OWN_1_FEID_SSN 			:=	'';
    self.OWN_1_DOB					:=	if(lOwnerIsIndividual,
										   pOrig.OWN_1_DOB,
										   ''
										  );
    self.OWN_1_STREET_ADDRESS		:=	Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	pNameAddress.PreDir,
																	pNameAddress.Prim_Name,
																	pNameAddress.Suffix,
																	pNameAddress.PostDir,
																	pNameAddress.Unit_Desig,
																	pNameAddress.Sec_Range
																   );
    self.OWN_1_CITY					:=	pNameAddress.p_city_name;
    self.OWN_1_STATE				:=	pNameAddress.st;
    self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= fFixZip(pNameAddress.Zip5,pNameAddress.Zip4);
	self.own_1_title 				:=	pNameAddress.title;
	self.own_1_fname 				:=	pNameAddress.fname;
	self.own_1_mname 				:=	pNameAddress.mname;
	self.own_1_lname 				:=	pNameAddress.lname;
	self.own_1_name_suffix 			:=	pNameAddress.name_suffix;
	self.own_1_company_name 		:=	if(lOwnerIsBusiness,
										   pNameAddress.CNAME,
										   ''
										  );
	self.own_1_prim_range 			:=	pNameAddress.prim_range;
	self.own_1_predir 				:=	pNameAddress.predir;
	self.own_1_prim_name 			:=	pNameAddress.prim_name;
	self.own_1_suffix 				:=	pNameAddress.suffix;
	self.own_1_postdir 				:=	pNameAddress.postdir;
	self.own_1_unit_desig 			:=	pNameAddress.unit_desig;
	self.own_1_sec_range 			:=	pNameAddress.sec_range;
	self.own_1_p_city_name 			:=	pNameAddress.p_city_name;
	self.own_1_v_city_name 			:=	pNameAddress.v_city_name;
	self.own_1_state_2 				:=	pNameAddress.st;
	self.own_1_zip5 				:=	pNameAddress.zip5;
	self.own_1_zip4 				:=	pNameAddress.zip4;
	self.own_1_county				:=	pNameAddress.County;
	self							:=	pOrig;
  end
 ;

dOrigPlusOwner	:=	join(dTempOrigAsVehiclesSort,dNameAddressJoined(NAME_TYPE = 'OWNER'),
						 left.temp_FILE_NO = right.FILE_NO
					 and left.temp_SEQ_NO = right.SEQ_NO,
						 tGetOwner(left,right),
						 left outer,
						 keep(1),
						 local
						);

rTempLayoutVehicles	tGetCoOwner(dOrigPlusOwner pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	boolean lCoOwnerIsBusiness		:=	if(pNameAddress.CName <> '',
										   true,
										   false
										  );
	boolean lCoOwnerIsIndividual	:=	if(pNameAddress.lname <> '',
										   true,
										   false
										  );
	self.OWNER_2_CUSTOMER_TYPE		:=	if(lCoOwnerIsBusiness,
										   'B',
										   if(lCoOwnerIsIndividual,
											  'I',
											  ''
											 )
										  );
	self.OWN_2_CUSTOMER_NAME		:=	pNameAddress.ORIG_NAME;
    self.OWN_2_FEID_SSN 			:=	'';
    self.OWN_2_DOB					:=	'';
    self.OWN_2_STREET_ADDRESS		:=	Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	pNameAddress.PreDir,
																	pNameAddress.Prim_Name,
																	pNameAddress.Suffix,
																	pNameAddress.PostDir,
																	pNameAddress.Unit_Desig,
																	pNameAddress.Sec_Range
																   );
    self.OWN_2_CITY					:=	pNameAddress.p_city_name;
    self.OWN_2_STATE				:=	pNameAddress.st;
    self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= fFixZip(pNameAddress.Zip5,pNameAddress.Zip4);
	self.own_2_title 				:=	pNameAddress.title;
	self.own_2_fname 				:=	pNameAddress.fname;
	self.own_2_mname 				:=	pNameAddress.mname;
	self.own_2_lname 				:=	pNameAddress.lname;
	self.own_2_name_suffix 			:=	pNameAddress.name_suffix;
	self.own_2_company_name 		:=	if(lCoOwnerIsBusiness,
										   pNameAddress.CNAME,
										   ''
										  );
	self.own_2_prim_range 			:=	pNameAddress.prim_range;
	self.own_2_predir 				:=	pNameAddress.predir;
	self.own_2_prim_name 			:=	pNameAddress.prim_name;
	self.own_2_suffix 				:=	pNameAddress.suffix;
	self.own_2_postdir 				:=	pNameAddress.postdir;
	self.own_2_unit_desig 			:=	pNameAddress.unit_desig;
	self.own_2_sec_range 			:=	pNameAddress.sec_range;
	self.own_2_p_city_name 			:=	pNameAddress.p_city_name;
	self.own_2_v_city_name 			:=	pNameAddress.v_city_name;
	self.own_2_state_2 				:=	pNameAddress.st;
	self.own_2_zip5 				:=	pNameAddress.zip5;
	self.own_2_zip4 				:=	pNameAddress.zip4;
	self.own_2_county				:=	pNameAddress.County;
	self							:=	pOrig;
  end
 ;

dOrigPlusCoOwner	:=	join(dOrigPlusOwner,dNameAddressJoined(NAME_TYPE = 'CO_OWNER'),
							 left.temp_FILE_NO = right.FILE_NO
						 and left.temp_SEQ_NO = right.SEQ_NO,
							 tGetCoOwner(left,right),
							 left outer,
							 keep(1),
							 local
							);

rTempLayoutVehicles	tGetRegistrant(dOrigPlusCoOwner pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	boolean lRegistrantIsBusiness	:=	if(pNameAddress.CName <> '',
										   true,
										   false
										  );
	boolean lRegistrantIsIndividual	:=	if(pNameAddress.lname <> '',
										   true,
										   false
										  );
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:=	if(lRegistrantIsBusiness,
											   'B',
											   if(lRegistrantIsIndividual,
												  'I',
												  ''
												 )
											  );
	self.REG_1_CUSTOMER_NAME		:=	pNameAddress.ORIG_NAME;
    self.REG_1_FEID_SSN 			:=	'';
    self.REG_1_DOB					:=	if(lRegistrantIsIndividual,
										   pOrig.REG_1_DOB,
										   ''
										  );
    self.REG_1_STREET_ADDRESS		:=	Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	pNameAddress.PreDir,
																	pNameAddress.Prim_Name,
																	pNameAddress.Suffix,
																	pNameAddress.PostDir,
																	pNameAddress.Unit_Desig,
																	pNameAddress.Sec_Range
																   );
    self.REG_1_CITY					:=	pNameAddress.p_city_name;
    self.REG_1_STATE				:=	pNameAddress.st;
    self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= fFixZip(pNameAddress.Zip5,pNameAddress.Zip4);
	self.reg_1_title 				:=	pNameAddress.title;
	self.reg_1_fname 				:=	pNameAddress.fname;
	self.reg_1_mname 				:=	pNameAddress.mname;
	self.reg_1_lname 				:=	pNameAddress.lname;
	self.reg_1_name_suffix 			:=	pNameAddress.name_suffix;
	self.reg_1_company_name 		:=	if(lRegistrantIsBusiness,
										   pNameAddress.CNAME,
										   ''
										  );
	self.reg_1_prim_range 			:=	pNameAddress.prim_range;
	self.reg_1_predir 				:=	pNameAddress.predir;
	self.reg_1_prim_name 			:=	pNameAddress.prim_name;
	self.reg_1_suffix 				:=	pNameAddress.suffix;
	self.reg_1_postdir 				:=	pNameAddress.postdir;
	self.reg_1_unit_desig 			:=	pNameAddress.unit_desig;
	self.reg_1_sec_range 			:=	pNameAddress.sec_range;
	self.reg_1_p_city_name 			:=	pNameAddress.p_city_name;
	self.reg_1_v_city_name 			:=	pNameAddress.v_city_name;
	self.reg_1_state_2 				:=	pNameAddress.st;
	self.reg_1_zip5 				:=	pNameAddress.zip5;
	self.reg_1_zip4 				:=	pNameAddress.zip4;
	self.reg_1_county				:=	pNameAddress.County;
	self							:=	pOrig;
  end
 ;

dOrigPlusRegistrant	:=	join(dOrigPlusCoOwner,dNameAddressJoined(NAME_TYPE = 'REGISTRANT'),
							 left.temp_FILE_NO = right.FILE_NO
						 and left.temp_SEQ_NO = right.SEQ_NO,
							 tGetRegistrant(left,right),
							 left outer,
							 keep(1),
							 local
							);

rTempLayoutVehicles	tGetCoRegistrant(dOrigPlusRegistrant pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	boolean lCoRegistrantIsBusiness	:=	if(pNameAddress.CName <> '',
										   true,
										   false
										  );
	boolean lCoRegistrantIsIndividual	:=	if(pNameAddress.lname <> '',
											   true,
											   false
											  );
	self.REGISTRANT_2_CUSTOMER_TYPE	:=	if(lCoRegistrantIsBusiness,
										   'B',
										   if(lCoRegistrantIsIndividual,
											  'I',
											  ''
											 )
										  );
	self.REG_2_CUSTOMER_NAME		:=	pNameAddress.ORIG_NAME;
    self.REG_2_FEID_SSN 			:=	'';
    self.REG_2_DOB					:=	'';
    self.REG_2_STREET_ADDRESS		:=	Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	pNameAddress.PreDir,
																	pNameAddress.Prim_Name,
																	pNameAddress.Suffix,
																	pNameAddress.PostDir,
																	pNameAddress.Unit_Desig,
																	pNameAddress.Sec_Range
																   );
    self.REG_2_CITY					:=	pNameAddress.p_city_name;
    self.REG_2_STATE				:=	pNameAddress.st;
    self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= fFixZip(pNameAddress.Zip5,pNameAddress.Zip4);
	self.reg_2_title 				:=	pNameAddress.title;
	self.reg_2_fname 				:=	pNameAddress.fname;
	self.reg_2_mname 				:=	pNameAddress.mname;
	self.reg_2_lname 				:=	pNameAddress.lname;
	self.reg_2_name_suffix 			:=	pNameAddress.name_suffix;
	self.reg_2_company_name 		:=	if(lCoRegistrantIsBusiness,
										   pNameAddress.CNAME,
										   ''
										  );
	self.reg_2_prim_range 			:=	pNameAddress.prim_range;
	self.reg_2_predir 				:=	pNameAddress.predir;
	self.reg_2_prim_name 			:=	pNameAddress.prim_name;
	self.reg_2_suffix 				:=	pNameAddress.suffix;
	self.reg_2_postdir 				:=	pNameAddress.postdir;
	self.reg_2_unit_desig 			:=	pNameAddress.unit_desig;
	self.reg_2_sec_range 			:=	pNameAddress.sec_range;
	self.reg_2_p_city_name 			:=	pNameAddress.p_city_name;
	self.reg_2_v_city_name 			:=	pNameAddress.v_city_name;
	self.reg_2_state_2 				:=	pNameAddress.st;
	self.reg_2_zip5 				:=	pNameAddress.zip5;
	self.reg_2_zip4 				:=	pNameAddress.zip4;
	self.reg_2_county				:=	pNameAddress.County;
	self							:=	pOrig;
  end
 ;

dOrigPlusCoRegistrant	:=	join(dOrigPlusRegistrant,dNameAddressJoined(NAME_TYPE = 'CO_REGISTRANT'),
								 left.temp_FILE_NO = right.FILE_NO
							 and left.temp_SEQ_NO = right.SEQ_NO,
								 tGetCoRegistrant(left,right),
								 left outer,
								 keep(1),
								 local
								);

rTempLayoutVehicles	tGetLessor(dOrigPlusCoRegistrant pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	boolean	lOwner1AlreadyFilled	:=	if(pOrig.OWNER_1_CUSTOMER_TYPExBG3 <> '',
										   true,
										   false
										  );
	boolean lOwnerIsBusiness		:=	if(pNameAddress.CName <> '',
										   true,
										   false
										  );
	boolean lOwnerIsIndividual		:=	if(pNameAddress.lname <> '',
										   true,
										   false
										  );
	self.OWNER_1_CUSTOMER_TYPExBG3	:=	if(lOwner1AlreadyFilled,
										   pOrig.OWNER_1_CUSTOMER_TYPExBG3,
										   if(lOwnerIsBusiness,
											  'B',
											  if(lOwnerIsIndividual,
												 'I',
												 ''
												)
											 )
										  );
	self.OWN_1_CUSTOMER_NAME		:=	if(lOwner1AlreadyFilled,
										   pOrig.OWN_1_CUSTOMER_NAME,
										   pNameAddress.ORIG_NAME
										  );
    self.OWN_1_FEID_SSN 			:=	'';
    self.OWN_1_DOB					:=	if(lOwner1AlreadyFilled,
										   pOrig.OWN_1_DOB,
										   if(lOwnerIsIndividual,
											  pOrig.OWN_1_DOB,
											  ''
											 )
										  );
    self.OWN_1_STREET_ADDRESS		:=	if(lOwner1AlreadyFilled,
										   pOrig.OWN_1_STREET_ADDRESS,
										   Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	   pNameAddress.PreDir,
																	   pNameAddress.Prim_Name,
																	   pNameAddress.Suffix,
																	   pNameAddress.PostDir,
																	   pNameAddress.Unit_Desig,
																	   pNameAddress.Sec_Range
																	  )
										  );
    self.OWN_1_CITY					:=	if(lOwner1AlreadyFilled,
										   pOrig.OWN_1_CITY,
										   pNameAddress.p_city_name
										  );
    self.OWN_1_STATE				:=	if(lOwner1AlreadyFilled,
										   pOrig.OWN_1_STATE,
										   pNameAddress.st
										  );
    self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(lOwner1AlreadyFilled,
											  pOrig.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,
											  fFixZip(pNameAddress.Zip5,pNameAddress.Zip4)
											 );
	self.own_1_title 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_title,
										   pNameAddress.title
										  );
	self.own_1_fname 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_fname,
										   pNameAddress.fname
										  );
	self.own_1_mname 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_mname,
										   pNameAddress.mname
										  );
	self.own_1_lname 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_lname,
										   pNameAddress.lname
										  );
	self.own_1_name_suffix 			:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_name_suffix,
										   pNameAddress.name_suffix
										  );
	self.own_1_company_name 		:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_company_name,
										   if(lOwnerIsBusiness,
											  pNameAddress.CNAME,
											  ''
											 )
										  );
	self.own_1_prim_range 			:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_prim_range,
										   pNameAddress.prim_range
										  );
	self.own_1_predir 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_predir,
										   pNameAddress.predir
										  );
	self.own_1_prim_name 			:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_prim_name,
										   pNameAddress.prim_name
										  );
	self.own_1_suffix 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_suffix,
										   pNameAddress.suffix
										  );
	self.own_1_postdir 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_postdir,
										   pNameAddress.postdir
										  );
	self.own_1_unit_desig 			:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_unit_desig,
										   pNameAddress.unit_desig
										  );
	self.own_1_sec_range 			:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_sec_range,
										   pNameAddress.sec_range
										  );
	self.own_1_p_city_name 			:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_p_city_name,
										   pNameAddress.p_city_name
										  );
	self.own_1_v_city_name 			:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_v_city_name,
										   pNameAddress.v_city_name
										  );
	self.own_1_state_2 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_state_2,
										   pNameAddress.st
										  );
	self.own_1_zip5 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_zip5,
										   pNameAddress.zip5
										  );
	self.own_1_zip4 				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_zip4,
										   pNameAddress.zip4
										  );
	self.own_1_county				:=	if(lOwner1AlreadyFilled,
										   pOrig.own_1_county,
										   pNameAddress.County
										  );
	self							:=	pOrig;
  end
 ;

dOrigPlusLessor	:=	join(dOrigPlusCoRegistrant,dNameAddressJoined(NAME_TYPE = 'LESSOR'),
						 left.temp_FILE_NO = right.FILE_NO
					 and left.temp_SEQ_NO = right.SEQ_NO,
						 tGetLessor(left,right),
						 left outer,
						 keep(1),
						 local
						);

rTempLayoutVehicles	tGetLessee(dOrigPlusLessor pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	boolean	lRegistrant1AlreadyFilled	:=	if(pOrig.REGISTRANT_1_CUSTOMER_TYPExBG5 <> '',
											   true,
											   false
											  );
	boolean lRegistrantIsBusiness	:=	if(pNameAddress.CName <> '',
										   true,
										   false
										  );
	boolean lRegistrantIsIndividual	:=	if(pNameAddress.lname <> '',
										   true,
										   false
										  );
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:=	if(lRegistrant1AlreadyFilled,
											   pOrig.REGISTRANT_1_CUSTOMER_TYPExBG5,
											   if(lRegistrantIsBusiness,
												  'B',
												  if(lRegistrantIsIndividual,
													 'I',
													 ''
													)
												 )
											  );
	self.REG_1_CUSTOMER_NAME		:=	if(lRegistrant1AlreadyFilled,
										   pOrig.REG_1_CUSTOMER_NAME,
										   pNameAddress.ORIG_NAME
										  );
    self.REG_1_FEID_SSN 			:=	'';
    self.REG_1_DOB					:=	if(lRegistrant1AlreadyFilled,
										   pOrig.REG_1_DOB,
										   ''
										  );
    self.REG_1_STREET_ADDRESS		:=	if(lRegistrant1AlreadyFilled,
										   pOrig.REG_1_STREET_ADDRESS,
										   Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	   pNameAddress.PreDir,
																	   pNameAddress.Prim_Name,
																	   pNameAddress.Suffix,
																	   pNameAddress.PostDir,
																	   pNameAddress.Unit_Desig,
																	   pNameAddress.Sec_Range
																     )
										  );
    self.REG_1_CITY					:=	if(lRegistrant1AlreadyFilled,
										   pOrig.REG_1_CITY,
										   pNameAddress.p_city_name
										  );
    self.REG_1_STATE				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.REG_1_STATE,
										   pNameAddress.st
										  );
    self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(lRegistrant1AlreadyFilled,
											  pOrig.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,
											  fFixZip(pNameAddress.Zip5,pNameAddress.Zip4)
											 );
	self.reg_1_title 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_title,
										   pNameAddress.title
										  );
	self.reg_1_fname 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_fname,
										   pNameAddress.fname
										  );
	self.reg_1_mname 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_mname,
										   pNameAddress.mname
										  );
	self.reg_1_lname 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_lname,
										   pNameAddress.lname
										  );
	self.reg_1_name_suffix 			:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_name_suffix,
										   pNameAddress.name_suffix
										  );
	self.reg_1_company_name 		:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_company_name,
										   if(lRegistrantIsBusiness,
											  pNameAddress.CNAME,
											  ''
											 )
										  );
	self.reg_1_prim_range 			:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_prim_range,
										   pNameAddress.prim_range
										  );
	self.reg_1_predir 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_predir,
										   pNameAddress.predir
										  );
	self.reg_1_prim_name 			:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_prim_name,
										   pNameAddress.prim_name
										  );
	self.reg_1_suffix 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_suffix,
										   pNameAddress.suffix
										  );
	self.reg_1_postdir 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_postdir,
										   pNameAddress.postdir
										  );
	self.reg_1_unit_desig 			:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_unit_desig,
										   pNameAddress.unit_desig
										  );
	self.reg_1_sec_range 			:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_sec_range,
										   pNameAddress.sec_range
										  );
	self.reg_1_p_city_name 			:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_p_city_name,
										   pNameAddress.p_city_name
										  );
	self.reg_1_v_city_name 			:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_v_city_name,
										   pNameAddress.v_city_name
										  );
	self.reg_1_state_2 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_state_2,
										   pNameAddress.st
										  );
	self.reg_1_zip5 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_zip5,
										   pNameAddress.zip5
										  );
	self.reg_1_zip4 				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_zip4,
										   pNameAddress.zip4
										  );
	self.reg_1_county				:=	if(lRegistrant1AlreadyFilled,
										   pOrig.reg_1_county,
										   pNameAddress.County
										  );
	self							:=	pOrig;
  end
 ;

dOrigPlusLessee	:=	join(dOrigPlusLessor,dNameAddressJoined(NAME_TYPE = 'LESSEE'),
						 left.temp_FILE_NO = right.FILE_NO
					 and left.temp_SEQ_NO = right.SEQ_NO,
						 tGetLessee(left,right),
						 left outer,
						 keep(1),
						 local
						);

rTempLayoutVehicles	tGetCoLessee(dOrigPlusLessee pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	boolean	lRegistrant2AlreadyFilled	:=	if(pOrig.REGISTRANT_2_CUSTOMER_TYPE <> '',
											   true,
											   false
											  );
	boolean lRegistrantIsBusiness	:=	if(pNameAddress.CName <> '',
										   true,
										   false
										  );
	boolean lRegistrantIsIndividual	:=	if(pNameAddress.lname <> '',
										   true,
										   false
										  );
	self.REGISTRANT_2_CUSTOMER_TYPE	:=	if(lRegistrant2AlreadyFilled,
										   pOrig.REGISTRANT_2_CUSTOMER_TYPE,
										   if(lRegistrantIsBusiness,
											  'B',
											  if(lRegistrantIsIndividual,
												 'I',
												 ''
												)
											 )
										  );
	self.REG_2_CUSTOMER_NAME		:=	if(lRegistrant2AlreadyFilled,
										   pOrig.REG_1_CUSTOMER_NAME,
										   pNameAddress.ORIG_NAME
										  );
    self.REG_2_FEID_SSN 			:=	'';
    self.REG_2_DOB					:=	if(lRegistrant2AlreadyFilled,
										   pOrig.REG_2_DOB,
										   ''
										  );
    self.REG_2_STREET_ADDRESS		:=	if(lRegistrant2AlreadyFilled,
										   pOrig.REG_2_STREET_ADDRESS,
										   Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	   pNameAddress.PreDir,
																	   pNameAddress.Prim_Name,
																	   pNameAddress.Suffix,
																	   pNameAddress.PostDir,
																	   pNameAddress.Unit_Desig,
																	   pNameAddress.Sec_Range
																     )
										  );
    self.REG_2_CITY					:=	if(lRegistrant2AlreadyFilled,
										   pOrig.REG_2_CITY,
										   pNameAddress.p_city_name
										  );
    self.REG_2_STATE				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.REG_2_STATE,
										   pNameAddress.st
										  );
    self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(lRegistrant2AlreadyFilled,
											  pOrig.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL,
											  fFixZip(pNameAddress.Zip5,pNameAddress.Zip4)
											 );
	self.reg_2_title 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_title,
										   pNameAddress.title
										  );
	self.reg_2_fname 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_fname,
										   pNameAddress.fname
										  );
	self.reg_2_mname 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_mname,
										   pNameAddress.mname
										  );
	self.reg_2_lname 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_lname,
										   pNameAddress.lname
										  );
	self.reg_2_name_suffix 			:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_name_suffix,
										   pNameAddress.name_suffix
										  );
	self.reg_2_company_name 		:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_company_name,
										   if(lRegistrantIsBusiness,
											  pNameAddress.CNAME,
											  ''
											 )
										  );
	self.reg_2_prim_range 			:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_prim_range,
										   pNameAddress.prim_range
										  );
	self.reg_2_predir 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_predir,
										   pNameAddress.predir
										  );
	self.reg_2_prim_name 			:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_prim_name,
										   pNameAddress.prim_name
										  );
	self.reg_2_suffix 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_suffix,
										   pNameAddress.suffix
										  );
	self.reg_2_postdir 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_postdir,
										   pNameAddress.postdir
										  );
	self.reg_2_unit_desig 			:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_unit_desig,
										   pNameAddress.unit_desig
										  );
	self.reg_2_sec_range 			:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_sec_range,
										   pNameAddress.sec_range
										  );
	self.reg_2_p_city_name 			:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_p_city_name,
										   pNameAddress.p_city_name
										  );
	self.reg_2_v_city_name 			:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_v_city_name,
										   pNameAddress.v_city_name
										  );
	self.reg_2_state_2 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_state_2,
										   pNameAddress.st
										  );
	self.reg_2_zip5 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_zip5,
										   pNameAddress.zip5
										  );
	self.reg_2_zip4 				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_zip4,
										   pNameAddress.zip4
										  );
	self.reg_2_county				:=	if(lRegistrant2AlreadyFilled,
										   pOrig.reg_2_county,
										   pNameAddress.County
										  );
	self							:=	pOrig;
  end
 ;

dOrigPlusCoLessee	:=	join(dOrigPlusLessee,dNameAddressJoined(NAME_TYPE = 'CO_LESSEE'),
							 left.temp_FILE_NO = right.FILE_NO
						 and left.temp_SEQ_NO = right.SEQ_NO,
							 tGetLessee(left,right),
							 left outer,
							 keep(1),
							 local
							);

rTempLayoutVehicles	tGetLienholder(dOrigPlusCoLessee pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	self.LEIN_HOLDER_1_CUSTOMER_TYPE	:=	if(pNameAddress.cname<>'','B','I');
	self.LH_1_CUSTOMER_NUMBER 			:=	'';
    self.LH_1_FEID_SSN					:=	'';
	self.LH_1_CUSTOMER_NAME				:= 	if(pNameAddress.cname<>'',
											   pNameAddress.CNAME,
											   pNameAddress.ORIG_NAME
											  );
	self.LH_1_DEALER_LICENSE_NUMBER		:=	'';
	self.LH_1_DRIVER_LICENSE_NUMBER		:=	'';
	self.LH_1_DOB						:= 	'';
	self.LH_1_SEX						:=	'';
	self.LH_1_SEXUAL_PREDATOR_FLAG		:=	'';
	self.LH_1_MAIL_SUPPESSION_FLAG		:=	'';
	self.LH_1_ADDR_NON_DISCLOSURE_FLAG 	:= 	'';
	self.LH_1_LAW_ENFORCEMENT_FLAG		:=	'';
	self.LH_1_ADDRESS_NUMBER 			:=	'';
	self.LH_1_FOREIGN_ADDRESS_FLAG		:=	'';
	self.LH_1_STREET_ADDRESS			:=	Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	    pNameAddress.PreDir,
																	    pNameAddress.Prim_Name,
																	    pNameAddress.Suffix,
																	    pNameAddress.PostDir,
																	    pNameAddress.Unit_Desig,
																	    pNameAddress.Sec_Range
																      );
	self.LH_1_APARTMENT_NUMBER			:=	'';
	self.LH_1_CITY						:=	pNameAddress.p_city_name;
	self.LH_1_STATE						:=	pNameAddress.st;
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	pNameAddress.zip5 + if(pNameAddress.Zip4 <> '',
																   '-' + pNameAddress.Zip4,
																   ''
																  );
	self.LH_1_RESIDENCE_COUNTY			:=	'';
	self							:=	pOrig;
  end
 ;

dOrigPlusLienholder	:=	join(dOrigPlusCoLessee,dNameAddressJoined(NAME_TYPE = 'CO_LESSEE'),
							 left.temp_FILE_NO = right.FILE_NO
						 and left.temp_SEQ_NO = right.SEQ_NO,
							 tGetLienholder(left,right),
							 left outer,
							 keep(1),
							 local
							);

rTempLayoutVehicles	tGetAddlLienholder(dOrigPlusLienholder pOrig, dNameAddressJoined pNameAddress)
 :=
  transform
	self.LEIN_HOLDER_2_CUSTOMER_TYPE	:=	if(pNameAddress.cname<>'','B','I');
	self.LH_2_CUSTOMER_NUMBER 			:=	'';
    self.LH_2_FEID_SSN					:=	'';
	self.LH_2_CUSTOMER_NAME				:= 	if(pNameAddress.cname<>'',
											   pNameAddress.CNAME,
											   pNameAddress.ORIG_NAME
											  );
	self.LH_2_DEALER_LICENSE_NUMBER		:=	'';
	self.LH_2_DRIVER_LICENSE_NUMBER		:=	'';
	self.LH_2_DOB						:= 	'';
	self.LH_2_SEX						:=	'';
	self.LH_2_SEXUAL_PREDATOR_FLAG		:=	'';
	self.LH_2_MAIL_SUPPESSION_FLAG		:=	'';
	self.LH_2_ADDR_NON_DISCLOSURE_FLAG 	:= 	'';
	self.LH_2_LAW_ENFORCEMENT_FLAG		:=	'';
	self.LH_2_ADDRESS_NUMBER 			:=	'';
	self.LH_2_FOREIGN_ADDRESS_FLAG		:=	'';
	self.LH_2_STREET_ADDRESS			:=	Address.Addr1FromComponents(pNameAddress.Prim_Range,
																	    pNameAddress.PreDir,
																	    pNameAddress.Prim_Name,
																	    pNameAddress.Suffix,
																	    pNameAddress.PostDir,
																	    pNameAddress.Unit_Desig,
																	    pNameAddress.Sec_Range
																      );
	self.LH_2_APARTMENT_NUMBER			:=	'';
	self.LH_2_CITY						:=	pNameAddress.p_city_name;
	self.LH_2_STATE						:=	pNameAddress.st;
	self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL	:=	pNameAddress.zip5 + if(pNameAddress.Zip4 <> '',
																   '-' + pNameAddress.Zip4,
																   ''
																  );
	self.LH_2_RESIDENCE_COUNTY			:=	'';
	self							:=	pOrig;
  end
 ;

dOrigPlusAddlLienholder	:=	join(dOrigPlusLienholder,dNameAddressJoined(NAME_TYPE = 'ADDL_LIENHOLDER'),
								 left.temp_FILE_NO = right.FILE_NO
							 and left.temp_SEQ_NO = right.SEQ_NO,
								 tGetAddlLienholder(left,right),
								 left outer,
								 keep(1),
								 local
								);

VehLic.Layout_Vehicles	tOrigAsVehicles(dOrigPlusAddlLienholder pInput)
 :=
  transform
	self	:=	pInput;
  end
 ;

dOrigAsVehicles	:=	project(dOrigPlusAddlLienholder,tOrigAsVehicles(left));

export Experian_Nonupdating_as_Vehicles := dOrigAsVehicles : persist('~thor_data400::persist::vehreg_experian_nonupdating_as_vehicles');