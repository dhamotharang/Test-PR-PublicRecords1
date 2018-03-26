//  BWR_Spray_Gateway_LNP 	-- only need this for the initial gateway data we receive.  ONE TIME

/* **********************************************************************************
Simply spray the Gateway generated data file into HPCC files for further processing.
********************************************************************************** */
// Preliminary steps done in DEV prior to creating base file, not needed in PROD code

IMPORT ut, PRTE2_LNProperty, PRTE2_Common;

#workunit('name', 'Boca PRCT LN Property Gateway Spray');

STRING fileVersion := ut.GetDate+'';

CSVName := 'LNP_batchGateway_20131023_Append.csv';
// If CSV path is not '/load01/prct2/bpetro/batchGateway/LNProperty', we can add a 3rd param below to override

BuildFile := PRTE2_LNProperty.U_Fn_Spray_Gateway( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
