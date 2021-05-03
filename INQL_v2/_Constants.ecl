import _control, Data_Services, std, riskwise;

EXPORT _Constants  := module

	export DatasetName 				:= 'INQL';
	export NON_FCRA_ESP 			:= '10.173.50.42';//'10.240.32.16';
	export FCRA_ESP		  			:= '10.173.52.3';//'10.241.21.32';
	export FIDO_ESP					:= '10.194.93.1';
	export PROD_ESP                 := 'uspr-prod-thor-esp.risk.regn.net'; 
	export LZ						:= _CONTROL.IPADDRESS.BCTLPEDATA10;
  export thisDaliIP         		:= _Control.ThisEnvironment.ThisDaliIp;
	export foreign_fcra_logs  		:= Data_Services.foreign_fcra_logs;
	export PROD_THOR          		:= 'thor400_36';
	export NONFCRA_THOR       		:= 'thor200_50';
	export FCRA_THOR       			:= 'fcra_logs_thor';
	export PROD_THOR_GIT            := 'thor400_36_eclcc';
	export NONFCRA_THOR_GIT         := 'thor200_50_eclcc';
	export FCRA_THOR_GIT       		:= 'fcra_logs_thor_eclcc';
	
	export PREFIX 					:= '~thor_data::'; // if (thisDaliIP='10.173.52.1','~thor_data::', foreign_fcra_logs +'thor_data::');
	export FCRA_PREFIX 				:= if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.FCRALogTHOR_dali
										,'~thor_data::',Data_Services.foreign_fcra_logs + 'thor_data::');

  export NONFCRA_PREFIX 		    := if(_Control.ThisEnvironment.ThisDaliIp = _Control.IPAddress.NewLogTHOR_dali
										,'~thor_data::',Data_Services.foreign_logs + 'thor_data::');
	
	export USPR_PREFIX              := if(_Control.ThisEnvironment.ThisDaliIp = STD.System.Util.ResolveHostName(_Control.IPAddress.prod_thor_dali)
	                               ,'~uspr::',Data_Services.foreign_prod + 'uspr::');
  																																
	export GROUPNAME				:= ThorLib.Group();
	export ROOTDIR 					:= '/data/inquiry_data_01/';
	export READYDIR					:= ROOTDIR + 'spray_ready/';
	export SPRAYINGDIR				:= ROOTDIR + 'spraying/';
	export DONEDIR 					:= ROOTDIR + 'done/';
	export ERRORDIR 				:= ROOTDIR + 'error/';
	export NONFCRA_FILTERS 			:= ['accurint*.txt','banko_batch_non*.txt','banko_non*.txt','bridger*.cat','custom*.txt','deconfliction*.txt',
										'*InquiryTracking.csv','delta_shell*.txt','riskwise_acc*.txt','transaction_desc*.txt','batch_non_fcra*.cat'];
	export FCRA_FILTERS 			:= ['banko_batch_fcra*.txt','fcra_log_accounting_log_*.txt','banko_fcra*.txt','batch_fcra*.cat','riskwise_fcra*.txt'];
	export FILE_TYPES 				:= ['bridger','riskwise','banko','batch','custom','InquiryTracking','delta_shell','deconfliction','transaction','accounting_log','accurint'];
	
	export FCRA_SPRAY_SCHEDULERNAME					:= 'INQL FCRA SPRAY SCHEDULER';
	export NON_FCRA_SPRAY_SCHEDULERNAME				:= 'INQL NON-FCRA SPRAY SCHEDULER';	
	export FCRA_DAILY_BLD_SCHEDULERNAME				:= 'INQL FCRA DAILY BUILD';
	export FCRA_DAILY_PREP_BLD_SCHEDULERNAME		:= 'INQL FCRA DAILY PREP BUILD';	
	export NON_FCRA_DAILY_BLD_SCHEDULERNAME			:= 'INQL NON-FCRA DAILY BUILD';	
	export NON_FCRA_DAILY_PREP_BLD_SCHEDULERNAME	:= 'INQL NON-FCRA DAILY PREP BUILD';	
	export FCRA_WEEKLY_BLD_SCHEDULERNAME			:= 'INQL FCRA WEEKLY BUILD';
	export NON_FCRA_WEEKLY_BLD_SCHEDULERNAME		:= 'INQL NON-FCRA WEEKLY BUILD';	
		
	export FCRA_DAILY_BLD_CONTROLLERNAME			:= 'INQL FCRA DAILY BUILD CONTROLLER';
	export NON_FCRA_DAILY_BLD_CONTROLLERNAME		:= 'INQL NON-FCRA DAILY BUILD CONTROLLER';
	export FCRA_WEEKLY_BLD_CONTROLLERNAME			:= 'INQL FCRA WEEKLY BUILD CONTROLLER';
	export NON_FCRA_WEEKLY_BLD_CONTROLLERNAME		:= 'INQL NON-FCRA WEEKLY BUILD CONTROLLER';
	
	export FCRA_SPRAY_EVENTNAME						:= 'FCRA_SPRAY';
	export NON_FCRA_SPRAY_EVENTNAME					:= 'NONFCRA_SPRAY';
	export FCRA_DAILY_BASE_EVENTNAME				:= 'BLD_FCRA_DAILY_BASE';
	export FCRA_DAILY_BASE_PREP_EVENTNAME			:= 'BLD_FCRA_DAILY_BASE_PREP';	
	export NON_FCRA_DAILY_BASE_EVENTNAME			:= 'BLD_NONFCRA_DAILY_BASE'; 
	export NON_FCRA_DAILY_BASE_PREP_EVENTNAME		:= 'BLD_NONFCRA_DAILY_BASE_PREP'; 	
	export FCRA_DAILY_KEYS_EVENTNAME				:= 'BLD_FCRA_DAILY_KEYS';
	export NON_FCRA_DAILY_KEYS_EVENTNAME			:= 'BLD_NONFCRA_DAILY_KEYS';
	export FCRA_WEEKLY_BASE_EVENTNAME				:= 'BLD_FCRA_WEEKLY_BASE';
	export NON_FCRA_WEEKLY_BASE_EVENTNAME			:= 'BLD_NONFCRA_WEEKLY_BASE';
	export FCRA_WEEKLY_KEYS_EVENTNAME				:= 'BLD_FCRA_WEEKLY_KEYS';	
	export NON_FCRA_WEEKLY_KEYS_EVENTNAME			:= 'BLD_NONFCRA_WEEKLY_KEYS';

	export SBFE_REPORT_BATCH_PROCESS_ID_FILTER  	:= ['306','311','49','375', '335', '434'];
	export RISKWISE_ROXIE_IP              			:=  std.str.splitwords(RiskWise.shortcuts.prod_batch_analytics_roxie,'//')[2];
	
	
END;