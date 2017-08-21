EXPORT proc_scank_extract(string filedate) := FUNCTION
	
	IMPORT Death_Master, Header, _control;
	
	#workunit('name','DeathMaster - SCANK Extract');
	
	email_list	:=	'valerie.minnis@lexisnexis.com; DataReceiving@lexisnexis.com; ALP-MediaOps@choicepoint.com; jason.ding@lexisnexis.com; kevin.reeder@lexisnexis.com' ;
	
	SSABaseFile	:=	Header.File_Death_Master_Plus(state_death_flag = 'N');
	
	layouts_extract.layout_scank_extract	tBaseToSCANK(SSABaseFile pInput)	:=	TRANSFORM
		self.SSN							:=	pInput.ssn;
		self.LAST_NAME				:=	pInput.lname;
		self.FIRST_NAME				:=	pInput.fname;
		self.MID_NAME					:=	pInput.mname;
		self.SUFFIX						:=	pInput.name_suffix;
		self.DOD							:=	pInput.dod8[5..8] + pInput.dod8[1..4]; //MMDDCCYY
		self.CLA_DOD					:=	pInput.dod8; //CCYYMMDD
		self.DOB							:=	pInput.dob8[5..8] + pInput.dod8[1..4]; //MMDDCCYY
		self.CLA_DOB					:=	pInput.dob8; //CCYYMMDD
		self.STATE_CTRY				:=	pInput.st_country_code;
		self.ZIP_LAST_RES			:=	pInput.zip_lastres;
		self.ZIP_PAYMENT			:=	pInput.zip_lastpayment;
		self.CERTIF_NUM				:=	'';
		self.COUNTY						:=	pInput.fipscounty;
		self.GENDER						:=	'';
		self.RACE							:=	'';
		self.MARITIAL_STATUS	:=	'';
		self.RECORD_SRC				:=	'SA';
		self.VERT_PROOF				:=	'';
		self.VOL_NUMB					:=	'';
		self.EOR							:=	'\r\n';
	END;
	
	rsSCANKExtract	:=	PROJECT(SSABaseFile, tBaseToSCANK(left));
	
	layouts_extract.layout_scank_extract	tJoinStateCds(rsSCANKExtract pInputL, lkp_SSA_state_cntry_cd pInputR)	:=	TRANSFORM
		self.STATE_CTRY	:=	pInputR.LN_ST_COUNTRY_CODE;
		self						:=	pInputL;
	END;
	
	rsSCANKExtractLkp						:=	JOIN(rsSCANKExtract, lkp_SSA_state_cntry_cd,
																		LEFT.STATE_CTRY = RIGHT.ST_COUNTRY_CODE,
																		tJoinStateCds(LEFT, RIGHT),
																		LEFT OUTER,
																		LOOKUP
																	);
	
	writeFile		:=	OUTPUT(rsSCANKExtractLkp, , '~thor_data400::out::death_master::SCANK::base_' + filedate, CLUSTER('thor400_20'), OVERWRITE);
	//writeFile		:=	OUTPUT(rsSCANKExtractLkp, , '~thor_data400::out::death_master::SCANK::base_' + filedate, CLUSTER('thor400_84'), OVERWRITE);
	
	desprayFile	:=	FileServices.Despray('~thor_data400::out::death_master::SCANK::base_' + filedate, _Control.IPAddress.edata11, 
											 '/load01/choicepoint_inbound/outbound/deaths/DEPARTEN.T00.' + filedate,,,,TRUE);
											 
	send_email 	:= fileservices.sendemail(email_list, 'SCANK Death Extract is complete', 'The file DEPARTEN.T00.' + filedate
	                                               + ' can be found on edata14 in /load01/choicepoint_inbound/outbound/deaths.');											 
	
	RETURN SEQUENTIAL(writeFile, desprayFile, send_email);

END;