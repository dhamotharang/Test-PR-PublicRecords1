import _control, std, data_services;

EXPORT _Constants := module

	export DatasetName 										:= 'InquiryHistory';
	export FCRA_ESP		  									:= _Control.IPAddress.prod_thor_esp;
	export LZ															:= _CONTROL.IPADDRESS.BCTLPEDATA10;
	export GROUPNAME											:= 'thor400_36'; //ThorLib.Group();
	export THOR_ROOT                      := 'uspr';
	export ROOTDIR 												:= '/data/inquiry_history_data_01/';
	export READYDIR												:= ROOTDIR + 'spray_ready/';
	export SPRAYINGDIR										:= ROOTDIR + 'spraying/';
	export DONEDIR 												:= ROOTDIR + 'done/';
	export ERRORDIR 											:= ROOTDIR + 'error/';
	export FCRA_FILTERS 									:= ['*inq_hist*.txt'];
	export FILE_TYPES 										:= ['inqlffd'];
	export FCRA_DAILY_BASE_EVENTNAME			:= 'BLD_FCRA_HIST_DAILY_PROCESS_EVENT';
	export FCRA_DAILY_BLD_SCHEDULERNAME   := 'BLD_FCRA_HIST_DAILY_PROCESS';
	export FCRA_PPC                       := ['165','216'];
	export FCRA_PPC_EXCLUDE               := ['420','426'];
END;