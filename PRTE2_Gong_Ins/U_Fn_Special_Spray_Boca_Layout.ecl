/* *****************************************************************************************
PRTE2_Gong_Ins.U_Fn_Special_Spray_Boca_Layout
This is because Linda handed us some data in the final Boca layout and no one noticed.
So I have to convert it to our layout too.  Differences from the standard Fn_Spray_And_Build_BaseMain:
1. We spray a CSV file which is in Boca layout
2. We read that temp CSV file
3. We transform it into our Layouts.Alpha_CSV_Layout (note all 'x' fields were lost!)
4. We save this as a new Files.Gong_Base_CSV
5. We also save the sprayed in file as the Boca base (since that's how it originally was)

 *** We have lost any special Alpha-only CSV fields and need to refill them.
***************************************************************************************** */

IMPORT ut, RoxieKeyBuild, Address, PRTE2, PRTE2_Common,PromoteSupers;

EXPORT U_Fn_Special_Spray_Boca_Layout(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,						// file LZ
																								SourcePathForCSV+CSVName, 					// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 

			// Read the CSV data but in the final BOCA_LAYOUT that Linda created
			oddball_Boca_Lay_Spray := Files.SPRAYED_DS_BOCALAY;
			
			// appendIf5 := PRTE2_Common.Functions.appendIf5;
			// *********************************************************************************************************************
			// transform data of CSV usinf clean address (simulate action of RMPO on request sent).
			// *********************************************************************************************************************
			Layouts.Alpha_CSV_Layout Clean_Address_Transform(oddball_Boca_Lay_Spray L) := TRANSFORM
					SELF.xSponsor := L.cust_name,
					SELF.xBug_Num := L.bug_num,
				SELF := L;
				SELF := [];
			END;

			// In this case - it will convert the Boca base into our layout, but note: it lost any 'x' field values.
			newBase := PROJECT(oddball_Boca_Lay_Spray, Clean_Address_Transform(LEFT) );

			PromoteSupers.Mac_SF_BuildProcess(newBase, Files.Gong_Base_CSV, buildBase);
			PromoteSupers.Mac_SF_BuildProcess(oddball_Boca_Lay_Spray, Files.Gong_Base_SF, BuildBCBase);
			// Skipping the Boca transform and build.
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);
			// --------------------------------------------------
			AlphaNewBase := Files.Gong_Base_CSV_DS;
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildBase,  BuildBCBase,
															delSprayedFile, output(AlphaNewBase)
															);

			RETURN sequentialSteps;

END;