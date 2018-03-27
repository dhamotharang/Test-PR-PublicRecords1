//  U_BWR_Spray_Gateway_X2 
// The thors have lost some parts of the original gateway file so recovering this from spraying the PII_Gateway_Scramble2_DS which I desprayed

IMPORT ut, PRTE2_PropertyInfo, PRTE2_Common;

#workunit('name', 'Boca PRCT Property Info Gateway Spray');

STRING fileVersion := ut.GetDate+'';

CSVName := 'PropertyInfo_Pre-Scramble_DS2.csv';
// If CSV path is not '/load01/prct2/bpetro/batchGateway/PropertyInfo', we can add a 3rd param below to override

BuildFile := PRTE2_PropertyInfo.U_Fn_Spray_GatewayX2( CSVName, fileVersion );

SEQUENTIAL (BuildFile);
