IMPORT PRTE2_Common as Common;

EXPORT Fn_SprayFile(STRING FileName, STRING fileSprayPath) := 
											FileServices.SprayVariable(Constants.LandingZoneIP,					    // file LZ
																								 Constants.SourcePathForCSV+FileName, // path to file on landing zone
																								 Constants.CSVMaxCount,								// maximum record size
																								 Constants.CSVSprayFieldSeparator,		// field separator(s)
																								 Constants.CSVSprayLineSeparator,		  // line separator(s)
																								 Constants.CSVSprayQuote,						  // text quote character
																								 ThorLib.Cluster(),									  // destination THOR cluster
																								 fileSprayPath,
																								 -1,												  				// -1 means no timeout
																								 ,													  			  // use default ESP server IP port
																								 ,														 	 		  // use default maximum connections
																								 TRUE,												 		 		// allow overwrite
																								 Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								 FALSE												  			// do not compress
																								 );									