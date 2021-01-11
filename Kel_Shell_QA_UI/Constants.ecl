EXPORT Constants := MODULE
IMPORT PublicRecords_KEL, RiskWise, SALT38, SALTRoutines, STD;
//*************  Environments  ************* 

EXPORT BOCA_DEV_ROXIE:= RiskWise.shortcuts.Dev156;

//nonFCRA cert
EXPORT QA_neutral_roxieIP := 'http://certqavip.hpcc.risk.regn.net:9876';

EXPORT staging_neutral_roxieIP := 'http://certqavip.hpcc.risk.regn.net:9876';
//I think both of these are pointed to the cert VIP

// FCRA cert
EXPORT staging_fcra_roxieIP :='http://certfcraroxievip.hpcc.risk.regn.net:9876';

// nonFCRA prod VIP
EXPORT prod_batch_neutral := 'http://roxiethorvip.hpcc.risk.regn.net:9856';

// FCRA prod VIP
EXPORT prod_batch_fcra := 'http://fcrathorvip.hpcc.risk.regn.net:9876';

// Bridgett comments on Vault Roxie 10/14/2020
// yes, the boca shell for example has been restructured where it can run on thor and all of the keyed joins have been modified for that and they would use roxiedev or roxieprod code I think. for MAS we use the vault repo and the code in the vault repo is structured different than MAS on roxie.


//************* DALI ****************

EXPORT Alpha_Dev_THOR:='10.194.126.207::';
EXPORT Alpha_Prod_THOR:='10.194.112.105::';
EXPORT Boca_Dataland:='10.173.14.201::';
EXPORT Boca_Prod_THOR:='10.173.44.105::';
EXPORT Vault_THOR:='10.194.90.202::';
// EXPORT Healthcare_Dev_THOR:=;
// EXPORT Healthcare_PRod_THOR:=;

// ************* Default logical files ************* 

EXPORT nonFCRA_Consumer_InputFile := 'mas::uatsamples::consumer_nonfcra_100k_07102019.csv';
EXPORT FCRA_Consumer_InputFile := 'mas::uatsamples::consumer_fcra_100k_07102019.csv';
EXPORT Business_InputFile := 'mas::uatsamples::business_nfcra_100k_07102019.csv'; 


//*************  ECL Watch ************* 
EXPORT Public_Records_EW:='http://10.173.14.204:8010/WsWorkunits';
EXPORT Vault_EW:='http://10.194.90.204:8010/WsWorkunits';

END;