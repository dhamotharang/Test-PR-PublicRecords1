string8 cluster := '' : stored('roxie_regression_system'); 

batvip := 'roxiebatch.br.seisint.com:9856';

theip := case(cluster,
'dev' => 		'10.173.192.1-40:9876',
'dev_vip' =>	'roxiedev.br.seisint.com:9856',
'qa' => 		'10.173.193.1-80:9876',
'qa_vip' => 	'roxieqavip.br.seisint.com:9856',
'stg_vip' => 	'roxiestaging.br.seisint.com:9856',
//'prod' => 	'10.150.128.1-80:9866|10.150.134.1-80:9866|10.173.136.1-80:9866',
//'prod_vip' => '172.16.71.100:9866',
//'bat'=> 		'10.173.197.1-80:9866',  //batch roxie
'bat_vip' => 	batvip,
batvip // default to batch vip
);

export roxie_ip := trim(theip, all);