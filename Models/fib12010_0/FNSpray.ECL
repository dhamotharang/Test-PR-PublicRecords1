IMPORT STD;
IMPORT fib12010_0.Constants as Constants;
EXPORT FNSpray(STRING LandingZoneIP, STRING lzFilePath, STRING SprayCSVName, STRING CSVSpraySeparator = ',', STRING CSVSprayQuote = '"') := FUNCTION
	// spray file from landing zone
	sprayFile := FileServices.SprayVariable(LandingZoneIP,                      // file landing zone
	                                        lzFilePath,	                        // path to file on landing zone
											Constants.maxRecLength,		    	// maximum record size
										    CSVSpraySeparator,	                // field separator(s)
											Constants.CSVSprayLineSeparator,	// line separator(s)
											CSVSprayQuote,		  		        // text quote character
											ThorLib.Group(),				    // destination THOR cluster
											SprayCSVName,	                    // destination file
											-1,									// -1 means no timeout
											,									// use default ESP server IP port
											,									// use default maximum connections
											TRUE,								// allow overwrite
											FALSE,								// replicate
											TRUE								// do not compress
											);
	RETURN sprayFile;
END;
