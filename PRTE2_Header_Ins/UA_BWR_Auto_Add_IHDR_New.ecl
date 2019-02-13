/* ************************************************************************************
PRTE2_Header_Ins.UA_BWR_Auto_Add_IHDR_New  (UA = Utility Automated Job)

Automated process to add new records from Alpha IHDR to Boca Person HDR
See also: fn_Save_Alpharetta_Base

Should run 1/week?   

If no new records, then it should skip the save process and the despray process and just send email
Not building keys just a base file so no reason to do DOPS or ORBIT
************************************************************************************ */

IMPORT ut, PRTE2_Header_Ins, PRTE2_Common, PRTE_CSV;
#WORKUNIT('name', 'PRCT Alpharetta-Adds BHDR File');
#OPTION('multiplePersistInstances',FALSE);
#CONSTANT('SubstituteEmail','Bruce.Petro@lexisnexis.com, Clayton.Demirtas@lexisnexisrisk.com');

// Run Options
fileVersion := PRTE2_Common.Constants.TodayString+'s' :INDEPENDENT;		// using 's' (system job) to avoid bumping into any builds done that day.
DesprayVersion := PRTE2_Common.Constants.TodayString :INDEPENDENT;
 
// *******************************************************************************************************
// *****  These are the two base files to read in and process ********************************************
// *******************************************************************************************************
IHDR := PRTE2_Header_Ins.UA_Alpha_IHDR.InsHead_Base_DS_PROD(fb_src='EXPERIAN' AND addr_ind='1');
BHDR := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS_Prod;

// *******************************************************************************************************
// ****************** Filter out records added to IHDR since the last update done to BHDR ****************
// *******************************************************************************************************
IHDR xformIHDR(IHDR L, BHDR R) := TRANSFORM
		SELF := L;
		SELF := [];
END;
// ******  JOIN left only to determine if there are any new IHDR records to process 
IHDRNew := join(IHDR, BHDR,
					left.id = right.did, 
					xformIHDR(left,right),
					left only);
// ****** This transforms the above IHDRNew - IHDR layout to BHDR layout for the above filtered (new) records
NewIHDR_Converts := MAC_fn_Add_From_IHDR(IHDRNew)		:INDEPENDENT;
// *******************************************************************************************************

// ***************************************************
CountNewRecs := COUNT(NewIHDR_Converts);
NEWBHDR := DEDUP(SORT(BHDR+NewIHDR_Converts,did),did);	// valid for Ins. Boca Person data, we don't do multiple per person (at least not yet)
// ***************************************************

// *******************************************************************************************************
// **** Go ahead and save the new data in the base file ready to be picked up in the next Boca build *****
// *******************************************************************************************************
OUTPUT('Debug: '+COUNT(IHDR)+' '+COUNT(BHDR)+' '+COUNT(NEWBHDR)+' and '+CountNewRecs+':');
NoSAVE   := OUTPUT('No new records ['+CountNewRecs+'] found in IHDR, so no actions taken');
EmailSubj := IF(CountNewRecs=0, 'IHDR to PRCT PersonHDR: ['+CountNewRecs+'] No New Records', 'IHDR to PRCT PersonHDR:  '+CountNewRecs+' New IHDR Records Found');
EmailBody := IF(CountNewRecs=0, 'The Auto-check for new IHDR records to add to PersonHeader found no new records to add \n', 'The Auto-check for new IHDR records to add to PersonHeader found '+CountNewRecs+' New IHDR Records which have been added \n');

// *******************************************************************************************************
// **** Go ahead and despray the old and new data to allow recovery if something went wrong  *************
// *******************************************************************************************************
CSV_NAME1 := 'PersonHDR_Alpha_PreSync_'+DesprayVersion+'.csv';
CSV_NAME2 := 'PersonHDR_Alpha_PostSync_'+DesprayVersion+'.csv';
pathAndFile1	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME1;
pathAndFile2	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME2;
TempCSV1 := PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT+'_1';
TempCSV2 := PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT+'_2';

Despray1 := PRTE2_Common.DesprayCSV(BHDR, TempCSV1, PRTE2_Header_Ins.Constants.LandingZoneIP, pathAndFile1);
Despray2 := PRTE2_Common.DesprayCSV(NEWBHDR, TempCSV2, PRTE2_Header_Ins.Constants.LandingZoneIP, pathAndFile2);
// *******************************************************************************************************

SaveSteps := SEQUENTIAL(Despray1, Despray2, PRTE2_Header_Ins.fn_Save_Alpharetta_Base(NEWBHDR, fileVersion));	
ActionSteps := IF(CountNewRecs=0, NoSAVE, SaveSteps);

// *******************************************************************************************************
// **** NOW PERFORM ACTION AND SEND AN EMAIL TO INFORM WHAT HAPPENED *************************************
// *******************************************************************************************************
SEQUENTIAL(ActionSteps,
				) :	SUCCESS(	PRTE2_Common.Email.sendGenericToSuccessGroup(EmailSubj,EmailBody)	),
						FAILURE(	PRTE2_Common.Email.sendFail(EmailSubj)	);
// *******************************************************************************************************



// *******************************************************************************************************
//   END
// *******************************************************************************************************
