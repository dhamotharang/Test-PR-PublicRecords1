IMPORT _Control, Scrubs_IDA, Scrubs;

#OPTION('multiplePersistInstances',FALSE);
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                           */
/*******************************************************************************/
datasetName	    :=	'IDA';
filedate		:=	'20201105';
scopename		:=	'Outfile';

/*******************************************************************************/
/*	NO NEED TO CHANGE ANYTHING BELOW THIS LINE                                 */
/*******************************************************************************/
MAC_Scrubs_Report(BuildDate,myFolder,myFile)	:=	MACRO
	folder						:=	#EXPAND(myFolder);
	inFile						:=	folder.#EXPAND(myFile);
	scrubs_name					:=	IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_Scrubs','Scrubs');
	scope_datasetName			:=	IF(TRIM(scopename,ALL)<>'',scopename+'_'+datasetName,datasetName);
	
	myEmail		:=	_Control.MyInfo.EmailAddressNotify;	//	Email address to send notifications
	F	:=	inFile;																				//	Records to scrub
	S	:=	folder.#EXPAND(scrubs_name);					//	My scrubs module
	N	:=	S.FromNone(F);																//	Generate the error flags
	U 	:=	S.FromExpanded(N.ExpandedInFile);							//	Pass the expanded error flags into the Expanded module
	ErrorSummary			:=	OUTPUT(U.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
	EyeballSomeErrors		:=	OUTPUT(CHOOSEN(U.AllErrors, 10000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
	SomeErrorValues			:=	OUTPUT(CHOOSEN(U.BadValues, 10000), NAMED('SomeErrorValues'));			//	See my error field values

	persist_name					:=	'~persist::'+
													IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_','')+
													myFolder+'_orbit_stats';
	Orbit_stats						:=	U.OrbitStats():PERSIST(persist_name);
	OrbitReport						:=	OUTPUT(Orbit_stats,ALL,NAMED('OrbitReport'));
	OrbitReportSummary				:=	OUTPUT(Scrubs.OrbitProfileStatsPost310(,,Orbit_stats).SummaryStats,ALL,NAMED('OrbitReportSummary'));


	//This will output a file with bitmap(s) for the rules
	bitfile_name					:=	'~thor_data::'+scope_datasetName+'_Scrubs_Bits';
	CreateBitmaps					:=	OUTPUT( N.BitmapInfile,,bitfile_name, OVERWRITE, compressed); // long term storage
	DS 								:= DATASET(bitfile_name,S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
	//This will translate the bitmap(s)
	T := S.FromBits(DS);	// Use the FromBits module; makes my bitmap datafile easier to get to read
	TranslateBitmap					:=	OUTPUT(T);

	//Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
	//Once the profile is set and doesn't need updates.  There is no need to rerun.
	GenerateCSVTemplate				:=	Scrubs.OrbitProfileStatsPost310(myFolder,,Orbit_stats,BuildDate,scope_datasetName).ProfileTemplate;
	GenerateAlertsCSVTemplate		:=	Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,scope_datasetName,'20').ProfileAlertsTemplate;

	//Submits Profile's stats to Orbit
	SubmitStats						:=	Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).SubmitStats;
	dScrubsWithExamples				:=	Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).CompareToProfile_with_examples;
	scrubsAlert						:=	dScrubsWithExamples(RejectWarning = 'Y');
	scrubsAttachment				:=	Scrubs.fn_email_attachment(scrubsAlert);
	mailfile						:=	FileServices.SendEmailAttachData(myEmail
																															,scope_datasetName+' Report Test' //subject
																															,scope_datasetName+' Report Test' //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,datasetName+'ScrubsReport.csv'
																															,
																															,
																															,myEmail);	


	SEQUENTIAL(
		ErrorSummary,
		EyeballSomeErrors,
		SomeErrorValues,
		OrbitReport,
		OrbitReportSummary,
		CreateBitmaps,
		TranslateBitmap,
		GenerateCSVTemplate,
		GenerateAlertsCSVTemplate
		//SubmitStats,
		//mailfile
	);
ENDMACRO;

folderName	:=	'Scrubs_'+datasetName;
inFileName	:=	IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_In_'+datasetName,'In_'+datasetName);

MAC_Scrubs_Report(filedate,folderName,inFileName);
