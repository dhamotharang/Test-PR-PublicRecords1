IMPORT Civ_Court,  ut, lib_StringLib, STD, Data_Services;

	//spray as CSV, pipe delimited as the default so it doesn't use the commas in the data as a seperator and will just use carriage return (\r) for EOR
	raw_in	:= dataset(Data_Services.foreign_prod + 'thor_data400::in::civil::mi_saginaw',Civ_Court.Layout_In_MI_Saginaw.raw_in, CSV(SEPARATOR('|'),notrim));

	//Replace form feed (\f) at end of file with \r
	pRaw	:= PROJECT(raw_in,TRANSFORM(Civ_Court.Layout_In_MI_Saginaw.raw_in, self.line	:= REGEXREPLACE('\f',left.line,'\r'); self := left));
	
 //Replace 
	pRaw2 := PROJECT(pRaw,TRANSFORM(Civ_Court.Layout_In_MI_Saginaw.raw_in, 
																	self.line	:= REGEXREPLACE('^-',REGEXREPLACE('(--)+',left.line,''),''); self := left));
																	
//parse records
	l_temp	:= RECORD
		string10	disposition_date;
		string		case_type;
		string14	case_num;
		string35	plaintiff;
		string32	defendant;
		string35	plaintiff_street;
		string32	plaintiff_csz;
		string35	def_street;
		string32	def_csz;
		string10	filed_date;
		string10	activity_date1;
		string		activity1;
		string		line;
	END;
	
	//Remove blank records, header, footer records, parse/identify fields
	InvalidRecs	:= 'TOTAL|REPORT|RUN DATE|CASES WITH FINAL DISPOSITION|CASE NUMBER|SAGINAW COUNTY DISTRICT COURT|CASE TYPE| THRU |INCLUDES SATISFACTIONS';
	StrAddrPattern := '^[0-9]+ [0-9]*[A-Z]+|^[0-9]+-[0-9]+ [A-Z]+|^[0-9]+ [0-9]/[0-9] [A-Z]+| AVE| STREET| ST$| DRIVE| DR$| ROAD| RD|BOULEVARD| BLVD| WAY$| PLAZA| PLACE|'+
										'^PO |^P O |^P.O. |^P.O|BOX [0-9]+';
	l_temp ParseRec(pRaw2 input)	:= TRANSFORM
		tempLine			:= IF(REGEXFIND(InvalidRecs,trim(input.line,left,right),NOCASE) or trim(input.line,left,right)= '','',input.line);
		tempDispDte		:= IF(REGEXFIND('DISPOSITION DATE:',trim(tempLine,left,right)),REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine,0),'');
		tempCaseType	:= IF(REGEXFIND('DISPOSITION DATE:',tempLine),tempLine[35..],'');
		tempCaseNum		:= IF(REGEXFIND('^[0-9]{2}-[0-9]{4}-[A-Z]{2}-[0-9]{1}',trim(tempLine,left,right),NOCASE),REGEXFIND('^[0-9]{2}-[0-9]{4}-[A-Z]{2}-[0-9]{1}',tempLine,0),'');
		self.disposition_date	:= tempDispDte;
		self.case_type	:= ut.CleanSpacesAndUpper(tempCaseType);
		self.case_num		:= tempCaseNum;
		tempPlaintiff	:= IF(REGEXFIND('^[0-9]{2}-[0-9]{4}-[A-Z]{2}-[0-9]{1}',trim(tempLine,left,right),NOCASE) and REGEXFIND('[A-Z]+',tempLine[15..48],NOCASE),
												tempLine[15..48],'');
		tempDefendant	:= IF(REGEXFIND('^[0-9]{2}-[0-9]{4}-[A-Z]{2}-[0-9]{1}',trim(tempLine,left,right),NOCASE) and REGEXFIND('[A-Z]+',tempLine[49..],NOCASE),
												tempLine[49..],'');
		self.plaintiff	:= ut.CleanSpacesAndUpper(tempPlaintiff);
		self.defendant	:= ut.CleanSpacesAndUpper(tempDefendant);
		self.plaintiff_street	:= IF(REGEXFIND(StrAddrPattern,trim(tempLine[15..48],left),NOCASE) or REGEXFIND('^C/O|^%|^C/P ',trim(tempLine,left)),tempLine[15..48],'');
		self.plaintiff_csz		:= IF(REGEXFIND('[A-Z]+, [A-Z]{2} [0-9]{5}',tempLine[15..48]),tempLine[15..48],'');
		self.def_street				:= IF(REGEXFIND(StrAddrPattern,tempLine[49..],NOCASE) and not 
																REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine),tempLine[49..],'');
		self.def_csz					:= IF(REGEXFIND('[A-Z]+, [A-Z]{2} [0-9]{5}',tempLine[49..]) and not 
																REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine),tempLine[49..],'');
		self.filed_date				:= IF(REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine) and REGEXFIND('CASE FILED',tempLine),
																REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine,0),'');
		self.activity_date1		:= IF(REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine) and not 
																REGEXFIND('CASE FILED|THRU ',tempLine,NOCASE),REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine,0),'');
		self.activity1				:= IF(REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine) and not 
																REGEXFIND('CASE FILED|THRU ',tempLine,NOCASE),trim(REGEXREPLACE('[0-9]+/[0-9]+/[0-9]+',tempLine,''),left,right),'');
		self.line							:= tempLine;
		self := [];
	END;
	
	pRawIn	:= project(pRaw2,ParseRec(left))(line <> '');
	
	//Iterate to populate common fields: disposition_date, case_type, case_num
	l_temp PopCaseInfo(pRawIn L, pRawIn R) := TRANSFORM
		self.disposition_date	:= IF(R.disposition_date = '',L.disposition_date,R.disposition_date);
		self.case_type	:= IF(R.case_type = '',L.case_type,R.case_type);
		self.case_num		:= IF(R.case_num = '',L.case_num,R.case_num);
		self.plaintiff	:= IF(R.plaintiff = '',ut.CleanSpacesAndUpper(L.plaintiff),ut.CleanSpacesAndUpper(R.plaintiff));
		self.defendant	:= IF(R.defendant = '',ut.CleanSpacesAndUpper(L.defendant),ut.CleanSpacesAndUpper(R.defendant));
	//If there is no plaintiff in raw file but there is a defendant record, address gets shifted left.  This fixes that issue.
		ClnStreet				:= ut.CleanSpacesAndUpper(MAP(STD.Str.Find(R.plaintiff_street,'C/O',1)>0 => StringLib.StringFindReplace(R.plaintiff_street,'C/O',''),
																						STD.Str.Find(R.plaintiff_street,'%',1)>0 => StringLib.StringFindReplace(R.plaintiff_street,'%',''),
																						STD.Str.Find(R.plaintiff_street,'C/P',1)>0 => StringLib.StringFindReplace(R.plaintiff_street,'C/P',''),
																						R.plaintiff_street));
		self.plaintiff_street	:= ClnStreet;
		self.plaintiff_csz		:= R.plaintiff_csz;
		self.def_street				:= R.def_street;
		self.def_csz					:= R.def_csz;
		self.filed_date				:= R.filed_date;
		self.activity1				:= ut.CleanSpacesAndUpper(R.activity1);
		self.line							:= R.line;
		self := R;
	END;
	
	fillCaseInfo	:= iterate(pRawIn, PopCaseInfo(left,right));
	
	filterDispHdr	:= fillCaseInfo(~REGEXFIND('DISPOSITION DATE:',line)); //Removes records with blank case_num
	
	//Denormalize to combine all activity records
	fActivity	:= filterDispHdr(trim(activity_date1) <> '');
	fBase			:= filterDispHdr(trim(activity_date1) = '');
	
	l_temp2 := RECORD
		UNSIGNED1  numRows;
		l_temp - line;
		string		case_title;
		string10	activity_date2;
		string		activity2;
		string10	activity_date3;
		string		activity3;
		string10	activity_date4;
		string		activity4;
		string10	activity_date5;
		string		activity5;
		string10	activity_date6;
		string		activity6;
		string10	activity_date7;
		string		activity7;
		string10	activity_date8;
		string		activity8;
		string10	activity_date9;
		string		activity9;
		string10	activity_date10;
		string		activity10;
	END;
	
	pBase	:= project(fBase, transform(l_temp2,self.numRows := 0;
																		self.case_title := IF(left.plaintiff <> '',trim(left.plaintiff,left,right)+' VS '+trim(left.defendant,left,right),'');
																		self := left; self := []));
	
	l_temp2 DeNormRec(pBase L, fActivity R, integer C) := TRANSFORM
		self.numRows := C;
		self.activity_date1	:= IF(C = 1,R.activity_date1,L.activity_date1);
		self.activity1			:= IF(C = 1,R.activity1,L.activity1);
		self.activity_date2	:= IF(C = 2,R.activity_date1,L.activity_date2);
		self.activity2			:= IF(C = 2,R.activity1,L.activity2);
		self.activity_date3	:= IF(C = 3,R.activity_date1,L.activity_date3);
		self.activity3			:= IF(C = 3,R.activity1,L.activity3);
		self.activity_date4	:= IF(C = 4,R.activity_date1,L.activity_date4);
		self.activity4			:= IF(C = 4,R.activity1,L.activity4);
		self.activity_date5	:= IF(C = 5,R.activity_date1,L.activity_date5);
		self.activity5			:= IF(C = 5,R.activity1,L.activity5);
		self.activity_date6	:= IF(C = 6,R.activity_date1,L.activity_date6);
		self.activity6			:= IF(C = 6,R.activity1,L.activity6);
		self.activity_date7	:= IF(C = 7,R.activity_date1,L.activity_date7);
		self.activity7			:= IF(C = 7,R.activity1,L.activity7);
		self.activity_date8	:= IF(C = 8,R.activity_date1,L.activity_date8);
		self.activity8			:= IF(C = 8,R.activity1,L.activity8);
		self.activity_date9	:= IF(C = 9,R.activity_date1,L.activity_date9);
		self.activity9			:= IF(C = 9,R.activity1,L.activity9);
		self.activity_date10:= IF(C = 10,R.activity_date1,L.activity_date10);
		self.activity10			:= IF(C = 10,R.activity1,L.activity10);
		self := L;
	END;
	
	deRec	:= DENORMALIZE(pBase, fActivity,
                       LEFT.disposition_date = RIGHT.disposition_date and
											 LEFT.case_type = RIGHT.case_type and
											 LEFT.case_num = RIGHT.case_num and
											 LEFT.plaintiff = RIGHT.plaintiff and
											 LEFT.defendant = RIGHT.defendant,
                       DeNormRec(LEFT,RIGHT,COUNTER));
	
	//Fill in plaintiff/defendant address
 srt_output := sort(deRec,disposition_date,case_type,case_num,plaintiff,defendant,-plaintiff_street,-plaintiff_csz,-def_street,-def_csz);
 
 	l_temp2 PopAddress(srt_output L, srt_output R) := TRANSFORM
		self.case_num		:= L.case_num;
		self.case_type	:= L.case_type;
		self.plaintiff	:= L.plaintiff;
		self.defendant	:= L.defendant;
		self.plaintiff_street	:= IF(L.plaintiff_street <> '',L.plaintiff_street,'');
		self.plaintiff_csz		:= IF(L.plaintiff_csz = '', R.plaintiff_csz, L.plaintiff_csz);
		self.def_street				:= IF(L.def_street = '', R.def_street, L.def_street);
		self.def_csz					:= IF(L.def_csz = '',R.def_csz, L.def_csz);
		self.filed_date				:= IF(L.filed_date = '',R.filed_date,L.filed_date);
		self	:= L;
	END;
	
	fillAddress := rollup(srt_output, PopAddress(left,right),case_num,case_type,plaintiff,defendant);
	
	//One final iterate to populate filed_date so that a proper dedup can be done
	srt_FileDte	:= sort(fillAddress,case_num,case_type,plaintiff,-filed_date);
	
	l_temp2 PopFiledDte(srt_FileDte L, srt_FileDte R) := TRANSFORM
		self.case_num		:= R.case_num;
		self.case_title	:= IF(L.case_num = self.case_num, L.case_title,R.case_title);
		self.filed_date	:= IF(R.filed_date = '',L.filed_date,R.filed_date);
		self						:= R;
	END;
	
	fillFileDate	:= iterate(srt_FileDte, PopFiledDte(left,right));
	
	//Project into final layout
	pFinalOut	:= project(fillFileDate,transform(Civ_Court.Layout_In_MI_Saginaw.case_in, self := left));

EXPORT File_In_MI_Saginaw := pFinalOut;