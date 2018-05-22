/* ********************************************************************************************
PRTE2_Header_Ins.fn_generate_relation_base
MUST SWITCH TO THE NEW BOCA BUSINESS CASE BUILD PROCESSES - FOR NOW MUST KEEP THE SAME FILE NAMES
NOTE: We only need file info here for 
a) Spray/DeSpray and the data preparation we used to do during the build before the append.
b) Our Base file and 
c) any research/maintenance
************************************************************************************ */
IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT fn_Save_BaseAndRels_Alpharetta_Base(DATASET(Layouts.Base_Layout) spreadsheetIncoming, STRING fileVersion) := FUNCTION
			

			// --------------------------------------------------
			sortedDS := SORT(spreadsheetIncoming,DID);
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(sortedDS,
																					 Files.Base_Prefix, 
																					 Files.Base_Name,
																					 fileVersion, buildHDRBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			relationFile := fn_generate_relation_base();		// this depends on the Files.HDR_BASE_ALPHA_DS being completed
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(relationFile,
																		 Files.Base_Prefix, 
																		 Files.Relationship_Suffix,
																		 fileVersion, buildHDRRelatives, 3,
																		 false,true);

			// --------------------------------------------------

			// sequentialSteps	:= SEQUENTIAL (buildHDRBase);		// if buildHDRRelatives is obsolete.
			sequentialSteps	:= SEQUENTIAL (buildHDRBase,buildHDRRelatives);
																// buildHDRRelatives must happen after buildHDRBase


			RETURN sequentialSteps;

END;