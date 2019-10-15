import std;

version := std.date.today();

#workunit('protect',true);
#workunit('name','D2C Customers Build - ' + version);
#workunit('priority','high');
#stored  ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com,jose.bello@lexisnexisrisk.com'); 
#OPTION('multiplePersistInstances',FALSE);

buildType := enum(UNSIGNED1, FULL, QUARTERLY, MONTHLY);

D2C_Customers.proc_build_all(buildType.FULL, version);