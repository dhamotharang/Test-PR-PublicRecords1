// Logic to extract fields out of PROVNOTE fields

import ut, Address, Standard, Prof_License_Mari, lib_stringlib ,Lib_FileServices, std;

EXPORT  fBaseFix(DATASET(recordof(Prof_License_Mari.layouts.base)) pDataset) := FUNCTION 


provnote_pattern	:= '^(.*):(.*)$';
violation_pattern	:= '^((.*)/(.*)/([0-9]{4}))((.*)-(.*)-(.*)-?([0-9]{1,}))[ ]([A-Za-z ]+)$';
company_list	:= '(P[.]W[.]H[.]O[.]A|E[.]P[.]A[.]|HOSPITLAL|CORNING GLASS WORKS| TECH | AREA|WEBSTER HALL|BASF FIBERS|ANNEX)';
exclusion_list := '(P\\.O\\.|SUITE|ROOM|STATION|REGION|AIRNG BASE|FIREHOUSE|PKWAY|WRHS|ROAD|CTR| BOX |EXTENSION|ARMY TERMINAL|DISPATCH| FLOOR|TOWER| ST[.]$)';

name_filter_set := ['1057CG-20III 1057CG-20III','LASTNAME FIRSTNAME','NAME NAME','210CG-20IIIR 210CG-20IIIR','PAGE -1','RECORD 2',
										'CONSUMER AFFAIRS TESTER','ONLINE TESTING','ONLINE TESTING 2','XXX','TEST ACCOUNT1','TEST SALES','TRAINEE TEST APPRAISER',
										'APPRAISER RESIDENTIAL','APPRAISER STATE','APPRAISER GENERAL','LAST NAME','FIRST NAME','SMITH SEE #29304554','SMITH SEE #293045154',
			              'RECORD DUPLICATE .','SORT NAME','TESTER CONSUMER','TESTING ONLINE','TESTING 2 ONLINE','ONLINE TESTING 2'];

type_filter_set := ['(520)401-8','(602)317-1','9/1/2010','9/29/2010'];
mari_dba_set		:= ['INC','INC.','CORPORATION','INCORPORATED','CORP','L. L. C.','CORP.','LTD.','THE'];

filter_misc_record := pDataset(trim(name_org) not in name_filter_set);

//Remove Records with NonPrintable Characters
filter_nonprintable := filter_misc_record(regexfind('[\\x00-\\x1F\\x7F]', trim(name_org)) and std_source_upd = 'S0654');
new_misc_record := filter_misc_record - filter_nonprintable;

//Extract Data from PROVNOTE FIELDS
recordof(pDataset)				xformBase(recordof(pDataset) L) := transform

//Blank Out NAME_FiRST with Numbers
self.NAME_FIRST 						:= if(L.STD_SOURCE_UPD = 'S0869' AND regexfind('[0-9]', trim(L.NAME_FIRST)),'',L.NAME_FIRST);

//Fix Parsing in NAME_MARI_DBA field
self.NAME_MARI_ORG					:= if(L.NAME_MARI_DBA != '' AND L.NAME_DBA = '' AND L.NAME_MARI_DBA IN mari_dba_set, 
																		STD.Str.CleanSpaces(L.NAME_MARI_ORG + ' '+ L.NAME_MARI_DBA), 
																		L.NAME_MARI_ORG);
self.NAME_MARI_DBA					:= if(L.NAME_MARI_DBA != '' AND L.NAME_DBA = '' AND L.NAME_MARI_DBA IN mari_dba_set,'', 
																	IF( LENGTH(TRIM(L.NAME_DBA)) < 2, '',
																	L.NAME_MARI_DBA));
															
self.STD_LICENSE_TYPE       := IF(trim(L.STD_LICENSE_TYPE) not in type_filter_set,L.STD_LICENSE_TYPE,'');

self.CURR_ISSUE_DTE					:= IF(TRIM(L.CURR_ISSUE_DTE) = '0   0000','',L.CURR_ISSUE_DTE);
self.ORIG_ISSUE_DTE					:= IF(TRIM(L.ORIG_ISSUE_DTE) = '0   0000','',L.ORIG_ISSUE_DTE);
self.EXPIRE_DTE							:= IF(TRIM(L.EXPIRE_DTE) = '0   0000','',L.EXPIRE_DTE);

//Populate Business Type Field
self.BUSINESS_TYPE		:= 	IF(L.BUSINESS_TYPE = '' AND REGEXFIND('(BUSINESS TYPE)',L.PROVnOTE_1),REGEXFIND(provnote_pattern,L.PROVNOTE_1,2),
																L.BUSINESS_TYPE);

//Populate Renewal Date
getRENEWAL_DATE	:= IF(REGEXFIND('(RENEWAL DUE|DUE DATE|RENEWAL DATE)',L.PROVnOTE_1),REGEXFIND(provnote_pattern,L.PROVNOTE_1,2),'');
self.RENEWAL_DTE			:= IF(L.RENEWAL_DTE = '' AND getRENEWAL_DATE != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(getRENEWAL_DATE),
															L.RENEWAL_DTE);

//Populate Broker Fields
self.BRKR_LICENSE_NBR	:= IF(L.BRKR_LICENSE_NBR = '' AND L.STD_SOURCE_UPD = 'S0825' AND REGEXFIND('ASSOCIATE BROKER LICENSE NUMBER',L.PROVNOTE_1),L.LICENSE_NBR_CONTACT,
																L.BRKR_LICENSE_NBR);

self.OFF_LICENSE_NBR_TYPE	:= IF(L.OFF_LICENSE_NBR_TYPE = '' AND REGEXFIND('(AFFILIATED LICENSED CORPORATION\\(S\\)|EMPLOYING BROKER\'S LICENSE NUMBER|DESIGNATED OFFICER)',L.PROVNOTE_1),REGEXFIND(provnote_pattern,L.PROVNOTE_1,1),
																	L.OFF_LICENSE_NBR_TYPE); 
self.BRKR_LICENSE_NBR_TYPE	:= IF(L.BRKR_LICENSE_NBR_TYPE = '' AND REGEXFIND('(ASSOCIATE BROKER LICENSE NUMBER)',L.PROVNOTE_1),'ASSOCIATE BROKER LICENSE NUMBER',
																		L.BRKR_LICENSE_NBR_TYPE); 
       
																		
//Populate Violation Fields
tmpViolation := 	if(REGEXFIND('(VIOL|CRIMINAL)',L.PROVNOTE_1),stringlib.stringfilterout(L.PROVNOTE_1,'('),L.PROVNOTE_1);
getVIOL_DESC		:= if(REGEXFIND('(VIOL|CRIMINAL)',tmpViolation),REGEXFIND(violation_pattern,tmpViolation,10),'');
getViolationDate	:= if(REGEXFIND('(VIOL|CRIMINAL)',tmpViolation),REGEXFIND(violation_pattern,tmpViolation,1),'');

tmpVIOL_DESC := MAP(STD.Str.Find(getVIOL_DESC,'VIOLATION',1) > 0 => STD.Str.FindReplace(getVIOL_DESC,'VIOLATION','VIOLATION'),
										STD.Str.Find(getVIOL_DESC,'VIOLATI',1) > 0 => STD.Str.FindReplace(getVIOL_DESC,'VIOLATI','VIOLATION'),
										STD.Str.Find(getVIOL_DESC,'VIOLAT',1) > 0 => STD.Str.FindReplace(getVIOL_DESC,'VIOLAT','VIOLATION'),
										STD.Str.Find(getVIOL_DESC,'VIOLA',1) > 0 => STD.Str.FindReplace(getVIOL_DESC,'VIOLA','VIOLATION'),
										STD.Str.Find(getVIOL_DESC,'VIOL',1) > 0 => STD.Str.FindReplace(getVIOL_DESC,'VIOL','VIOLATION'),
																					getVIOL_DESC);														
self.VIOL_DESC				:= IF(L.VIOL_DESC = '' AND L.PROVNOTE_1 = 'NO CURRENT ENFORCEMENT ACTIONS',L.PROVNOTE_1,
														IF(L.VIOL_DESC = '' AND tmpVIOL_DESC != '', tmpVIOL_DESC,
																		L.VIOL_DESC));
SELF.VIOL_DTE					:= if(L.VIOL_DTE = '' AND getViolationDate != '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(getViolationDate),
																L.VIOL_DTE);
self.VIOL_CASE_NBR		:= if(L.VIOL_CASE_NBR = '' AND REGEXFIND('(VIOL|CRIMINAL)',tmpViolation),REGEXFIND(violation_pattern,tmpViolation,5),
																L.VIOL_CASE_NBR);

//Remove Agent Data
agent_exclusion := ['AGENT 4','AGENT F','AGENT FO','AGENT FOR','AGENT FOR F',
								'AGENT SEE (096062','AGT FOR','AGENT FOR C','AGENT FOR CO',
								'AGENT FOR F','AGENT FOR FT','AGENT FOR FT M','AGENT FOR N','AGT FO'];
								

prepAgentName		:= IF(L.PROVNOTE_1 in agent_exclusion,'',
											regexreplace('(AGT |RECEIVER |^AGE )',L.PROVNOTE_1,'AGENT '));

//Extract Contact Info		
prepContactInfoInit	:= regexreplace('C/0',L.provnote_1,'C/O'); 
getContactInfo := if(regexfind('(ATTENTION)',prepContactInfoInit)
											and not prof_license_mari.func_is_company(prepContactInfoInit) 
											AND NOT REGEXFIND(exclusion_list,prepContactInfoInit)
											and not (regexfind('^[2-9]\\d{2}-\\d{3}-\\d{4}$',prepContactInfoInit)  OR
															 regexfind('((\\(\\d{3}\\) ?)|(\\d{3}-))?\\d{3}-\\d{4}',prepContactInfoInit))
											and not regexfind(company_list, prepContactInfoInit), prepContactInfoInit,'');
											
prepContactInfo	:=	IF(REGEXFIND('(ATTENTION OF)',L.PROVnOTE_1),REGEXFIND(provnote_pattern,getContactInfo,2),'');
removeCareOf		:= 	if(prepContactInfo != '' and regexfind('(C/O)',prepContactInfo), Prof_License_Mari.fRemoveDBA_Contact.getDBAName(prepContactInfo,'CONTACT'),
													prepContactInfo);					
removeContactTitle := if(regexfind('(MANAGER|MGR[.]|PRESIDENT|VP\\/GC|TREAS)',removeCareOf),
									regexfind('^([A-Z \\,\\.]+)(TREASURER|\\(TREASURER\\)|TREAS[.]?|TREAS-MGR[.]?|MANAGER|MGR[.]?|[-]? PRESIDENT|VP/GC)$',removeCareOf,1),
												if(regexfind('^([0-9])',removeCareOf),'',
												if(removeCareOf[1] = '%',removeCareof[2..],
									  removeCareOf)));	


parseContact	:= if(length(trim(removeContactTitle)) <= 3,'',
										if(stringlib.stringfind(removeContactTitle,' ',1) < 1, '',
												if(removeContactTitle != '',Address.CleanPersonFML73(removeContactTitle),
														'')));
self.NAME_CONTACT_PREFX		:= IF(L.NAME_CONTACT_PREFX = '' AND parseContact != '', parseContact[1..5], L.NAME_CONTACT_PREFX);
self.NAME_CONTACT_FIRST		:= IF(L.NAME_CONTACT_FIRST = '' AND parseContact != '', parseContact[6..25], L.NAME_CONTACT_FIRST);
self.NAME_CONTACT_MID			:= IF(L.NAME_CONTACT_MID = '' AND parseContact != '', parseContact[26..45], L.NAME_CONTACT_MID);
self.NAME_CONTACT_LAST		:= IF(L.NAME_CONTACT_LAST = '' AND parseContact != '', parseContact[46..65], L.NAME_CONTACT_LAST);
self.NAME_CONTACT_SUFX		:= IF(L.NAME_CONTACT_SUFX = '' AND parseContact != '', parseContact[66..70], L.NAME_CONTACT_SUFX);
getContactTTL := if(regexfind('(MANAGER|MGR[.]|PRESIDENT|VP\\/GC|TREAS)',removeCareOf),
																	regexfind('^([A-Z \\,\\.]+)(TREASURER|\\(TREASURER\\)|TREAS[.]?|TREAS-MGR[.]?|MANAGER|MGR[.]?|[-]? PRESIDENT|VP/GC)$',removeCareOf,2),
																			'');
remove_punctContactTTL :=	STD.Str.CleanSpaces(STD.Str.FilterOut(getContactTTL,'().,-'));
standardContactTtl		:= CASE(remove_punctContactTTL,
															'MGR'      	=> 	'MANAGER',
															'TREAS'			=>	'TREASURER',
															'TREASMGR'	=>	'TREASURER',
															'VP/GC'			=>	'VICE PRESIDENT/GENERAL COUNSEL',	remove_punctContactTTL);
															
self.NAME_CONTACT_TTL			:= if(L.NAME_CONTACT_TTL = '' AND standardContactTtl != '',standardContactTtl,L.NAME_CONTACT_TTL);

getRank := IF(L.std_source_upd = 'S0513' and L.provnote_3 IN ['AA','AAL','AF','APPL','ATPP','BR','CGAP','CRAP','FM','LREA','PB','TN','TRN','TS'],
								L.provnote_3,'');
self.ADDL_LICENSE_SPEC		:= CASE(getRank,
																	'FM' 		=>	'FIRM',
																	'LREA' 	=>	'LICENSE REAL ESTATE APPRAISER',
																	'CGAP' 	=>	'CERTIFIED GENERAL REAL ESTATE APPRAISER',
																	'CRAP' 	=>	'CERTIFIED RESIDENTIAL REAL ESTATE APPRISER',
																	'AF'   	=>	'AFFILIATED BROKER',
																	'PB'   	=>	'PRINCIPAL BROKER',
																	'TS'   	=>	'TIME SHARE SALERSPERSON',
																	'BR' 		=>	'REAL ESTATE BROKER',
																	'TRN'		=>	'REGISTERED TRAINEE',
																	'AAL'		=>	'ACQUISITION AGENT',
																	'AA' 		=>	'ACQUISITION AGENT',
																	'APPL'	=>	'UNAPPROVED INITIAL',
																	'ATPP'	=> 'APPRAISER TEMPORARY PRACTICE',
																			L.ADDL_LICENSE_SPEC);
																	

convert_condition := MAP(TRIM(L.PROVNOTE_1) = 'CONDITIONAL LICENSE INDICATOR: B' => 'CONDITIONAL LICENSE INDICATOR: ADDITIONAL CONDITIONS OR LIMITATIONS IMPOSED AFFECTING THE LICENSEE\'S PRACTICE',    
												 TRIM(L.PROVNOTE_1) = 'CONDITIONAL LICENSE INDICATOR: C' => 'CONDITIONAL LICENSE INDICATOR: ADDITIONAL CONDITIONS OR LIMITATIONS IMPOSED FOR COMPLIANCE WITH BOARD OR COURT ORDER',                                           
												 TRIM(L.PROVNOTE_1) = 'CONDITIONAL LICENSE INDICATOR: Z' => 'CONDITIONAL LICENSE INDICATOR: ZONING',
												 TRIM(L.PROVNOTE_1) = 'CONDITIONAL LICENSE INDICATOR: V' => 'CONDITIONAL LICENSE INDICATOR: ADDITIONAL CONDITIONS OR LIMITATIONS INVOLVING VARIOUS DESCRIPTIONS',
												 TRIM(L.PROVNOTE_1) = 'LICENSE RESTRICTION INDICATOR: R' => 'LICENSE RESTRICTION INDICATOR: RESTRICTED',
																'');


self.PROVNOTE_1		:= MAP( getRENEWAL_DATE != '' => '',
                          tmpViolation  != '' => '',
                          L.BUSINESS_TYPE = '' AND REGEXFIND('(BUSINESS TYPE)',L.PROVnOTE_1) => '',
                          L.BRKR_LICENSE_NBR = '' AND L.STD_SOURCE_UPD = 'S0825' AND REGEXFIND('ASSOCIATE BROKER LICENSE NUMBER',L.PROVNOTE_1)
                                      => '',
                          L.OFF_LICENSE_NBR_TYPE = '' AND REGEXFIND('(AFFILIATED LICENSED CORPORATION\\(S\\)|EMPLOYING BROKER\'S LICENSE NUMBER|DESIGNATED OFFICER)',L.PROVNOTE_1)
                                      => '',
                          prepAgentName != ''     => prepAgentName,
													convert_condition != '' =>  convert_condition,
                                  L.PROVNOTE_1
                                           );
                                  
self.PROVNOTE_3   := IF( getRank != '','',L.PROVNOTE_3);


//DF-16148- Fix MARI Phone Fields, 
//Select the better phone number
fCleanPhoneNbr(string mari_phn, string phn) := function
getPhoneNumber      := If(mari_phn <> '', mari_phn, 
													 IF(length(trim(phn)) < 7, '',
																	 phn)); 
vPHN_MARI_1         := IF(std.str.find(STD.Str.ToUpperCase(getPhoneNumber), 'X',1) > 0, trim(getPhoneNumber[1..STD.Str.Find(STD.Str.ToUpperCase(getPhoneNumber), 'X', 1) -1], right), getPhoneNumber);
vPhoneNumber			  := MAP(vPHN_MARI_1 = '2.08838E+12'  => '', 
													vPHN_MARI_1 = '6o96542125' => '6096542125',
													vPHN_MARI_1 = '5o73819228' => '5073819228',
													vPHN_MARI_1 = '800-561-4567; 8' => '800-561-4567',
														vPHN_MARI_1);
temp_phone					:= ut.CleanPhone(STD.Str.Filter(trim(vPhoneNumber),'0123456789'));
clean_phone 				:= IF(temp_phone in ['0000000000','9999999999'],'',          
													IF(temp_phone = '' and length(trim(vPhoneNumber)) > 10 and phn <> '', phn, temp_phone));
return clean_phone;
end;


self.PHN_MARI_1					:= fCleanPhoneNbr(L.PHN_MARI_1, L.PHN_PHONE_1);
self.PHN_MARI_FAX_1			:= fCleanPhoneNbr(L.PHN_MARI_FAX_1, L.PHN_FAX_1);
self.PHN_MARI_2					:= fCleanPhoneNbr(L.PHN_MARI_2, L.PHN_PHONE_2);
self.PHN_MARI_FAX_2			:= fCleanPhoneNbr(L.PHN_MARI_FAX_2, L.PHN_FAX_2);


SELF := L;
END;	

ds_base:= project(new_misc_record, xformBase(left));

return ds_base;

end;

