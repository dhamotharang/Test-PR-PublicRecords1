/* ************** I think we'll just do this in dataland ******************
Some of the logic was isolated from PRTE2_Header_Ins.fn_Spray_Alpharetta_Base
into this sub-step.  This must be in Production to support fn_Spray_Alpharetta_Base
************************************************************************ */
IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT fn_Save_BaseAndRels_Alpharetta_Base(DATASET(Layouts.Expanded_Main_Header_Layout) spreadsheetIncoming, STRING fileVersion) := FUNCTION
			

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

			sequentialSteps	:= SEQUENTIAL (buildHDRBase, 
																			buildHDRRelatives	// must happen after buildHDRBase
																		);

			RETURN sequentialSteps;

END;