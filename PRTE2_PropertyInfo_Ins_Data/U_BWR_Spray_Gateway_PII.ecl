//  BWR_Spray_Gateway_PII 
/* **********************************************************************************
Simply spray the Gateway generated data file into HPCC files for further processing.
********************************************************************************** */
// Preliminary steps done in DEV prior to creating base file, not needed in PROD code
// the gateway file is raw production data that is then scrambled, so this is probably not done again.

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;

#workunit('name', 'Boca PRCT Property Info Gateway Spray');

STRING fileVersion := ut.GetDate+'';

CSVName := 'PropertyInfo_Gateway_Recover_20140715.csv';
//NOTE: the Thor lost some parts of the QA gateway file, but the "Father" was intact. Recs were equal, so I desprayed the father.
// After recovering that I see there is also a PropertyInfo_Gateway_Export_20140409.csv out there that is same size in LZ so that is probably good too.


// If CSV path is not '/load01/prct2/bpetro/batchGateway/PropertyInfo', we can add a 3rd param below to override
BuildFile := PRTE2_PropertyInfo.U_Fn_Spray_Gateway( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
