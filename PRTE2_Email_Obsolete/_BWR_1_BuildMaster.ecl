#WORKUNIT('name','Build PRCT Email Data (PRTE2_Email._BWR_1_BuildMaster)');
// Builder window code 

// to do a full build of all base files and keys by adding ALL NEW data to the existing 
//   main base (i.e. remove old data and create a new main base)
// Set bDoingAFullRebuild		:= TRUE;

// to simply append new data to the existing base file 
// Set bDoingAFullRebuild		:= FALSE;
// NOTE: for Landing Zone file locations, use the / notations
// In Boca they are uploading the files to Linda's dir, with a subdir they name.

IMPORT PRTE2_Email,ut;

//---------- Modify this section ------------------------------
bDoingAFullRebuild		:= TRUE;
STRING lzDirectory := '20130827_prct/';
STRING lzFileName := 'Lead Opt - EMAIL DATA 20130822 FINAL.csv';
//---------- Modify this section ------------------------------

fileVersion				:= ut.GetDate;
LZpathPrefix := PRTE2_Email._constants.LZ_Path_LindaCain;
LZPathFileName := LZpathPrefix+lzDirectory+lzFileName;

//***********************************************************************************
// NOTE: in Boca - it appears we will not have consistent directory and file names 
//   Therefore, no consistent and different file name for append/overwrite actions
//***********************************************************************************
//   ONLY ONE OF THESE WILL RUN 
Build1 := PRTE2_Email.Build_Master(fileVersion, LZPathFileName, TRUE);
Build2 := PRTE2_Email.Build_Master(fileVersion, LZPathFileName, FALSE);
//***********************************************************************************

BuildToRun := IF( bDoingAFullRebuild, Build1, Build2);

SEQUENTIAL(BuildToRun);
