// BWR_Spray_Gateway_Foreclosures 
/* ********************************************************************************************
Simply spray the Gateway generated Foreclosure data file into HPCC files for further processing.
********************************************************************************************** */
// Preliminary steps done in DEV prior to creating base file, not needed in PROD code

IMPORT ut, PRTE2, PRTE2_Foreclosures, PRTE2_Common;

#workunit('name', 'Boca PRCT Property Info Gateway Spray');

STRING fileVersion := ut.GetDate+'';

CSVName := 'LN_Output_batchGateway_export_20131023.csv';

// If CSV path is not '/load01/prct2/bpetro/batchGateway/Foreclosures', add a 3rd param below to override
BuildFile := PRTE2_Foreclosures.U_Fn_Spray_Gateway( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
