﻿/* *********************************************************************************************
******** PROBABLY WILL NEVER BE NEEDED SINCE WE WOULD NORMALLY USE BWR_Spray_Both_Files ********
 PRTE2_Liens_Ins.BWR_Spray_Main
 This is for spraying base data from csv files
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Common;
#workunit('name', 'Spray PRCT L&J Main');

// Using new PromoteSuper: File version not needed for base files.
CSVName := 'Lien_Main_afterUpdates_updTo16VacatedJudgRecords.csv';

BuildInFile := PRTE2_Liens_Ins.fSprays.fSpray_Main(CSVName);
BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;

// SEQUENTIAL (BuildInFile);
SEQUENTIAL (BuildInFile,BuildBaseFiles);
// Note Building base files is only done when both Main and Party contain all data needed.
// BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;					// have to do this to move from CSV to Boca compatible