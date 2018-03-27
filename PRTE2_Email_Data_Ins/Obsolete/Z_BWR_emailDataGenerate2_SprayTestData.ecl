//Spray Required Email Test Data from Nancy

IMPORT ut, RoxieKeyBuild, PRTE2_Email_Data, PRTE2_Common, PRTE2_X_Ins_DataCleanse;

Constants    := PRTE2_Email_Data.Constants;
Files        := PRTE2_Email_Data.Files;
Layouts      := PRTE2_Email_Data.Layouts;

sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					  // file LZ
																					'/load01/prct2/email/ContactsInfoTestDataV5_Nancy.csv', // path to file on landing zone
																					Constants.CSVMaxCount,															// maximum record size
																					Constants.CSVSprayFieldSeparator,		// field separator(s)
																					Constants.CSVSprayLineSeparator,		// line separator(s)
																					Constants.CSVSprayQuote,						// text quote character
																					ThorLib.Cluster(),									// destination THOR cluster
																				    '~prct::SPRAYED::ct::email_spreadsheet_TestData::'+ThorLib.Wuid(),
																					-1,												  				// -1 means no timeout
																						,													  			// use default ESP server IP port
																						,														 	 		// use default maximum connections
																					TRUE,												 		 		// allow overwrite
																					PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																					FALSE												  			// do not compress
																					);	
sprayFile; 
