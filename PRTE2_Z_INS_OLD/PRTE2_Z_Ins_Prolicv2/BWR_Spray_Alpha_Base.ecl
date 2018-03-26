IMPORT ut, PRTE2_Prolicv2, PRTE2_Common;
#workunit('name', 'Boca PRTE2 Prolicv2 File Spray');

STRING fileVersion := ut.GetDate+'';
CSVName := 'ProfLic_CSV_Boca.csv'; 

BuildFile := PRTE2_Prolicv2.Fn_Spray_And_Build_BaseMain( CSVName, fileVersion ); 
SEQUENTIAL (BuildFile);
