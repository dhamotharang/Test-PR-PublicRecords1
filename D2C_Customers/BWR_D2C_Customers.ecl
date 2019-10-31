import std;
#stored('TestBuild', TRUE)

version := (string8)std.date.today();

#workunit('protect',true);
#workunit('name','D2C Customers Build - ' + version);
#workunit('priority','high');
#stored  ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com,jose.bello@lexisnexisrisk.com'); 
#OPTION('multiplePersistInstances',FALSE);

unsigned mode := 1; //1 -> FULL, 2 -> QUARTERLY, 3 -> MONTHLY
customer_name := 'My Life';

D2C_Customers.proc_build_all(mode, version, customer_name);