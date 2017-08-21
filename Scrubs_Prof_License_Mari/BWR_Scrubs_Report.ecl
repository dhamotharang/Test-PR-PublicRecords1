#OPTION('multiplePersistInstances',FALSE);
/*******************************************************************************/
/*	datasetName:=<Dataset>                                                     */
/*	This assumes:                                                              */
/*	Folder Name = Scrubs_<Dataset>                                             */
/*	In File Name	=	In_<Dataset>                                               */
/*******************************************************************************/
datasetName	:=	'Prof_License_Mari';
filedate		:=	'20150205';	//	Build Date

/*******************************************************************************/
/*	NO NEED TO CHANGE ANYTHING BELOW THIS LINE                                 */
/*******************************************************************************/
MAC_Scrubs_Report(BuildDate,myFolder,myFile)	:=	MACRO
	folder				:=	#EXPAND(myFolder);
	inFile				:=	folder.#EXPAND(myFile);
	
	myEmail		:=	_Control.MyInfo.EmailAddressNotify;		//	Email address to send notifications
	F	:=	inFile;																				//	Records to scrub
	S	:=	folder.Scrubs;																//	My scrubs module
	N	:=	S.FromNone(F);																//	Generate the error flags
	U :=	S.FromExpanded(N.ExpandedInFile);							//	Pass the expanded error flags into the Expanded module
	ErrorSummary			:=	OUTPUT(CHOOSEN(U.SummaryStats, 1000), NAMED('ErrorSummary'));			//	Show errors by field and type
	EyeballSomeErrors	:=	OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
	SomeErrorValues		:=	OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values

	Orbit_stats					:=	U.OrbitStats():PERSIST('~persist::'+myFolder+'_orbit_stats');
	OrbitReport					:=	OUTPUT(Orbit_stats,ALL,NAMED('OrbitReport'));
	OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStats(,,Orbit_stats).SummaryStats,ALL,NAMED('OrbitReportSummary'));


	//This will output a file with bitmap(s) for the rules
	CreateBitmaps		:=	OUTPUT( N.BitmapInfile,,'~thor_data::'+datasetName+'_Scrubs_Bits', OVERWRITE, compressed); // long term storage
	DS := DATASET('~thor_data::'+datasetName+'_Scrubs_Bits',S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
	//This will translate the bitmap(s)
	T := S.FromBits(DS);	// Use the FromBits module; makes my bitmap datafile easier to get to read
	TranslateBitmap	:=	OUTPUT(T);

	//Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
	//Once the profile is set and doesn't need updates.  There is no need to rerun.
	GenerateCSVTemplate				:=	Scrubs.OrbitProfileStats(myFolder,,Orbit_stats,BuildDate).ProfileTemplate;
	GenerateAlertsCSVTemplate	:=	Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,,'20').ProfileAlertsTemplate;

	//Submits Profile's stats to Orbit
	SubmitStats						:=	Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).SubmitStats;
	dScrubsWithExamples		:=	Scrubs.OrbitProfileStats(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).CompareToProfile_with_examples;
	scrubsAlert						:=	dScrubsWithExamples(RejectWarning = 'Y');
	scrubsAttachment			:=	Scrubs.fn_email_attachment(scrubsAlert);
	mailfile							:=	FileServices.SendEmailAttachData(myEmail
																															,datasetName+' Report Test' //subject
																															,datasetName+' Report Test' //body
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
		GenerateAlertsCSVTemplate,
		// SubmitStats,
		mailfile
	);
ENDMACRO;

folderName	:=	'Scrubs_'+datasetName;
inFileName	:=	'In_'+datasetName;

MAC_Scrubs_Report(filedate,folderName,inFileName);
