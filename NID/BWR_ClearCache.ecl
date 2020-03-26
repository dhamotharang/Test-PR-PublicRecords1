import Nid, _Control;

#WORKUNIT('name', 'Schedule NID Cache Clearance');

  Sun_at_7_AM:='7 2 * * 0';		// actually at 6:07 (Eastern Standard Time)

	ThorName:=if(_Control.ThisEnvironment.Name='Dataland','hthor_dev','hthor');


 _Control.fSubmitNewWorkunit('NID.EmptyCache', ThorName ) : WHEN(CRON(Sun_at_7_AM))
																								 ,FAILURE(fileservices.sendemail('charles.salvo@lexisnexisrisk.com'
																																								 ,'Schedule NID Cache Clearance'
																																								 ,'schedule failure\n'
																																								 +'See '+workunit+'\n\n'
																																								 +FAILMESSAGE
																																								 ));
