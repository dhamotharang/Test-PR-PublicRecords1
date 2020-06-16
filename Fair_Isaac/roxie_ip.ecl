string8 cluster := '' : stored('roxie_regression_system'); 

batvip := 'roxiethor.sc.seisint.com:9856';

theip := case(cluster,
'bair_DR' => 		'aroxiebatch.sc.seisint.com:9876',
'dev' => 		'roxiedev.br.seisint.com:9856',//'10.173.192.1-40:9876',
'dev_vip' =>	'roxiedev.br.seisint.com:9856',
'qa' =>   'roxieqavip.br.seisint.com:9876',//'10.173.193.1-80:9876',
'qa_vip' => 	'roxieqavip.sc.seisint.com:9876',
'stg_vip' => 	'roxiestaging.sc.seisint.com:9876',
// 'cert_fcra_vip' => 	'certfcraroxievip.sc.seisint.com:9876',
//'prod' => 	'10.150.128.1-80:9866|10.150.134.1-80:9866|10.173.136.1-80:9866',
//'prod_vip' => '172.16.71.100:9866',
//'bat'=> 		'10.173.197.1-80:9866',  //batch roxie
'bat_vip' => 	batvip,
batvip // default to batch vip
);

export roxie_ip := trim(theip, all);