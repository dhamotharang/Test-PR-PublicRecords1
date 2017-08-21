IMPORT	BankruptcyV3,	BankruptcyV2,	Data_Services;
EXPORT	File_BankruptcyV3_WithdrawnStatus(	STRING	pVersion	=	'',
																						BOOLEAN	pUseProd	=	FALSE)	:=	MODULE
	SHARED	filename	:=	Filenames(pVersion,pUseProd).Input.WithdrawnStatus.Using;
	SHARED	dSampleFileLogical	:=	
		DATASET(filename,Layout_BankruptcyV3_WithdrawnStatus.wsLogical,
			CSV(	SEPARATOR([',']),
						TERMINATOR(['\n','\r\n','\n\r']),
						QUOTE(['\'','"'])));
	SHARED	dSampleFileVirtual	:=	
		DATASET(filename,Layout_BankruptcyV3_WithdrawnStatus.wsVirtual,
			CSV(	SEPARATOR([',']),
						TERMINATOR(['\n','\r\n','\n\r']),
						QUOTE(['\'','"'])));

	// SHARED	dSampleRecordsLogical	:=	
		// DATASET([
			// {1000000, '2017/03/15 17:08:46.00', '40990111', '80185983', '13', '7', '', '2016/11/19 00:00:00.0', 'OPEN',       '', '2017/01/23 00:00:00.0', '88', '9999999999-9999999999-99999997', 'BKAZ0011515181', '', '', '', '', 																													  '1', '2016/03/15 17:08:46.00', 'DISMISSED', '2017/03/15 17:08:46.00', 'false', '', '2017/03/14 17:08:46.00'}, 
			// {1000001, '2017/03/15 17:08:46.00', '41796450', '81167457', '7', '13', '', '2017/02/09 00:00:00.0', 'DISCHARGED', '', '2017/01/23 00:00:00.0', '2',  '9999999999-9999999999-99999998', 'BKCA0021625840', '298576', '2014/12/04 00:00:00.0 ', 'DISMISSED', '2014/09/09 00:00:00.0 ', '2', '2016/03/15 17:08:46.00', 'DISMISSED', '2017/03/15 17:08:46.00', 'false', '', '2017/03/14 17:08:46.00'}, 
			// {1000002, '2017/03/15 17:08:46.00', '40653920', '79773539', '13', '7', '', '2016/11/19 00:00:00.0', 'DISMISSED',  '', '2017/01/23 00:00:00.0', '15', '9999999999-9999999999-99999999', 'BKFL0011522078', '298575', '2014/12/04 00:00:00.0 ', 'DISMISSED', '2014/09/09 00:00:00.0 ', '3', '2016/03/15 17:08:46.00', 'DISMISSED', '2017/03/15 17:08:46.00', 'false', '', '2017/03/14 17:08:46.00'}], BankruptcyV3.Layout_BankruptcyV3_WithdrawnStatus.wsLogical);

	// SHARED	dSampleRecordsLogicalVirtual	:=	PROJECT(dSampleRecordsLogical,
																							// TRANSFORM(
																								// RECORDOF(Layout_BankruptcyV3_WithdrawnStatus.wsVirtual),
																								// SELF	:=	LEFT;
																								// SELF	:=	[];
																							// )
																						// );

	EXPORT	wsLogical	:=	dSampleFileLogical;//+dSampleRecordsLogical;
	EXPORT	wsVirtual	:=	dSampleFileVirtual;//+dSampleRecordsLogicalVirtual;
	EXPORT	wsBase		:=	DATASET(Filenames(,pUseProd).Base.WithdrawnStatus.QA,Layout_BankruptcyV3_WithdrawnStatus.wsBase,THOR,__COMPRESSED__,OPT);
END;