IMPORT prte2,std;

EXPORT fSpray := FUNCTION

EXPORT spray_variable(STRING CSVName,  STRING FILENAME, STRING overridePath='') := FUNCTION
//ln_propertyV2__base__tax	
	sFileMask := '*'+CSVName+'*';
	
dFilesToProcess		:= FileServices.RemoteDirectory(Constants.LandingZoneIP, Constants.SourcePathForCSV,sFileMask);
shared inFilename := dFilesToProcess[1].name;
//If present, pull date from filename, else use today's date	
	FileVersion := IF(	regexfind('[[:digit:]]{8}',inFilename),
						regexfind('[[:digit:]]{8}',inFilename,0),
						(STRING)Std.Date.Today());
	SourcePathForCSV := IF(	overridePath<>'',
							overridePath,
							Constants.SourcePathForCSV);

	spray_File    := FileServices.SprayVariable(Constants.LandingZoneIP,					  
					SourcePathForCSV+inFilename,   					// path to file on landing zone
					Constants.CSVMaxCount,							// maximum record size
					Constants.CSVSprayFieldSeparator,				// field separator(s)
					Constants.CSVSprayLineSeparator,				// line separator(s)
					Constants.CSVSprayQuote,						// text quote character
					ThorLib.Cluster(),//versioncontrol.Groupname(),						// destination THOR cluster
					Constants.IN_PREFIX_NAME+'::'+FileVersion +'::'+ FILENAME,
					-1,												// -1 means no timeout
						,											// use default ESP server IP port
						,											// use default maximum connections
					TRUE,												// allow overwrite
					,								                // replicate if in PROD
					FALSE												// do not compress
					);																																												
	sprayed_file	:= Constants.IN_PREFIX_NAME+'::'+FileVersion +'::'+ FILENAME;																						
	dest_file 		:= Constants.IN_PREFIX_NAME+'::'+ FILENAME;
	add_to_super := SEQUENTIAL(				 
					STD.File.StartSuperFileTransaction();
					STD.File.ClearSuperFile(dest_file),
					STD.File.AddSuperFile(dest_file, sprayed_file);
					STD.File.FinishSuperFileTransaction();
					);
	RETURN SEQUENTIAL(spray_file, add_to_super);
	END;
	
prte2.SprayFiles.Spray_Raw_Data('ln_propertyV2__base__deed', 'deed', 'ln_propertyv2');

//prte2.SprayFiles.Spray_Raw_Data('ln_propertyV2__base__tax', 'tax', 'ln_propertyv2');
spray_variable('ln_propertyV2__base__tax', 'tax');

prte2.SprayFiles.Spray_Raw_Data('ln_propertyV2__base__search', 'search', 'ln_propertyv2',true);

return 'success';

END;