import Ut, lib_stringlib, Drivers;

string1	fGenderCodeFromString(string pGenderIn)
 :=	case(pGenderIn,
		 'MALE'		=>	'M',
		 'FEMALE'	=>	'F',
		 ''
		)
 ;

string3	fEyeColorCodeFromString(string pEyeColorIn)
 :=	case(pEyeColorIn,
		 'BLUE'		=>	'XBL',
		 'BROWN'	=>	'XBR',
		 'GREEN'	=>	'XGR',
		 'HAZEL'	=>	'XHZ',
		 'GREY'		=>	'XGY',
		 'BLACK'	=>	'XBK',
		 'PINK'		=>	'XPK',
		 'MIXED'	=>	'XDI',
		 ''
		)
 ;

string3	fHairColorCodeFromString(string pHairColorIn)
 :=	case(pHairColorIn,
		 'BLACK'		=>	'XBK',
		 'BROWN'		=>	'XBR',
		 'BLONDE'		=>	'XBD',
		 'GREY'			=>	'XGY',
		 'RED'			=>	'XRD',
		 'WHITE'		=>	'XWT',
		 'AUBURN'		=>	'XAU',
		 'NONE/BALD'	=>	'XNN',
		 ''
		)
 ;
/*
string3	fEndorsementCodeFromLicenseClassString(string pLicenseClassIn)
 :=	case(pLicenseClassIn,
		 'ALL VEHICLE COMBINATIONS UPTO AND EXCEEDING 24,000 POUNDS GROSS VEHICLE WEIGHT - EXCEPT MOTORCYCLES'	=>	'A',
		 'BUS LICENSE'																							=>	'B',
		 'COMMERCIAL HEAVY'																					    =>	'C',
		 'COMMERCIAL HEAVY W/MOTORCYCLE'														                =>	'D',
		 'COMMERCIAL LIGHT'																					    =>	'E',
		 'COMMERCIAL LIGHT W/MOTORCYCLE'														                =>	'F',
		 'DRIVERS PERMIT'																						=>	'G',
		 'MOPED'																								=>	'H',
		 'MOTOR DRIVEN CYCLE (-100CC)'															                =>	'I',
		 'MOTORCYCLE (+100CC)'																			        =>	'J',
		 'NON-DRIVER ID CARD'																				    =>	'K',
		 'OPERATORS W/MOTORCYCLE'																		        =>	'L',
		 'OPERATORS LICENSE'																				    =>	'',
		 ''
		)
 ;
*/
string3	fRestrictionCodeFromString(string pRestrictionIn)
 :=	case(pRestrictionIn,
		 'ACCELERATOR ON LEFT SIDE'				=>'XA',
		 'ARTIFICIAL LIMB'						=>'XB',
		 'AUTOMATIC TRANSMISSION'				=>'XC',
		 'CORRECTIVE LENS'						=>'XD',
		 'DAYLIGHT ONLY'						=>'XE',
		 'DIMMER SWITCH ON STEERING WHEEL'		=>'XF',
		 'DRIVERS EDUCATION'					=>'XG',
		 'DRIVING RANGE RESTRICTION'			=>'XH',
		 'EXTENSION FOR ACCELERATOR/BRAKE'		=>'XI',
		 'FULL HAND CONTROLS REQUIRED'		    =>'XJ',
		 'HARDSHIP RESTRICTION'					=>'XK',
		 'LIMITED TO RURAL AREAS'				=>'XL',
		 'MECHANICAL TURN SIGNAL'				=>'XM',
		 'MEDICAL EXAM RESTRICTION'				=>'XN',
		 'MINOR RESTRICTION (PERMIT)'			=>'XO',
		 'MIRROR RESTRICTIONS'					=>'XP',
		 'MOTORCYCLE ENDORSEMENT'				=>'XQ',
		 'MUST WEAR HEARING AID'				=>'XR',
		 'NO INTERSTATE DRIVING'				=>'XS',
		 'NOT COVERED BY SPECIFIC RESTRICTIONS'	=>'XT',
		 'NOT-CORRECTABLE HEARING'				=>'XU',
		 'POWER STEERING/STEERING KNOB'		    =>'XV',
		 'SEAT CUSHION REQUIRED'				=>'XW',
		 'SPECIAL EQUIPMENT REQUIRED'			=>'XX',
		 'SPECIAL MEDICATION (INSULIN)'		    =>'XY',
		 'SPEED RESTRICTION'					=>'XZ',
		 'VALID ONLY IN-STATE'					=>'X1',
		 'VISION EXAM RESTRICTION'				=>'X2',
		 'WITH LICENSED DRIVER'					=>'X3',
		 'NO RESTRICTIONS'						=>'',
		 ''
		)
 ;
 

string2	fLicenseTypeFromLicenseClassString(string pLicenseClassIn)
 :=	case(pLicenseClassIn,
		 'DRIVERS PERMIT'		=>	'XP',
		 'NON-DRIVER ID CARD'	=>	'XI',
		 'OPERATORS LICENSE'	=>	'XO',
		 ''
		)
 ;


string3 fLicenseClassCodeFromString(string pLicenseClassIn)
 := case(pLicenseClassIn,
         'OPERATORS LICENSE'																				    =>	'XA',
		 'OPERATORS W/MOTORCYCLE'																		        =>	'XB',
		 'COMMERCIAL LIGHT'																					    =>	'XC',
		 'COMMERCIAL HEAVY'																					    =>	'XD',
		 'COMMERCIAL LIGHT W/MOTORCYCLE'														                =>	'XE',
		 'COMMERCIAL HEAVY W/MOTORCYCLE'														                =>	'XF',
		 'COMMERCIAL TRACTOR/TRAILER' 													                		=>	'XG',
		 'CHAUFFEURS LICENSE'		 													                		=>	'XH',
		 'DRIVINR INSTRUCTOR PERMIT'																			=>	'XI',
		 'BUS LICENSE'																							=>	'XJ',
		 'MOTORCYCLE (+100CC)'																			        =>	'XK',
		 'MOTOR DRIVEN CYCLE (-100CC)'															                =>	'XL',
		 'MOPED'																								=>	'XM',
		 '2 AXLE/TRUCK W/NO CARGO'																				=>	'XN',
		 '2 AXLE/TRUCK WCARGO'  																				=>	'XO',
		 '3 AXLE/TRUCK AND BUS'																					=>	'XP',
		 'NON-DRIVER ID CARD'																				    =>	'XQ',
		 'DRIVE ALL VEHICLES'																					=>	'XR',
		 'ALL VEHICLE COMBINATIONS UPTO AND EXCEEDING 24,000 POUNDS GROSS VEHICLE WEIGHT - EXCEPT MOTORCYCLES'	=>	'XS',
		 'DRIVERS PERMIT'																						=>	'XT',
		 ''
		)
 ;

string8	fDateStringFromSlashedMDY(string pDateIn)
 :=	
  function
	boolean		lIsValidSlashedDate	:=	regexfind('[0-9]*[^0-9][0-9]*[^0-9][0-9]*',pDateIn);
	string		fNumberSegment(string pDateIn, integer pSegment)
				 := if(lIsValidSlashedDate,
					   trim(regexfind('([0-9]*)[^0-9]([0-9]*)[^0-9]([0-9]*)',pDateIn,pSegment),left,right),
					   ''
					  );
	string4		lYearString		:=	fNumberSegment(pDateIn,3)[1..4];
	string2		lMonthString	:=	intformat((unsigned2)fNumberSegment(pDateIn,1),2,1);
	string2		lDayString		:=	intformat((unsigned2)fNumberSegment(pDateIn,2),2,1);
	string8		lReturnValue	:=	if(lIsValidSlashedDate,
									   lYearString + lMonthString + lDayString,
									   ''
									  );
	return lReturnValue;
  end
 ;

unsigned3	fDateSeenFromIssueDate(string pDateIn, unsigned3 pLatestDateIn)
 :=
  function
	unsigned3	lDateIn			:=	(unsigned8)fDateStringFromSlashedMDY(pDateIn) div 100;
	unsigned4	lLatestMonths	:=	((pLatestDateIn div 100) * 12) + pLatestDateIn % 100;
	unsigned4	lDateInMonths	:=	((lDateIn div 100) * 12) + lDateIn % 100;
	unsigned3	lReturnValue	:=	if(lLatestMonths >= lDateInMonths and lLatestMonths - lDateInMonths <= 12,
									   lDateIn,
									   0
									  );
	return lReturnValue;
  end
 ;

rStateIssueDate
 :=
  record
	string4		file_information;
	unsigned3	issue_year_month;
  end
 ;

rStateIssueDate	tStateIssueDate(Drivers.Mapping_Experian_XML_Fixed pInput)
 :=
  transform
	self.file_information	:= 	pInput.file_information;
	self.issue_year_month	:=	(unsigned8)fDateStringFromSlashedMDY(pInput.issue_date) / 100;
  end
 ;

dStateIssueDate	:=	project(Drivers.Mapping_Experian_XML_Fixed,tStateIssueDate(left));

rIssueDateYearMonthTable
 :=
  record
	dStateIssueDate.file_information;
	dStateIssueDate.issue_year_month;
	unsigned3	YearMonthCount	:=	count(group,dStateIssueDate.issue_year_month !=0);
  end
 ;

dIssueDateYearMonthTable	:=	table(dStateIssueDate,rIssueDateYearMonthTable,file_information,issue_year_month,few);

rLatestIssueDateTable
 :=
  record
	dIssueDateYearMonthTable.file_information;
	unsigned3	LatestYearMonth	:=	max(group,dIssueDateYearMonthTable.issue_year_month);
  end
 ;

dLatestYearMonth	:=	table(dIssueDateYearMonthTable(YearMonthCount >= 500),rLatestIssueDateTable,file_information,few);

DriversV2.Layout_DL_Extended	tExperianFixedToCommon(Drivers.Mapping_Experian_XML_Fixed pInput, dLatestYearMonth pLatestDate)
 :=
  transform
	self.dt_first_seen 		      :=  fDateSeenFromIssueDate(pInput.Issue_Date,pLatestDate.LatestYearMonth);
    self.dt_last_seen 		      :=  fDateSeenFromIssueDate(pInput.Issue_Date,pLatestDate.LatestYearMonth);
    self.dt_vendor_first_reported :=  pLatestDate.LatestYearMonth;
    self.dt_vendor_last_reported  :=  pLatestDate.LatestYearMonth;
		self.dateReceived					:=	if (pLatestDate.LatestYearMonth != 0,
																				(integer)((string)pLatestDate.LatestYearMonth + '01'),
																				0
																			);
    self.orig_state 		      :=  pInput.file_information[1..2];
	self.source_code			  :=  'AX';
	self.name					  :=  pInput.full_name;
	self.addr_type                :=  'R'; // R represents residence address - added as a part of rewrite
	self.addr1					  :=  pInput.CurrentAddress_street_1;
	self.city 					  :=  pInput.CurrentAddress_city;
	self.state					  :=  pInput.CurrentAddress_state;
	self.zip 					  :=  pInput.CurrentAddress_zip;
	self.country                  :=  ''; //pInput.CurrentAddress_country;     // added as a part of rewrite
	self.postal_code              :=  ''; //pInput.CurrentAddress_foreign_zip; // added as a part of rewrite
	self.ssn_safe			  :=  lib_stringlib.StringLib.stringfilter(pInput.orig_ssn_first_5 + pInput.orig_ssn_last_4,'0123456789');
	self.dob 					  :=  (unsigned4)fDateStringFromSlashedMDY(trim(pInput.dob_month,left,right) + '/' + trim(pInput.dob_day,left,right) + '/' + trim(pInput.dob_year,left,right));
	self.sex_flag				  :=  fGenderCodeFromString(pInput.gender_description);
	self.expiration_date	      :=  (unsigned4)fDateStringFromSlashedMDY(pInput.expiration_date);
	self.lic_issue_date 	      :=  (unsigned4)fDateStringFromSlashedMDY(pInput.issue_date);
	self.height 				  :=  trim(pInput.height_feet,left,right)[1] + intformat((unsigned1)pInput.height_inches,2,1);
	self.weight					  :=  pInput.weight;
    self.eye_color			      :=  fEyeColorCodeFromString(pInput.eye_color);
	self.hair_color				  :=  fHairColorCodeFromString(pInput.hair_color);
	self.dl_number 				  :=  trim(pInput.dl_number,left,right);									
	string2	lRestriction1	      :=  fRestrictionCodeFromString(pInput.restrictions1);
	string2	lRestriction2	      :=  fRestrictionCodeFromString(pInput.restrictions2);
	string2	lRestriction3	      :=  fRestrictionCodeFromString(pInput.restrictions3);
	string2	lRestriction4	      :=  fRestrictionCodeFromString(pInput.restrictions4);
	string2	lRestriction5	      :=  fRestrictionCodeFromString(pInput.restrictions5);
	self.restrictions			  :=  lRestriction1
								    + lRestriction2
									+ lRestriction3
									+ lRestriction4
					   			    + lRestriction5
													;
	self.restrictions_delimited	  :=  lRestriction1
									+ if(lRestriction2<>'', ',' + lRestriction2, ''	)
									+ if(lRestriction3<>'', ',' + lRestriction3, ''	)
									+ if(lRestriction4<>'', ',' + lRestriction4, ''	)
									+ if(lRestriction5<>'', ',' + lRestriction5, '' );
	Self.license_class			  :=  trim(fLicenseClassCodeFromString(pInput.license_class1)
										 + fLicenseClassCodeFromString(pInput.license_class2)
										 + fLicenseClassCodeFromString(pInput.license_class3)
										   ,all);
	self.license_type             :=  '';

	TempClass							:=  StringLib.StringFindReplace(StringLib.StringCleanSpaces(trim(pInput.license_class1) + '; ' +
																																										trim(pInput.license_class2) + '; ' + 
																																										trim(pInput.license_class3)
																																										),'; ; ','; '
																												);
	Self.OrigLicenseClass := 	if (TempClass[1]=';',
																	if (TempClass[length(TempClass)] =';',
																				TempClass[2..length(TempClass) - 1],
																				TempClass[2..]
																			),
																	if (TempClass[length(TempClass)] =';',
																				TempClass[1..length(TempClass) - 1],
																				TempClass[1..]
																			)
																);																													
														
	self.OrigLicenseType	:=  '';	
	self.moxie_license_type		  :=  fLicenseTypeFromLicenseClassString(pInput.license_class1);
	self.lic_endorsement	      :=  '';
	self.title 					  :=  pInput.title;
	self.fname 					  :=  pInput.fname;
	self.mname 					  :=  pInput.mname;
	self.lname 					  :=  pInput.lname;
	self.name_suffix 			  :=  pInput.name_suffix;
	self.cleaning_score 	      :=  pInput.cleaning_score;
	self.prim_range 			  :=  pInput.prim_range;
	self.predir 				  :=  pInput.predir;
	self.prim_name 				  :=  pInput.prim_name;
	self.suffix 			      :=  pInput.suffix;
	self.postdir 				  :=  pInput.postdir;
	self.unit_desig 			  :=  pInput.unit_desig;
	self.sec_range 				  :=  pInput.sec_range;
	self.p_city_name 			  :=  pInput.p_city_name;
	self.v_city_name 			  :=  pInput.v_city_name;
	self.st 					  :=  pInput.st;
	self.zip5 					  :=  pInput.zip5;
	self.zip4 					  :=  pInput.zip4;
	self.cart 					  :=  pInput.cart;
	self.cr_sort_sz 			  :=  pInput.cr_sort_sz;
	self.lot 					  :=  pInput.lot;
	self.lot_order 				  :=  pInput.lot_order;
	self.dpbc 					  :=  pInput.dpbc;
	self.chk_digit 				  :=  pInput.chk_digit;
	self.rec_type 				  :=  pInput.rec_type;
	self.ace_fips_st 			  :=  pInput.ace_fips_st;
	self.county 				  :=  pInput.county;
	self.geo_lat 				  :=  pInput.geo_lat;
	self.geo_long 				  :=  pInput.geo_long;
	self.msa 					  :=  pInput.msa;
	self.geo_blk 				  :=  pInput.geo_blk;
	self.geo_match 				  :=  pInput.geo_match;
	self.err_stat 				  :=  pInput.err_stat;
	self.history				  :=  if(self.expiration_date = 0,		// if no expiration date, set history to 'U'
										 'U', '' );
	self.issuance 				  := ''; // has no default
end;

export Mapping_Experian_as_DL	:=	join(Drivers.Mapping_Experian_XML_Fixed, dLatestYearMonth,
										 left.file_information = right.file_information,
										 tExperianFixedToCommon(left,right),
										 left outer,
										 lookup
										);
