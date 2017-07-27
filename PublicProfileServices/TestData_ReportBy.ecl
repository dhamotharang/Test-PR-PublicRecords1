Import iesp;
EXPORT TestData_ReportBy := MODULE


	Export DataSet_ReportByData_Empty() := FUNCTION
		return DATASET([{'','','','','',0,0,0,'','','',''}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271437() := FUNCTION
		return DATASET([{'9912714379','SARAH','J','LLARKER','991271437',8,18,1995,'99512 FIRST AVE','BIRDVILLE','PA','17052'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271438() := FUNCTION
		return DATASET([{'9912714389','MARIA','D','BBERSTEIN','991271438',2,15,1999,'75484 SECOND AVE','CONCEPTION','MO','64433'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271439() := FUNCTION
		return DATASET([{'9912714399','GERTUDE','L','SSTEINWAY','991271439',5,19,1995,'3251 SIXTH AVE','NEPTUNE','NJ','07753'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271440() := FUNCTION
		return DATASET([{'9912714409','HORACE','H','HHOWITZER','991271440',10,21,2000,'2225 LOMBARD ST','TANKSLEY','KY','40962'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271441() := FUNCTION
		return DATASET([{'9912714419','HEATHCLIFF','F','BBRONTE','991271441',2,12,2001,'5402 MISSION ST','SISTERS','OR','97759'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271442() := FUNCTION
		return DATASET([{'9912714429','IVY','C','WWALL','991271442',9,4,1995,'2014 BAY SHORE WY','SISSONVILLE','WV','26175'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271443() := FUNCTION
		return DATASET([{'9912714439','JENNIFER','K','CCRENSHAW','991271443',5,5,1996,'50233 MIDDLETOWN RD','HONEYDEW','CA','95545'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271444() := FUNCTION
		return DATASET([{'9912714449','JEAN','L','LLAFITTER','991271444',1,22,2008,'7801 LONG RIDGE RD','NEW ORLEANS','LA','70112'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271445() := FUNCTION
		return DATASET([{'9912714459','GLEN','D','GGLEN','991271445',10,21,1998,'1021 DELTA DR','SPANGLE','WA','99031'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271446() := FUNCTION
		return DATASET([{'9912714469','JASON','P','AARGONAUT','991271446',3,21,2003,'1502 CROWNSGATE ST','SAILOR SPRINGS','IL','62879'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271447() := FUNCTION
		return DATASET([{'9912714479','WILLARD','P','MMARSHALL','991271447',2,15,2008,'45 FESTIVAL WY','SHERIDAN','MI','48884'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271448() := FUNCTION
		return DATASET([{'9912714489','RACHAEL','E','WWRIGHT','991271448',9,21,1997,'10 PADRONE WY','KILL DEVIL HILLS','NC','27948'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271449() := FUNCTION
		return DATASET([{'9912714499','EMILY','W','HHEATHCLIFF','991271449',9,30,1998,'20 HIGHLAND ST','MOORES MILL','MS','38838'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271454() := FUNCTION
		return DATASET([{'9912714549','TYLER','N','BBISHOP','991271454',12,25,2004,'70 LUTHER WY','CHURCHS FERRY','ND','58325'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271455() := FUNCTION
		return DATASET([{'9912714559','TRONE','','TTRONK','991271455',4,17,2003,'80 POLLSTER PASS','WILSON','OK','73463'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271456() := FUNCTION
		return DATASET([{'9912714569','TYRONE','P','SSPRITZER','991271456',1,4,2009,'90 BOGLE DR','CHANTILLY','VA','20151'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271475() := FUNCTION
		return DATASET([{'9912714759','JERZY','B','BBAKEKKE','991271475',7,5,1992,'55 GLASSINE DR','WINDOW ROCK','AZ','86515'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271527() := FUNCTION
		return DATASET([{'9912715279','PHILLIP','X','HHALL','991271527',6,18,2001,'23335 JACKSON RD','WILTON','AL','35186'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271617() := FUNCTION
		return DATASET([{'9912716179','WARREN','G','HHARDLINER','991271617',4,1,2007,'32589 HARRISON RD','WINDSOR','CT','06095'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271618() := FUNCTION
		return DATASET([{'9912716189','BRUCE','C','TTOADY','991271618',12,12,1993,'24523 FROG LEAP WY','CALISTOGA','CA','94515'}], layouts.myDemoRec);
	END;
	Export DataSet_ReportByData_991271619() := FUNCTION
		return DATASET([{'9912716199','BRYANT','','GGRANT','991271619',5,5,1980,'15478 JUSTIN CT','TAOS','NM','87571'}], layouts.myDemoRec);
	END;

	export iesp.public_profile_report.t_PublicProfileReportBy xformRptBy(layouts.myDemoRec l) := TRANSFORM
		SELF.Name.First := l.FirstName;
		SELF.Name.Middle := l.MiddleName;
		SELF.Name.Last := l.LastName;
		SELF.UniqueId := l.UniqueId;
		SELF.SSN := l.SSN;
		SELF.DOB.Month := l.DOB_MONTH;
		SELF.DOB.Day := l.DOB_DAY;
		SELF.DOB.Year := l.DOB_YEAR;
		SELF.Address.StreetAddress1 := l.Addr;
		SELF.Address.City := l.City;
		SELF.Address.State := l.State;
		SELF.Address.Zip5 := l.Zip;
		SELF := [];
	END;


	EXPORT DemoData(IParam.searchParams rptBy) := FUNCTION
		return MAP (rptBy.SSN='991271437' => DataSet_ReportByData_991271437(),
								rptBy.SSN='991271438' => DataSet_ReportByData_991271438(),
								rptBy.SSN='991271439' => DataSet_ReportByData_991271439(),
								rptBy.SSN='991271440' => DataSet_ReportByData_991271440(),
								rptBy.SSN='991271441' => DataSet_ReportByData_991271441(),
								rptBy.SSN='991271442' => DataSet_ReportByData_991271442(),
								rptBy.SSN='991271443' => DataSet_ReportByData_991271443(),
								rptBy.SSN='991271444' => DataSet_ReportByData_991271444(),
								rptBy.SSN='991271445' => DataSet_ReportByData_991271445(),
								rptBy.SSN='991271446' => DataSet_ReportByData_991271446(),
								rptBy.SSN='991271447' => DataSet_ReportByData_991271447(),
								rptBy.SSN='991271448' => DataSet_ReportByData_991271448(),
								rptBy.SSN='991271449' => DataSet_ReportByData_991271449(),
								rptBy.SSN='991271454' => DataSet_ReportByData_991271454(),
								rptBy.SSN='991271455' => DataSet_ReportByData_991271455(),
								rptBy.SSN='991271456' => DataSet_ReportByData_991271456(),
								rptBy.SSN='991271475' => DataSet_ReportByData_991271475(),
								rptBy.SSN='991271527' => DataSet_ReportByData_991271527(),
								rptBy.SSN='991271456' => DataSet_ReportByData_991271456(),
								rptBy.SSN='991271617' => DataSet_ReportByData_991271617(),
								rptBy.SSN='991271618' => DataSet_ReportByData_991271618(),
								rptBy.SSN='991271619' => DataSet_ReportByData_991271619(),
								DataSet_ReportByData_EMPTY());
	END;

End;