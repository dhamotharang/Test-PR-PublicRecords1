/* *****************************************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_Add_TU
NOTE: this would have been better if I added a check to remove records that clashed with existing SSNs
***************************************************************************************************************** */
IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep, PromoteSupers, PRTE2_Common,Address,STD;
CSVName := 'TU_Test_Cases_6_13_12.csv';

IHDR_MAIN := PRTE2_X_Ins_DataCleanse.Files_Alpha.InsHeadDLDeath_Base_DS_PROD;
Constants := PRTE2_Liens_Ins.Constants;
Files			:= PRTE2_Liens_Ins_DataPrep.Files;
FilesLJ		:= PRTE2_Liens_Ins.Files;

SourcePathForCSV := Constants.SourcePathForCSV;

sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																					SourcePathForCSV+CSVName, 			// path to file on landing zone
																					8192,																// maximum record size
																					Constants.CSVSprayFieldSeparator,		// field separator(s)
																					Constants.CSVSprayLineSeparator,		// line separator(s)
																					Constants.CSVSprayQuote,						// text quote character
																					ThorLib.Group(),										// destination THOR cluster
																					Files.Spray_TU_Name,
																					-1,												  				// -1 means no timeout
																						,													  			// use default ESP server IP port
																						,														 	 		// use default maximum connections
																					TRUE,												 		 		// allow overwrite
																					PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																					FALSE												  			// do not compress
																					);																					 

AppendIF(STRING S1, STRING S2) := IF(S1='',S2,S1+' '+S2);
AppendIF4(STRING S1, STRING S2, STRING S3, STRING S4) := AppendIF(AppendIF(S1,S2),AppendIF(S3,S4));
AppendIF5(STRING S1, STRING S2, STRING S3, STRING S4, STRING S5) := AppendIF(AppendIF4(S1,S2,S3,S4),S5);
UPPER(STRING S1) := STD.Str.ToUpperCase(S1);

speadsheetIncoming := PROJECT(SORT(Files.Spray_TU_DS,state),
															TRANSFORM(Layouts.New_TU_Layout,
															SELF.JoinInt := COUNTER, 
															SELF.AddressLine1 := AppendIF5(LEFT.HOUSE_num,LEFT.DIRECTION,LEFT.STREET_NAME,LEFT.STREET_TYPE,LEFT.UNIT);
															SELF := LEFT));
howMany := 10;																		
StateSamples := CHOOSESETS(speadsheetIncoming,
	 state='AK'=>howMany,state='AL'=>howMany,state='AR'=>howMany,state='AZ'=>howMany,state='CA'=>howMany,state='CO'=>howMany,
	 state='CT'=>howMany,state='DC'=>howMany,state='DE'=>howMany,state='FL'=>howMany,state='GA'=>howMany,state='HI'=>howMany,
	 state='IA'=>howMany,state='ID'=>howMany,state='IL'=>howMany,state='IN'=>howMany,state='KS'=>howMany,state='KY'=>howMany,
	 state='LA'=>howMany,state='MA'=>howMany,state='MD'=>howMany,state='ME'=>howMany,state='MI'=>howMany,state='MN'=>howMany,
	 state='MO'=>howMany,state='MS'=>howMany,state='MT'=>howMany,state='NC'=>howMany,state='ND'=>howMany,state='NE'=>howMany,
	 state='NH'=>howMany,state='NJ'=>howMany,state='NM'=>howMany,state='NV'=>howMany,state='NY'=>howMany,state='OH'=>howMany,
	 state='OK'=>howMany,state='OR'=>howMany,state='PA'=>howMany,state='RI'=>howMany,state='SC'=>howMany,state='SD'=>howMany,
	 state='TN'=>howMany,state='TX'=>howMany,state='UT'=>howMany,state='VA'=>howMany,state='VT'=>howMany,state='WA'=>howMany,
	 state='WI'=>howMany,state='WV'=>howMany,state='WY'=>howMany, 0);

PromoteSupers.Mac_SF_BuildProcess(speadsheetIncoming, Files.Save_TU_Name, buildBase1,2);
PromoteSupers.Mac_SF_BuildProcess(StateSamples, Files.TMP_TU_Name, buildBase2,2);
																			 
// --------------------------------------------------
delSprayedFile  := FileServices.DeleteLogicalFile (Files.Spray_TU_Name);
// --------------------------------------------------
BaseBuiltDS := Files.Save_TU_DS;
ShowResults := CHOOSEN(BaseBuiltDS, 200);	
// --------------------------------------------------

SEQUENTIAL ( sprayFile
						, buildBase1,buildBase2
						, delSprayedFile
						// , save, despray
						);
