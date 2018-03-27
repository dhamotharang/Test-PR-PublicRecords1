/* **************************************************************************************
Since the VIN data is in Boca - it's not efficient to run the VIN gathering with a JOIN
to avoid existing CT VINs in use.  
Some day we should write this here rather than what we do in Alpha
************************************************************************************** */
IMPORT PRTE2_X_DataCleanse, vehiclev2;

//TODO - we can reference our VINS-in-use data here...
DS := PRTE2_X_Ins_DataCleanse.Files_Alpha.ALL_CT_VINs_IN_USE_DS;
OUTPUT(COUNT(DS));

//TODO - and JOIN with the VIN key for left-only (remove any that match in-use)
VINS := pull(vehiclev2.key_vehicle_VIN)(vin = '');
OUTPUT(VINS);

// do this when I have a few minutes to spare