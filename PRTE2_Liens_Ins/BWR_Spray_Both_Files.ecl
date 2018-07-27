/* *********************************************************************************************
 PRTE2_Liens_Ins.BWR_Spray_Main
 This is for spraying base data from csv files
************************************  NOTES: ***************************************************
********************************************************************************************** */

IMPORT PRTE2_Liens_Ins, PRTE2_Common, PRTE2_Liens;
#workunit('name', 'Spray PRCT L&J Base Files');

// Using new PromoteSuper: File version not needed for base files.
CSVNameMain := 'Liens_MainV2_PROD_20180709.csv';
CSVNameParty := 'Liens_PartyV2_PROD_20180709.csv';
BuildInFile1 := PRTE2_Liens_Ins.fSprays.fSpray_Main(CSVNameMain);
BuildInFile2 := PRTE2_Liens_Ins.fSprays.fSpray_Party(CSVNameParty);
BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;					// have to do this to move from CSV to Boca compatible
SEQUENTIAL (BuildInFile1, BuildInFile2, BuildBaseFiles);

// AppendToBocaData := PRTE2_Liens.proc_build_base;		
// When Boca does a build they do this step for us.  So we don't need this line, just know that they do it
/* ****************************************************************************************** */

