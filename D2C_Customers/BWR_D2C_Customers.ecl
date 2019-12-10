import std;

version := '20191111';

unsigned mode := 1; //1 -> FULL, 2 -> QUARTERLY, 3 -> MONTHLY
customer_name := 'My Life';

#workunit('protect',true);
#workunit('name',customer_name + ' Build - ' + D2C_Customers.Constants.sMode(mode) + ' ' + version);
#workunit('priority','high');
#stored ('TestBuild', FALSE);
#stored ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com,jose.bello@lexisnexisrisk.com'); 
#OPTION('multiplePersistInstances',FALSE);

D2C_Customers.proc_build_all(mode, version, customer_name);