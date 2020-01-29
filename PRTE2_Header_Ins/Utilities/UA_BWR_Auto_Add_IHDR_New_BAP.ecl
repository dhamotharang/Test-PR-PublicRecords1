/* ************************************************************************************
PRTE2_Header_Ins.UA_BWR_Auto_Add_IHDR_New
Automated process to add new records from Alpha IHDR to Boca Person HDR
See also: fn_Save_BaseAndRels_Alpharetta_Base

Should run 1/week?   If no new records, then it can just not do a save process
Not building keys just a base file so no reason to do DOPS or ORBIT
************************************************************************************ */

IMPORT ut, PRTE2_Header_Ins, PRTE2_Common, PRTE2_Alpha_Data, PRTE_CSV;
#WORKUNIT('name', 'PRCT Alpharetta-Adds BHDR File');
#OPTION('multiplePersistInstances',FALSE);
#CONSTANT('SubstituteEmail','Bruce.Petro@lexisnexis.com');

// Run Options
fileVersion := PRTE2_Common.Constants.TodayString+'Z';		// using 'Z' to avoid bumping into any builds done that day.
 
// *******************************************************************************************************
// *****  These are the two base files to read in and process ********************************************
// *******************************************************************************************************
IHDR := PRTE2_Alpha_Data.Files_Alpha.InsHead_Base_DS_PROD(fb_src='EXPERIAN' AND addr_ind='1');
BHDR := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS_Prod;
// *******************************************************************************************************

//Filter out records to be added to BHDR
IHDR xformIHDR(IHDR L, BHDR R) := TRANSFORM
		SELF := L;
		SELF := [];
END;

// *******************************************************************************************************
// ******  JOIN left only to determine if there are any new IHDR records to process **********************
// *******************************************************************************************************
IHDRNew := join(IHDR, BHDR,
					left.id = right.did, 
					xformIHDR(left,right),
					left only);
//This transforms IHDR layout to BHDR layout for the above filtered (new) records
NewIHDR_Converts := MAC_fn_Add_From_IHDR(IHDRNew);
// *******************************************************************************************************

CntMissing := COUNT(NewIHDR_Converts);
NEWBHDR := DEDUP(SORT(BHDR+NewIHDR_Converts,did),did);

// *******************************************************************************************************
// **** Go ahead and save the new data in the base file ready to be picked up in the next Boca build *****
// *******************************************************************************************************
BOOLEAN NoChange := CntMissing=0;
NoNewRecs := OUTPUT('No new records found in IHDR',NAMED('No_Save_Done'));
SaveSteps := SEQUENTIAL(PRTE2_Header_Ins.fn_Save_BaseAndRels_Alpharetta_Base(NEWBHDR, fileVersion));	
NoSAVE   := SEQUENTIAL(NoNewRecs);
ActionStep := IF(NoChange, NoSAVE, SaveSteps);
EmailSubj := IF(NoChange, 'PRCT BHDR: No New IHDR Records', 'PRCT BHDR: New IHDR Records Added');

// *******************************************************************************************************
// **** Go ahead and despray the old and new data to allow recovery if something went wrong  *************
// *******************************************************************************************************
EXPORT_DS1 :=	BHDR;
EXPORT_DS2 :=	NEWBHDR;
CSV_NAME1 := 'PersonHDR_Alpha_PreSync_'+fileVersion+'.csv';
CSV_NAME2 := 'PersonHDR_Alpha_PostSync_'+fileVersion+'.csv';
pathAndFile1	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME1;
pathAndFile2	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME2;
TempCSV1 := PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT+'_1';
TempCSV2 := PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT+'_2';

Despray1 := PRTE2_Common.DesprayCSV(EXPORT_DS1, TempCSV1, PRTE2_Header_Ins.Constants.LandingZoneIP, pathAndFile1);
Despray2 := PRTE2_Common.DesprayCSV(EXPORT_DS2, TempCSV2, PRTE2_Header_Ins.Constants.LandingZoneIP, pathAndFile2);
// *******************************************************************************************************

// *******************************************************************************************************
// **** NOW PERFORM ACTION AND SEND AN EMAIL TO INFORM WHAT HAPPENED *************************************
// *******************************************************************************************************
SEQUENTIAL(ActionStep,Despray1,Despray2
				) :	SUCCESS(	PRTE2_Common.Email.sendSuccess(EmailSubj)	),
						FAILURE(	PRTE2_Common.Email.sendFail(EmailSubj)	);

// *******************************************************************************************************


// *******************************************************************************************************



// *******************************************************************************************************
// *******************************************************************************************************
