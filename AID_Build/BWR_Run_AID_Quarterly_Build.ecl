import std;

pVersion := (STRING8)STD.Date.Today();
#WORKUNIT('name','Yogurt:AID Quarterly Build');
#STORED('emailList', 'Kevin.Garrity@lexisnexisrisk.com,Michael.Gould@lexisnexisrisk.com'); 
#STORED('KeyName','AddressLineAIDKeys');
#OPTION('multiplePersistInstances',FALSE);
AID_Build.proc_build_all(pVersion).All : when(cron('0 1 15 Jan,Apr,Jul,Oct *'));