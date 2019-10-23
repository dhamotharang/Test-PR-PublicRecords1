/* *********************************************************************************************
******** PROBABLY WILL NEVER BE NEEDED SINCE WE WOULD NORMALLY USE BWR_Spray_Both_Files ********
 PRTE2_Liens_Ins.BWR_Spray_Main
 This is for spraying base data from csv files
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Common;
#workunit('name', 'Spray PRCT L&J Main');

// Using new PromoteSuper: File version not needed for base files.
CSVName := 'Liens_Main_PROD_20190131.csv';

SprayInFile := PRTE2_Liens_Ins.fSprays.fSpray_Main(CSVName);
BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;

// SEQUENTIAL (SprayInFile);
SEQUENTIAL (SprayInFile,BuildBaseFiles);
// Note Building base files is only done when both Main and Party contain all data needed.
// BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;					// have to do this to move from CSV to Boca compatible