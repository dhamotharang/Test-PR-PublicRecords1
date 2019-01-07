/* ************************************************************************************
		PRTE2_Header_Ins_Data_Work.BWR_Add_New_Alp_MHDR_to_Alp_Base
This will will be run ONLY in Dataland to prepare new records in the Alpha Base
See also: fn_Save_BaseAndRels_Alpharetta_Base

5/17/15 ...  new process to add records
ALPHARETTA SIDE:
	New records must exist in Alpharetta Dev IHDR Base.
	Edit CustomerTest_IHDR_MHDR_BHDR.BWR_IHDR_Add_to_MHDR and add any IHDR IDs that should be added
	Run CustomerTest_IHDR_MHDR_BHDR.BWR_IHDR_Add_to_MHDR and it will add them to MHDR 
BOCA SIDE (DEV/Dataland)
	Run PRTE2_Header_Ins.BWR_Add_New_Alp_MHDR_to_Alp_Base and it will add any new records sitting in the MHDR into the BHDR 
  IF it finds no new records, it should not bother with the new base file building process
BOCA PROD
	When desired, DESPRAY the current Alpharetta Boca Header Base file, then go into 
	production and run the Spray Alpharetta Base program
	Then run the Build Boca Keys process - which is still 
			PRTE.BWR_Build	

	TODO ???? What to do if we begin having multiple records with the same DID  ?????	
	********** SO FAR WE ARE NOT DOING THAT IN BOCA, BUT MAY NEED TO AT SOME POINT ***********

NOTE: after running the first build, I desprayed, resprayed and tested to the two CSV - they were exact equals.

6/16 - added 2083 records in one blast.  The first DID of the 2082 was 888809050097
Feb 2018 - added all IHDR addr_ind=1 records this big load I jumped did to 888809150001 to have separation.
note: Nancy's critical Farmers records begin with 888809439154
************************************************************************************ */

IMPORT ut, PRTE2_Header_Ins, PRTE2_Common, PRTE2_Alpha_Data, PRTE_CSV;
#workunit('name', 'PRCT Alpharetta-Adds BHDR File');
#OPTION('multiplePersistInstances',FALSE);

STRING SAVE_VIEW := 'V';
// STRING SAVE_VIEW := 'S';
fileVersion	:= PRTE2_Common.Constants.TodayString+'';

// *******************************************************************************************************
MRGD := PRTE2_Alpha_Data.Files_Alpha.PS_Merged_Headers_DS(addr_ind='1');
BHDR := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS;
// *******************************************************************************************************


MRGD xformMRGD(MRGD L, BHDR R) := TRANSFORM
		SELF := L;
		SELF := [];
END;
MERGDFILTER := join(MRGD, BHDR,
									left.did = right.did, 
									xformMRGD(left,right),
									left only);
//IE: MRGD(did NOT IN BHDR);

OUT1 := OUTPUT(' BHDR: '+COUNT(BHDR)+' MRGD: '+COUNT(MRGD)+' Filtered: '+COUNT(MERGDFILTER) ,NAMED('Initial_Data'));

//TODO - once we sync IHDR and BHDR, we'll pull directly from IHDR and this transform needs to contain
// 			all the stuff currently found in CustomerTest_IHDR_MHDR_BHDR.BWR_IHDR_Add_to_MHDR
PRTE_CSV.ge_header_base.layout_payload xform(MERGDFILTER L) := TRANSFORM
		// *************** WARNING ************* metaphonelib doesn't appear to exist in Alpha *****************
		self.dph_lname := metaphonelib.DMetaPhone1(l.lname);
		// Obviously this will leave the Alpha MHDR unsync'd for this field.
		// ******************** We will have to add this initialization over on the Boca side ***************
		
		// NOTE: Some original MHDR records have alpharetta RIDs so take the DID to be safe ...
		self.rid := L.did;
		//TODO ???? What to do if we begin having multiple records with the same DID  ?????	
		// ********** SO FAR WE ARE NOT DOING THAT IN BOCA, BUT MAY NEED TO AT SOME POINT ***********
		// If so suggest we do this:    (Feb 2018, I'm going to start doing this now)
		// STRING RIDPart2 := IF(L.addr_ind='1','',L.addr_ind);
		// SELF.RID := (INTEGER) ( (STRING)L.DID + RIDPart2);		// IE: 888809150001 becomes 8888091500012
		// BUT not sure - that might cause us to create a dup since the DID for 
		//     another group might put that larger number into the RID???????  Emailed Danny and Gabriel
		SELF := L;
END;

MRGDNEW := PROJECT(MERGDFILTER, xform(LEFT) );
CntMissing := COUNT(MRGDNEW);
OUT2 := OUTPUT(COUNT(MRGDNEW),NAMED('C_NEW_BHDR_RECORDS'));
OUT3 := OUTPUT(CHOOSEN(MRGDNEW,500),NAMED('NEW_BHDR_RECORDS'));

TMPBHDR := BHDR + MRGDNEW;
// *******************************************************************************************************
//TODO - Check with Danny - we might someday want multiple per DID
// Very likely we need DID+source, and possibly other for prior addresses.
NEWBHDR := DEDUP(SORT(TMPBHDR,did),did);
// *******************************************************************************************************
FINALCnt1 := OUTPUT('TMPBHDR: '+COUNT(TMPBHDR)+' NEWBHDR: '+COUNT(NEWBHDR),NAMED('Final_BHDR_COUNTS'));
boolean NoChange := CntMissing=0 OR SAVE_VIEW<>'S';
NoNewRecs := OUTPUT('No new records found in MHDR',NAMED('No_Save_Done'));
ViewOnly	:= OUTPUT('View only has been requested, no save will happen',NAMED('VIEW_ONLY'));
NoSaveWhy := IF(CntMissing=0, NoNewRecs, ViewOnly);

SaveSteps := SEQUENTIAL(PRTE2_Header_Ins.fn_Save_BaseAndRels_Alpharetta_Base(NEWBHDR, fileVersion),FINALCnt1);	
// SaveSteps := SEQUENTIAL(OUTPUT('***TESTING ONLY****',NAMED('WOULD_HAVE_SAVED')), FINALCnt1);	
NoSAVE   := SEQUENTIAL(NoSaveWhy, FINALCnt1);
SHOWSTPS := SEQUENTIAL(OUT1,OUT2,OUT3);
ActionStep := IF(NoChange, NoSAVE, SaveSteps);
SEQUENTIAL(SHOWSTPS,ActionStep);

// *******************************************************************************************************
// **** Go ahead and despray the new data to study prior to actually saving the data **********************
// *******************************************************************************************************
EXPORT_DS		:=	NEWBHDR;
CSV_NAME := 'PersonHDR_Alpha_AfterAdds_'+fileVersion+'.csv';
pathAndFile	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV				:= PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Header_Ins.Constants.LandingZoneIP, pathAndFile);
// *******************************************************************************************************
// *******************************************************************************************************
// *******************************************************************************************************