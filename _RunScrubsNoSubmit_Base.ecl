#OPTION('multiplePersistInstances', FALSE);
/*******************************************************/
/* datasetName:=<Dataset>                              */
/* This assumes:                                       */
/* Folder Name = Scrubs_<Dataset>                      */
/* In File Name = In_<Dataset>                         */
/*******************************************************/
datasetName := 'CollegeLocator';
filedate    := '20190220';                             
scopename   := ' ';                 

/*******************************************************/
/*   No NEED CHANGE ANYTHING BELOW THIS LINE           */
/*******************************************************/

MAC_Scrubs_Report(BuildDate,myFolder,myFile) := MACRO
   folder             := #EXPAND(myFolder);
	 inFile             := folder.#EXPAND(myFile);
	 scrubs_name        := IF(TRIM(scopename,ALL)<>'', TRIM(scopename, ALL)+'_Scrubs', 'Scrubs');
	 scope_datasetName  := IF(TRIM(scopename,All)<>'', scopename+'_'+datasetName,datasetName);
	 
	 myEmail            := _Control.MyInfo.EmailAddressNotify;
	 F                  := inFile;
	 S                  := folder.#EXPAND(scrubs_name);
	 N                  := S.FromNone(F);
	 U                  := S.FromExpanded(N.ExpandedInFile);
	 ErrorSummary       := OUTPUT (U.SummaryStats, NAMED('ErrorSummary'));
	 EyeballSomeErrors  := OUTPUT (CHOOSEN(U.AllErrors, 1000), NAMED('EyeballSomeErrors'));
	 SomeErrorValues    := OUTPUT (CHOOSEN(U.BadValues, 1000), NAMED('SomeErrorValues'));
	 
	 persist_name       := '~persist::'+
	                    IF(TRIM(scopename, ALL)<>'', TRIM(scopename, ALL)+'_','')+
											myFolder+'_orbit_stats';
	 Orbit_stats        := U.OrbitStats():PERSIST(persist_name);
	 Orbit_report       := OUTPUT(Orbit_stats, ALL, NAMED('OrbitReport'));
	 OrbitReportSummary := OUTPUT(Scrubs.OrbitProfileStatsPost310(,,Orbit_stats).SummaryStats, All,NAMED('OrbitReportSummary'));
	 
	 
	 //This will output a file with bitmap(s) for the rules
	 bitfile_name     := '~thor_data::'+scope_datasetName+'_Scrubs_Bits';
	 CreateBitmaps    := OUTPUT(N.BitmapInfile,,bitfile_name, OVERWRITE, compressed); //long term storage
	 DS := DATASET(bitfile_name, S.Bitmap_Layout, FLAT); // Read in my data (which has bitmap appended
	 // This will translate the bitmap(s)
	 T := S.FromBits(DS); // Use the FromBits module; makes my bitmap datafile easier to get to read
	 TranslateBitmap := OUTPUT(T);
	 
	 //Generates a Profile template to set up a profile in Orbit - don't need to run it every time.
	 //Once the profile is set and doesn't need updates. There is no need to return.
	 GenerateCSVTemplate       := Scrubs.OrbitProfileStatsPost310(myFolder,,Orbit_stats,BuildDate,scope_datasetName).ProfileTemplate;
	 GenerateAlertsCSVTemplate := Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts',Orbit_stats,BuildDate,scope_datasetName,'20').ProfileAlertsTemplate;
	 
	 //Submits Profile's stats to Orbit
	 SubmitStats               := Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts', Orbit_stats, BuildDate,datasetName).SubmitStats;
	 dScrubsWithExamples       := Scrubs.OrbitProfileStatsPost310(myFolder,'ScrubsAlerts', Orbit_stats, BuildDate,datasetName).CompareToProfile_with_examples;
	 scrubsAlert               := dScrubsWithExamples(RejectWarning = 'Y');
	 scrubsAttachment          := Scrubs.fn_email_attachment(scrubsAlert);
	 mailfile                  := FileServices.SendEmailAttachData(myEmail, 
	                                                                 scope_datasetName+ ' Report Test', //subject
																																	 scope_datasetName+'  Report Test', //body
																																	 (data)scrubsAttachment,
																																	 'text/csv',
																																	 datasetName+'ScrubsReport.csv',,,
																																	 myEmail);
																																	 
	SEQUENTIAL(
	  ErrorSummary,
		EyeballSomeErrors,
		SomeErrorValues, 
		//OrbitReport,
		OrbitReportSummary,
		//CreateBitmaps,
		//TranslateBitmaps,
		//GenerateCSVTemplate,
		GenerateAlertsCSVTemplate,
		//SubmitStats,
		//mailfile
		);
		
ENDMACRO;

folderName := '_Scrubs_VendorSrc_'+datasetName;
inFileName := IF(TRIM(scopename,ALL)<>'', TRIM(scopename, ALL)+'_In_'+datasetName, 'In_'+datasetName);


MAC_Scrubs_Report(filedate,folderName,inFileName);
		
																																	 
	 
	 
	 
	 
	 