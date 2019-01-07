/* ************************************************************************************
PRTE2_Header_Ins.BWR_Add_New_INS_IHDR_to_Alp_Base
This will will be run to add new IHDR records to BHDR
See also: fn_Save_BaseAndRels_Alpharetta_Base

6/7/18 -  new process to add records

BOCA SIDE (DEV/Dataland)
	Run PRTE2_Header_Ins.BWR_Add_New_INS_IHDR_to_Alp_Base and it will add any new records sitting in the foreign IHDR into the BHDR 
  IF it finds no new records, it should not bother with the new base file building process
	When desired, DESPRAY the current Alpharetta Boca Header Base file, then go into 
	production and run the Spray Alpharetta Base program
	Then run the Build Boca Keys process - which is still PRTE.BWR_Build	

6/16 - added 2083 records in one blast.  The first DID of the 2082 was 888809050097
Feb 2018 - added all IHDR addr_ind=1 records this big load I jumped did to 888809150001 to have separation.
note: Nancy's critical Farmers records begin with 888809439154
************************************************************************************ */

IMPORT ut, PRTE2_Header_Ins, PRTE2_Common, PRTE2_Alpha_Data, PRTE_CSV;
#WORKUNIT('name', 'PRCT Alpharetta-Adds BHDR File');
#OPTION('multiplePersistInstances',FALSE);

// Run Options
fileVersion := PRTE2_Common.Constants.TodayString+'';
DesprayProd := TRUE;
BuildNewFile := FALSE;
 
IHDR := PRTE2_Alpha_Data.Files_Alpha.InsHead_Base_DS_PROD(fb_src='EXPERIAN' AND addr_ind='1');
BHDR_P := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS_Prod;
BHDR_D := PRTE2_Header_Ins.files.HDR_BASE_ALPHA_DS;
BHDR := IF(DesprayProd,BHDR_P,BHDR_D);

//Filter out records to be added to BHDR
IHDR xformIHDR(IHDR L, BHDR R) := TRANSFORM
		SELF := L;
		SELF := [];
END;
IHDRFILTER := join(IHDR, BHDR,
									left.id = right.did, 
									xformIHDR(left,right),
									left only);

OUT1 := OUTPUT(' BHDR: '+COUNT(BHDR)+' IHDR: '+COUNT(IHDR)+' Filtered: '+COUNT(IHDRFILTER) ,NAMED('Initial_Data'));

//Transforms IHDR layout to BHDR layout for filtered records
NEWIHDR := MAC_fn_Add_From_IHDR(IHDRFILTER);

CntMissing := COUNT(NEWIHDR);
OUT2 := OUTPUT(COUNT(NEWIHDR),NAMED('C_NEW_BHDR_RECORDS'));
OUT3 := OUTPUT(CHOOSEN(SORT(NEWIHDR,-did),500),NAMED('NEW_BHDR_RECORDS'));

TMPBHDR := BHDR + NEWIHDR;

NEWBHDR := DEDUP(SORT(TMPBHDR,did),did);
FINALCnt1 := OUTPUT('TMPBHDR: '+COUNT(TMPBHDR)+' NEWBHDR: '+COUNT(NEWBHDR),NAMED('Final_BHDR_COUNTS'));
BOOLEAN NoChange := CntMissing=0 OR BuildNewFile=FALSE;
NoNewRecs := OUTPUT('No new records found in MHDR',NAMED('No_Save_Done'));
ViewOnly	:= OUTPUT('View only has been requested, no save will happen',NAMED('VIEW_ONLY'));
NoSaveWhy := IF(CntMissing=0, NoNewRecs, ViewOnly);
SaveSteps := SEQUENTIAL(PRTE2_Header_Ins.fn_Save_BaseAndRels_Alpharetta_Base(NEWBHDR, fileVersion),FINALCnt1);	
NoSAVE   := SEQUENTIAL(NoSaveWhy, FINALCnt1);
SHOWSTPS := SEQUENTIAL(OUT1,OUT2,OUT3);
ActionStep := IF(NoChange, NoSAVE, SaveSteps);
SEQUENTIAL(SHOWSTPS,ActionStep);
OUTPUT(CHOOSEN(SORT(NEWBHDR,-did),100));

// *******************************************************************************************************
// **** Go ahead and despray the new data to study prior to actually saving the data **********************
// *******************************************************************************************************
EXPORT_DS :=	NEWBHDR;
CSV_NAME := 'PersonHDR_Alpha_Synced_'+fileVersion+'.csv';
pathAndFile	:= PRTE2_Header_Ins.Constants.SourcePathForHDRCSV + CSV_NAME;
TempCSV := PRTE2_Header_Ins.Files.HDR_CSV_FILE + '::' +  WORKUNIT;

PRTE2_Common.DesprayCSV(EXPORT_DS, TempCSV, PRTE2_Header_Ins.Constants.LandingZoneIP, pathAndFile);
// *******************************************************************************************************
// *******************************************************************************************************
// *******************************************************************************************************
