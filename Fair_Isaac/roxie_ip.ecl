string8 cluster := '' : stored('roxie_regression_system'); 

batvip := 'roxiethorvip.hpcc.risk.regn.net:9856';

theip := case(cluster,
'bair_DR' => 		'prdrroxiethorvip.hpcc.risk.regn.net:9876',
'dev' => 		'dev154vip.hpcc.risk.regn.net:9876',
'dev_vip' =>	'dev155vip.hpcc.risk.regn.net:9876',
'qa' =>   'certstagingvip.hpcc.risk.regn.net:9876',
'qa_vip' => 	'certstagingvip.hpcc.risk.regn.net:9876',
'stg_vip' => 	'certstagingvip.hpcc.risk.regn.net:9876',
// 'cert_fcra_vip' => 	'certfcraroxievip.hpcc.risk.regn.net:9876',
//'prod' => 	'10.150.128.1-80:9866|10.150.134.1-80:9866|10.173.136.1-80:9866',
//'prod_vip' => '172.16.71.100:9866',
//'bat'=> 		'10.173.197.1-80:9866',  //batch roxie
'bat_vip' => 	batvip,
batvip // default to batch vip
);

export roxie_ip := trim(theip, all);