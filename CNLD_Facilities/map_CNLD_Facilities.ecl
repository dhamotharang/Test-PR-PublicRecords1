#workunit('name','CNLD Facilities')

import ut, CNLD_Facilities, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date, address;
		 
		 
export map_CNLD_Facilities(string process_date) := function
	
	
  string8  fSlashedMDYtoCYMD(string pDateIn) 
						:= intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
								+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
								+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
		 
	   
// Standard Date Format YYYYMMDD
Format_Date(integer2 year, integer1 month, integer1 day) :=
        (string4)year+intformat(month,2,1)+intformat(day,2,1);

fn_RemoveSpecialChars(string s, string replacement=' ') := 
			REGEXREPLACE('([*^ |~_/".]+)',s,replacement);

// string8 process_date:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();

amp_pattern	:= '^(.*)\\@[ ]?(.*)$';
semicolon_pattern := '^(.*)\\;[ ]?(.*)$';
colon_pattern := '^(.*)\\:[ ]?(.*)$';
pound_pattern	:= '^(.*)#[ ]?([0-9]+)';
// CO_pattern := '^(.*)(C/O | C/0|ATTN:|ATTN |ATT:)(.*)$';

C_O_Ind := '(C/O |ATTN:| ATTN |ATTENTION:|ATT:|%|ATN:|^ATTN )';
DBA_Ind := '( DBA$|D/B/A | D/B/A|/DBA | DBA |DBA:|/DBA|^DBA/|^DBA | A/K/A| AKA |^AKA |T/A |A/K/A |A/K/A$|^D B A|/DBA/)';
addr_DBA := '(DBA: |D/B/A |D B A |/DBA/|DBA/)';

BusExceptions := '(2.5% |-2-|.COM|A.M.E.|AM CAN CO|ASSIST 2 |E.P.A.|EVOFI ONE|EXCLUSIVE| HOME |HOSPITLAL|INTEGRITY 1ST|IRELAND|JD R E|KEYSTONE|'+
									'L.C.|L[.]L[.]C[.]| LP\\>|LONG AND FOSTER|NEWS DISPATCH|PALM HARBOR |PIERRE|PIERCE|POLICE|P.W.H.O.A.|'+
									'OWENS CORNING FIBE|SACRED HEART| SERVS|STOCKING|SVC|STATION|TECH PROD|TELEPHONE|TERMINAL|TRNTY PROP SERV| WORKS|WEBSTER HALL|'+
									'BASE, TN|PLANT EMPLOYEE)';

AddrExceptions := '(PLAZA| PLZ|^BLDG |^BLGD | BLDG|BLDING|BUILDING | BLD |APARTMENT|ONE | AVE |AVENUE| AV |^AVE | TOWER| BLVD|GENERAL DELIVERY| ESTS|'+
									'ROAD|^R D | AND MAIN\\>| & MAIN\\>|^THREE |^THIRD |THOUSAND|^FOUR|^SIX |^SIXTH |^ELEVENTH|^FIFTH|^FIVE|^NINTH |^EIGHTH |^SEVENTH |^TENTH |^TWELFTH|^TWELVETH|RIVERWALK|'+
									' ALLEY|SECOND|FLOOR|PAVILION|PAVILLION| RD|TOWN$|LEVEL|LOWR LL|CREEK|ROUTE|^RTE|CENTRE| CTR\\>| CT\\>| DR\\>| PARK|DRIVE| SQUARE| SQ\\>| WAY|LOCATION|^UNIT |UNIT |'+
									'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND| MALL| VILLA$|P M B|PMB | LODGE|^BOOTH |ACRES|AIRPORT|'+
									'UPPER|TRACE|#|LANE|LAGOONS|PENTHOUSE |POST OFFICE|^POST| STS\\>| AVES\\>| ST\\>|STREET|FRONT|FAIR GROUNDS|FAIRGROUNDS|BETWEEN|'+
									'APT.|APT |APT[.] |APT$|APARTMENT |P O |PO |POB |PO DRAWER|P O DRAWER|^DRAWER |BOX |BOX|ROOM |^RT | RT |HIGHWAY|HWY|RIDGE| PL\\>|'+
									'EXPRESSWAY| STE |^STE |^SUIT |STE |SUITE|SU | PKWY|CROSSING|CORNER OF|& MAINLAND| AT MAIN|MAIN AND|MAIN &|^HCR|MAIL STOP| LN\\>| MANOR\\>| MNR\\>| TPKE\\>|'+
									'METROPLEX|PARKWAY|^COURT |^PH |^RM | RM\\>|^ROOM |LBBY|^SPC |BSMT|OFC|TRLR|^LOT | LOT\\>|^FL | CENTER WEST| TERRACE\\>| TRAIL\\>| TR\\>| TRL\\>|'+
									'STUDIO|MARKETPLACE| COMMONS\\>|CORPORATE CENTER|COMMERCE CENTER|EXECUTIVE CENTER|PROFESSIONAL CEN|SHOPPING|SHOPPING CTR|CITY CENTER|SUBDIVISION|'+
									'SHOPPING CENTER|BUSINESS OFFICE|SHOP COMPLEX|NAVAL STATION|NAVAL AIR STATION|AIR FORCE BASE|PROFESSIONAL COMPLEX|VETERANS HOME|MARINA|RESIDENTIAL|'+
									'METROPOLITAN|^LAKE | LAKE\\>| TWP| CONDO|COTTAGE|RESORT|HALF DAY|FREEWAY| CIRCLE\\>| CIR\\>|HARBOR|^NORTHERN|^NORTH| COVE\\>|ARENA|CAFE|AISLE| PATH\\>)'; 

valid_unit_desig := '( APT|^APT|BSMT|BLDG|^FL |FRNT|HNGR|LBBY|^LOT |LOWR|OFC|^PH |PIER|^REAR|^RM |^SIDE|SLIP|SPC|^STOP|^STE |TRLR|^UNIT|^UPPR)';


//Pull Input Data Sample
inFile_base 	:= CNLD_Facilities.file;


layout_FacilityAddl := record, maxsize(5000)
	string8  FIRST_SEEN_DATE;
	string8  LAST_SEEN_DATE;
	string8  PROCESS_DATE;
	CNLD_Facilities.layout;
	string40 STD_PROF_DESC,
	string40 STD_PROF_STAT,
	string50 NAME_CONTACT_1,
	string50 NAME_CONTACT_2,
	string50 NAME_CONTACT_3,
	string60 NAME_DBA_1,
	string60 NAME_DBA_2,
	string60 NAME_DBA_3,
end;

layout_FacilityAddl xformFile(CNLD_Facilities.layout pInput) 
    := 
	   TRANSFORM
			self.first_seen_date := '20090226';
			self.last_seen_date	 := '20090226';
			self.process_date			:= process_date;
			
	    TrimNAME_ORG	:= ut.fnTrim2Upper(pInput.org_name);
			TrimAddr1_1 := ut.fnTrim2Upper(pInput.addr1_line1);
			TrimAddr2_1	:= ut.fnTrim2Upper(pInput.addr2_line1);
			TrimAddr3_1	:= ut.fnTrim2Upper(pInput.addr3_line1);
			TrimAddr1_2	:= ut.fnTrim2Upper(pInput.addr1_line2);
			TrimAddr2_2	:= ut.fnTrim2Upper(pInput.addr2_line2);
			TrimAddr3_2	:= ut.fnTrim2Upper(pInput.addr3_line2);
			
			prepNAME_ORG		:= MAP(TrimNAME_ORG[1..6] = 'ATTN: ' => TrimNAME_ORG[7..],
														 StringLib.stringfind(TrimNAME_ORG,'%',1) > 0 => StringLib.StringFilterOut(TrimNAME_ORG, '%'),
														 StringLib.stringfind(TrimNAME_ORG,'@',1) > 0 and TrimNAME_ORG[1] != '@' =>
																	StringLib.StringCleanSpaces(regexfind(amp_pattern,TrimNAME_ORG,1) + ' ('+ regexfind(amp_pattern,TrimNAME_ORG,2) + ')'),
														 REGEXFIND(DBA_Ind,TrimNAME_ORG) and REGEXFIND('^([^0-9])*$',TrimAddr1_1) => TrimNAME_ORG + ' '+TrimAddr1_1,
														 REGEXFIND(DBA_Ind,TrimNAME_ORG) and StringLib.stringfind(TrimAddr2_1,'PHARMACY',1) > 0 => TrimNAME_ORG + ' '+TrimAddr2_1,
														 												TrimNAME_ORG);
																										
			getCORP_NAME := CNLD_Facilities.fRemoveDBA_Contact.GetCorpName(prepNAME_ORG);														
			getNAME_ORG		:= MAP(StringLib.stringfind(getCORP_NAME,';',1) > 0 => REGEXFIND(semicolon_pattern,getCORP_NAME,1),
														StringLib.stringfind(getCORP_NAME,':',1) > 0 => REGEXFIND(colon_pattern,getCORP_NAME,1)+ ' ('+ regexfind(colon_pattern,getCORP_NAME,2) + ')',
																	getCORP_NAME);
			stripNAME_ORG := fn_RemoveSpecialChars(getNAME_ORG);													
			 
//Removing STORENO from ORG_NAME field
			TrimStoreNo		:= ut.fnTrim2Upper(pInput.StoreNo);
			getSTORENO 		:= IF(TrimStoreNo = '' and StringLib.stringfind(stripNAME_ORG[3..],'#',1) > 0,regexfind(pound_pattern,getNAME_ORG,2),'');
			removeSTRNO		:= IF(getSTORENO <> '' and StringLib.StringFind(stripNAME_ORG[3..],'#',1) > 0, StringLib.StringFindReplace(stripNAME_ORG,'#'+ getSTORENO,''),
												 																											stripNAME_ORG);
			self.ORG_NAME	:= IF(Stringlib.stringfind(stripNAME_ORG,'()',1) > 0,StringLib.StringFilterOut(stripNAME_ORG, '()'),StringLib.StringCleanSpaces(removeSTRNO));
			self.STORENO			:= IF(getStoreNo != '',getStoreNo,TrimStoreNo);
			
//Removing DBA/Contact Names from Address fields
			prepTrimAddr1_1 := IF(REGEXFIND(DBA_Ind,TrimNAME_ORG) and REGEXFIND('^([^0-9])*$',TrimAddr1_1),'',
															regexreplace(addr_DBA,TrimAddr1_1,'D/B/A '));
			prepTrimAddr2_1 := If(REGEXFIND(DBA_Ind,TrimNAME_ORG) and StringLib.stringfind(TrimAddr2_1,'PHARMACY',1) > 0,'',
																regexreplace(addr_DBA,TrimAddr2_1,'D/B/A '));
			prepTrimAddr3_1 := regexreplace(addr_DBA,TrimAddr3_1,'D/B/A ');
			prepTrimAddr1_2 := If(StringLib.Stringfind(TrimAddr1_2,'%',1) > 0, StringLib.StringFindReplace(TrimAddr1_2,'%','C/O '),
																regexreplace(addr_DBA,TrimAddr1_2,'D/B/A '));
			prepTrimAddr2_2 := regexreplace(addr_DBA,TrimAddr2_2,'D/B/A ');
			prepTrimAddr3_2 := regexreplace(addr_DBA,TrimAddr3_2,'D/B/A ');
								
			self.ADDR1_LINE1 :=  CNLD_Facilities.fRemoveDBA_Contact.fn_getAddr(prepTrimAddr1_1);
			self.ADDR2_LINE1 :=  CNLD_Facilities.fRemoveDBA_Contact.fn_getAddr(prepTrimAddr2_1);
			self.ADDR3_LINE1 :=  CNLD_Facilities.fRemoveDBA_Contact.fn_getAddr(prepTrimAddr3_1);
		  self.ADDR1_LINE2 	:= CNLD_Facilities.fRemoveDBA_Contact.fn_getAddr(prepTrimAddr1_2);
			self.ADDR2_LINE2	:= CNLD_Facilities.fRemoveDBA_Contact.fn_getAddr(prepTrimAddr2_2);
			self.ADDR3_LINE2	:= CNLD_Facilities.fRemoveDBA_Contact.fn_getAddr(prepTrimAddr3_2);
			
			TrimCity_1	:= fn_RemoveSpecialChars(pInput.addr1_city);
			TrimCity_2	:= fn_RemoveSpecialChars(pInput.addr2_city);
			TrimCity_3	:= fn_RemoveSpecialChars(pInput.addr3_city); 
		  self.ADDR1_CITY		:= TrimCity_1;
			self.ADDR2_CITY		:= IF(StringLib.stringfind(TrimCity_2,' ',3) > 1 and regexfind(AddrExceptions,TrimCity_2) and TrimCity_1 <> TrimCity_2
																 and prepTrimAddr2_1 = '','',TrimCity_2);
			self.ADDR3_CITY		:= IF(StringLib.stringfind(TrimCity_3,' ',3) > 1 and regexfind(AddrExceptions,TrimCity_3) and TrimCity_1 <> TrimCity_3
																	and prepTrimAddr3_1 = '','',TrimCity_3);
			 
		  self.ADDR1_ST		:= ut.fnTrim2Upper(pInput.ADDR1_ST);
			self.ADDR2_ST		:= ut.fnTrim2Upper(pInput.ADDR2_ST);
			self.ADDR3_ST		:= ut.fnTrim2Upper(pInput.ADDR3_ST);
		  self.ADDR1_ZIP		:= pInput.ADDR1_ZIP;
			self.ADDR2_ZIP		:= pInput.ADDR2_ZIP;
			self.ADDR3_ZIP		:= pInput.ADDR3_ZIP;
			self.ADDR1_PHONE	:= IF((integer)pInput.addr1_phone = 0,' ',stringlib.stringfilter(pInput.addr1_phone,'0123456789')[1..10]);
			self.ADDR2_PHONE	:= IF((integer)pInput.addr2_phone = 0,' ',stringlib.stringfilter(pInput.addr2_phone,'0123456789')[1..10]);
			self.ADDR3_PHONE	:= IF((integer)pInput.addr3_phone = 0,' ',stringlib.stringfilter(pInput.addr3_phone,'0123456789')[1..10]);
			self.ADDR1_FAX		:= IF((integer)pInput.addr1_fax = 0,' ',stringlib.stringfilter(pInput.addr1_fax,'0123456789')[1..10]);
			self.ADDR2_FAX		:= IF((integer)pInput.addr2_fax = 0,' ',stringlib.stringfilter(pInput.addr2_fax,'0123456789')[1..10]);
			self.ADDR3_FAX		:= IF((integer)pInput.addr3_fax = 0,' ',stringlib.stringfilter(pInput.addr3_fax,'0123456789')[1..10]);
			self.PROFCODE				:= pInput.PROFCODE;
			self.PROFSTAT				:= pInput.PROFSTAT;
			
			TrimNAME_OWN := StringLib.StringCleanSpaces(ut.fnTrim2Upper(pInput.ownername));
			self.OWNERNAME			:= IF(length(trim(TrimNAME_OWN)) < 3,'',TrimNAME_OWN);
			self.OWNERTYPE			:= pInput.OWNERTYPE;
			self.STD_PROF_DESC		:= '';
			self.STD_PROF_STAT		:= '';
			
			tmpBUS_CONTACT	:= CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepNAME_ORG,'CONTACT');
			self.NAME_CONTACT_1		:= IF(tmpBUS_CONTACT != '', tmpBUS_CONTACT,
																	IF(prepTrimAddr1_1 != '',CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr1_1,'CONTACT'),
																							CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr1_2,'CONTACT')));
			self.NAME_CONTACT_2		:= IF(prepTrimAddr2_1 != '',CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr2_1,'CONTACT'),
																							CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr2_2,'CONTACT'));
			self.NAME_CONTACT_3		:= IF(prepTrimAddr3_1 != '',CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr3_1,'CONTACT'),
																							CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr3_2,'CONTACT'));

			tmpBUS_DBA := IF(StringLib.stringfind(prepNAME_ORG,';',1) > 0, REGEXFIND(semicolon_pattern,prepNAME_ORG,2),
												IF(REGEXFIND(' DBA$',prepNAME_ORG),'',
																		CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepNAME_ORG,'DBA')));																				
			self.NAME_DBA_1				:= IF(tmpBUS_DBA != '', tmpBUS_DBA,
																	IF(prepTrimAddr1_1 != '',CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr1_1,'DBA'),
																							CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr1_2,'DBA')));
			self.NAME_DBA_2				:= If(prepTrimAddr2_1 != '',CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr2_1,'DBA'),
																							CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr2_2,'DBA')); 
			self.NAME_DBA_3				:= If(prepTrimAddr3_1 != '',CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr3_1,'DBA'),
																							CNLD_Facilities.fRemoveDBA_Contact.getDBAName(prepTrimAddr3_2,'DBA')); 																	
			self := pInput;
			// self := [];
	   
END;

dsRecOut_dist     := sort(distribute(PROJECT(inFile_base, xformFile(left)),hash(gennum)),gennum,local);

//Dataset reference files for lookup joins
ds_Status_Desc	:= Prof_License_Mari.files_References.MARIcmvLicStatus;
ds_Prof_Desc		:= Prof_License_Mari.files_References.MARIcmvProf;

																		
// Populate prof code description
layout_FacilityAddl trans_prof_desc(dsRecOut_dist L, ds_Prof_Desc R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

dsProf_desc := JOIN(dsRecOut_dist, ds_Prof_Desc,
						 TRIM(left.profcode,left,right)= TRIM(right.prof_cd,left,right),
						 trans_prof_desc(left,right),left outer,lookup);
						 
// Populate License Status Description field
layout_FacilityAddl trans_status_desc(dsProf_desc L, ds_Status_Desc R) := transform
  self.STD_PROF_STAT := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
  self := L;
end;

dsStatus_desc := jOIN(dsProf_desc, ds_Status_Desc,
							TRIM(left.profstat,left,right)= TRIM(right.license_status,left,right),
							trans_status_desc(left,right),left outer,lookup);


// Normalizing the file
r1 := RECORD
		layout_FacilityAddl;
		string9		deanbr;						// 10 iterations
		string8		deanbr_exp;				// 10 iterations
		string7		deanbr_sch;				// 10 iterations
		
END;


r1 NormItDeaNbr(layout_FacilityAddl L, INTEGER C) := TRANSFORM
SELF := L;
SELF.deanbr := CHOOSE(C, L.deanbr1, L.deanbr2, L.deanbr3, L.deanbr4, L.deanbr5, L.deanbr6, L.deanbr7, L.deanbr8, L.deanbr9, L.deanbr10);
SELF.deanbr_exp := CHOOSE(C, L.deanbr_exp1, L.deanbr_exp2, L.deanbr_exp3, L.deanbr_exp4, L.deanbr_exp5, L.deanbr_exp6, L.deanbr_exp7, L.deanbr_exp8, L.deanbr_exp9, L.deanbr_exp10);
SELF.deanbr_sch := CHOOSE(C, L.deanbr_sch1, L.deanbr_sch2, L.deanbr_sch3, L.deanbr_sch4, L.deanbr_sch5, L.deanbr_sch6, L.deanbr_sch7, L.deanbr_sch8, L.deanbr_sch9, L.deanbr_sch10);
END;

NormDeaNbr := DEDUP(NORMALIZE(dsStatus_desc,10,NormItDeaNbr(LEFT,COUNTER)),all,record);

NoDeaRecs	:= NormDeaNbr(deanbr1 = '' AND deanbr2 = '' AND deanbr3 = '' AND deanbr4 = '' AND deanbr5 = '' AND deanbr6 = '' and deanbr7 = ''
													and deanbr8 = '' and deanbr9 = '' and deanbr10 = '');
DeaRecs 	:= NormDeaNbr(deanbr != '');
FilteredDeaRecs  := DeaRecs + NoDeaRecs;


r2 := RECORD
			r1;
		string2		st_lic_in;				// 50 iterations
		string15	st_lic_num;				// 50 iterations
		string8		st_lic_num_exp;		// 50 iterations
		string3		st_lic_stat;				// 50 iterations
		string10	st_lic_type;				// 50 iterations
		
END;

r2 NormItStLic(FilteredDeaRecs L, INTEGER C) := TRANSFORM
SELF := L;
SELF.st_lic_in := CHOOSE(C, L.st_lic_in1, L.st_lic_in2, L.st_lic_in3, L.st_lic_in4, L.st_lic_in5, L.st_lic_in6, L.st_lic_in7, L.st_lic_in8, L.st_lic_in9, L.st_lic_in10,
													L.st_lic_in11, L.st_lic_in12, L.st_lic_in13, L.st_lic_in14, L.st_lic_in15, L.st_lic_in16, L.st_lic_in17, L.st_lic_in18, L.st_lic_in19, L.st_lic_in20,
													L.st_lic_in21, L.st_lic_in22, L.st_lic_in23, L.st_lic_in24, L.st_lic_in25, L.st_lic_in26, L.st_lic_in27, L.st_lic_in28, L.st_lic_in29, L.st_lic_in30,
													L.st_lic_in31, L.st_lic_in32, L.st_lic_in33, L.st_lic_in34, L.st_lic_in35, L.st_lic_in36, L.st_lic_in37, L.st_lic_in38, L.st_lic_in39, L.st_lic_in40,
													L.st_lic_in41, L.st_lic_in42, L.st_lic_in43, L.st_lic_in44, L.st_lic_in45, L.st_lic_in46, L.st_lic_in47, L.st_lic_in48, L.st_lic_in49, L.st_lic_in50);
													
SELF.st_lic_num := CHOOSE(C, L.st_lic_num1, L.st_lic_num2, L.st_lic_num3, L.st_lic_num4, L.st_lic_num5, L.st_lic_num6, L.st_lic_num7, L.st_lic_num8, L.st_lic_num9, L.st_lic_num10,
													L.st_lic_num11, L.st_lic_num12, L.st_lic_num13, L.st_lic_num14, L.st_lic_num15, L.st_lic_num16, L.st_lic_num17, L.st_lic_num18, L.st_lic_num19, L.st_lic_num20,
													L.st_lic_num21, L.st_lic_num22, L.st_lic_num23, L.st_lic_num24, L.st_lic_num25, L.st_lic_num26, L.st_lic_num27, L.st_lic_num28, L.st_lic_num29, L.st_lic_num30,
													L.st_lic_num31, L.st_lic_num32, L.st_lic_num33, L.st_lic_num34, L.st_lic_num35, L.st_lic_num36, L.st_lic_num37, L.st_lic_num38, L.st_lic_num39, L.st_lic_num40,
													L.st_lic_num41, L.st_lic_num42, L.st_lic_num43, L.st_lic_num44, L.st_lic_num45, L.st_lic_num46, L.st_lic_num47, L.st_lic_num48, L.st_lic_num49, L.st_lic_num50);
													
SELF.st_lic_num_exp := CHOOSE(C, L.st_lic_num_exp1, L.st_lic_num_exp2, L.st_lic_num_exp3, L.st_lic_num_exp4, L.st_lic_num_exp5, L.st_lic_num_exp6, L.st_lic_num_exp7, L.st_lic_num_exp8, L.st_lic_num_exp9, L.st_lic_num_exp10,
													L.st_lic_num_exp11, L.st_lic_num_exp12, L.st_lic_num_exp13, L.st_lic_num_exp14, L.st_lic_num_exp15, L.st_lic_num_exp16, L.st_lic_num_exp17, L.st_lic_num_exp18, L.st_lic_num_exp19, L.st_lic_num_exp20,
													L.st_lic_num_exp21, L.st_lic_num_exp22, L.st_lic_num_exp23, L.st_lic_num_exp24, L.st_lic_num_exp25, L.st_lic_num_exp26, L.st_lic_num_exp27, L.st_lic_num_exp28, L.st_lic_num_exp29, L.st_lic_num_exp30,
													L.st_lic_num_exp31, L.st_lic_num_exp32, L.st_lic_num_exp33, L.st_lic_num_exp34, L.st_lic_num_exp35, L.st_lic_num_exp36, L.st_lic_num_exp37, L.st_lic_num_exp38, L.st_lic_num_exp39, L.st_lic_num_exp40,
													L.st_lic_num_exp41, L.st_lic_num_exp42, L.st_lic_num_exp43, L.st_lic_num_exp44, L.st_lic_num_exp45, L.st_lic_num_exp46, L.st_lic_num_exp47, L.st_lic_num_exp48, L.st_lic_num_exp49, L.st_lic_num_exp50);
													
SELF.st_lic_stat := CHOOSE(C, L.st_lic_stat1, L.st_lic_stat2, L.st_lic_stat3, L.st_lic_stat4, L.st_lic_stat5, L.st_lic_stat6, L.st_lic_stat7, L.st_lic_stat8, L.st_lic_stat9, L.st_lic_stat10,
													L.st_lic_stat11, L.st_lic_stat12, L.st_lic_stat13, L.st_lic_stat14, L.st_lic_stat15, L.st_lic_stat16, L.st_lic_stat17, L.st_lic_stat18, L.st_lic_stat19, L.st_lic_stat20,
													L.st_lic_stat21, L.st_lic_stat22, L.st_lic_stat23, L.st_lic_stat24, L.st_lic_stat25, L.st_lic_stat26, L.st_lic_stat27, L.st_lic_stat28, L.st_lic_stat29, L.st_lic_stat30,
													L.st_lic_stat31, L.st_lic_stat32, L.st_lic_stat33, L.st_lic_stat34, L.st_lic_stat35, L.st_lic_stat36, L.st_lic_stat37, L.st_lic_stat38, L.st_lic_stat39, L.st_lic_stat40,
													L.st_lic_stat41, L.st_lic_stat42, L.st_lic_stat43, L.st_lic_stat44, L.st_lic_stat45, L.st_lic_stat46, L.st_lic_stat47, L.st_lic_stat48, L.st_lic_stat49, L.st_lic_stat50);
													
SELF.st_lic_type := CHOOSE(C, L.st_lic_type1, L.st_lic_type2, L.st_lic_type3, L.st_lic_type4, L.st_lic_type5, L.st_lic_type6, L.st_lic_type7, L.st_lic_type8, L.st_lic_type9, L.st_lic_type10,
													L.st_lic_type11, L.st_lic_type12, L.st_lic_type13, L.st_lic_type14, L.st_lic_type15, L.st_lic_type16, L.st_lic_type17, L.st_lic_type18, L.st_lic_type19, L.st_lic_type20,
													L.st_lic_type21, L.st_lic_type22, L.st_lic_type23, L.st_lic_type24, L.st_lic_type25, L.st_lic_type26, L.st_lic_type27, L.st_lic_type28, L.st_lic_type29, L.st_lic_type30,
													L.st_lic_type31, L.st_lic_type32, L.st_lic_type33, L.st_lic_type34, L.st_lic_type35, L.st_lic_type36, L.st_lic_type37, L.st_lic_type38, L.st_lic_type39, L.st_lic_type40,
													L.st_lic_type41, L.st_lic_type42, L.st_lic_type43, L.st_lic_type44, L.st_lic_type45, L.st_lic_type46, L.st_lic_type47, L.st_lic_type48, L.st_lic_type49, L.st_lic_type50);
END;

NormStLic := DEDUP(NORMALIZE(FilteredDeaRecs,50,NormItStLic(LEFT,COUNTER)),all,record);


NoStLicRecs	:= NormStLic(st_lic_in1 = '' AND st_lic_in2 = '' AND st_lic_in3 = '' AND st_lic_in4 = '' AND st_lic_in5 = '' AND st_lic_in6 = '' AND st_lic_in7 = '' AND st_lic_in8 = '' AND st_lic_in9 = '' AND st_lic_in10 = ''
														AND st_lic_in11 = '' AND  st_lic_in12 = '' AND  st_lic_in13 = '' AND  st_lic_in14 = '' AND  st_lic_in15 = '' AND  st_lic_in16 = '' AND  st_lic_in17 = '' AND  st_lic_in18 = '' AND st_lic_in19 = '' AND  st_lic_in20 = ''
														AND st_lic_in21 = '' AND  st_lic_in22 = '' AND  st_lic_in23 = '' AND  st_lic_in24 = '' AND  st_lic_in25 = '' AND  st_lic_in26 = '' AND  st_lic_in27 = '' AND  st_lic_in28 = '' AND st_lic_in29 = '' AND  st_lic_in30 = ''
														AND st_lic_in31 = '' AND  st_lic_in32 = '' AND  st_lic_in33 = '' AND  st_lic_in34 = '' AND  st_lic_in35 = '' AND  st_lic_in36 = '' AND  st_lic_in37 = '' AND  st_lic_in38 = '' AND st_lic_in39 = '' AND  st_lic_in40 = ''
														AND st_lic_in41 = '' AND  st_lic_in42 = '' AND  st_lic_in43 = '' AND  st_lic_in44 = '' AND  st_lic_in45 = '' AND  st_lic_in46 = '' AND  st_lic_in47 = '' AND  st_lic_in48 = '' AND st_lic_in49 = '' AND  st_lic_in50 = '');
StLicRecs 	:= NormStLic(st_lic_in != '');
FilteredStLicRecs  := NoStLicRecs + StLicRecs;



r3 := RECORD
		r2;
		string10	fednum;						// 4 iterations
		string1		fednum_type;			// 4 iterations
		
		
END;


r3 NormItMisc1(FilteredStLicRecs L, INTEGER C) := TRANSFORM
SELF := L;
SELF.fednum := CHOOSE(C, L.fednum1, L.fednum2, L.fednum3, L.fednum4);
SELF.fednum_type := CHOOSE(C, L.fednum_type1, L.fednum_type2, L.fednum_type3, L.fednum_type4);
END;

NormMisc1 := DEDUP(NORMALIZE(FilteredStLicRecs,4,NormItMisc1(LEFT,COUNTER)),all,record);


NoMiscRecs	:= NormMisc1(fednum1 = '' AND fednum2 = '' AND fednum3 = '' and fednum4 = '');
MiscRecs 	:= NormMisc1(fednum != '');
FilteredMiscRecs  := NoMiscRecs + MiscRecs;



r4 := RECORD
			r3;
	  string10	ncpdpnbr;					// 3 iterations 
		string10	npi;								// 3 iterations
		
END;

r4 NormItMisc2(FilteredMiscRecs L, INTEGER C) := TRANSFORM
SELF := L;
SELF.ncpdpnbr := CHOOSE(C, L.ncpdpnbr1, L.ncpdpnbr2, L.ncpdpnbr3);
SELF.npi := CHOOSE(C, L.npi1, L.npi2, L.npi3);
END;

NormMisc2 := DEDUP(NORMALIZE(FilteredMiscRecs,3,NormItMisc2(LEFT,COUNTER)),all,record);


NoMiscRecs2	:= NormMisc2(ncpdpnbr1 = '' AND ncpdpnbr2 = '' AND ncpdpnbr3 = '');
MiscRecs2 	:= NormMisc2(ncpdpnbr != '');
FilteredMiscRecs2  := NoMiscRecs2 + MiscRecs2;


r5 := RECORD
		r4;
		string8		survey_date;				// 6 iterations
		string1		survey_type;				// 6 iterations
		string4		def_code;					// 6 iterations
		string1		def_rate;					// 6 iterations
		string1		def_status;				// 6 iterations
		string1		def_type;					// 6 iterations
		string8		sanction_date;			// 6 iterations
		string2		sanction_state;		// 6 iterations
		string30	sanction_case;			// 6 iterations
		unsigned integer	sanction_amt;	// 6 iteraions
		
END;

r5 NormItMisc3(FilteredMiscRecs2 L, INTEGER C) := TRANSFORM
SELF := L;
SELF.survey_date := CHOOSE(C, L.survey_date1, L.survey_date2, L.survey_date3, L.survey_date4,L.survey_date5,L.survey_date6);
SELF.survey_type := CHOOSE(C, L.survey_type1, L.survey_type2, L.survey_type3, L.survey_type4,L.survey_type5,L.survey_type6);
SELF.def_code := CHOOSE(C, L.def_code1, L.def_code2, L.def_code3,L.def_code4,L.def_code5,L.def_code6);
SELF.def_rate := CHOOSE(C, L.def_rate1, L.def_rate2, L.def_rate3, L.def_rate4, L.def_rate5, L.def_rate6);
SELF.def_status := CHOOSE(C, L.def_status1, L.def_status2, L.def_status3, L.def_status4, L.def_status5, L.def_status6);
SELF.def_type := CHOOSE(C, L.def_type1, L.def_type2, L.def_type3, L.def_type4, L.def_type5, L.def_type6);
SELF.sanction_date := CHOOSE(C, L.sanction_date1, L.sanction_date2, L.sanction_date3, L.sanction_date4, L.sanction_date5, L.sanction_date6);
SELF.sanction_state := CHOOSE(C, L.sanction_state1, L.sanction_state2, L.sanction_state3, L.sanction_state4, L.sanction_state5, L.sanction_state6);
SELF.sanction_case := CHOOSE(C, L.sanction_case1, L.sanction_case2, L.sanction_case3, L.sanction_case4, L.sanction_case5, L.sanction_case6);
SELF.sanction_amt := CHOOSE(C, L.sanction_amt1, L.sanction_amt2, L.sanction_amt3, L.sanction_amt4, L.sanction_amt5, L.sanction_amt6);

END;

NormMisc3 := DEDUP(NORMALIZE(FilteredMiscRecs2,6,NormItMisc3(LEFT,COUNTER)),all,record);

NoMiscRecs3	:= NormMisc3(sanction_date1 = '' AND sanction_date2 = '' AND sanction_date3 = '' AND sanction_date4 = '' AND sanction_date5 = '' AND sanction_date6 = '');
MiscRecs3 	:= NormMisc3(sanction_date != '');
FilteredMiscRecs3  := NoMiscRecs3 + MiscRecs3;


CNLD_Facilities.layout_Facilities_Out xformFileNorm(r5 pInput) := TRANSFORM
	self.deanbr 		:= ut.fnTrim2Upper(pInput.deanbr);
	self.deanbr_exp	:= pInput.deanbr_exp;
	self.deanbr_sch	:= pInput.deanbr_sch;
	self.st_lic_in	:= ut.fnTrim2Upper(pInput.st_lic_in);
	
	TrimLIC_NBR		:= ut.fnTrim2Upper(pInput.ST_LIC_NUM);
	self.st_lic_num		:= IF(stringlib.stringfind(TrimLIC_NBR,'/',1) > 2, '',StringLib.StringFilterOut(TrimLIC_NBR, '*'));
	self.st_lic_stat	:= ut.fnTrim2Upper(pInput.st_lic_stat);	
	
	TrimLIC_TYPE	:= ut.fnTrim2Upper(pInput.ST_LIC_TYPE);
	self.ST_LIC_TYPE		:= StringLib.StringFilterOut(TrimLIC_TYPE, '*');
	self.fednum				:= pInput.fednum;
	self.survey_type	:= ut.fnTrim2Upper(pInput.survey_type);
	self.def_code			:= ut.fnTrim2Upper(pInput.def_code);
	self.def_status		:= ut.fnTrim2Upper(pInput.def_status);
	self.def_type			:= ut.fnTrim2Upper(pInput.def_type);
	
	TrimSANC_CSE := StringLib.StringCleanSpaces(ut.fnTrim2Upper(pInput.SANCTION_CASE));
	self.SANCTION_CASE		:= StringLib.StringFilterOut(TrimSANC_CSE, '"');
	self.sanction_state	:= ut.fnTrim2Upper(pInput.sanction_state);
	
  self := pInput;
	   
END;

dsRecOutNorm_dist     := sort(distribute(PROJECT(FilteredMiscRecs3 ,xformFileNorm(left)),hash(gennum)),gennum,local);

return output(dsRecOutNorm_dist,,'~thor_data400::in::cnldfacilities::base',overwrite);

// return output(dsRecOutNorm_dist,,'~thor_data400::out::cnldfacilities::base',overwrite);

// export map_CNLD_Facilities := output(dsRecOutNorm_dist,,'~thor_data400::out::cnldfacilities::base',overwrite);


END;
