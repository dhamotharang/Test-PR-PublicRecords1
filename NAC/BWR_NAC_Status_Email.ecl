//------------------------------------
import	NAC, Std, lib_fileservices;
#workunit('priority', 'high');
#workunit('priority', 11);
#workunit('name', 'NAC Status Email');

//------------------------------------
unsigned2	gFilenameDatesToKeep	:=	40;
unsigned2	gNCFFileListLimit			:=	200;
string		gEmailTarget					:=	'tony.kirk@lexisnexis.com,nacprojectsupport@lnssi.com,jennifer.paganacci@lexisnexis.com,'
																+		'Tim.Meeks@mdhs.ms.gov,Reshma.Khatkhate@mdhs.ms.gov,'
																+		'Patricia.Roberts@dhr.alabama.gov,OACIS_HELPDESK@dhr.alabama.gov,MELISSA.BAKER@DHR.ALABAMA.GOV,'
																+		'Lynn_Rossow@dcf.state.fl.us,Karen_Hawkins@dcf.state.fl.us,'
																+		'Kimberlin.Donald@dhs.ga.gov,Latonya.James@dhs.ga.gov,sonya.ward@dhs.ga.gov,wewebb@dhr.state.ga.us,cmjohnson2@dhr.state.ga.us,Jean.Cliche@dhs.ga.gov,'
																+		'Michael.A.Morris@la.gov,Michael.Dronet@la.gov,Kevin.Bourgeois.DCFS@la.gov,J.Funderburk.DCFS@la.gov'
																;
string		gEmailSender					:=	'nacprojectsupport@lnssi.com';

//------------------------------------
rStates	:=
record
	string2		State;
end;
dStates	:=	dataset([{'AL'},
										 {'FL'},
										 {'GA'},
										 {'LA'},
										 {'MS'}
										], rStates
									 );

//------------------------------------
dAllNCFFiles	:=	global(nothor(Std.File.LogicalFileList('nac::in::??_ncf_*.dat')), few);
rFilesPlus :=
record
	string2		State;
	string8		Date;
	recordof(dAllNCFFiles);
end;
rFilesPlus	tFilesPlus(dAllNCFFiles pInput) :=
transform
	lUpperName	:=	Std.Str.ToUpperCase(pInput.Name);
	self.Name		:=	lUpperName;
	self.Date		:=	regexfind('NAC::IN::.._NCF_([0-9]{8})_', lUpperName, 1);
	self.State	:=	regexfind('NAC::IN::(..)_NCF_', lUpperName, 1);
	self				:=	pInput;
end;
dFilesPlus	:=	project(dAllNCFFiles, tFilesPlus(left));

//------------------------------------
dAllDatesSorted	:=	sort(dFilesPlus, -Date);
dAllDatesDedup	:=	dedup(dAllDatesSorted, Date);
dLatestDates		:=	choosen(dAllDatesDedup, gFilenameDatesToKeep);

//------------------------------------
rNCFFileList	:=
record
	string2		State;
	string8		Date;
	string15	DateTime;
	unsigned8	Records;
	string20	GMT;
end;
rNCFFileList	tNCFFileList(dFilesPlus pInput) :=
transform
	self.State		:=	pInput.State;
	self.Date			:=	pInput.Date;
	self.DateTime	:=	regexfind('NAC::IN::.._NCF_([0-9]{8}_[0-9]{6})\\.', pInput.Name, 1);
	self.Records	:=	pInput.RowCount;
	self.GMT			:=	pInput.Modified;
end;
dNCFFileList	:=	project(dFilesPlus, tNCFFileList(left));

//------------------------------------
rNCFDenormalized	:=
record
	string8			Date;
	unsigned8		AL;
	unsigned8		FL;
	unsigned8		GA;
	unsigned8		LA;
	unsigned8		MS;
end;
rNCFDenormalized	tNCFDenormalizedPrep(dLatestDates pInput) :=
transform
	self.Date		:=	pInput.Date;
	self				:=	[];
end;
dNCFDenormalizedPrep	:=	project(dLatestDates, tNCFDenormalizedPrep(left));
rNCFDenormalized	tNCFDenormalized(dNCFDenormalizedPrep pDates, dNCFFileList pNCFFileList) :=
transform
	self.Date	:=	pDates.Date;
	self.AL		:=	pDates.AL + if(pNCFFileList.State = 'AL',  pNCFFileList.Records, 0);
	self.FL		:=	pDates.FL + if(pNCFFileList.State = 'FL',  pNCFFileList.Records, 0);
	self.GA		:=	pDates.GA + if(pNCFFileList.State = 'GA',  pNCFFileList.Records, 0);
	self.LA		:=	pDates.LA + if(pNCFFileList.State = 'LA',  pNCFFileList.Records, 0);
	self.MS		:=	pDates.MS + if(pNCFFileList.State = 'MS',  pNCFFileList.Records, 0);
end;
dNCFDenormalized	:=	denormalize(dNCFDenormalizedPrep, dNCFFileList,
																	left.Date = right.Date,
																	tNCFDenormalized(left, right)
																 );

//------------------------------------
dBase	:=	nac.files().base;

rBenefitMonthCounts	:=
record
	dBase.case_benefit_month;
	unsigned8	AL	:=	sum(group, if(dBase.case_state_abbreviation = 'AL', 1, 0));
	unsigned8	FL	:=	sum(group, if(dBase.case_state_abbreviation = 'FL', 1, 0));
	unsigned8	GA	:=	sum(group, if(dBase.case_state_abbreviation = 'GA', 1, 0));
	unsigned8	LA	:=	sum(group, if(dBase.case_state_abbreviation = 'LA', 1, 0));
	unsigned8	MS	:=	sum(group, if(dBase.case_state_abbreviation = 'MS', 1, 0));
end;
dBenefitMonthCounts	:=	table(dBase, rBenefitMonthCounts, case_benefit_month, few);

//------------------------------------
dNCFFileListSort				:=	choosen(sort(dNCFFileList, -GMT), gNCFFileListLimit);
dNCFDenormalizedSort		:=	sort(dNCFDenormalized, -Date);
dBenefitMonthCountsSort	:=	sort(dBenefitMonthCounts, -case_benefit_month);

//------------------------------------
rCSVLayout	:=
record
	string	TextLine;
end;

//------------------------------------
dNCFFileCSVHeader	:=	dataset([{'State,Date,File Date Time,Records,GMT'}], rCSVLayout);
rCSVLayout	tNCFFileToCSV(dNCFFileListSort pInput)	:=
transform
	self.TextLine	:=	pInput.State + ',' + pInput.Date + ',' + pInput.DateTime + ',' + pInput.Records + ',' + pInput.GMT;
end;
dNCFFileToCSV	:=	dNCFFileCSVHeader & project(dNCFFileListSort, tNCFFileToCSV(left));

dNCFDenormalizedCSVHeader	:=	dataset([{'Date,AL,FL,GA,LA,MS'}], rCSVLayout);
rCSVLayout	tNCFDenormalizedToCSV(dNCFDenormalizedSort pInput)	:=
transform
	self.TextLine	:=	pInput.Date + ',' + pInput.AL + ',' + pInput.FL + ',' + pInput.GA + ',' + pInput.LA  + ',' + pInput.MS;
end;
dNCFDenormalizedToCSV	:=	dNCFDenormalizedCSVHeader & project(dNCFDenormalizedSort, tNCFDenormalizedToCSV(left));

dBenefitMonthCountsHeader	:=	dataset([{'Month,AL,FL,GA,LA,MS'}], rCSVLayout);
rCSVLayout	tBenefitMonthCountsToCSV(dBenefitMonthCountsSort pInput)	:=
transform
	self.TextLine	:=	pInput.case_benefit_month + ',' + pInput.AL + ',' + pInput.FL + ',' + pInput.GA + ',' + pInput.LA  + ',' + pInput.MS;
end;
dBenefitMonthCountsToCSV	:=	dBenefitMonthCountsHeader & project(dBenefitMonthCountsSort, tBenefitMonthCountsToCSV(left));

//------------------------------------
rCSVLayout	tCSVToOneRecord(rCSVLayout pLeft, rCSVLayout pRight) :=
transform
	self.TextLine	:=	pLeft.TextLine + '\n' + pRight.TextLine;
end;
dNCFFileEmail							:=	rollup(dNCFFileToCSV, tCSVToOneRecord(left, right), true);
dNCFDenormalizedEmail			:=	rollup(dNCFDenormalizedToCSV, tCSVToOneRecord(left, right), true);
dBenefitMonthCountsEmail	:=	rollup(dBenefitMonthCountsToCSV, tCSVToOneRecord(left, right), true);

//------------------------------------
z1	:=	output(dNCFFileListSort, all, named('Ncf_Files_Last_' + gNCFFileListLimit + '_Received'));
z2	:=	output(dNCFDenormalizedSort, all, named('Ncf_Records_Last_40_Days'));
z3	:=	output(dBenefitMonthCountsSort, all, named('Benefit_Month_Records_By_State'));
z4	:=	Std.System.Email.SendEmailAttachText(gEmailTarget,
																						 'NAC - NCF File History',
																						 'With most recent first, the last ' + gNCFFileListLimit + ' NCF files received.\n\n'
																					 + 'The GMT column is the GMT date/time LN actually received it for processing.',
																						 dNCFFileEmail[1].TextLine,
																						 'text/xml',
																						 'NCF_File_History_Last_' + gNCFFileListLimit + '.csv',
																						 ,,gEmailSender
																						);
z5	:=	Std.System.Email.SendEmailAttachText(gEmailTarget,
																						 'NAC - NCF Records History',
																						 'With most recent date first, NCF records ingest the last 40 days.',
																						 dNCFDenormalizedEmail[1].TextLine,
																						 'text/xml',
																						 'NCF_Records_Last_40_Days.csv',
																						 ,,gEmailSender
																						);
z6	:=	Std.System.Email.SendEmailAttachText('Sandra.Giddy@mdhs.ms.gov,' + gEmailTarget,
																						 'NAC - Benefit Month Record Counts',
																						 'In reverse order, records in the NAC data by benefit month, by state.',
																						 dBenefitMonthCountsEmail[1].TextLine,
																						 'text/xml',
																						 'Benefit_Month_Records_By_State.csv',
																						 ,,gEmailSender
																						);

zGo	:=	parallel(z1,	z2,	z3,	z4,	z5,	z6);
//------------------------------------
zGo : when(cron('0 8 * * *')), failure(lib_FileServices.FileServices.SendEmail('tony.kirk@lexisnexis.com', 'NAC Status Email Failed', 'NAC Status Email Failed - ' + workunit));
zGo	:	when(event('NAC Email Go Now', '*')), failure(lib_FileServices.FileServices.SendEmail('tony.kirk@lexisnexis.com', 'NAC Status Email Failed', 'NAC Status Email Failed - ' + workunit));
