/* ********************************************************************************************
PRTE2_Header_Ins.fn_Save_Alpharetta_Base

SWITCHING TO THE NEW BOCA BUSINESS CASE BUILD PROCESSES
NOTE: We only need code here in PRTE2_Header_Ins for Spray/DeSpray and the data preparation and Our Base file
************************************************************************************ */
IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT fn_Save_Alpharetta_Base(DATASET(Layouts.Base_Layout) spreadsheetIncoming, STRING fileVersion) := FUNCTION

// ***************************************************************************************************	
// *** Not certain which base layout the new Boca build uses so save both just in case ***************	
// ***************************************************************************************************	

			
// ***************************************************************************************************	
// ** First just save the incoming base file *********************************************************	
	sortedDS := SORT(spreadsheetIncoming,DID);
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(sortedDS,
																			 Files.Base_Prefix, 
																			 Files.Base_Name,
																			 fileVersion, buildHDRBase, 3,
																			 false,true);
																						 
// ***************************************************************************************************	


// ***************************************************************************************************	
// ** Next, transform to relation layout but don't do the fake relation logic ************************	
// FEB 2018 - Gabriel says they re-generate relations with all combined legacy data so this seems to
// 							be obsolete unless at some point, we (a) need specific relations and (b) get them to alter their build
// 							Gabriel says look at this WU W20180213-102027 in prod thor.
// ***************************************************************************************************	
	retds1 := files.HDR_BASE_ALPHA_DS;
	retds_Layout := Layouts.Relative_Layout;
	// ------------------------------------------------------------------------------------------------------------------
	relationFile := PROJECT(retds1,retds_Layout);			
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(relationFile,
																 Files.Base_Prefix, 
																 Files.Relationship_Suffix,
																 fileVersion, buildHDRRelatives, 3,
																 false,true);
// ***************************************************************************************************	

	RETURN SEQUENTIAL (buildHDRBase,buildHDRRelatives);

END;