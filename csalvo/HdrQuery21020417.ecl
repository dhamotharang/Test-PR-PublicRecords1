import header, mdr, ut;

export HdrQuery21020417 := MODULE

SET of STRING400 querydata := [
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 100-50-8216~First Name: MICHAEL~Last Name: STEIFMAN~Middle Name: h',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 100-50-8216~First Name: MICHAEL~Last Name: STEIFMAN~Middle Name: h',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 100-50-8216~First Name: MICHAEL~Last Name: STEIFMAN~Middle Name: h',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 572-85-8576~First Name: JANE~Last Name: BARRY~Middle Name: l',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 572-85-8576~First Name: JANE~Last Name: BARRY~Middle Name: l',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 420-31-0432~First Name: DANIEL~Last Name: MURDOCK',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 420-31-0432~First Name: DANIEL~Last Name: MURDOCK',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 420-31-0432~First Name: DANIEL~Last Name: MURDOCK',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 420-31-0432~First Name: DANIEL~Last Name: MURDOCK',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: JOHN~Last Name: GROTHE~Middle Name: m~Street Address: 10361 RAVENSWOOD WAY~City: HIGHLANDS RANCH~State: CO~Zip Code: 80130',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: JOHN~Last Name: GROTHE~Middle Name: m~Street Address: 10361 RAVENSWOOD WAY~City: HIGHLANDS RANCH~State: CO~Zip Code: 80130',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: MELINA~Last Name: MEJIA~Street Address: 3035 WHITE PLAINS RD # 7F~City: BRONX~State: NY~Zip Code: 10467',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: MELINA~Last Name: MEJIA~Street Address: 3035 WHITE PLAINS RD # 7F~City: BRONX~State: NY~Zip Code: 10467',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: ALEXIS~Last Name: GATZIMAS~Middle Name: j~Street Address: 508 JUDSON ST~City: RAYNHAM~State: MA~Zip Code: 02767',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: ALEXIS~Last Name: GATZIMAS~Street Address: 508 JUDSON ST~City: RAYNHAM~State: MA~Zip Code: 02767',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: JAMES~Last Name: GATZIMAS~Middle Name: d~Street Address: 508 JUDSON ST~City: RAYNHAM~State: MA~Zip Code: 02767',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: JAMES~Last Name: GATZIMAS~Middle Name: d~Street Address: 508 JUDSON ST~City: RAYNHAM~State: MA~Zip Code: 02767',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 539-58-6884',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 539-58-6884',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 535-68-2097',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 535-68-2097',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 255-47-0522',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 255-47-0522',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: MANSOOR~Last Name: HABIB~Street Address: 4926 LOCKHART ST~City: WEST BLOOMFIELD~State: MI~Zip Code: 48323',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: MANSOOR~Last Name: HABIB~Street Address: 4926 LOCKHART ST~City: WEST BLOOMFIELD~State: MI~Zip Code: 48323',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: MANSOOR~Last Name: HABIB~Middle Name: h~Street Address: 4926 LOCKHART ST~City: WEST BLOOMFIELD~State: MI~Zip Code: 48323~DOB: 4/14/1949',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: MANSOOR~Last Name: HABIB~Middle Name: h~Street Address: 4926 LOCKHART ST~City: WEST BLOOMFIELD~State: MI~Zip Code: 48323~DOB: 4/14/1949',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: mufazzal~Last Name: HABIB~Street Address: 4926 LOCKHART ST~City: WEST BLOOMFIELD~State: MI~Zip Code: 48323~DOB: 4/14/1949',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: mufazzal~Last Name: HABIB~Street Address: 4926 LOCKHART ST~City: WEST BLOOMFIELD~State: MI~Zip Code: 48323~DOB: 4/14/1949',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 230-19-7146',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=SSN: 230-19-7146',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: ROBERT~Last Name: FEITLER~Street Address: 433 CLAFFIN AVE~City: MAMARONECK~State: NY~Zip Code: 10543',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=N;SSNMaskType=Last4Masked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: ROBERT~Last Name: FEITLER~Street Address: 433 CLAFFIN AVE~City: MAMARONECK~State: NY~Zip Code: 10543',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: ROBERT~Last Name: FEITLER~Street Address: 433 CLAFFIN AVE~City: MAMARONECK~State: NY~Zip Code: 10543',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: ROBERT~Last Name: FEITLER~Street Address: 433 CLAFFIN AVE~City: MAMARONECK~State: NY~Zip Code: 10543',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: REX~Last Name: LIU~Street Address: 502 Shoal Circle~City: Redwood City~State: CA~Zip Code: 94065',
'name=SsntSrchEngnExct;msg=SeisintSearchEngineExecute;originationCode=00241;simulateFlag=N;urlApiAppFlag=N;DISPLAY_DLN=Y;SSNMaskType=NoneMasked;LoggingXacnId=00000000-0000-0000-0000-000000000000;MBSCompany=1588575;searchterms=First Name: REX~Last Name: LIU~Street Address: 502 Shoal Circle~City: Redwood City~State: CA~Zip Code: 94065'
];

temp := DATASET(querydata, {string400 searchstr});

EXPORT dsQueryStrings := PROJECT(temp, TRANSFORM({string200 searchstr},
												n := StringLib.StringFind(LEFT.searchstr,'searchterms=', 1);
												s := if(n=0, SKIP, LEFT.searchstr[n+12..]);
												SELF.searchstr := StringLib.StringToUpperCase(s);

												));

integer cvtdob(string s) := (integer)ut.ConvertDate(s);

rHdrQueryEx x(dsQueryStrings src) := TRANSFORM
	SELF.fname := REGEXFIND('FIRST NAME: ([A-Z]+)\\b', src.searchstr, 1);
	SELF.mname := REGEXFIND('MIDDLE NAME: ([A-Z]+)\\b', src.searchstr, 1);
	SELF.lname := REGEXFIND('LAST NAME: ([A-Z]+)\\b', src.searchstr, 1);
	SELF.address := 
		TRIM(Stringlib.Stringfilterout(
			REGEXFIND('STREET ADDRESS: ([0-9A-Z #./-]+)\\b', src.searchstr, 1),
			'.-/#'),ALL);
	SELF.city := REGEXFIND('CITY: ([A-Z ]+)\\b', src.searchstr, 1);
	SELF.state := REGEXFIND('STATE: ([A-Z]+)\\b', src.searchstr, 1);
	SELF.zip := REGEXFIND('ZIP CODE: ([0-9]+)\\b', src.searchstr, 1);
	SELF.ssn := StringLib.StringFilterOut(
								REGEXFIND('SSN: ([0-9-]+)\\b', src.searchstr, 1),
								'-');
	SELF.dob := cvtdob(REGEXFIND('DOB: ([0-9/]+)', src.searchstr, 1));
	SELF.phone := REGEXFIND('PHONE=\\(([0-9]+)\\)', src.searchstr, 1);
	SELF.UID := 0;		//(unsigned6)REGEXFIND('UID=([0-9]+)~',src.uidstr,1);
	SELF.class := 
			TRIM(
			  IF(SELF.fname='','','F') +
			  IF(SELF.mname='','','M') +
			  IF(SELF.lname='','','L') +
			  IF(SELF.address='','','A') +
			  IF(SELF.city='','','C') +
			  IF(SELF.state='','','S') +
			  IF(SELF.zip='','','Z') +
			  IF(SELF.ssn='','','N') +
			  //IF(SELF.dob=0,'','D') +
			  MAP(
				SELF.dob=0 => '',
				SELF.dob<999999 => 'E',	// year & month
				'D'
			  ) +
			  IF(SELF.phone='','','P') +
			  IF (SELF.UID = 0, '','U')
			  ,ALL);
	//SELF.searchstr := IF(SELF.UID != 0 AND src.searchstr='', src.uidstr,
	//						src.searchstr);
	
	SELF := src;
	//SELF := [];
END;

export dsQueryParms := PROJECT(dsQueryStrings, x(LEFT));

string Fix(string s) := TRIM(Stringlib.Stringfilterout(s,'.-#/'),ALL);
//*FLACSZ    
//*N         
//*FMLACSZ   
//*FMLN      
//*FLN          
//FMLACSZD  
//FLACSZD   

rQueryResult xr(header.Layout_Header L, csalvo.rHdrQueryEx R) := TRANSFORM
	SELF.Is_DL:=map(mdr.sourceTools.SourceIsDirectDL(L.src)=>'Direct'
				,mdr.sourceTools.SourceIsDL(L.src)=>'non-Direct'
				,'');
	SELF.Is_Vehicle:=map(mdr.sourceTools.SourceIsDirectVehicle(L.src)=>'Direct'
					,mdr.sourceTools.SourceIsVehicle(L.src)=>'non-Direct'
					,'');
	SELF.contributing_source:=header.translateSource(L.src);
	SELF.dod := 0;	// comes from Doxie key
	SELF.query := R.class;
	SELF.searchstr := R.searchstr;
	SELF := L;
//	SELF := R;
END;
qry := dsQueryParms;
hdr := DISTRIBUTE(dataset(header.Filename_Header,header.Layout_Header,flat),did)
		/*+ header.File_TUCS_did*/ : PERSIST('~thor::persist::header');
export query := 
	JOIN(hdr, qry(class='N'), 
/*N*/		LEFT.ssn=RIGHT.ssn
			, xr(LEFT, RIGHT), INNER, LOOKUP) +
	JOIN(hdr, qry(class='FLN'), 
/*FLN*/		LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn
			, xr(LEFT, RIGHT), INNER, LOOKUP) +
	JOIN(hdr, qry(class='FMLN'), 
/*FMLN*/	LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname AND LEFT.ssn=RIGHT.ssn
			, xr(LEFT, RIGHT), INNER, LOOKUP) +
	JOIN(hdr, qry(class='FLACSZ'), 
/*FLACSZ*/ LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND   
				LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			AND fix(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.sec_range)=fix(RIGHT.address)
			, xr(LEFT, RIGHT), INNER, LOOKUP) +
	JOIN(hdr, qry(class='FMLACSZ'), 
/*FMLACSZ*/ LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
				AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
				AND fix(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.sec_range)=RIGHT.address
			, xr(LEFT, RIGHT), INNER, LOOKUP) +
	JOIN(hdr, qry(class='FLACSZD'), 
/*FLACSZD*/ LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname AND LEFT.dob=RIGHT.dob  
			AND	LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
			AND fix(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.sec_range)=RIGHT.address
			, xr(LEFT, RIGHT), INNER, LOOKUP) +
	JOIN(hdr, qry(class='FMLACSZD'), 
/*FMLACSZD*/ LEFT.fname=RIGHT.fname AND LEFT.mname=RIGHT.mname AND LEFT.lname=RIGHT.lname
				AND LEFT.city_name=RIGHT.city AND LEFT.st=RIGHT.state AND LEFT.zip=RIGHT.zip
				AND LEFT.dob=RIGHT.dob
				AND fix(LEFT.prim_range+LEFT.predir+LEFT.prim_name+LEFT.suffix+LEFT.postdir+LEFT.sec_range)=RIGHT.address
			, xr(LEFT, RIGHT), INNER, LOOKUP);
			


END;