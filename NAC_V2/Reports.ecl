EXPORT Reports(NAC_V2.ValidationCodes.rError dsErrs, string fname = 'test.dat') := MODULE



export rRejectReport := RECORD
	string4			RecordCode;
	string2			ProgramState;
	string1			ProgramCode;
	string20		CaseID;
	string20		ClientId;
		string1		Severity;			// error or warning
		string1		Level;				// file/record/field
		string4		errorCode;
		string4		fieldCode;
		string32	fieldName;
		string50	msg;
		string80	badValue;
END;


export rRejectReport xRejectReport(nac_v2.ValidationCodes.rError err, string4 sRecordCode, string2 sProgramState, string1 sProgramCode,
																		string20 sCaseId, string20 sClientId) := TRANSFORM
								self.RecordCode := sRecordCode;
								self.ProgramState := sProgramState;
								self.ProgramCode := sProgramCode;
								self.CaseID := sCaseId;
								self.ClientId := sClientId;
								self.errorCode := nac_v2.ValidationCodes.GetErrorText(err.class, err.errCode);
								self.msg := nac_v2.ValidationCodes.GetErrorMsg(err.class, err.errCode);
								self.FieldName := nac_v2.ValidationCodes.GetFieldName(err.fieldCode);
								self.Severity := err.class;
								self := err;
END;

shared dsReport := NORMALIZE(dsErrs, left.dsErrs, Nac_V2.Reports.xRejectReport(RIGHT, 'CL01',
							left.ProgramState, left.ProgramCode, left.CaseId, left.ClientId));


//export GenReport := NORMALIZE(dsWithErrs, left.dsErrs, xErrReport(RIGHT, 'CL01',
//							left.ProgramState, left.ProgramCode, left.CaseId, left.ClientId));
/***
		NCD Report
***/
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

shared	string8	fFixPercent8(decimal6_3 pValue)	:=
	function
		unsigned4	lInteger	:=	if(pValue <> 0, pValue * 1000, 0);
		string6		lString		:=	intformat(lInteger, 6, 1);
		string8		ReturnValue	:=	lString[1..3] + '.' + lString[4..6] + '%';
		return	ReturnValue;
	end;
	shared string8 getPct(integer dividend, integer divisor) := fFixPercent8((dividend/divisor) * 100);
	
	export	rNCD	:=
	record
		string1		RecordType;					// C=Contribution, R=Record, F=Field
		string2		Filler1	:=	'';
		string4		Code;
		string2		Filler2	:=	'';
		string4		CodeValue;
		string2		Filler3	:=	'';
		string40	Description;
		string2		Filler4	:=	'';
		string12	CodeCount;
		string2		Filler5	:=	'';
		string8		CodePercent;
		//string2		Filler6	:=	'';
		//string12	SampleRecord;
		string2		Filler7	:=	'';
		string80	SampleValue;
		string1		LF	:=	'\n';
	end;
	
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
																		{ContributionLevel,	ContributionEndOfReport,			'End of Report',	'End of Report'}
																	], rNCD_Inline
																 );

	////////////////////////////////////////////////////////////////////////
	NAC_V2.Layouts.NCD	tContributionLevel(dNCD_Inline pInput)	:=
	transform
	
		RecordsTotal := COUNT(clients);
		RecordsAccepted := COUNT(clients(errors = 0));
		RecordsRejected := COUNT(clients(errors > 0));
		WarningCount := COUNT(dsReport(Severity='W'));
		ErrorCount := COUNT(dsReport(Severity='E'));
		isAccepted := RecordsRejected/RecordsTotal < 0.05;
	
		self.RecordType			:=	pInput.RecordType;
		self.Code						:=	pInput.Code;
		self.CodeValue			:=	'';
		self.Description		:=	pInput.Description;
		self.CodeCount			:=	case(pInput.Code,
																 ContributionFileName					=>	intformat(0, 12, 1),
																 ContributionIsFileAccepted		=>	intformat(0, 12, 1),
																 ContributionTotalRecords			=>	intformat(RecordsTotal, 12, 1),
																 ContributionAcceptedRecords	=>	intformat(RecordsAccepted, 12, 1),
																 ContributionRejectedRecords	=>	intformat(RecordsRejected, 12, 1),
																 ContributionWarningsCount		=>	intformat(WarningCount, 12, 1),
																 ContributionErrorsCount			=>	intformat(ErrorCount, 12, 1),
																 ContributionEndOfReport			=>	intformat(0, 12, 1),
																 intformat(0, 12, 1)
																);
		self.CodePercent		:=	fFixPercent8(case(pInput.Code,
																							ContributionFileName				=>	0,
																							ContributionIsFileAccepted	=>	0,
																							ContributionTotalRecords		=>	0,
																							ContributionAcceptedRecords	=>	(RecordsAccepted / RecordsTotal) * 100,
																							ContributionRejectedRecords	=>	(RecordsRejected / RecordsTotal) * 100,
																							ContributionWarningsCount		=>	0,
																							ContributionErrorsCount			=>	0,
																							ContributionEndOfReport 		=>	0,
																							0
																						 )
																				);
		//self.SampleRecord		:=	intformat(0, 12, 1);
		self.SampleValue		:=	case(pInput.Code,
																 ContributionFileName				=>	pFileName,
																 ContributionIsFileAccepted	=>	if(isAccepted, 'YES', 'NO'),
																 ''
																);
	end;
	shared	dContributionLevel	:=	project(dNCD_Inline(RecordType = 'C'), tContributionLevel(left));
	
	ncd := TABLE(dsReport, {RecordType := dsReport.Severity, code := dsReport.fieldCode, 
														codeValue := dsReport.errorCode, description := dsReport.fieldName, 
														cnt := COUNT(GROUP), codepercent := getPct(COUNT(GROUP),COUNT(clients))},
														Severity, fieldCode, errorCode, fieldName, few);
														
	shared dNcd := PROJECT(ncd, TRANSFORM(NAC_V2.Layouts.NCD,
										self.codecount := intformat((unsigned4)left.cnt, 12, 1);
										self := left;
										self := [];));

	shared dsSamples := DEDUP(dsReport(badValue<>''), errorCode, fieldcode, all);
	
	// get some sample values
	shared dNdcReport := JOIN(dNcd, dsSamples, left.codeValue=right.errorcode and left.code=right.fieldcode,
													TRANSFORM(NAC_V2.Layouts.NCD,
														self.SampleValue := right.badValue;
														self := left;), LEFT OUTER, KEEP(1));

	export NCDReport := 
						dContributionLevel(code<>'9999') 
										& SORT(dNdcReport, RecordType, codeValue, code)
										& dContributionLevel(code='9999'))

END;