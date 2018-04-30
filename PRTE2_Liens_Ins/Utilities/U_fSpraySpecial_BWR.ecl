/* *************************************************************************************************************
As a final step I need to spray the CSVs created by PRTE2_Liens_Ins_DataPrep.U_Generate_Secondary_Records
But during the spray in DEV - empty the tax_id and record_code columns and move them to ln_product_notes
Also should ensure the PUBLIC and Age flags are all set.
************************************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Common;
#workunit('name', 'Spray PRCT L&J Base Files');

// Using new PromoteSuper: File version not needed for base files.
CSVName1 := '5000_Main_Multi_2_UPD_Special.csv';
CSVName2 := '5000_Party_Multi_2_UPD_Special.csv';

BuildInFile1 := PRTE2_Liens_Ins.U_fSpraySpecial.fSpray_Main(CSVName1);
BuildInFile2 := PRTE2_Liens_Ins.U_fSpraySpecial.fSpray_Party(CSVName2);
BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;
// AppendToBocaData := PRTE2_Liens.proc_build_base;		// Don't think we need but we can do it here.

SEQUENTIAL (BuildInFile1, BuildInFile2, BuildBaseFiles);
