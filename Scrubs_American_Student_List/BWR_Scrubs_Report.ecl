import _Control,Scrubs,Orbit3SOA,SALT32;

EXPORT MAC_Scrubs_Report(string BuildDate) := FUNCTION
// MAC_Scrubs_Report(filedate,folderName,inFileName);
#OPTION('multiplePersistInstances',FALSE);

datasetName := 'American_Student_List';
folderName	:=	'Scrubs_'+datasetName;
// inFileName	:=	IF(TRIM(scopename,ALL)<>'',TRIM(scopename,ALL)+'_In_'+datasetName,'In_'+datasetName);

wuid := WORKUNIT; //get WUID
myEmail		:=	_Control.MyInfo.EmailAddressNotify;		//	Email address to send notifications


	F := Scrubs_American_Student_List.In_American_Student_List;
	S := Scrubs_American_Student_List.Scrubs; 			// My scrubs module
	N := S.FromNone(F); 														  // Generate the error flags
	U := S.FromExpanded(N.ExpandedInFile); 					  // Pass the expanded error flags into the Expanded module
	
	ErrorSummary			:=	OUTPUT(U.SummaryStats, NAMED('ErrorSummary'));										//	Show errors by field and type
	EyeballSomeErrors	:=	OUTPUT(CHOOSEN(U.AllErrors, 1000), NAMED('EyeballSomeErrors'));		//	Just eyeball some errors
	SomeErrorValues		:=	OUTPUT(CHOOSEN(U.BadValues, 1000), NAMED('SomeErrorValues'));			//	See my error field values

	persist_name				:=	'~persist::scrubs_'+datasetName+'_orbit_stats';
	Orbit_stats					:=	U.OrbitStats():PERSIST(persist_name);
	OrbitReport					:=	OUTPUT(Orbit_stats,ALL,NAMED('OrbitReport'));
	OrbitReportSummary	:=	OUTPUT(Scrubs.OrbitProfileStats(,,Orbit_stats).SummaryStats,ALL,NAMED('OrbitReportSummary'));


	//This will output a file with bitmap(s) for the rules
	bitfile_name		:=	'~thor_data::'+datasetName+'_Scrubs_Bits';
	CreateBitmaps		:=	OUTPUT( N.BitmapInfile,,bitfile_name, OVERWRITE, compressed); // long term storage
	DS := DATASET(bitfile_name,S.Bitmap_Layout,FLAT); // Read in my data (which has bitmap appended
	//This will translate the bitmap(s)
	T := S.FromBits(DS);	// Use the FromBits module; makes my bitmap datafile easier to get to read
	TranslateBitmap	:=	OUTPUT(T);

	//Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
	//Once the profile is set and doesn't need updates.  There is no need to rerun.
	GenerateCSVTemplate				:=	Scrubs.OrbitProfileStats(folderName,,Orbit_stats,BuildDate,datasetName).ProfileTemplate;
	GenerateAlertsCSVTemplate	:=	Scrubs.OrbitProfileStats(folderName,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName,'20').ProfileAlertsTemplate;

	//Submits Profile's stats to Orbit
	SubmitStats						:=	Scrubs.OrbitProfileStats(folderName,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).SubmitStats;
	dScrubsWithExamples		:=	Scrubs.OrbitProfileStats(folderName,'ScrubsAlerts',Orbit_stats,BuildDate,datasetName).CompareToProfile_with_examples;
	scrubsAlert						:=	dScrubsWithExamples(RejectWarning = 'Y');
	scrubsAttachment			:=	Scrubs.fn_email_attachment(scrubsAlert);

	mailfile							:=	FileServices.SendEmailAttachData(myEmail
																															,datasetName+' Report Test' //subject
																															,datasetName+' Report Test' //body
																															,(data)scrubsAttachment
																															,'text/csv'
																															,datasetName+'_ScrubsReport.csv'
																															,
																															,
																															,myEmail);	


	RETURN SEQUENTIAL(
										ErrorSummary,
										EyeballSomeErrors,
										SomeErrorValues	
										// OrbitReport,
										// OrbitReportSummary,
										// CreateBitmaps,
										// TranslateBitmap,
										// GenerateCSVTemplate,
										// GenerateAlertsCSVTemplate,
										// SubmitStats,
										// mailfile
										);
	END;


