IMPORT ut;

EXPORT fStandardizedCode(DATASET(RECORDOF(Prof_License_Mari.layouts.base)) int0)
	:=
FUNCTION
//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation;
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType;
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp		:= Prof_License_Mari.files_References.MARIcmvSrc; 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;

RECORDOF(int0) xformMiscCodes(RECORDOF(int0) le) := TRANSFORM
      SELF.STD_LICENSE_DESC	 := MAP(le.STD_SOURCE_UPD = 'S0636' AND le.RAW_LICENSE_TYPE = 'REGULATED LENDER' AND le.STD_LICENSE_DESC = '' => le.RAW_LICENSE_TYPE,
			                              le.STD_SOURCE_UPD = 'S0658' AND TRIM(le.RAW_LICENSE_TYPE) = 'REGULATED LENDER' AND le.STD_LICENSE_DESC = '' => le.RAW_LICENSE_TYPE,
                                    le.STD_SOURCE_UPD = 'S0658' AND le.RAW_LICENSE_TYPE[1..6] in ['BANKER','BROKER'] AND le.STD_LICENSE_DESC = '' => le.RAW_LICENSE_TYPE[1..6],
																		le.STD_SOURCE_UPD = 'S0636' AND le.RAW_LICENSE_TYPE = 'CREDIT ACCESS BUSINESS' AND le.STD_LICENSE_TYPE = '' => le.RAW_LICENSE_TYPE,
                                    le.STD_SOURCE_UPD = 'S0636' AND le.RAW_LICENSE_TYPE = 'MOTOR VEHICLE SALES FINANCE' AND le.STD_LICENSE_TYPE = '' => le.RAW_LICENSE_TYPE,
																		le.STD_SOURCE_UPD = 'S0636' AND le.RAW_LICENSE_TYPE = 'PAWN SHOP' AND le.STD_LICENSE_TYPE = '' => le.RAW_LICENSE_TYPE,
																				le.STD_LICENSE_DESC);
																				
																				                                                                              

																				
			tmp_STATUS_DESC := MAP(le.STD_SOURCE_UPD IN ['S0636','S0376'] AND le.STD_STATUS_DESC = '' AND TRIM(le.RAW_LICENSE_STATUS) in 
																	['ACTIVE','INACTIVE','REVOKED','SURRENDERED'] => le.RAW_LICENSE_STATUS,
														 le.STD_SOURCE_UPD IN ['S0636','S0376'] AND le.STD_STATUS_DESC = '' AND TRIM(le.RAW_LICENSE_STATUS) = 'REVOKED LICENSE' => 'REVOKED',
														 le.STD_SOURCE_UPD IN ['S0636','S0376'] AND le.STD_STATUS_DESC = '' AND TRIM(le.RAW_LICENSE_STATUS) = 'CANCELED' => 'CANCELLED',
														 le.STD_SOURCE_UPD IN ['S0636','S0376'] AND le.STD_STATUS_DESC = '' AND TRIM(le.RAW_LICENSE_STATUS) = 'CANCELED DUE TO' => 'CANCELLED',
														 le.STD_SOURCE_UPD IN ['S0855'] AND le.STD_STATUS_DESC = '' AND TRIM(le.RAW_LICENSE_STATUS) = 'CANCELLED' => 'CANCELLED',
														 le.STD_SOURCE_UPD IN ['S0855'] AND le.STD_STATUS_DESC = '' AND TRIM(le.RAW_LICENSE_STATUS) = 'REVOKED' => 'REVOKED',
														 le.STD_SOURCE_UPD IN ['S0855'] AND le.STD_STATUS_DESC = '' AND TRIM(le.RAW_LICENSE_STATUS) = 'SUSPENDED' => 'SUSPENDED',                                                                  

																	'');
																
			SELF.STD_STATUS_DESC	:= IF(tmp_status_desc != '', tmp_STATUS_DESC, le.STD_STATUS_DESC);
			SELF.BK_CLASS_DESC		:= CASE(TRIM(le.BK_CLASS),
																		'N'		=> 'Commercial Bank. Bank is supervised by (OCC). National Charter and a Fed member.',
																		'SM'	=> 'Comptroller of the Currency (OCC). National Charter and a Fed member.',
																		'NM'  => 'Commercial Bank. Bank is supervised by (FDIC). State charter and Fed non-member',
																		'SB'	=> 'Savings Bank. Bank is supervised by (FDIC). State Charer',
																		'SA'	=> 'As of July 21, 2011, FDIC supervised state chartered thrifts and OCC supervised federally chartered thrifts.', 
																		'OI'	=> 'Bank is an insured United States branch of a foreign chartered institution (IBA)',
																				'');
			SELF.ORIGIN_CD_DESC		:= CASE(TRIM(le.ORIGIN_CD),
																			'D' => 'ENDORSEMENT',
																			'C' => 'CREDENTIAL',
																			'E' => 'EXAM',
																			'G' => 'GRANDFATHERED',
																			'L' => 'ORIGINAL',
																			'O' => 'OTHER',
																			'W' => 'WAIVER',
																			'R' => 'RECIPROCITY/COMITY',
																			'S' => 'SCHOOLING',
																			'U' => 'UNKNOWN',
																			'F' => 'EXAMINATION-FEDERAL',
																			'X' => 'RECIPROCITY-FEDERAL',
																			'5' => 'IA RULE 5.3', // valid for IA professional records only
																			'');

			SELF.DISP_TYPE_DESC			:= CASE(TRIM(le.DISP_TYPE_CD),
																		'C' => 'CHARGES FILED',
																		'D' => 'DISCIPLINARY ACTION',
																		'L' => 'LETTER OF REPRIMAND',
																		'O' => 'PRIOR DISCIPLINSE ACTION',		
																		'P' => 'PROBATION',
																		'Q' => 'POSSIBLE DISCIPLINARY ACTION',
																		'R' => 'REVOKED',
																		'V' => 'VOLUNTARY SURRENDER TO AVOID FURTHER DISCIPLINARY ACTION',
																				'');
			SELF.RACE_DESC					:= CASE(TRIM(le.STD_RACE_CD),
																			'ALEU' 	=> 'ALEUTIAN',
																			'API' 	=> 'ASIAN/PACIFIC IS.',
																			'BLK' 	=> 'BLACK/AFRICAN AMERICAN',
																			'ESK' 	=> 'ALASKAN NATIVE',
																			'HISP' 	=> 'HISPANIC',
																			'JPN' 	=> 'JAPANESE',
																			'MIX' 	=> 'MIXED',
																			'NAAM' 	=> 'NATIVE AMERICAN INDIAN',
																			'OTH'  	=> 'OTHER(S)',
																			'UNK'  	=> 'UNKNOWN',
																			'WHT'  	=> 'WHITE/CAUCASIAN','');
			SELF  := le;
END;
p_code_desc := PROJECT(int0,xformMiscCodes(LEFT));

RECORDOF(int0) JoinLicStatus(p_code_desc le, cmvTransLkp RInput) := TRANSFORM
	SELF.STD_LICENSE_STATUS := IF(le.STD_LICENSE_STATUS = '',ut.CleanSpacesAndUpper(RInput.DM_VALUE1),le.STD_LICENSE_STATUS);
	SELF  := le;
END;
						
ds_StdStatus		:=	JOIN(p_code_desc, cmvTransLkp,	
													TRIM(LEFT.STD_SOURCE_UPD,LEFT,RIGHT) = TRIM(RIGHT.SOURCE_UPD,LEFT,RIGHT)
													AND StringLib.StringToUpperCase(TRIM(LEFT.RAW_LICENSE_STATUS,LEFT,RIGHT))=TRIM(RIGHT.FLD_VALUE,LEFT,RIGHT)
													AND RIGHT.fld_name='LIC_STATUS',
													JoinLicStatus(LEFT,RIGHT), LEFT OUTER, LOOKUP);

RECORDOF(int0) JoinProf(ds_StdStatus le, cmvTransLkp RInput) := TRANSFORM
	SELF.STD_PROF_CD := IF(le.STD_PROF_CD = '',ut.CleanSpacesAndUpper(RInput.DM_VALUE1),le.STD_PROF_CD);
	SELF  := le;
END;
						
ds_StdProfCd		:=	JOIN(ds_StdStatus, cmvTransLkp,	
													TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT) = TRIM(RIGHT.FLD_VALUE,LEFT,RIGHT)
													AND RIGHT.fld_name='LIC_TYPE' 
													AND RIGHT.dm_name1 = 'PROFCODE',
													JoinProf(LEFT,RIGHT), LEFT OUTER, LOOKUP);
																										


RECORDOF(int0) doJoinSource(ds_StdProfCd le, LicSrcLkp RInput) := TRANSFORM
	SELF.STD_SOURCE_DESC := IF(le.STD_SOURCE_DESC = '',ut.CleanSpacesAndUpper(RInput.SRC_NAME),le.STD_SOURCE_DESC);
	SELF  := le;
END;
						
ds_StdSource		:=	JOIN(ds_StdProfCd, LicSrcLkp,	
													TRIM(LEFT.STD_SOURCE_UPD,LEFT,RIGHT) = TRIM(RIGHT.SRC_NBR,LEFT,RIGHT),
													doJoinSource(LEFT,RIGHT), LEFT OUTER, LOOKUP);
													

RECORDOF(int0)	doJoinType(ds_StdSource LInput, LicTypeLkp RInput) := TRANSFORM
	SELF.STD_LICENSE_DESC := IF(LInput.STD_LICENSE_DESC = '',ut.CleanSpacesAndUpper(RInput.LICENSE_DESC),LInput.STD_LICENSE_DESC);
	SELF	:= LInput;
END;
					  

ds_StdType	:= JOIN(ds_StdSource, LicTypeLkp,
										TRIM(LEFT.STD_SOURCE_UPD,LEFT,RIGHT) = TRIM(RIGHT.SRC_UPD,LEFT,RIGHT)
										AND TRIM(LEFT.STD_LICENSE_TYPE,LEFT,RIGHT) = TRIM(RIGHT.LICENSE_TYPE,LEFT,RIGHT),
										doJoinType(LEFT,RIGHT),LEFT OUTER, LOOKUP);


RECORDOF(int0)		doJoinStatus(ds_StdType LInput, LicStatusLkp RInput)	:= TRANSFORM
	SELF.STD_STATUS_DESC  := IF(LInput.STD_STATUS_DESC = '', ut.CleanSpacesAndUpper(RInput.STATUS_DESC),LInput.STD_STATUS_DESC);
	SELF  := LInput;
END;
						
ds_StdStatusDesc	:=	JOIN(ds_StdType, LicStatusLkp,
												TRIM(LEFT.STD_LICENSE_STATUS,LEFT,RIGHT) = TRIM(RIGHT.LICENSE_STATUS,LEFT,RIGHT),
												doJoinStatus(LEFT,RIGHT), LEFT OUTER, lOOKUP);


RECORDOF(int0)		doJoinProf(ds_StdStatusDesc LInput, LicProfLkp RInput)	:= TRANSFORM
	SELF.STD_PROF_DESC  := IF(LInput.STD_PROF_DESC = '', ut.CleanSpacesAndUpper(RInput.PROF_DESC),LInput.STD_PROF_DESC);
	SELF  := LInput;
END;
						
ds_StdProf	:=	JOIN(ds_StdStatusDesc, LicProfLkp,
											TRIM(LEFT.STD_PROF_CD,LEFT,RIGHT) = TRIM(RIGHT.PROF_CD,LEFT,RIGHT),
											doJoinProf(LEFT,RIGHT), LEFT OUTER, LOOKUP);


RETURN ds_StdProf;

END;
