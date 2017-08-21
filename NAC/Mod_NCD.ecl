export	Mod_NCD(string pFileName)	:=
module
	import	NAC;

	////////////////////////////////////////////////////////////////////////
	shared	dFieldStats	:=	NAC.Mod_Stats.ValidateInputFields(pFileName).ValidationResults;

	////////////////////////////////////////////////////////////////////////
	shared	string1		ContributionLevel						:=	'C';
	shared	string1		FieldLevel									:=	'F';
	shared	string1		RecordLevel									:=	'R';
	shared	string4		ContributionFileName				:=	'1001';
	shared	string4		ContributionIsFileAccepted	:=	'1002';
	shared	string4		ContributionTotalRecords		:=	'1003';
	shared	string4		ContributionAcceptedRecords	:=	'1004';
	shared	string4		ContributionRejectedRecords	:=	'1005';
	shared	string4		ContributionWarningsCount		:=	'1098';
	shared	string4		ContributionErrorsCount			:=	'1099';
	shared	string4		ContributionEndOfReport			:=	'9999';

	////////////////////////////////////////////////////////////////////////
	shared	string8	fFixPercent8(decimal6_3 pValue)	:=
	function
		unsigned4	lInteger	:=	if(pValue <> 0, pValue * 1000, 0);
		string6		lString		:=	intformat(lInteger, 6, 1);
		string8		ReturnValue	:=	lString[1..3] + '.' + lString[4..6] + '%';
		return	ReturnValue;
	end;

	////////////////////////////////////////////////////////////////////////
	rNCD_Inline	:=
	record
		string1		RecordType;					// C=Contribution, R=Record, F=Field
		string4		Code;
		string40	Description;
		string50	StatsField;					// For join to stats (NAC.Mod_Stats.ValidateInputFields)
	end;
	shared	dNCD_Inline	:=	dataset([
																		{ContributionLevel,	ContributionFileName,					'File Name',	'File Name'},
																		{ContributionLevel,	ContributionIsFileAccepted,		'File Accepted',	'File Accepted'},
																		{ContributionLevel,	ContributionTotalRecords,			'Total Records',	'Total Records'},
																		{ContributionLevel,	ContributionAcceptedRecords,	'Accepted Records',	'Accepted Records'},
																		{ContributionLevel,	ContributionRejectedRecords,	'Rejected Records',	'Rejected Records'},
																		{ContributionLevel,	ContributionWarningsCount,		'Warnings',	'Warnings'},
																		{ContributionLevel,	ContributionErrorsCount,			'Errors',	'Errors'},
																		{ContributionLevel,	ContributionEndOfReport,			'End of Report',	'End of Report'},
																		{FieldLevel, '2001', 'Case_State_Abbreviation', 'Case_State_Abbreviation'},
																		{FieldLevel, '2002', 'Case_Benefit_Type', 'Case_Benefit_Type'},
																		{FieldLevel, '2003', 'Case_Benefit_Month', 'Case_Benefit_Month'},
																		{FieldLevel, '2004', 'Case_Identifier', 'Case_Identifier'},
																		{FieldLevel, '2005', 'Case_Last_Name', 'Case_Last_Name'},
																		{FieldLevel, '2006', 'Case_First_Name', 'Case_First_Name'},
																		{FieldLevel, '2007', 'Case_Middle_Name', 'Case_Middle_Name'},
																		{FieldLevel, '2008', 'Case_Phone_1', 'Case_Phone_1'},
																		{FieldLevel, '2009', 'Case_Phone_2', 'Case_Phone_2'},
																		{FieldLevel, '2010', 'Case_Email', 'Case_Email'},
																		{FieldLevel, '2011', 'Case_Physical_Address_Street_1', 'Case_Physical_Address_Street_1'},
																		{FieldLevel, '2012', 'Case_Physical_Address_Street_2', 'Case_Physical_Address_Street_2'},
																		{FieldLevel, '2013', 'Case_Physical_Address_City', 'Case_Physical_Address_City'},
																		{FieldLevel, '2014', 'Case_Physical_Address_State', 'Case_Physical_Address_State'},
																		{FieldLevel, '2015', 'Case_Physical_Address_Zip', 'Case_Physical_Address_Zip'},
																		{FieldLevel, '2016', 'Case_Mailing_Address_Street_1', 'Case_Mailing_Address_Street_1'},
																		{FieldLevel, '2017', 'Case_Mailing_Address_Street_2', 'Case_Mailing_Address_Street_2'},
																		{FieldLevel, '2018', 'Case_Mailing_Address_City', 'Case_Mailing_Address_City'},
																		{FieldLevel, '2019', 'Case_Mailing_Address_State', 'Case_Mailing_Address_State'},
																		{FieldLevel, '2020', 'Case_Mailing_Address_Zip', 'Case_Mailing_Address_Zip'},
																		{FieldLevel, '2021', 'Case_County_Parish_Code', 'Case_County_Parish_Code'},
																		{FieldLevel, '2022', 'Case_County_Parish_Name', 'Case_County_Parish_Name'},
																		{FieldLevel, '2023', 'Client_Identifier', 'Client_Identifier'},
																		{FieldLevel, '2024', 'Client_Last_Name', 'Client_Last_Name'},
																		{FieldLevel, '2025', 'Client_First_Name', 'Client_First_Name'},
																		{FieldLevel, '2026', 'Client_Middle_Name', 'Client_Middle_Name'},
																		{FieldLevel, '2027', 'Client_Gender', 'Client_Gender'},
																		{FieldLevel, '2028', 'Client_Race', 'Client_Race'},
																		{FieldLevel, '2029', 'Client_Ethnicity', 'Client_Ethnicity'},
																		{FieldLevel, '2030', 'Client_SSN', 'Client_SSN'},
																		{FieldLevel, '2031', 'Client_SSN_Type_Indicator', 'Client_SSN_Type_Indicator'},
																		{FieldLevel, '2032', 'Client_DOB', 'Client_DOB'},
																		{FieldLevel, '2033', 'Client_DOB_Type_Indicator', 'Client_DOB_Type_Indicator'},
																		{FieldLevel, '2034', 'Client_Eligible_Status_Indicator', 'Client_Eligible_Status_Indicator'},
																		{FieldLevel, '2035', 'Client_Eligible_Status_Date', 'Client_Eligible_Status_Date'},
																		{FieldLevel, '2036', 'Client_Phone', 'Client_Phone'},
																		{FieldLevel, '2037', 'Client_Email', 'Client_Email'},
																		{FieldLevel, '2038', 'State_Contact_Name', 'State_Contact_Name'},
																		{FieldLevel, '2039', 'State_Contact_Phone', 'State_Contact_Phone'},
																		{FieldLevel, '2040', 'State_Contact_Phone_Extension', 'State_Contact_Phone_Extension'},
																		{FieldLevel, '2041', 'State_Contact_Email', 'State_Contact_Email'},
																		{RecordLevel,	'3001',	'Case Physical Zip/Mailing Zip',	'PHY/Z-MAI/Z'},
																		{RecordLevel,	'3002',	'Case Physical Zip',	'PHY/Z'},
																		{RecordLevel,	'3003',	'Case Mailing Zip',	'MAI/Z'},
																		{RecordLevel,	'3004',	'Client SSN & SSN_TYPE',	'TYP/SSN'},
																		{RecordLevel,	'3005',	'Client DOB & DOB_TYPE',	'TYP/DOB'},
																		{RecordLevel,	'3006',	'Client Eligibility Indicator / Date',	'IND/DTE'}
																	], rNCD_Inline
																 );

	////////////////////////////////////////////////////////////////////////
	NAC.Layouts.NCD	tContributionLevel(dNCD_Inline pInput)	:=
	transform
		self.RecordType			:=	pInput.RecordType;
		self.Code						:=	pInput.Code;
		self.CodeValue			:=	'';
		self.Description		:=	pInput.Description;
		self.CodeCount			:=	case(pInput.Code,
																 ContributionFileName					=>	intformat(0, 12, 1),
																 ContributionIsFileAccepted		=>	intformat(0, 12, 1),
																 ContributionTotalRecords			=>	intformat(NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsTotal, 12, 1),
																 ContributionAcceptedRecords	=>	intformat(NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsTotal - NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsRejected, 12, 1),
																 ContributionRejectedRecords	=>	intformat(NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsRejected, 12, 1),
																 ContributionWarningsCount		=>	intformat(NAC.Mod_Stats.ValidateInputFields(pFileName).WarningCount, 12, 1),
																 ContributionErrorsCount			=>	intformat(NAC.Mod_Stats.ValidateInputFields(pFileName).ErrorCount, 12, 1),
																 ContributionEndOfReport			=>	intformat(0, 12, 1),
																 intformat(0, 12, 1)
																);
		self.CodePercent		:=	fFixPercent8(case(pInput.Code,
																							ContributionFileName				=>	0,
																							ContributionIsFileAccepted	=>	0,
																							ContributionTotalRecords		=>	0,
																							ContributionAcceptedRecords	=>	((NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsTotal - NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsRejected) / NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsTotal) * 100,
																							ContributionRejectedRecords	=>	(NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsRejected / NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsTotal) * 100,
																							ContributionWarningsCount		=>	0,
																							ContributionErrorsCount			=>	0,
																							ContributionEndOfReport 		=>	0,
																							0
																						 )
																				);
		self.SampleRecord		:=	intformat(0, 12, 1);
		self.SampleValue		:=	case(pInput.Code,
																 ContributionFileName				=>	NAC.Mod_Stats.ValidateInputFields(pFileName).FileName,
																 ContributionIsFileAccepted	=>	if(NAC.Mod_Stats.ValidateInputFields(pFileName).Accepted = 'Y', 'YES', 'NO'),
																 ''
																);
	end;
	shared	dContributionLevel	:=	project(dNCD_Inline(RecordType = 'C'), tContributionLevel(left));

	////////////////////////////////////////////////////////////////////////
	NAC.Layouts.NCD	tJoined(dNCD_Inline pNCD_Inline, dFieldStats pFieldStats) :=
	transform
		self.RecordType			:=	pNCD_Inline.RecordType;
		self.Code						:=	pNCD_Inline.Code;
		self.CodeValue			:=	pFieldStats.Err;
		self.Description		:=	pNCD_Inline.Description;
		self.CodeCount			:=	intformat((unsigned4)pFieldStats.Err_Cnt, 12, 1);
		self.CodePercent		:=	fFixPercent8((pFieldStats.Err_Cnt / PFieldStats.RecordsTotal) * 100);
		self.SampleRecord		:=	intformat((unsigned4)pFieldStats.Seq, 12, 1);
		self.SampleValue		:=	pFieldStats.Value;
	end;

	////////////////////////////////////////////////////////////////////////
	shared	dJoined			:=	join(dNCD_Inline, dFieldStats,
															 left.StatsField = right.Field,
															 tJoined(left, right)
															);
	shared	dInlineOnly	:=	join(dNCD_Inline, dFieldStats,
															 left.StatsField = right.Field, 
															 left only
															);
	shared	dInStatOnly	:=	join(dFieldStats, dNCD_Inline,
															 left.Field = right.StatsField, 
															 left only
															);

	////////////////////////////////////////////////////////////////////////
	dNCMBasis	:=	dataset([{'', '', '', '', '', '', '', '', ''}], NAC.Layouts.NCM);
	NAC.Layouts.NCM	tNCM(dNCMBasis pInput)	:=
	transform
		self.FileName					:=	NAC.Mod_Stats.ValidateInputFields(pFileName).FileName;
		self.State						:=	NAC.Mod_Stats.ValidateInputFields(pFileName).FileName[1..2];
		self.FileDate					:=	NAC.Mod_Stats.ValidateInputFields(pFileName).FileName[8..15];
		self.FileTime					:=	NAC.Mod_Stats.ValidateInputFields(pFileName).FileName[17..22];
		self.IsAccepted				:=	NAC.Mod_Stats.ValidateInputFields(pFileName).Accepted;
		self.RecordsTotal			:=	(string)NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsTotal;
		self.RecordsRejected	:=	(string)NAC.Mod_Stats.ValidateInputFields(pFileName).RecordsRejected;
		self.ErrorCount				:=	(string)NAC.Mod_Stats.ValidateInputFields(pFileName).ErrorCount;
		self.WarningCount			:=	(string)NAC.Mod_Stats.ValidateInputFields(pFileName).WarningCount;
	end;
	shared	dNCMReport					:=	project(dNCMBasis, tNCM(left));

	////////////////////////////////////////////////////////////////////////
	export	dNCDReport					:=	sort(dJoined + dContributionLevel, Code);

	////////////////////////////////////////////////////////////////////////
	shared	lNCDFileName				:=	'nac::out::' + regexreplace('_NCF_', pFileName, '_NCD_');
	shared	lNCMFileName				:=	'nac::out::' + regexreplace('_NCF_', pFileName, '_NCM_');
	export	ProcOutputNCDFile		:=	parallel(
																						output(dNCDReport, , '~' + lNCDFileName, compressed)
																					 ,output(dInlineOnly, all, named('In_NCD_Basis_Only'))
																					 ,output(dInStatOnly, all, named('In_Stats_Not_In_NCD_Basis'))
																					 );
	export	ProcOutputNCMFile		:=	output(dNCMReport, , '~' + lNCMFileName, csv(terminator('\n'), separator(','), quote([])), compressed);

end;