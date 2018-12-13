/* ************************************************************************************
PRTE2_Liens_Ins_DataPrep.BWR_Generate_1a_Spray_IHDR_Records
Spray a CSV and load it into the local work file of IHDR records to generate from
************************************************************************************ */
IMPORT PRTE2_X_Ins_DataCleanse, PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep, PromoteSupers, PRTE2_Common,STD;


CSVName := 'NCF_L_n_J_for_Risk_Classifier.csv';

Constants := PRTE2_Liens_Ins.Constants;
FilesLJ		:= PRTE2_Liens_Ins.Files;
Files			:= PRTE2_Liens_Ins_DataPrep.Files;
Layouts		:= PRTE2_Liens_Ins_DataPrep.Layouts;

SourcePathForCSV := Constants.SourcePathForCSV;

sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																					SourcePathForCSV+CSVName, 			// path to file on landing zone
																					8192,																// maximum record size
																					Constants.CSVSprayFieldSeparator,		// field separator(s)
																					Constants.CSVSprayLineSeparator,		// line separator(s)
																					Constants.CSVSprayQuote,						// text quote character
																					ThorLib.Group(),										// destination THOR cluster
																					Files.Spray_IIHDR_Name,
																					-1,												  				// -1 means no timeout
																						,													  			// use default ESP server IP port
																						,														 	 		// use default maximum connections
																					TRUE,												 		 		// allow overwrite
																					PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																					FALSE												  			// do not compress
																					);																					 

NewBase := PROJECT(SORT(Files.Spray_IIHDR_DS,STATE),
															TRANSFORM(Layouts.IHDR_DL_Death_Joinable,
															SELF.JoinInt := COUNTER, 
															SELF := LEFT));
	NewBase trxBase(NewBase L, INTEGER CNT) := TRANSFORM
			SELF.joinint := CNT;
			SELF := L
	END;
	G_Base := GROUP(SORT(NewBase,state),state);
	FinalData := UNGROUP(PROJECT(G_Base,trxBase(LEFT,COUNTER)));
	
PromoteSupers.Mac_SF_BuildProcess(FinalData, Files.Incoming_IHDR_Name, buildBase1,2);
																			 
// --------------------------------------------------
delSprayedFile  := FileServices.DeleteLogicalFile (Files.Spray_IIHDR_Name);
// --------------------------------------------------
BaseBuiltDS := Files.Incoming_IHDR_DS;
ShowResults := CHOOSEN(BaseBuiltDS, 200);	
// --------------------------------------------------
SEQUENTIAL ( sprayFile
						, buildBase1
						, delSprayedFile
						);


