// --------------------------------------------------------------------------------
// BWR_Spray_Alpha_Base 
// This is for initial Header data for Alpharetta
// --------------------------------------------------------------------------------
/* ********************************************************************************************
*********************************************************************************************** */

IMPORT ut, PRTE2_Header, PRTE2_Common;
#workunit('name', 'Spray PRCT Alpharetta Person-Header File');
#OPTION('multiplePersistInstances',FALSE);

STRING fileVersion := ut.GetDate+'b';
CSVName := 'Boca_Header_Alpha_New_Export_20150218.csv';

BuildFile := PRTE2_Header.fn_Spray_Alpharetta_Base( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
