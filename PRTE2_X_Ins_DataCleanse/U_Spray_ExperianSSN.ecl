IMPORT STD, PRTE2_X_DataCleanse, PRTE2_Header_Ins;

// -------------------------------------------------------------------------
// Spray the master test seeds
// -------------------------------------------------------------------------
Constants := PRTE2_Header_Ins.Constants;

LandingZonePath := PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + 'Experian_SSN_Cross_Reference.csv';	
																					
sprayFile       := FileServices.SprayVariable(PRTE2_Header_Ins.Constants.LandingZoneIP,		          // file LZ
																				    	LandingZonePath, 							                		// path to file on landing zone
																					    8192,                               			        // maximum record size
																					    PRTE2_Header_Ins.Constants.CSVSprayFieldSeparator,		// field separator(s)
																					    PRTE2_Header_Ins.Constants.CSVSprayLineSeparator,		  // line separator(s)
																					    PRTE2_Header_Ins.Constants.CSVSprayQuote,						  // text quote character
																					    ThorLib.Cluster(),									              // destination THOR cluster
																					    PRTE2_Header_Ins.files.SPRAYED_PREFIX_NAME + 'Experian_SSN_Cross_Reference::'+WORKUNIT,
																					    -1,												  			              	// -1 means no timeout
																						  ,													  			                // use default ESP server IP port
																							,														 	 		                // use default maximum connections
																					    TRUE,												 		 		              // allow overwrite
																					    TRUE,												  			              // replicate
																					    FALSE												  			              // do not compress
																					    );																					 
sprayFile;


// DS := dataset('~prct::sprayed::ct::header::experian_ssn_cross_reference::w20150826-170432', PRTE2_X_Ins_DataCleanse.Layouts.Layout_Experian
              // ,CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"'), MAXLENGTH(8192)) );


// DS;
// COUNT(DS);