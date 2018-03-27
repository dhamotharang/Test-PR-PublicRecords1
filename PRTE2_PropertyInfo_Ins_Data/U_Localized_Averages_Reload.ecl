#workunit('name', 'Boca Localized Averages Respray');

IMPORT PRTE2_Common, ut,STD;
IMPORT PRTE2_PropertyInfo, PropertyCharacteristics;

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;
#workunit('name', 'Boca PRCT Property Info Scrambled File Spray');

STRING fileVersion := ut.GetDate+'b';
STRING CSVName1 := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_noChanges_20160419.csv';
STRING CSVName2 := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_Enhanced_20160419_UPD.csv';

BuildFile := PRTE2_PropertyInfo.U_Localized_Averages_Spray( CSVName1, CSVName2, fileVersion ); 

SEQUENTIAL (BuildFile);


