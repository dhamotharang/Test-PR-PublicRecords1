IMPORT iesp;
export TestData_HeaderSummary := MODULE

	export string ds1 := 'Person Locator 1';
	export string ds2 := 'Person Locator 2';
	export string ds3 := 'Person Locator 4';
	export string ds4 := 'Person Locator 5';
	export string ds5 := 'Historical Person Locator';
	export string ds6 := 'Phones';
	export string ds7 := 'PhonesPlus Records';
	export string ds8 := 'Drivers Licenses';
	export string ds9 := 'Deceased';
	export string ds10 := 'Email addresses';
	export string ds11 := 'Voter Registrations';
	export string ds12 := 'Hunting and Fishing Licenses';
	export string ds13 := 'Utility Locator';
	export string ds14 := 'Deed Transfers';
	export string ds15 := 'Liens and Judgments';
	export string ds16 := 'Bankruptcy Records';
	export string ds17 := 'Criminal';
	export string ds18 := 'Professional Licenses';
	export string ds19 := 'Motor Vehicle Registrations';
	export string ds20 := 'Corporate Affiliations';
	export string ds21 := 'Internet Domain Registrations';
	export string ds22 := 'Weapon Permits';
	export string ds23 := 'Sexual Offense';
	export string ds24 := 'Foreclosure Records';
	export string ds25 := 'Tax Assessor Records';
	export string sal1 := 'MR';
	export string bgfirst1 := 'IVBEN';
	export string bglast1 := 'HACKING';
	export string bgfirst2 := 'IMA';
	export string bglast2 := 'THIEF';
	export string bgfirst3 := 'IAMA';
	export string bglast3 := 'CROOK';
	export string bgfirst4 := 'ITOOKA';
	export string bglast4 := 'YOURCREDIT';
	export string bgfirst4AKA := 'ITOOK';
	export string bglast4AKA := 'AYOURCREDIT';
	export string bgfirst5 := 'YOUBE';
	export string bglast5 := 'STUCKPAYING';
	export string bgfirst6 := 'IAM';
	export string bglast6 := 'LIVINITUP';
	export string bglast6AKA := 'CROOKEDGUY';
	export string bgfirst7 := 'ISPENDA';
	export string bglast7 := 'YOURMONEY';
	export string bgfirst8 := 'NOMORE';
	export string bglast8 := 'MONEY';
	export string bgfirst8AKA := 'NAMORE';
	export string bgfirst9 := 'BUY';
	export string bglast9 := 'MESTUFF';
	export string bgfirst10 := 'UBE';
	export string bglast10 := 'PAYING';

	export myTestDataRec := Record
			integer subjectcount;
			integer sourcecount;
			integer fsy;
			integer fsm;
			integer fsd;
			integer lsy;
			integer lsm;
			integer lsd;
			integer ssnc;
			integer dobc;
			integer source;
			string s1;
			string s2;
			string s3;
			string s4;
			string s5;
			string s6;
			string t1;
			string n1f;
			string n1l;
			string t2;
			string n2f;
			string n2l;
			string t3;
			string n3f;
			string n3l;
			string ssn;
			String firstname;
			String lastname;
			String uniqueid;
			integer dobm1;
			integer dobd1;
			integer doby1;
			integer dobm2;
			integer dobd2;
			integer doby2;
			integer dodm;
			integer dodd;
			integer dody;
			integer dodage;
			STRING60  Addr1;
			STRING25  City1;
			STRING2   State1;
			STRING5   Zip1;
			STRING60  Addr2;
			STRING25  City2;
			STRING2   State2;
			STRING5   Zip2;
			STRING60  Addr3;
			STRING25  City3;
			STRING2   State3;
			STRING5   Zip3;
			STRING60  Addr4;
			STRING25  City4;
			STRING2   State4;
			STRING5   Zip4;
	end;
		
	Export DataSet_991271437(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{1,2,1999,12,15,2010,9,15,3,1,2,ds1,ds2,'','','','',sal1,bgfirst1,bglast1,sal1,bgfirst2,bglast2,'','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMESSN' => Dataset([{2,4,2000,1,30,2010,8,15,2,1,3,ds1,ds6,ds8,'','','',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,4,2000,1,30,2010,8,15,2,1,2,ds1,ds2,'','','','',sal1,bgfirst5,bglast5,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'011',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEDOB' => Dataset([{2,5,2003,1,30,2009,7,10,1,3,3,ds1,ds6,ds9,'','','',sal1,bgfirst4,bglast4,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'020',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''},{2,5,2003,1,30,2010,8,15,1,2,2,ds2,ds8,'','','','',sal1,bgfirst6,bglast6,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'021',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='ADDRESS' => Dataset([{1,6,2000,2,21,2010,8,10,1,1,6,ds1,ds2,ds6,ds8,ds13,ds14,sal1,'ROBERT',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{1,6,2008,2,21,2010,9,2,1,1,6,ds2,ds6,ds7,ds10,ds11,ds12,'',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'2'+l.Addr,l.City,l.State,l.Zip,'9'+l.Addr,l.City,l.State,l.Zip}], myTestDataRec),
								section='COMBO' => Dataset([{1,2,2007,2,21,2010,9,2,1,1,2,ds2,ds6,'','','','','',l.firstname,l.LastName,'',l.firstname[1],l.LastName,'',l.firstname[1],l.LastName[2..],l.ssn,l.firstname,l.lastname,'050',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;

	Export DataSet_991271438(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{1,2,1999,12,15,2010,9,15,2,1,3,ds1,ds2,ds6,'','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMESSN' => Dataset([{1,2,2000,1,30,2010,8,15,3,1,2,ds1,ds6,'','','','',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEDOB' => Dataset([{1,2,2003,1,30,2009,7,10,1,3,3,ds1,ds6,'','','','',sal1,bgfirst4,bglast4,'',l.FirstName,l.LastName,sal1,bgfirst4AKA,bglast4AKA,l.ssn,l.firstname,l.lastname,'020',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='ADDRESS' => Dataset([{2,5,2000,2,21,2010,8,10,1,1,2,ds1,ds6,'','','','',sal1,'ROBERT',l.LastName,sal1,'BOB',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{2,5,2000,2,21,2010,8,10,1,1,4,ds1,ds2,ds8,ds13,'','','MRS','ELIZABETH',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{2,6,2008,2,21,2010,9,2,1,1,3,ds2,ds6,ds7,'','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{2,6,2009,9,21,2010,9,2,1,1,3,ds3,ds10,ds12,'','','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='COMBO' => Dataset([{1,5,2007,2,21,2010,9,2,1,1,5,ds2,ds6,ds7,ds10,ds12,'','',l.firstname,l.LastName,'',l.firstname[1],l.LastName,'',l.firstname[1],l.LastName[2..],l.ssn,l.firstname,l.lastname,'050',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271439(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{2,5,1999,12,15,2010,9,15,2,1,3,ds1,ds6,ds13,'','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,5,2000,12,15,2010,9,15,2,1,2,ds2,ds12,'','','','',sal1,bgfirst2,bglast2,'','','','','','',l.ssn,l.firstname,l.lastname,'002',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMESSN' => Dataset([{2,2,2000,1,30,2010,8,15,2,1,2,ds1,ds6,'','','','',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,2,2000,1,30,2010,8,15,2,1,2,ds1,'','','','','',sal1,bgfirst5,bglast5,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'011',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEDOB' => Dataset([{2,5,2003,1,30,2009,7,10,1,3,3,ds1,ds6,ds9,'','','',sal1,bgfirst4,bglast4,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'020',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''},{2,5,2003,1,30,2010,8,15,1,2,2,ds2,ds8,'','','','',sal1,bgfirst6,bglast6,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'021',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='ADDRESS' => Dataset([{2,1,2000,2,21,2010,8,10,1,1,1,ds1,'','','','','',sal1,'ROBERT',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{2,1,2000,2,21,2010,8,10,1,1,1,ds1,'','','','','','MRS','ELIZABETH',l.LastName,'MRS','BETH',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{3,5,2008,2,21,2010,9,2,1,1,1,ds2,'','','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,5,2009,9,21,2010,9,2,1,1,1,ds3,'','','','','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,5,2010,1,21,2010,9,2,1,1,3,ds4,ds10,ds6,'','','','',l.firstname[1],l.LastName[2..],'','','','','','',l.ssn,l.firstname,l.lastname,'042',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='COMBO' => Dataset([{2,3,2007,2,21,2010,9,2,1,1,2,ds2,ds6,'','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'050',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{2,3,2007,2,21,2010,9,2,2,1,2,ds2,ds10,'','','','','',l.firstname,l.LastName[2..],'','','','','','',l.ssn,l.firstname,l.lastname,'051',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271440(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{3,6,2001,12,15,2010,9,15,2,1,3,ds1,ds6,ds13,'','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,6,2004,12,15,2010,9,15,2,1,2,ds2,ds12,'','','','',sal1,bgfirst2,bglast2,'','','','','','',l.ssn,l.firstname,l.lastname,'002',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,6,2004,12,15,2010,9,15,2,1,2,ds3,ds6,'','','','',sal1,bgfirst7,bglast7,'','','','','','',l.ssn,l.firstname,l.lastname,'003',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMESSN' => Dataset([{1,5,2000,1,30,2010,8,15,3,1,5,ds1,ds2,ds6,ds8,ds13,'',sal1,bgfirst3,bglast3,sal1,bgfirst6,bglast6AKA,'',l.FirstName,l.LastName,l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEDOB' => Dataset([{3,12,2003,1,30,2009,7,10,1,3,3,ds1,ds6,ds9,'','','',sal1,bgfirst4,bglast4,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'020',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''},{3,12,2003,1,30,2010,8,15,1,2,4,ds2,ds8,ds16,ds24,'','',sal1,bgfirst6,bglast6,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'021',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,12,2003,1,30,2009,7,10,1,3,6,ds4,ds22,ds21,ds23,ds17,ds9,sal1,bgfirst8,bglast8,'',l.FirstName,l.LastName,sal1,bgfirst8AKA,bglast8,l.ssn,l.firstname,l.lastname,'022',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='ADDRESS' => Dataset([{3,7,2000,2,21,2010,8,10,1,1,4,ds1,ds6,ds13,ds14,'','',sal1,'ROBERT',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,7,2000,2,21,2010,8,10,1,1,2,ds2,ds11,'','','','','MRS','ELIZABETH',l.LastName,'MRS','BETH',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{3,7,2000,2,21,2010,8,10,1,1,1,ds8,'','','','','',sal1,'BILLY',l.LastName,sal1,'WILLIAM',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'032',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{3,10,2008,2,21,2010,9,2,1,1,5,ds2,ds6,ds13,ds10,ds11,'','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,10,2009,9,21,2010,9,2,1,1,2,ds3,ds12,'','','','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,10,2010,1,10,2010,9,2,1,1,3,ds4,ds5,ds7,'','','','',l.firstname[1],l.LastName[2..],'','','','','','',l.ssn,l.firstname,l.lastname,'042',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='COMBO' => Dataset([{3,12,2007,2,21,2010,9,2,1,1,5,ds2,ds6,ds10,ds13,ds21,'','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'050',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,12,2007,2,21,2010,9,2,2,1,4,ds2,ds8,ds9,ds19,'','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'051',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,10,20,1962,10,25,2010,48,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,12,2007,2,21,2010,9,2,1,1,3,ds5,ds7,ds12,'','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname[2..],'052',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271441(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{2,2,2001,12,15,2010,9,15,2,1,1,ds1,'','','','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,2,2004,12,15,2010,9,15,2,1,1,ds2,'','','','','',sal1,bgfirst2,bglast2,'','','','','','',l.ssn,l.firstname,l.lastname,'002',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMESSN' => Dataset([{3,10,2000,1,30,2010,8,15,2,1,3,ds1,ds6,ds8,'','','',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,10,2000,1,30,2010,8,15,2,1,5,ds2,ds13,ds15,ds16,ds17,'',sal1,bgfirst5,bglast5,'',l.FirstName,l.LastName,sal1,bgfirst10,bglast10,l.ssn,l.firstname,l.lastname,'011',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,10,2000,1,30,2010,8,15,2,1,2,ds3,ds7,'','','','',sal1,bgfirst9,bglast9,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'012',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEDOB' => Dataset([{3,6,2003,1,30,2009,7,10,1,3,3,ds1,ds6,ds9,'','','',sal1,bgfirst4,bglast4,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'020',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''},{3,6,2003,1,30,2010,8,15,1,2,2,ds2,ds8,'','','','',sal1,bgfirst6,bglast6,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'021',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,6,2003,1,30,2009,7,10,1,3,1,ds4,'','','','','',sal1,bgfirst8,bglast8,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'022',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='ADDRESS' => Dataset([{3,12,2000,2,21,2010,8,10,1,1,4,ds1,ds6,ds13,ds14,'','',sal1,'ROBERT',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,12,2000,2,21,2010,8,10,1,1,5,ds2,ds11,ds18,ds19,ds20,'','MRS','ELIZABETH',l.LastName,'MRS','BETH',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{3,12,2000,2,21,2010,8,10,1,1,3,ds8,ds12,ds10,'','','',sal1,'BILLY',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'032',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{3,10,2008,2,21,2010,9,2,1,1,4,ds2,ds6,ds10,ds21,'','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,10,2009,9,21,2010,9,2,1,1,4,ds3,ds12,ds13,ds7,'','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,10,2010,1,10,2010,9,2,1,1,4,ds4,ds5,'','','','','',l.firstname[1],l.LastName[2..],'','','','','','',l.ssn,l.firstname,l.lastname,'042',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='COMBO' => Dataset([{3,5,2007,2,21,2010,9,2,1,1,2,ds2,ds6,'','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'050',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,12,2007,2,21,2010,9,2,2,1,1,ds3,'','','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'051',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,10,20,1962,10,25,2010,48,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,12,2007,2,21,2010,9,2,1,1,2,ds5,ds7,'','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname[2..],'052',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271442(layouts.myDemoRec l, String section) := FUNCTION
		return Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec);
	END;
	Export DataSet_991271443(layouts.myDemoRec l, String section) := FUNCTION
		return Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec);
	END;
	Export DataSet_991271444(layouts.myDemoRec l, String section) := FUNCTION
		return Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec);
	END;
	Export DataSet_991271445(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{2,2,2001,12,15,2010,9,15,2,1,1,ds1,'','','','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,2,2004,12,15,2010,9,15,2,1,1,ds2,'','','','','',sal1,bgfirst2,bglast2,'','','','','','',l.ssn,l.firstname,l.lastname,'002',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271446(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='NAMESSN' => Dataset([{3,10,2000,1,30,2010,8,15,2,1,5,ds1,ds6,ds15,ds16,ds17,'',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,10,2000,1,30,2010,8,15,2,1,3,ds2,ds13,ds8,'','','',sal1,bgfirst5,bglast5,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'011',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,10,2000,1,30,2010,8,15,2,1,2,ds3,ds7,'','','','',sal1,bgfirst9,bglast9,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'012',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271447(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='NAMEDOB' => Dataset([{2,5,2003,1,30,2009,7,10,1,3,3,ds1,ds6,ds8,'','','',sal1,bgfirst4,bglast4,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'020',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,6,2003,1,30,2010,8,15,1,2,3,ds2,ds6,ds13,'','','',sal1,bgfirst6,bglast6,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'021',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''},{3,6,2003,1,30,2009,7,10,1,3,1,ds4,'','','','','',sal1,bgfirst8,bglast8,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'022',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271448(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='ADDRESS' => Dataset([{3,11,2000,2,21,2010,8,10,1,1,5,ds1,ds6,ds13,ds14,ds25,'',sal1,'ROBERT',l.LastName,sal1,'BOB',l.LastName,sal1,'ROB',l.LastName,l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'5'+l.Addr,l.City,l.State,l.Zip,'2'+l.Addr,l.City,l.State,l.Zip},{3,11,2000,2,21,2010,8,10,1,1,4,ds2,ds11,ds18,ds19,'','','MRS','ELIZABETH',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'5'+l.Addr,l.City,l.State,l.Zip,'2'+l.Addr,l.City,l.State,l.Zip},{3,11,2000,2,21,2010,8,10,1,1,2,ds8,ds12,'','','','',sal1,'BILLY',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'032',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271449(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='NAMEADDRESS' => Dataset([{2,10,2008,2,21,2010,9,2,1,1,6,ds2,ds4,ds5,ds6,ds10,ds21,'',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{2,10,2009,9,21,2010,9,2,1,1,4,ds3,ds12,ds13,ds7,'','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271454(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='COMBO' => Dataset([{2,6,2007,2,21,2010,9,2,1,1,4,ds2,ds6,ds13,ds10,'','','',l.firstname,l.LastName,'',l.firstname[1],l.LastName,'',l.firstname[1],l.LastName[2..],l.ssn,l.firstname,l.lastname,'050',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,l.DOB_MONTH-1,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{2,6,2007,2,21,2010,9,2,1,1,2,ds5,ds7,'','','','','',l.firstname,l.LastName,'',l.firstname[1],l.LastName,'',l.firstname[1],l.LastName[2..],l.ssn,l.firstname,l.lastname,'051',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,20,2010,48,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271455(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{3,6,2004,12,15,2010,9,15,2,1,3,ds1,ds6,ds13,'','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,6,2004,12,15,2010,9,15,2,1,2,ds2,ds12,'','','','',sal1,bgfirst2,bglast2,'','','','','','',l.ssn,l.firstname,l.lastname,'002',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{3,6,2004,12,15,2010,9,15,2,1,2,ds3,ds6,'','','','',sal1,bgfirst7,bglast7,'','','','','','',l.ssn,l.firstname,l.lastname,'003',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMESSN' => Dataset([{2,4,2005,1,30,2010,8,15,2,1,2,ds1,ds6,'','','','',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,4,2005,1,30,2010,8,15,2,1,3,ds2,ds6,ds7,'','','',sal1,bgfirst5,bglast5,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'011',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271456(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='ADDRESS' => Dataset([{2,6,2000,2,21,2010,8,10,1,1,2,ds1,ds6,'','','','',sal1,'ROBERT',l.LastName,sal1,'BOB',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{2,6,2000,2,21,2010,8,10,1,1,4,ds2,ds11,ds18,ds19,'','','MRS','ELIZABETH',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{3,6,2008,2,21,2010,9,2,1,1,2,ds2,ds6,'','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'9'+l.Addr,l.City,l.State,l.Zip,'','','',''},{3,6,2009,9,21,2010,9,2,1,1,3,ds3,ds12,ds7,'','','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,6,2010,1,10,2010,9,2,1,1,3,ds4,ds10,ds21,'','','','',l.firstname[1],l.LastName[2..],'','','','','','',l.ssn,l.firstname,l.lastname,'042',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271475(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{2,5,2001,12,15,2010,9,15,2,1,3,ds1,ds6,ds13,'','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,5,2004,12,15,2010,9,15,2,1,2,ds2,ds12,'','','','',sal1,bgfirst2,bglast2,'','','','','','',l.ssn,l.firstname,l.lastname,'002',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='ADDRESS' => Dataset([{3,7,2000,2,21,2010,8,10,1,1,4,ds1,ds6,ds13,'','','',sal1,'ROBERT',l.LastName,sal1,'BOB',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{3,7,2000,2,21,2010,8,10,1,1,3,ds2,ds11,ds18,'','','','MRS','ELIZABETH',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,7,2000,2,21,2010,8,10,1,1,1,ds8,'','','','','',sal1,'BILLY',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'032',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{2,5,2008,2,21,2010,9,2,1,1,3,ds2,ds6,ds10,'','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'9'+l.Addr,l.City,l.State,l.Zip,'','','',''},{2,5,2009,9,21,2010,9,2,1,1,3,ds2,ds12,ds7,'','','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271527(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='NAMESSN' => Dataset([{2,5,2005,1,30,2010,8,15,2,1,3,ds1,ds6,ds13,'','','',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,5,2005,1,30,2010,8,15,2,1,3,ds2,ds6,ds7,'','','',sal1,bgfirst5,bglast5,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'011',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEADDRESS' => Dataset([{3,7,2008,2,21,2010,9,2,1,1,2,ds2,ds6,'','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'040',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{3,7,2009,9,21,2010,9,2,1,1,3,ds3,ds12,ds7,'','','','',l.firstname[1],l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'041',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,7,2010,1,10,2010,9,2,1,1,3,ds2,ds10,ds21,'','','','',l.firstname[1],l.LastName[2..],'','','','','','',l.ssn,l.firstname,l.lastname,'042',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export DataSet_991271617(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='NAMESSN' => Dataset([{2,5,2005,1,30,2010,8,15,2,1,3,ds1,ds6,ds13,'','','',sal1,bgfirst3,bglast3,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'010',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,5,2005,1,30,2010,8,15,2,1,3,ds2,ds6,ds7,'','','',sal1,bgfirst5,bglast5,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'011',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='NAMEDOB' => Dataset([{2,5,2003,1,30,2009,7,10,1,3,3,ds1,ds6,ds9,'','','',sal1,bgfirst4,bglast4,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'020',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,10,21,2009,38,'','','','','','','','','','','','','','','',''},{2,5,2003,1,30,2010,8,15,1,2,2,ds2,ds8,'','','','',sal1,bgfirst6,bglast6,'',l.FirstName,l.LastName,'','','',l.ssn,l.firstname,l.lastname,'021',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='COMBO' => Dataset([{2,3,2007,2,21,2010,9,2,1,1,2,ds2,ds6,'','','','','',l.firstname,l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'050',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{2,3,2007,2,21,2010,9,2,2,1,2,ds2,ds10,'','','','','',l.firstname,l.LastName[2..],'','','','','','',l.ssn,l.firstname,l.lastname,'051',l.DOB_MONTH,l.DOB_DAY,l.DOB_YEAR,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	Export Dataset_991271618(layouts.myDemoRec l, String section) := FUNCTION
		return map (section='SSN' => Dataset([{2,5,2001,12,15,2010,9,15,2,1,3,ds1,ds6,ds13,'','','',sal1,bgfirst1,bglast1,'','','','','','',l.ssn,l.firstname,l.lastname,'001',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''},{2,5,2004,12,15,2010,9,15,2,1,2,ds2,ds12,'','','','',sal1,bgfirst2,bglast2,'','','','','','',l.ssn,l.firstname,l.lastname,'002',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec),
								section='ADDRESS' => Dataset([{3,7,2000,2,21,2010,8,10,1,1,4,ds1,ds6,ds13,'','','',sal1,'ROBERT',l.LastName,sal1,'BOB',l.LastName,'','','',l.ssn,l.firstname,l.lastname,'030',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'1'+l.Addr,l.City,l.State,l.Zip,'','','','','','','',''},{3,7,2000,2,21,2010,8,10,1,1,3,ds2,ds11,ds18,'','','','MRS','ELIZABETH',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'031',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''},{3,7,2000,2,21,2010,8,10,1,1,1,ds8,'','','','','',sal1,'BILLY',l.LastName,'','','','','','',l.ssn,l.firstname,l.lastname,'032',0,0,0,0,0,0,0,0,0,0,l.Addr,l.City,l.State,l.Zip,'','','','','','','','','','','',''}], myTestDataRec),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;
	//Adult Demo Subjects
	Export DataSet_991271542(layouts.myDemoRec l, String section) := FUNCTION
		return Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec);
	END;
	Export DataSet_992213648(layouts.myDemoRec l, String section) := FUNCTION
		return Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec);
	END;
	Export DataSet_992212052(layouts.myDemoRec l, String section) := FUNCTION
		return Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec);
	END;
	Export DataSet_992212054(layouts.myDemoRec l, String section) := FUNCTION
		return Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec);
	END;

	Export getdata(layouts.myDemoRec l, String section) := Function
		return MAP (l.ssn='991271437' => DataSet_991271437(l, section),
								l.ssn='991271438' => DataSet_991271438(l, section),
								l.ssn='991271439' => DataSet_991271439(l, section),
								l.ssn='991271440' => DataSet_991271440(l, section),
								l.ssn='991271441' => DataSet_991271441(l, section),
								l.ssn='991271442' => DataSet_991271442(l, section),
								l.ssn='991271443' => DataSet_991271443(l, section),
								l.ssn='991271444' => DataSet_991271444(l, section),
								l.ssn='991271445' => DataSet_991271445(l, section),
								l.ssn='991271446' => DataSet_991271446(l, section),
								l.ssn='991271447' => DataSet_991271447(l, section),
								l.ssn='991271448' => DataSet_991271448(l, section),
								l.ssn='991271449' => DataSet_991271449(l, section),
								l.ssn='991271454' => DataSet_991271454(l, section),
								l.ssn='991271455' => DataSet_991271455(l, section),
								l.ssn='991271456' => DataSet_991271456(l, section),
								l.ssn='991271475' => DataSet_991271475(l, section),
								l.ssn='991271527' => DataSet_991271527(l, section),
								l.ssn='991271617' => DataSet_991271617(l, section),
								l.ssn='991271618' => DataSet_991271618(l, section),
								l.ssn='991271542' => DataSet_991271542(l, section),
								l.ssn='992213648' => DataSet_992213648(l, section),
								l.ssn='992212052' => DataSet_992212052(l, section),
								l.ssn='992212054' => DataSet_992212054(l, section),
								Dataset([{0,0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','','','','','',0,0,0,0,0,0,0,0,0,0,'','','','','','','','','','','','','','','',''}], myTestDataRec));
	END;

	export iesp.public_profile_report.t_SSNSubject xfm_SSN_Subject(myTestDataRec l) := TRANSFORM
		Self.UniqueId := l.uniqueid;
		Self.FirstSeen.Year := l.fsy;
		Self.FirstSeen.Month := l.fsm;
		Self.FirstSeen.Day := l.fsd;
		Self.LastSeen.Year := l.lsy;
		Self.LastSeen.Month := l.lsm;
		Self.LastSeen.Day := l.lsd;
		Self.SSNCount := l.ssnc;
		Self.DOBCount := l.dobc;
		Self.SourceCount := l.source;
		Self.Sources :=  map (length(l.s6)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5},{l.s6}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s5)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s4)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s3)>0 => Dataset([{l.s1},{l.s2},{l.s3}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s2)>0 => Dataset([{l.s1},{l.s2}], iesp.public_profile_report.t_PublicProfileSource),
													Dataset([{l.s1}], iesp.public_profile_report.t_PublicProfileSource));
		Self.SSNInformation := if (length(l.ssn)>0,Dataset([{l.ssn,'B','CA',1995,1,0,1996,12,0}], iesp.share.t_SSNInfo),Dataset([{'','','',0,0,0,0,0,0}], iesp.share.t_SSNInfo));
		Self.Names := map(length(l.n3f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n3f,'',l.n3l,'',l.t3,'')], iesp.share.t_Name),
											length(l.n2f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name),
											Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name));
		Self := [];
	END;

	Export iesp.public_profile_report.t_SSNResults xfm_SSN(layouts.myDemoRec l) := TRANSFORM
		myData := getdata(l,'SSN');
		Self.FirstSeen.Year := myData[1].fsy;
		Self.FirstSeen.Month := myData[1].fsm;
		Self.FirstSeen.Day := myData[1].fsd;
		Self.LastSeen.Year := myData[1].lsy;
		Self.LastSeen.Month := myData[1].lsm;
		Self.LastSeen.Day := myData[1].lsd;
		Self.SubjectCount := myData[1].subjectcount;
		Self.SourceCount := myData[1].sourcecount;
		self.Subjects := Project(myData,xfm_SSN_Subject(LEFT));
		Self := [];
	END;
		

	export iesp.public_profile_report.t_NameSSNSubject xfm_NameSSN_Subject(myTestDataRec l) := TRANSFORM
		Self.UniqueId := l.uniqueid;
		Self.FirstSeen.Year := l.fsy;
		Self.FirstSeen.Month := l.fsm;
		Self.FirstSeen.Day := l.fsd;
		Self.LastSeen.Year := l.lsy;
		Self.LastSeen.Month := l.lsm;
		Self.LastSeen.Day := l.lsd;
		Self.SSNCount := l.ssnc;
		Self.DOBCount := l.dobc;
		Self.SourceCount := l.source;
		Self.Sources :=  map (length(l.s6)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5},{l.s6}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s5)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s4)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s3)>0 => Dataset([{l.s1},{l.s2},{l.s3}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s2)>0 => Dataset([{l.s1},{l.s2}], iesp.public_profile_report.t_PublicProfileSource),
													Dataset([{l.s1}], iesp.public_profile_report.t_PublicProfileSource));
		Self.SSNInformation := if (length(l.ssn)>0,Dataset([{l.ssn,'B','CA',1995,1,0,1996,12,0}], iesp.share.t_SSNInfo),Dataset([{'','','',0,0,0,0,0,0}], iesp.share.t_SSNInfo));
		Self.Names := map(length(l.n3f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n3f,'',l.n3l,'',l.t3,'')], iesp.share.t_Name),
											length(l.n2f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name),
											Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name));
		Self := [];
	END;

	export iesp.public_profile_report.t_NameSSNResults xfm_NameSSN(layouts.myDemoRec l) := TRANSFORM
		myData := getdata(l,'NAMESSN');
		Self.FirstSeen.Year := myData[1].fsy;
		Self.FirstSeen.Month := myData[1].fsm;
		Self.FirstSeen.Day := myData[1].fsd;
		Self.LastSeen.Year := myData[1].lsy;
		Self.LastSeen.Month := myData[1].lsm;
		Self.LastSeen.Day := myData[1].lsd;
		Self.SubjectCount := myData[1].subjectcount;
		Self.SourceCount := myData[1].sourcecount;
		self.Subjects := Project(myData,xfm_NameSSN_Subject(LEFT));
		Self := [];
	END;

	export iesp.public_profile_report.t_NameDOBSubject xfm_NameDOB_Subject(myTestDataRec l) := TRANSFORM
		Self.UniqueId := l.uniqueid;
		Self.FirstSeen.Year := l.fsy;
		Self.FirstSeen.Month := l.fsm;
		Self.FirstSeen.Day := l.fsd;
		Self.LastSeen.Year := l.lsy;
		Self.LastSeen.Month := l.lsm;
		Self.LastSeen.Day := l.lsd;
		Self.SSNCount := l.ssnc;
		Self.DOBCount := l.dobc;
		Self.SourceCount := l.source;
		Self.Sources :=  map (length(l.s6)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5},{l.s6}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s5)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s4)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s3)>0 => Dataset([{l.s1},{l.s2},{l.s3}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s2)>0 => Dataset([{l.s1},{l.s2}], iesp.public_profile_report.t_PublicProfileSource),
													Dataset([{l.s1}], iesp.public_profile_report.t_PublicProfileSource));
		Self.BirthInformation := Dataset([{l.doby1,l.dobm1,l.dobd1}], iesp.public_profile_report.t_PublicProileBirthInfo);
		Self.DeathInformation := Dataset([{l.dody,l.dodm,l.dodd,l.dodage,'Y'}], iesp.public_profile_report.t_PublicProileDeathInfo);
		Self.Names := map(length(l.n3f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n3f,'',l.n3l,'',l.t3,'')], iesp.share.t_Name),
											length(l.n2f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name),
											Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name));
		Self := [];
	END;

	export iesp.public_profile_report.t_NameDOBResults xfm_NameDOB(layouts.myDemoRec l) := TRANSFORM
		myData := getdata(l,'NAMEDOB');
		Self.FirstSeen.Year := myData[1].fsy;
		Self.FirstSeen.Month := myData[1].fsm;
		Self.FirstSeen.Day := myData[1].fsd;
		Self.LastSeen.Year := myData[1].lsy;
		Self.LastSeen.Month := myData[1].lsm;
		Self.LastSeen.Day := myData[1].lsd;
		Self.SubjectCount := myData[1].subjectcount;
		Self.SourceCount := myData[1].sourcecount;
		self.Subjects := Project(myData,xfm_NameDOB_Subject(LEFT));
		Self := [];
	END;

	export iesp.public_profile_report.t_AddressSubject xfm_Address_Subject(myTestDataRec l) := TRANSFORM
		Self.UniqueId := l.uniqueid;
		Self.FirstSeen.Year := l.fsy;
		Self.FirstSeen.Month := l.fsm;
		Self.FirstSeen.Day := l.fsd;
		Self.LastSeen.Year := l.lsy;
		Self.LastSeen.Month := l.lsm;
		Self.LastSeen.Day := l.lsd;
		Self.SSNCount := l.ssnc;
		Self.DOBCount := l.dobc;
		Self.SourceCount := l.source;
		Self.Sources :=  map (length(l.s6)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5},{l.s6}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s5)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s4)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s3)>0 => Dataset([{l.s1},{l.s2},{l.s3}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s2)>0 => Dataset([{l.s1},{l.s2}], iesp.public_profile_report.t_PublicProfileSource),
													Dataset([{l.s1}], iesp.public_profile_report.t_PublicProfileSource));
		Self.Names := map(length(l.n3f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n3f,'',l.n3l,'',l.t3,'')], iesp.share.t_Name),
											length(l.n2f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name),
											Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name));
		Self.Addresses := map(length(trim(l.zip4))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr3,'',l.state3,l.city3,l.zip3,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr4,'',l.state4,l.city4,l.zip4,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											length(trim(l.zip3))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr3,'',l.state3,l.city3,l.zip3,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											length(trim(l.zip2))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress));
		Self := [];
	END;


	export iesp.public_profile_report.t_AddressResults xfm_Address(layouts.myDemoRec l) := TRANSFORM
		myData := getdata(l,'ADDRESS');
		Self.FirstSeen.Year := myData[1].fsy;
		Self.FirstSeen.Month := myData[1].fsm;
		Self.FirstSeen.Day := myData[1].fsd;
		Self.LastSeen.Year := myData[1].lsy;
		Self.LastSeen.Month := myData[1].lsm;
		Self.LastSeen.Day := myData[1].lsd;
		Self.SubjectCount := myData[1].subjectcount;
		Self.SourceCount := myData[1].sourcecount;
		self.Subjects := Project(myData,xfm_Address_Subject(LEFT));
		Self := [];
	END;

	export iesp.public_profile_report.t_NameAddressSubject xfm_NameAddress_Subject(myTestDataRec l) := TRANSFORM
		Self.UniqueId := l.uniqueid;
		Self.FirstSeen.Year := l.fsy;
		Self.FirstSeen.Month := l.fsm;
		Self.FirstSeen.Day := l.fsd;
		Self.LastSeen.Year := l.lsy;
		Self.LastSeen.Month := l.lsm;
		Self.LastSeen.Day := l.lsd;
		Self.SSNCount := l.ssnc;
		Self.DOBCount := l.dobc;
		Self.SourceCount := l.source;
		Self.Sources :=  map (length(l.s6)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5},{l.s6}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s5)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s4)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s3)>0 => Dataset([{l.s1},{l.s2},{l.s3}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s2)>0 => Dataset([{l.s1},{l.s2}], iesp.public_profile_report.t_PublicProfileSource),
													Dataset([{l.s1}], iesp.public_profile_report.t_PublicProfileSource));
		Self.Names := map(length(l.n3f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n3f,'',l.n3l,'',l.t3,'')], iesp.share.t_Name),
											length(l.n2f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name),
											Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name));
		Self.Addresses := map(length(trim(l.zip4))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr3,'',l.state3,l.city3,l.zip3,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr4,'',l.state4,l.city4,l.zip4,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											length(trim(l.zip3))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr3,'',l.state3,l.city3,l.zip3,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											length(trim(l.zip2))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress));
		Self := [];
	END;

	export iesp.public_profile_report.t_NameAddressResults xfm_NameAddress(layouts.myDemoRec l) := TRANSFORM
		myData := getdata(l,'NAMEADDRESS');
		Self.FirstSeen.Year := myData[1].fsy;
		Self.FirstSeen.Month := myData[1].fsm;
		Self.FirstSeen.Day := myData[1].fsd;
		Self.LastSeen.Year := myData[1].lsy;
		Self.LastSeen.Month := myData[1].lsm;
		Self.LastSeen.Day := myData[1].lsd;
		Self.SubjectCount := myData[1].subjectcount;
		Self.SourceCount := myData[1].sourcecount;
		self.Subjects := Project(myData,xfm_NameAddress_Subject(LEFT));
		Self := [];
	END;

	export iesp.public_profile_report.t_CombinationSubject xfm_Combo_Subject(myTestDataRec l) := TRANSFORM
		Self.UniqueId := l.uniqueid;
		Self.FirstSeen.Year := l.fsy;
		Self.FirstSeen.Month := l.fsm;
		Self.FirstSeen.Day := l.fsd;
		Self.LastSeen.Year := l.lsy;
		Self.LastSeen.Month := l.lsm;
		Self.LastSeen.Day := l.lsd;
		Self.SSNCount := l.ssnc;
		Self.DOBCount := l.dobc;
		Self.SourceCount := l.source;
		Self.Sources :=  map (length(l.s6)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5},{l.s6}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s5)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4},{l.s5}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s4)>0 => Dataset([{l.s1},{l.s2},{l.s3},{l.s4}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s3)>0 => Dataset([{l.s1},{l.s2},{l.s3}], iesp.public_profile_report.t_PublicProfileSource),
													length(l.s2)>0 => Dataset([{l.s1},{l.s2}], iesp.public_profile_report.t_PublicProfileSource),
													Dataset([{l.s1}], iesp.public_profile_report.t_PublicProfileSource));
		Self.SSNInformation := map (l.ssnc=2 => Dataset([{l.ssn,'G','CA',1995,1,0,1996,12,0},{'1'+l.ssn[2..],'T','CA',1995,1,0,1996,12,0}], iesp.share.t_SSNInfo),
													if (length(l.ssn)>0,Dataset([{l.ssn,'B','CA',1995,1,0,1996,12,0}], iesp.share.t_SSNInfo),Dataset([{'','','',0,0,0,0,0,0}], iesp.share.t_SSNInfo)));
		Self.DeathInformation := Dataset([{l.dody,l.dodm,l.dodd,l.dodage,'Y'}], iesp.public_profile_report.t_PublicProileDeathInfo);
		Self.Names := map(length(l.n3f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n3f,'',l.n3l,'',l.t3,'')], iesp.share.t_Name),
											length(l.n2f)>0 => Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name)+Dataset([iesp.ECL2ESP.setName(l.n2f,'',l.n2l,'',l.t2,'')], iesp.share.t_Name),
											Dataset([iesp.ECL2ESP.setName(l.n1f,'',l.n1l,'',l.t1,'')], iesp.share.t_Name));
		Self.key :=if(length(l.uniqueid)>0,'NAME,SSN,DOB','');									
		Self.BirthInformation := Dataset([{l.doby1,l.dobm1,l.dobd1}], iesp.public_profile_report.t_PublicProileBirthInfo);
		Self.Addresses := map(length(trim(l.zip4))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr3,'',l.state3,l.city3,l.zip3,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr4,'',l.state4,l.city4,l.zip4,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											length(trim(l.zip3))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr3,'',l.state3,l.city3,l.zip3,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											length(trim(l.zip2))>0 => Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd},{'','','','','','','',l.Addr2,'',l.state2,l.city2,l.zip2,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress),
											Dataset([{'','','','','','','',l.Addr1,'',l.state1,l.city1,l.zip1,'','','','',l.fsy,l.fsm,l.fsd,l.lsy,l.lsm,l.lsd}], iesp.public_profile_report.t_PublicProfileAddress));
		Self := [];
	END;

	export iesp.public_profile_report.t_CombinationResults xfm_Combo(layouts.myDemoRec l) := TRANSFORM
		myData := getdata(l,'COMBO');
		Self.FirstSeen.Year := myData[1].fsy;
		Self.FirstSeen.Month := myData[1].fsm;
		Self.FirstSeen.Day := myData[1].fsd;
		Self.LastSeen.Year := myData[1].lsy;
		Self.LastSeen.Month := myData[1].lsm;
		Self.LastSeen.Day := myData[1].lsd;
		Self.SubjectCount := myData[1].subjectcount;
		Self.SourceCount := myData[1].sourcecount;
		self.Subjects := Project(myData,xfm_Combo_Subject(LEFT));
		Self := [];
	END;

	Export getSSNResults(layouts.myDemoRec l) := Function
		return Project(l,xfm_SSN(LEFT));
	END;
	Export getNameSSNResults(layouts.myDemoRec l) := Function
		return Project(l,xfm_NameSSN(LEFT));
	END;
	Export getNameDOBResults(layouts.myDemoRec l) := Function
		return Project(l,xfm_NameDOB(LEFT));
	END;
	Export getAddressResultsResults(layouts.myDemoRec l) := Function
		return Project(l,xfm_Address(LEFT));
	END;
	Export getNameAddressResultsResults(layouts.myDemoRec l) := Function
		return Project(l,xfm_NameAddress(LEFT));
	END;
	Export getCombinationResultsResults(layouts.myDemoRec l) := Function
		return Project(l,xfm_Combo(LEFT));
	END;
	// Export getIndividualResults(layouts.myDemoRec l) := Function
		// myData := MAP(l.ssn='991271542' => PublicProfileServices.TestData_ReportBy.DataSet_ReportByData_991271542(),
								// l.ssn='992213648' => PublicProfileServices.TestData_ReportBy.DataSet_ReportByData_992213648(),
								// l.ssn='992212052' => PublicProfileServices.TestData_ReportBy.DataSet_ReportByData_992212052(),
								// l.ssn='992212054' => PublicProfileServices.TestData_ReportBy.DataSet_ReportByData_992212054(),
								// Dataset([], PublicProfileServices.layouts.myDemoRec));
		// return Project(myData,PublicProfileServices.TestData_Individual.xfmMain(LEFT));
		// return row(PublicProfileServices.TestData_Individual.xfmMain(myData));
	// END;

End;