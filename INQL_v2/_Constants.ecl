import _control;

EXPORT _Constants := module

	export DatasetName 				:= 'INQL';
	export NON_FCRA_ESP 			:= '10.240.32.16';//'10.241.50.42';
	export FCRA_ESP		  			:= '10.240.32.16';//'10.241.21.32';
	export LZ									:= _CONTROL.IPADDRESS.BCTLPEDATA10;
	export PREFIX 						:= '~thor_data::';
	export GROUPNAME					:= ThorLib.Group();
	export ROOTDIR 						:= '/data/inquiry_data_01/';
	export READYDIR						:= ROOTDIR + 'spray_ready/';
	export SPRAYINGDIR				:= ROOTDIR + 'spraying/';
	export DONEDIR 						:= ROOTDIR + 'done/';
	export ERRORDIR 					:= ROOTDIR + 'error/';
	export NONFCRA_FILTERS 		:= ['accurint*.txt','banko_batch_non*.txt','banko_non*.txt','bridger*.cat','custom*.txt','deconfliction*.txt',
															'*InquiryTracking.csv','delta_shell*.txt','riskwise_acc*.txt','transaction_desc*.txt','batch_non_fcra*.cat'];
	export FCRA_FILTERS 			:= ['banko_batch_fcra*.txt','fcra_log_accounting_log_*.txt','banko_fcra*.txt','batch_fcra*.cat','riskwise_fcra*.txt'];
	export FILE_TYPES 				:= ['bridger','riskwise','banko','batch','custom','InquiryTracking','delta_shell','deconfliction','transaction','accounting_log','accurint'];
	
	export FCRA_SPRAY_SCHEDULERNAME						:= 'INQL FCRA SPRAY SCHEDULER';
	export NON_FCRA_SPRAY_SCHEDULERNAME				:= 'INQL NON-FCRA SPRAY SCHEDULER';	
	export FCRA_DAILY_BLD_SCHEDULERNAME				:= 'INQL FCRA DAILY BUILD';
	export NON_FCRA_DAILY_BLD_SCHEDULERNAME		:= 'INQL NON-FCRA DAILY BUILD';	
	export FCRA_WEEKLY_BLD_SCHEDULERNAME			:= 'INQL FCRA WEEKLY BUILD';
	export NON_FCRA_WEEKLY_BLD_SCHEDULERNAME	:= 'INQL NON-FCRA WEEKLY BUILD';	
		
	export FCRA_DAILY_BLD_CONTROLLERNAME			:= 'INQL FCRA DAILY BUILD CONTROLLER';
	export NON_FCRA_DAILY_BLD_CONTROLLERNAME	:= 'INQL NON-FCRA DAILY BUILD CONTROLLER';
	export FCRA_WEEKLY_BLD_CONTROLLERNAME			:= 'INQL FCRA WEEKLY BUILD CONTROLLER';
	export NON_FCRA_WEEKLY_BLD_CONTROLLERNAME	:= 'INQL NON-FCRA WEEKLY BUILD CONTROLLER';
	
	export FCRA_SPRAY_EVENTNAME						:= 'FCRA_SPRAY';
	export NON_FCRA_SPRAY_EVENTNAME				:= 'NONFCRA_SPRAY';
	export FCRA_DAILY_BASE_EVENTNAME			:= 'BLD_FCRA_DAILY_BASE';
	export NON_FCRA_DAILY_BASE_EVENTNAME	:= 'BLD_NONFCRA_DAILY_BASE'; 
	export FCRA_DAILY_KEYS_EVENTNAME			:= 'BLD_FCRA_DAILY_KEYS';
	export NON_FCRA_DAILY_KEYS_EVENTNAME	:= 'BLD_NONFCRA_DAILY_KEYS';
	export FCRA_WEEKLY_BASE_EVENTNAME			:= 'BLD_FCRA_WEEKLY_BASE';
	export NON_FCRA_WEEKLY_BASE_EVENTNAME	:= 'BLD_NONFCRA_WEEKLY_BASE';
	export FCRA_WEEKLY_KEYS_EVENTNAME			:= 'BLD_FCRA_WEEKLY_KEYS';	
	export NON_FCRA_WEEKLY_KEYS_EVENTNAME	:= 'BLD_NONFCRA_WEEKLY_KEYS';
	
	export SBFE_REPORT_BATCH_PROCESS_ID_FILTER  := ['306','311','49','375', '335'];
	
	
END;