/* ************************************************************************************************
PRTE2_Email_Data_Ins.Fn_Spray_And_Build_BaseMain

Nov 2017 - re-write to new LZ and base layouts
************************************************************************************************ */

IMPORT ut, RoxieKeyBuild, PRTE2_Email_Data_Ins, PRTE2_Common;
IMPORT PRTE2_Common as Common;

Constants    := PRTE2_Email_Data_Ins.Constants;
Files        := PRTE2_Email_Data_Ins.Files;
Layouts      := PRTE2_Email_Data_Ins.Layouts;

EXPORT Fn_Spray_And_Build_BaseMain(STRING lzFilePath, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					  // file LZ
																								lzFilePath,                         // path to file on landing zone
																								Constants.CSVMaxCount,															// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);						

			// Safety step added by Fan - upper case names just in case data person put in spreadsheet not upper case
			SPRAYED_DS_UPPER := PRTE2_Common.mac_ConvertToUpperCase(Files.SPRAYED_DS , orig_first_name, orig_last_name);		
			
			// --------------------------------------------------
			// Build the alpha spray/despray base file before creating the Boca compatible version.
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(SPRAYED_DS_UPPER,             //thedataset - is the dataset to be written to disk
																					 Files.BASE_PREFIX_NAME,       //prefix - base name 
																					 Files.EMAIL_ALP_BASE_NAME,        //Suffix
																					 fileVersion,                  //File date
																					 buildAlphaBase,               //seq_name - is the action         
																					 3,                            //numgenerations is currently to be just 2 or 3    
																					 false,                        //csvout - optional should you need a csv output
																					 true);                        //pcompress - optional should you need the file to be compressed.

			// --------------------------------------------------
			// Build the BOCA BASE FILE with the compatible name and layout that the Boca build expects
			AlphaCompatible := PROJECT(SPRAYED_DS_UPPER,Layouts.Boca_Compatible);
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(AlphaCompatible,             //thedataset - is the dataset to be written to disk
																					 Files.BASE_PREFIX_NAME,       //prefix - base name 
																					 Files.EMAIL_BASE_NAME,        //Suffix
																					 fileVersion,                  //File date
																					 buildAlphaCompatBase,               //seq_name - is the action         
																					 3,                            //numgenerations is currently to be just 2 or 3    
																					 false,                        //csvout - optional should you need a csv output
																					 true);                        //pcompress - optional should you need the file to be compressed.
																					 																					 													 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile(Files.FILE_SPRAY);

			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
														  sprayFile,
															buildAlphaBase, buildAlphaCompatBase,
															delSprayedFile);

			RETURN sequentialSteps;

END;