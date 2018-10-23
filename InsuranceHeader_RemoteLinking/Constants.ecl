import _control, STD;
EXPORT Constants := MODULE
	EXPORT ins_prodBatchRoxieVip  	:= 'http://iroxiebatchvip.sc.seisint.com:9876';
	EXPORT ins_prodRoxieVip				 	:= 'http://iroxievip.sc.seisint.com:9876'; 
	EXPORT ins_certRoxieVip				 	:= 'http://iroxieqavip.sc.seisint.com:9876'; 	
  EXPORT ins_devRoxieVip       := 'http://10.194.3.15:9876';//Historical Purposes only, please use Cert or Prod - ZRS
  
  //For bankruptcy we want to go from batch to batch
	EXPORT prodRoxie_BatchVip				 	:= 'http://roxiebatch.sc.seisint.com:9866'; 
  EXPORT certRoxie_BatchVip				 	:= 'http://roxieqavip.sc.seisint.com:9876'; 	
  EXPORT devRoxieVip       := 'http://dev155vip.hpcc.risk.regn.net:9876';//Historical Purposes only, please use Cert or Prod - ZRS
	
  EXPORT String HEADER_SERVICE_ROXIE_IP := IF(STD.Str.ToUpperCase(_Control.ThisEnvironment.RoxieEnv) = 'PROD', prodRoxie_BatchVip, certRoxie_BatchVip);
	EXPORT String HEADER_SERVICE_NAME := 'InsuranceHeader_RemoteLinking.Remote_InsuranceHeader_Service_Dempsey';
	roxieEnv := stringlib.StringToUpperCase(thorlib.getenv('Environment','Default'));
	EXPORT BOOLEAN isCustomerTest := roxieEnv in ['CTQA', 'Prod_CT'];
END;