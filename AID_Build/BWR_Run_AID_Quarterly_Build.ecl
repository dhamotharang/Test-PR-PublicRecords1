import std,_control;

pVersion := (STRING8)STD.Date.Today();
#WORKUNIT('name','Yogurt:AID Quarterly Build kick off build');
#STORED('emailList', 'Kevin.Garrity@lexisnexisrisk.com,Michael.Gould@lexisnexisrisk.com'); 
#STORED('KeyName','AddressLineAIDKeys');
#OPTION('multiplePersistInstances',FALSE);
output(_control.fSubmitNewWorkunit('#workunit(\'name\',\'Yogurt:AID Quarterly Build - '+pVersion+'\');\r\n'+
       'AID_Build.proc_build_all(pVersion).All (\''+pversion+'\');\r\n'
      ,std.system.job.target())) : when(cron('0 1 15 Jan,Apr,Jul,Oct *'));
			
			
