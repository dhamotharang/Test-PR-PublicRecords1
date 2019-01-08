// Spray in the modified CSV records plus the noChanges CSV records to become the new base file.

#workunit('name', 'Boca Localized Averages Respray');

IMPORT PRTE2_Common, ut,STD;
IMPORT PRTE2_PropertyInfo, PropertyCharacteristics;

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;
#workunit('name', 'Boca PRCT Property Info Scrambled File Spray');

STRING fileVersion := ut.GetDate+'';
STRING CSVName1 := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_noChanges_20160419.csv';
STRING CSVName2 := PRTE2_PropertyInfo.Constants.SourcePathForPIICSV + 'PropInfo_Enhanced_20160419_UPD.csv';

BuildFile := PRTE2_PropertyInfo.U_Localized_Averages_Spray( CSVName1, CSVName2, fileVersion ); 

SEQUENTIAL (BuildFile);


