IMPORT PRTE2_WaterCraft_Ins,PRTE2_Common,PromoteSupers;

STRING CSVName := 'CT-1032_WATERCRAFT_20180510.csv';

Constants := PRTE2_WaterCraft_Ins.Constants;
sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
														Constants.SourcePathForCSV+CSVName, 			// path to file on landing zone
														8192,																// maximum record size
														Constants.CSVSprayFieldSeparator,		// field separator(s)
														Constants.CSVSprayLineSeparator,		// line separator(s)
														Constants.CSVSprayQuote,						// text quote character
														ThorLib.Group(),									// destination THOR cluster
														Files.SprayCraftRawName,
														-1,												  				// -1 means no timeout
															,													  			// use default ESP server IP port
															,														 	 		// use default maximum connections
														TRUE,												 		 		// allow overwrite
														PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
														TRUE												  			// compress
														);																					 
newData := Files.SprayCraftRawDS;
PromoteSupers.Mac_SF_BuildProcess(newData, Files.NewCraftRawName, buildBase);
delSprayedFile  := FileServices.DeleteLogicalFile (Files.SprayCraftRawName);
SEQUENTIAL( sprayFile, buildBase, delSprayedFile );