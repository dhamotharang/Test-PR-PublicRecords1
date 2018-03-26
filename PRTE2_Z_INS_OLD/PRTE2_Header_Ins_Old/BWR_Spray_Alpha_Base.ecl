// --------------------------------------------------------------------------------
// BWR_Spray_Alpha_Base 
// This is for initial Header data for Alpharetta
// --------------------------------------------------------------------------------
/* ********************************************************************************************
*********************************************************************************************** */

IMPORT ut, PRTE2_Header_Ins, PRTE2_Common;
#workunit('name', 'Spray PRCT Alpharetta Person-Header File');
#OPTION('multiplePersistInstances',FALSE);

STRING fileVersion := ut.GetDate+'';
CSVName := 'BHDR_EXP_SSN_FIXED_20150911.csv';

BuildFile := PRTE2_Header_Ins.fn_Spray_Alpharetta_Base( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
