EXPORT Constants := MODULE
IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;
//*************  Environments  ************* 

EXPORT BOCA_DEV_ROXIE:= RiskWise.shortcuts.Dev156;
// EXPORT BOCA_CERT_ROXIE:= ;
// EXPORT BOCA_PROD_ROXIE:= ;
// EXPORT VAULT:=;

//************* DALI ****************

EXPORT Alpha_Dev_THOR:='10.194.126.207:7070';
EXPORT Alpha_Prod_THOR:='10.194.112.105:7070';
EXPORT Boca_Dataland:='10.173.14.201:7070';
EXPORT Boca_Prod_THOR:='10.173.44.105:7070';
EXPORT Vault_THOR:='10.194.90.202:7070';
// EXPORT Healthcare_Dev_THOR:=;
// EXPORT Healthcare_PRod_THOR:=;

// ************* Default logical files ************* 

EXPORT nonFCRA_Consumer_InputFile := '~mas::uatsamples::consumer_nonfcra_100k_07102019.csv ';
EXPORT FCRA_Consumer_InputFile := '~mas::uatsamples::consumer_fcra_100k_07102019.csv';
EXPORT Business_InputFile := '~mas::uatsamples::business_nfcra_100k_07102019.csv'; 


//*************  ECL Watch ************* 
EXPORT Public_Records_EW:='http://10.173.14.204:8010/WsWorkunits';
EXPORT Vault_EW:='http://10.194.90.204:8010/WsWorkunits';

END;