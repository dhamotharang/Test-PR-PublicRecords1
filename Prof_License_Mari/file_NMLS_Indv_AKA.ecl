IMPORT ut,lib_fileservices,_Control,lib_stringlib,AID,address,idl_header;
#OPTION('multiplePersistInstances',FALSE);

EXPORT  file_NMLS_Indv_AKA(DATASET(recordof(Prof_License_Mari.layouts_NMLS0900.Individual_AKA)) pIndvAKAFile) := FUNCTION

setValidPrefix:=['MR','MS','DR','MRS','MISS','SIR','MISSES','MISTER','MRS/','MRS/MS','MISS & MRS','MISS MRS','MRS AND MS','MRS OR MS','MS MRS'];

setValidSuffix:=[' JR','JR','SR','I','II','III','IV','V','VI','VII','VIII','IX',
										'1','2','3','4','5','FOUTH','1ST','2ND','3RD','4TH','JUNIOR','SENIOR','SECOND','THIRD'];

setTitle := ['PRES','PRESIDENT','PROF','OWNER','BROKER','CORPORAL','LOAN ADMIN',
								'PRESENT','SENATOR','TELLER',
								'BS','CFP','CMB','CPA','CSR','DPM','DVM','ESQ','ESQUIRE','MA','FMS','PA','PH D',
								'CFA','CFO','CFP, CHFC','CMC','CMPS','CRMS','CSM','CSR','DD','DDS','DN','DOC',      
								'DOM','ER','ERPR','EDD','DMR','MD','MBA', 'MBA','PHD','SFO','SGT','VP','PHDC/MSC','BA/BS',
								'MBA CHRM','BA DCFS','BA MS','VP LENDING','AVP RETAIL'
								];	

setBogusSuffix := ['N/A','NA','NONE','LEGAL NAME','MADEN NAME','MAIDEN','MAIDEN NAM','NO SUFFIX','SUFFIX','(NONE)','.COM','?','MADIN NAME','(NO MIDDLE NAME)'];

setGender			:= ['FEMALE','MALE','FEMAIL','FEMAL','MAEL'];
setMarital		:= ['MARRIED','DIVORCE','DIVORCED','MARIED'];
setNickname		:= ['NICK NAME','NICKNAME','NICK-NAME'];
setNameType		:= ['MADEN NAME','MAIDEN NAM','MADIN NAME','MAIDEN','(MAIDEN)','MAIDE NAME','LEGAL NAME'];
// setNumber			:= ['03/09/1988','10/4/1977','7/26/1970','02/28/1969','5/31/1974','08/12/1967','402761','552950','628466088','6305','674421','10702'];
setName := ['NO LAST NAME','N/A','N//A','N/','NO MIDDLE NAME','NONE','NO FIRST NAME','?','(NO MIDDLE NAME)','(NONE)'];
setURL	:= ['COM','NET','ORG'];

slash_pattern_2 := '^(.*)/((.*)/(.*))$';
slash_pattern_1 := '^(.*)/(.*)$';
Datepattern := '^([0-9]+)/([0-9]+)/([0-9]+)$';
NameDate_Pattern := '^([A-Za-z]+)(([0-9]+)/([0-9]+)/([0-9]+))$';
AKA_Ind := '( AKA |A/K/A|A[.]K[.]A|AKA:|AKA/)';


layout_indv_with_addl	:= RECORD
	Prof_License_Mari.layouts_NMLS0900.INDIVIDUAL;
	string10	NAME_TYPE;
	string50	orig_first_name;
	string50	orig_middle_name;
	string50	orig_last_name;
	string10  orig_suffix;
	string10	std_name_prefix;
	string10	std_name_title;
	string30	nickname;
	string50  maiden_name;
	string10	gender;
	string15  marital_status;
	string11  std_name_type;
	string10  misc_info;			// possible ssn, birth_date
	string50  url;

END;


layout_indv_with_addl 					map_indv_aka(pIndvAKAFile L):= TRANSFORM
	trimFName				:= ut.fnTrim2Upper(L.FIRST_NAME);
	trimMName				:= ut.fnTrim2Upper(L.MIDDLE_NAME);
	trimLName				:= ut.fnTrim2Upper(L.LAST_NAME);
	trimSuffix			:= StringLib.StringFilterOut(ut.fnTrim2Upper(L.suffix),'".,?-`!>');
	trimNameType		:= StringLib.StringFilterOut(ut.fnTrim2Upper(L.name_type),'".,?-`');
	self.orig_first_name 	:= trimFName;
	self.orig_middle_name := trimMName;
	self.orig_last_name 	:= trimLName;
	self.orig_suffix			:= trimSuffix;
	self.name_type				:= trimNameType;
	
// Standardizing Suffix and Removing AKA, Nickname, Gender, Marital Status from Name Fields	
// Prep First Name Field
	prepFname	:= if(trimFName in setName,'',trimFName);
	getFirstName := if(regexfind(AKA_Ind, prepFName), 
												Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepFName),
											if(regexfind(NameDate_Pattern,prepFName),
															regexfind(NameDate_Pattern,prepFName,1),
													if(regexfind(slash_pattern_2,prepFName) and prepFName != 'N/A' and prepFName[1] != '/', 
																regexfind(slash_pattern_2,prepFname,1),
														if(regexfind(slash_pattern_1,prepFName) and prepFName != 'N/A' and prepFName[1] != '/', 
																	regexfind(slash_pattern_1,prepFname,1),	
																if(prepFName[1] != '"' and not regexfind('(NICKNAME|NICK NAME|NICK-NAME)',prepFName),Prof_License_Mari.fGetNickname(prepFname,'strip_nick'),
													prepFName)))));
	self.first_name				:= getFirstName;
	
// Prep Middle Name Field
	prepMname	:= if(trimMName in setName,'',trimMName);
	getMiddleName := if(regexfind(slash_pattern_1,prepMName) and prepMName != 'N/A' and not regexfind('(SHORT/NICKNAME)',prepMName), 
																regexfind(slash_pattern_1,prepMname,1),
																if(regexfind(AKA_Ind, prepMname), 
																	Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepMname),
																	 if(not regexfind('(NICKNAME|NICK NAME|NICK-NAME|CONFIRMATION|MAIDE NAME)',prepMName),
																						Prof_License_Mari.fGetNickname(prepmname,'strip_nick'),
																		prepMname)));
	self.middle_name			:= getMiddleName;

// Prep Last Name Field
	prepLname	:= if(trimLName in setName,'',
									if(regexfind(datepattern, trimLName),'',trimLName));
	tmpLastName_comma1	:= if(regexfind('^(.*),(.*)$',prepLname),regexfind('^(.*),(.*)$',prepLname,1),'');
  tmpLastName_comma2	:= if(regexfind('^(.*),(.*)$',prepLname),regexfind('^(.*),(.*)$',prepLname,2),'');
	filter_LastNameSufx := StringLib.StringCleanSpaces(StringLib.StringFilterOut(tmpLastName_comma2,'".,?-`'));
	getLastNameSufx		:= if( filter_LastNameSufx in setValidSuffix,filter_LastNameSufx,'');
	getLastName :=  if(regexfind('^(.*)/(.*)$',prepLName) and prepLName != 'N/A', 
																regexfind('^(.*)/(.*)$',prepLname,1),
																 if(getLastNameSufx != '',tmpLastName_comma1,
																		if(regexfind('^(.*),(.*)$',prepLname) and getLastNameSufx = '', prepLname,
																				if(regexfind(AKA_Ind, prepLname), 
																						Prof_License_Mari.mod_clean_name_addr.GetCorpName(prepLname),
																				Prof_License_Mari.fGetNickname(prepLname,'strip_nick')
																				))));
	self.last_name				:= getLastName;

	replaceNull			:= REGEXREPLACE('\\v', trimSuffix, '');
	convertSuffix		:= CASE(replaceNull,
													'11' 	=> 'II',
												 '111' 	=> 'III',
													'1V' 	=> 'IV',
												'FOUTH' => '4TH',
														'2'	=> '2ND',
														'3'	=> '3RD',
														'4'	=> '4TH',
														'5'	=> 'V',
													'LL'	=> 'II',        
													'LLL' => 'III', 
												'II II'	=> 'II',
											'III III'	=> 'III',
										'JR OR II' 	=> 'JR',
										'II OR JR'	=> 'JR',
											'JR III'	=> 'JR',
										'MISS  MS'  => 'MS',
												'MRRS'	=> 'MRS',
													replaceNull);

	self.suffix := if(convertSuffix in setValidSuffix,
										 convertSuffix,
										if(getLastNameSufx != '' ,getLastNameSufx,
																			''));
  self.std_name_prefix	:= if(convertSuffix in setValidPrefix,convertSuffix,'');		

// Extract Nickanme from Name Fields	
	getNickFirst 	:=  if(regexfind(AKA_Ind, prepFName), 
												Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepFName),
												if(regexfind(slash_pattern_2,prepFName) and prepFName != 'N/A' and prepFName[1] != '/'
															and not regexfind(NameDate_Pattern,prepFName),
																regexfind(slash_pattern_2,prepFname,2),
														if(regexfind(slash_pattern_1,prepFName) and prepFName != 'N/A' and prepFName[1] != '/'
																	and not regexfind(NameDate_Pattern,prepFName), 
																	regexfind(slash_pattern_1,prepFname,2),	
												 if(prepFName[1] != '"' and not regexfind('(NICKNAME|NICK NAME|NICK-NAME)',prepFName),Prof_License_Mari.fGetNickname(prepFname,'nick'),
													''))));
													
	
	getNickMiddle := if(regexfind('^(.*)/(.*)$',prepMname) and prepMName != 'N/A' and not regexfind('(SHORT/NICKNAME)',prepMName), 
											regexfind('^(.*)/(.*)$',prepMname,2),
													if(regexfind(AKA_Ind, prepMName), 
															Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepMName),
																	if(not regexfind('(NICKNAME|NICK NAME|NICK-NAME|CONFIRMATION|MAIDE NAME)',prepMName),
																						Prof_License_Mari.fGetNickname(prepmname,'nick'),
																						'')) );
//Maiden Name Exist in Field													
	getNickLast 	:= 	if(regexfind(AKA_Ind, prepLname),Prof_License_Mari.mod_clean_name_addr.GetDBAName(prepLName),
													'');
	getNickSuffx	:= if(convertSuffix not in setGender 
														 and convertSuffix not in setMarital
														 // and convertSuffix not in setNumber
														 and convertSuffix not in setNickname
														 and convertSuffix not in setBogusSuffix
														 and convertSuffix not in setTitle
														 and convertSuffix not in setValidPrefix
														 and convertSuffix not in setGender
														 and convertSuffix not in setValidSuffix
														 and not regexfind('(^[^A-Z]+)$',convertSuffix),
														 convertSuffix,'');
  self.nickname		:= if(getNickFirst != '', getNickFirst,
												if(getNickMiddle != '', getNickMiddle,
													if(getNickLast != '', getNickLast,
														if(getNickSuffx != '' 
																and convertSuffix not in setMarital
																	and convertSuffix not in setURL
																	and not regexfind(Datepattern, convertSuffix), getNickSuffx,
															'')
																	)));	

//Populating Miscellaneous Fields From Name Fields																	
  self.std_name_title	:= 	if( convertSuffix in setTitle,convertSuffix,'');
	self.maiden_name := '';
	self.std_name_type	:= if(convertSuffix = 'LEGAL NAME', convertSuffix,
														if( convertSuffix in setNameType,'MAIDEN NAME',trimNameType));
	self.gender		:= if( convertSuffix in setGender,convertSuffix,'');
	self.marital_status := if( convertSuffix in setMarital,convertSuffix,'');
	
// Extracting Assuming DOB, SSN, Misc ID	
	self.misc_info := if(regexfind('(^[^A-Z]+)$',convertSuffix) and convertSuffix not in setValidSuffix, convertSuffix,
												if(regexfind(datepattern, trimLName),trimLName,
														if(regexfind(NameDate_Pattern,prepFName),
																regexfind(NameDate_Pattern,prepFName,2),
																			'')));
	self.url   := if( convertSuffix in setURL,StringLib.StringCleanSpaces(trimFName+trimMname+trimLName+'.'+trimSuffix),'');
	self := L;
END;

CleanUpIndvAka			:= project(pIndvAKAFile,map_indv_aka(left)) : persist('~thor_data400::persist::proflic_mari::nmls_individual_aka'); 

return CleanUpIndvAka;
		
end;
