export map_AK_to_SCANK	:= MODULE

import Prof_License_Mari, Ut, Lib_FileServices, lib_stringlib, _control;

src_cd	:= 'S0376';
string8 process_date:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();

//ds_common	:= dataset('~thor400_88::in::prolic::'+process_date+'::'+src_cd+'',Prof_License_Mari.layouts_reference.MARIBASE,thor);

// Incoming Superfile
ds_common	:= dataset('~thor_data400::in::prolic::mari::'+src_cd+'',Prof_License_Mari.layouts_reference.MARIBASE,thor);


//Professional license types processed by SCANK
Occ_Prof	:= ['AC1L','AC1M','AC1N','AC1O','AC1P','AC1R','AC1S','AC1U','AC1V','AC1Y','AC1Z',
							'AC2C','AC2D','AC2F','AC2I','AC2J',
							'CS1C','CS1H','CS1I','CS1J','CS1Z','CS2A','CS2B','CS2C',
							'ACUA','ACUC','AUDA','AUDD',
							'CHIT','CHIC','CSWB','CSWM','CSWR','CSWS','CSWT',
							'DENA','DENB','DEND','DENG','DENH','DENP','DENS','DENT','DOPA','DOPD','DTND',
							'MEDA','MEDC','MEDD','MEDH','MEDI','MEDL','MEDM','MEDO','MEDP','MEDR','MEDS','MEDT','MEDU','MEDY',
							'MFTA','MFTM','MIDA','MIDM',
							'NTNN','NUAA','NUAT','NURA','NURL','NURN','NURP','NURR','NURS','NURT','NURU',
							'OPTB','OPTD','OPTO','OPTT',
							'PCOP','PADA','PADG','PADL','PADT',
							'PHAA','PHAB','PHAC','PHAD','PHAE','PHAF','PHAG','PHAH','PHAI','PHAK','PHAN','PHAO',
							'PHAP','PHAR','PHAT','PHAW',
							'PHYA','PHYC','PHYI','PHYL','PHYM','PHYN','PHYO','PHYP','PHYR','PHYS','PHYT','PHYU',
							'PSYA','PSYO','PSYP','PSYS','SLPA','SLPS'];
	 
//Map AK Professional license to SCANK layout
Prof_License_Mari.layouts_SCANK.AKProf	transformToScank(Prof_License_Mari.layouts_reference.MARIBASE L)	:= TRANSFORM
	self.LICENSE_CODE	:= L.RAW_LICENSE_TYPE; //combo of board and license type
	self.LICENSE_NUM	:= map(length(TRIM(L.LICENSE_NBR)) = 1 => '0000' + L.LICENSE_NBR,
						    	length(TRIM(L.LICENSE_NBR)) = 2 => '000' + L.LICENSE_NBR,
								  length(TRIM(L.LICENSE_NBR)) = 3 => '00' + L.LICENSE_NBR,
								    length(TRIM(L.LICENSE_NBR)) = 4 => '0' + L.LICENSE_NBR,
									   L.LICENSE_NBR); 
	self.STATUS				:= TRIM(L.RAW_LICENSE_STATUS,LEFT,RIGHT);
	self.BUSINESS_NAME := L.NAME_ORG;
	self.ADDR1				:= L.ADDR_ADDR1_1;                                       
	self.ADDR2				:= L.ADDR_ADDR2_1;
	self.CITY					:= L.ADDR_CITY_1;
	self.STATE				:= L.ADDR_STATE_1;
	self.ZIPCODE			:= TRIM(L.ADDR_ZIP5_1+L.ADDR_ZIP4_1,LEFT,RIGHT);
	self.ISSUE_DTE		:= L.CURR_ISSUE_DTE; // yyyymmdd
	self.EXPIRE_DTE		:= L.EXPIRE_DTE; // yyyymmdd
	self.ORIG_ISSUE_DTE	:= L.ORIG_ISSUE_DTE; // yyyymmdd
	self.DOB					:= L.BIRTH_DTE; // yyyymmdd
	self.FIRST_NAME		:= L.NAME_FIRST;
	self.LAST_NAME		:= L.NAME_LAST;
	self.MID_NAME			:= L.NAME_MID;
	self.SUFFIX				:= L.NAME_SUFX;
	self.CRLF					:= '\r\n';
END;

//ds_AK_PROF	:= project(ds_common,transformToScank(left));


// Removing duplicate records
ds_AK_PROF	:= dedup(project(ds_common,transformToScank(left)),record,all,local);

export AK_Prof	:= ds_AK_PROF(LICENSE_CODE IN Occ_Prof);



export AK_Despray_Prof	:= FUNCTION
	RETURN FileServices.Despray('~thor400_88::out::plotn::ak_prof.txt',
	_Control.IPAddress.edata10,
	'/data_build_5_2/PLOTN/Scank/AK_PROF.T00',,,,TRUE);
END;

export AK_to_SCANK	:=
SEQUENTIAL(
		OUTPUT(AK_Prof,,'~thor400_88::out::plotn::ak_prof.txt',OVERWRITE),
		AK_Despray_Prof);

END;