// --------------------------------------------------------------------------------
// This to spray the Boca Header Base file holding Alpharetta data
// --------------------------------------------------------------------------------

IMPORT ut, PRTE2_Header_Ins, PRTE2_Common;
#workunit('name', 'Boca PRCT Alpharetta Header File Spray');
#OPTION('multiplePersistInstances',FALSE);

STRING fileVersion := ut.GetDate+'';
CSVName := 'OnlyNameAddress_50_States.csv';

BuildFile := PRTE2_Header_Ins.U_fn_spray_50k( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
