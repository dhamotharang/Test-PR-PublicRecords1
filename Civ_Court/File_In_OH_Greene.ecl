IMPORT Civ_Court, ut, lib_StringLib, STD, Data_Services;

	//spray as CSV, pipe delimited as the default so it doesn't use the commas in the data as a seperator and will just use carriage return (\r) for EOR
	raw_in	:= dataset(Data_Services.foreign_prod + 'thor_data400::in::civil::oh_greene',Civ_Court.Layout_In_OH_Greene.raw_in, CSV(SEPARATOR('|')));
	
	//Replace form feed (\f) at end of file with \r
	pRaw	:= PROJECT(raw_in,TRANSFORM(Civ_Court.Layout_In_OH_Greene.raw_in, self.line	:= REGEXREPLACE('\f',left.line,'\r'); self := left));
	
	pRaw2 := PROJECT(pRaw,TRANSFORM(Civ_Court.Layout_In_OH_Greene.raw_in, 
																	self.line	:= StringLib.StringFindReplace(REGEXREPLACE('\n',left.line,'*'),'*',''); self := left));
	
	//parse records
	l_temp	:= RECORD
		string	case_num;
		string	case_name;
		string	file_date;
		string	charge;
		string	docket;
		string	pl_def;
		string	attorney;
		string	aka_name;
		string	is_docket;
		string	is_csz;
		string	is_address;
		string	is_name;
		string	line;
	END;
	
	//Remove blank records, header, footer records, parse/identify fields
	InvalidRecs	:= 'CASE STATUS|TIME:|^DATE:|LEGAL NEWS|END OF REPORT|^SAW ';
	StrAddrPattern := '^[0-9]+ [0-9]*[A-Z]+| AVE| STREET| ST$| DRIVE| DR$| ROAD| RD|BOULEVARD| BLVD|^PO BOX|^P O BOX|P.O. |^BOX |MAIL DROP|MAIL STOP|^#|MAC# | # |^SUITE | STE |^APARTMENT | APT ';
	l_temp ParseRec(pRaw2 input)	:= TRANSFORM
		tempLine	:= IF(REGEXFIND(InvalidRecs,trim(input.line,left,right),NOCASE) or length(trim(input.line,left,right)) < 5,'',input.line);
		tempCaseNum			:= IF(REGEXFIND('^[0-9]+( CV )[0-9]+',trim(tempLine,left,right),NOCASE),REGEXFIND('^[0-9]+( CV )[0-9]+',tempLine,0),'');
		self.case_num 	:= trim(tempCaseNum,left,right);
		self.case_name	:= ut.CleanSpacesAndUpper(IF(REGEXFIND(' VS',tempLine),tempLine[26..],''));
		self.file_date	:= IF(REGEXFIND('FILE DATE:',tempLine,NOCASE),REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine,0),'');
		tempCharge			:= ut.CleanSpacesAndUpper(IF(REGEXFIND('CHARGE:',tempLine,NOCASE),REGEXFIND('CHARGE:(.*)',tempLine,0,NOCASE),''));
		self.charge			:= StringLib.StringFindReplace(tempCharge,'CHARGE:','');
		self.docket			:= ut.CleanSpacesAndUpper(IF(REGEXFIND('DOCKET:',tempLine,NOCASE),REGEXFIND('DOCKET:(.*)',tempLine,0,NOCASE),''));
		self.pl_def			:= ut.CleanSpacesAndUpper(IF(REGEXFIND('PLAINT',tempLine,NOCASE),'PLAINTIFF',
																					IF(REGEXFIND('DEFENDA',tempLine,NOCASE),'DEFENDANT','')));
		self.attorney 	:= ut.CleanSpacesAndUpper(IF(NOT REGEXFIND('FILE DATE| VS|AKA |[0-9]+/[0-9]+/[0-9]+',tempLine,NOCASE)
																					and NOT REGEXFIND('ATTORNEY',tempLine,NOCASE)
																					and REGEXFIND('[A-Z]+(, )[A-Z]+',trim(tempLine[42..],left,right),NOCASE),
																					trim(tempLine[42..],left,right),''));
		tempAKA					:= IF(REGEXFIND('^AKA|^DBA ',tempLine,NOCASE),ut.CleanSpacesAndUpper(tempLine),'');
		self.aka_name		:= REGEXREPLACE('^AKA|^DBA',tempAKA,'');
		Clnline				:= IF(REGEXFIND(' VS\\.*|AKA |DBA |^et al |^E et al|^al ',trim(tempLine,left,right),NOCASE),'',
											IF(REGEXFIND('^INC ',trim(tempLine,left,right),NOCASE),REGEXREPLACE('^INC ',trim(tempLine,left,right),'',NOCASE),
												IF(StringLib.StringFind(tempLine,'Plaintiff',1) > 0, '',
													IF(StringLib.StringFind(tempLine,'Defendant',1) > 0, '',
													 IF(StringLib.StringFind(tempLine,'Additional Party',1) > 0, '',
														IF(StringLib.StringFind(tempLine,self.attorney,1) > 0, StringLib.StringFindReplace(tempLine,self.attorney,''),
															IF(REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine),'',tempLine)))))));
		self.is_docket	:= IF(self.docket <> '','Y','');
		self.is_csz			:= IF(REGEXFIND('(.*), [A-Z]{2} [0-9]{5,}$',Clnline) or REGEXFIND('^[0-9]{5}-[0-9]{4}$',Clnline)
												or REGEXFIND('WASHINGTON.D.C',Clnline),'Y','');
		self.is_address	:= IF(REGEXFIND(StrAddrPattern,Clnline,NOCASE) and self.is_csz = '' 
													and NOT REGEXFIND('[0-9]+/[0-9]+/[0-9]+',tempLine)
													and NOT REGEXFIND(' LLC| LTD| TRUST|^MAIN STREET|ST JOHN$| SP |WHIRLPOOL |GUARDIANSHIP |FIRST GROUP ',Clnline),'Y','');
		self.is_name		:= IF(self.is_csz = '' and self.is_address = '' and NOT REGEXFIND('File Date:|Docket:',Clnline,NOCASE) and trim(Clnline) <> '','Y','');
		self.line				:= trim(StringLib.StringFindReplace(ClnLine,'PRO SE',''),left,right);
	END;
	
	ClnRecs	:= project(pRaw2, ParseRec(left));
	
	//Filter blank records
	fRecs	:= ClnRecs(trim(case_num+case_name+file_date+charge+pl_def+attorney+aka_name+line,left,right) <> '');
	
	
	l_temp	PopCase(fRecs L, fRecs R) := TRANSFORM
		self.case_num		:= IF(R.case_num = '',L.case_num,R.case_num);
		self.case_name	:= IF(R.case_name = '',L.case_name,R.case_name);
		self.file_date	:= R.file_date;
		self.charge			:= R.charge;
		self.docket			:= R.docket;
		self.pl_def			:= IF(L.case_num = self.case_num and R.pl_def = '',L.pl_def,R.pl_def);
		self.attorney		:= R.attorney;
		self.aka_name		:= R.aka_name;
		self.is_docket	:= R.is_docket;
		self.is_csz			:= R.is_csz;
		self.is_address	:= R.is_address;
		self.is_name		:= IF(self.is_docket = 'Y','',R.is_name);
		self.line				:= R.line;
	END;
	
	FillCaseNum	:= iterate(fRecs, PopCase(left,right));
	
//Iterate again to fill in the rest of the common fields
	srtCase	:= sort(FillCaseNum,case_num, case_name, -file_date,-charge);
	
	l_temp	PopCommon(srtCase L, srtCase R) := TRANSFORM
		self.case_num		:= R.case_num;
		self.case_name	:= R.case_name;
		self.file_date	:= IF(R.file_date = '',L.file_date,R.file_date);
		self.charge			:= IF(R.charge = '',L.charge,R.charge);
		self.docket			:= IF(L.case_num = self.case_num and R.line <> '' and R.docket = '',L.docket,R.docket);
		self.pl_def			:= IF(R.aka_name = '' and R.line = '','',
												IF(REGEXFIND('File Date:',R.line,NOCASE),'',
													IF(self.docket <> '','',R.pl_def)));
		self.attorney		:= R.attorney;
		self.aka_name		:= R.aka_name;
		self.is_docket	:= IF(L.case_num = self.case_num and self.docket <> '' and R.line <> '','Y','');
		self.is_csz			:= R.is_csz;
		self.is_address	:= R.is_address;
		self.is_name		:= IF(self.docket <> '' and self.is_docket = 'Y','',R.is_name);
		self.line				:= IF(REGEXFIND(' SAW$',R.line),'',R.line);
	END;
	
	FillCommon	:= iterate(srtCase, PopCommon(left,right));
	
	//Project to new layout to be used to group party name with party address
	l_denorm_rec	:= RECORD
		l_temp;
		string name2;
		string address1;
		string address2;
		string address3;
		unsigned	cnt:=0;
		BOOLEAN	gotName;
		BOOLEAN	gotAddress;
		BOOLEAN	gotZip;
	END;
	
	pDeNormRec	:= project(FillCommon,transform(l_denorm_rec, self := left; self := []));
	
	l_denorm_rec GrpNameAddr(pDeNormRec L, pDeNormRec R) := TRANSFORM
		//,skip(trim(R.is_name+R.is_address+R.is_csz,left,right) = '')
		bCombine				:=	IF(L.case_num=R.case_num AND L.pl_def=R.pl_def AND 
														(~L.gotName OR ~L.gotAddress OR ~L.gotZip),TRUE,FALSE);
		self.case_num		:=	IF(bCombine,L.case_num,R.case_num);
		self.case_name	:=	IF(bCombine,L.case_name,R.case_name);
		self.file_date	:=	IF(bCombine,L.file_date,R.file_date);
		self.charge			:=	IF(bCombine,L.charge,R.charge);
		self.docket			:=	IF(bCombine,
													 IF(R.is_docket = 'Y',L.docket+' '+R.line,L.docket),
													 IF(R.is_docket = 'Y',R.line,''));
		self.pl_def			:=	IF(bCombine,L.pl_def,R.pl_def);
		self.attorney		:=	trim(IF(bCombine,L.attorney+R.attorney,R.attorney),left,right);
		self.aka_name		:=	trim(IF(bCombine,L.aka_name+R.aka_name,R.aka_name),left,right);
		self.is_csz			:=	R.is_csz;
		self.is_address	:=	R.is_address;
		self.is_name		:=	R.is_name;
		temp_name2			:=	IF(bCombine,
													IF(R.is_name='Y',L.name2+'; '+R.line,L.name2),
													IF(R.is_name='Y',R.line,''));
		self.name2			:= IF(length(trim(temp_name2,left,right)) = 1,'',temp_name2);
		self.address1			:=	IF(bCombine,
													IF(R.is_address='Y',L.address1+R.line,L.address1),
													IF(R.is_address='Y',R.line,''));
		self.address2			:=	IF(bCombine,
													IF(R.is_csz='Y',L.address2+R.line,L.address2),
													IF(R.is_csz='Y',R.line,''));
		self.address3			:=	IF(bCombine,
													IF(R.is_csz='Y',L.address3+R.line,L.address3),
													IF(R.is_csz='Y',R.line,''));
		self.cnt				:=	IF(bCombine ,L.cnt+1,R.cnt);
		self.gotName		:=	IF(bCombine,
													IF(R.is_name='Y',TRUE,L.gotName),
													IF(R.is_name='Y',TRUE,FALSE));
		self.gotAddress		:=	IF(bCombine,
													IF(R.is_address='Y',TRUE,L.gotAddress),
													IF(R.is_address='Y',TRUE,FALSE));
		self.gotZip		:=	IF(bCombine,
													IF(R.is_csz='Y',TRUE,L.gotZip),
													IF(R.is_csz='Y',TRUE,FALSE));
		
		self := R;
	END;
	
	PopAddress	:= iterate(SORT(DISTRIBUTE(pDeNormRec,HASH(case_num,pl_def)),case_num,pl_def,LOCAL), GrpNameAddr(left,right));

	DedResult	:=	DEDUP(SORT(DISTRIBUTE(PopAddress(trim(docket+Name2+address1+address2,left,right)<>''),
								HASH(	case_num,pl_def,Name2,address1)),
											case_num,pl_def,Name2,-cnt,LOCAL),
											case_num,pl_def,Name2,address1,LOCAL);
											
	//project to final output layout and rollup any redundant records
	Civ_court.Layout_in_OH_Greene.case_in xfrmResult(DedResult input) := TRANSFORM
		tempParty1			 := trim(REGEXREPLACE('^;',IF(input.is_name = 'Y',input.line,input.name2),''),left,right);
		self.party_name1 := IF(STD.Str.Find(tempParty1,';',1) > 0,
													trim(tempParty1[1..STD.Str.Find(tempParty1,';',1) -1],right),tempParty1);
		tempParty2			 := trim(REGEXREPLACE('^;',IF(input.name2 = self.party_name1,'',input.name2),''),left,right);
		self.party_name2 := IF(STD.Str.Find(tempParty2,';',1) > 0,
												trim(tempParty2[1..STD.Str.Find(tempParty2,';',1) -1],right),tempParty2);
		self.address1 	:= input.address1;
		self.address2		:= IF(input.address2 = self.address1,'',input.address2);
		self.address3		:= IF(input.address3 = input.address2,'',input.address3);
		self := input;
	END;
	
	NewOutput := SORT(project(DedResult, xfrmResult(left)),case_num,pl_def,-party_name1,-address1,-address2);
	
	Civ_court.Layout_in_OH_Greene.case_in RollItUp(NewOutput L, NewOutput R)	:= TRANSFORM
		self.address1 := IF(L.address1 = '',R.address1,L.address1);
		self.address2	:= IF(L.address2 = '',R.address2,L.address2);
		self.address3	:= IF(L.address3 = '',R.address3,L.address3);
		TempName1			:= IF(L.party_name1 = '',R.party_name1,L.party_name1);
		self.party_name1	:= TempName1;
		TempName2					:= IF(L.party_name2 = '',R.party_name2,L.party_name2);
		self.party_name2	:= TempName2;
		self := L;
	END;
	
	RollupAll := Rollup(NewOutput,RollItUp(left,right),case_num,file_date,pl_def,party_name1,address1);
	
	case_out := RollupAll;
	
EXPORT File_In_OH_Greene := case_out;