/* ************************************************************************************
PRTE2_Liens_Ins.BWR_Spray_Generated_Data

we don't bother with 3 generation files just delete the spray after we convert and do the appends.
for add-new spray in Linda's data, convert to the "IN" layout and append to the prod base file.
************************************************************************************ */

IMPORT PRTE2_Liens_Ins;

CSVNameMain := 'Linda_lien_main_adds.txt';
CSVNameParty := 'Linda_lien_party_adds.txt';
UseProdData := TRUE;		// This forces fn_Generated_Data_Merge to use the prod "IN" base files if true.

SprayInFile1 := PRTE2_Liens_Ins.fSprays_Generated.fSpray_Main(CSVNameMain);
SprayInFile2 := PRTE2_Liens_Ins.fSprays_Generated.fSpray_Party(CSVNameParty);

MergeNewData := PRTE2_Liens_Ins.fn_Generated_Data_Merge(UseProdData);
delSprayedFile1  := FileServices.DeleteLogicalFile (Files.TmpGeneratedMAIN_Name);
delSprayedFile2  := FileServices.DeleteLogicalFile (Files.TmpGeneratedPARTY_Name);
BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;					// have to do this to move from CSV to Boca compatible

Stage1 := SEQUENTIAL (SprayInFile1, SprayInFile2, MergeNewData,delSprayedFile1, delSprayedFile2);
Stage2 := SEQUENTIAL (BuildBaseFiles);
out1 := OUTPUT(Files.Main_IN_DS);
out2 := OUTPUT(Files.Party_IN_DS);
SEQUENTIAL(Stage1,Stage2,out1,out2);


// SEQUENTIAL (SprayInFile1, SprayInFile2);
// OUTPUT(Files.TmpGeneratedPARTY_DS);
// OUTPUT(Files.TmpGeneratedMAIN_DS);



