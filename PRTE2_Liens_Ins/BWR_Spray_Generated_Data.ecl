// BWR_Spray_Generated_Data 
// we don't bother with 3 generation files so delete after we do the appends.
IMPORT PRTE2_Liens_Ins;

CSVNameMain := 'LindaMain.txt';
CSVNameParty := 'LindaParty.txt';
UseProdData := FALSE;

SprayInFile1 := PRTE2_Liens_Ins.fSprays_Generated.fSpray_Main(CSVNameMain);
SprayInFile2 := PRTE2_Liens_Ins.fSprays_Generated.fSpray_Party(CSVNameParty);
MergeNewData := PRTE2_Liens_Ins.fn_Generated_Data_Merge(UseProdData);
delSprayedFile1  := FileServices.DeleteLogicalFile (Files.TmpGeneratedMAIN_Name);
delSprayedFile2  := FileServices.DeleteLogicalFile (Files.TmpGeneratedPARTY_Name);
BuildBaseFiles := PRTE2_Liens_Ins.proc_build_base;					// have to do this to move from CSV to Boca compatible

Stage1 := SEQUENTIAL (SprayInFile1, SprayInFile2, MergeNewData,delSprayedFile1, delSprayedFile2);
Stage2 := SEQUENTIAL (BuildBaseFiles);
SEQUENTIAL(Stage1,Stage2);



