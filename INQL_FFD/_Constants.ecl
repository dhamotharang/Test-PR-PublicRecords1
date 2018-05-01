import _control, std, data_services;

EXPORT _Constants := module

	export DatasetName 						:= 'InquiryHistory';
	export FCRA_ESP		  					:= '10.240.32.16';
	export LZ											:= _CONTROL.IPADDRESS.BCTLPEDATA10;
	export GROUPNAME							:= ThorLib.Group();
	export ROOTDIR 								:= '/data/inql_ffd_data_01/';
	export READYDIR								:= ROOTDIR + 'spray_ready/';
	export SPRAYINGDIR						:= ROOTDIR + 'spraying/';
	export DONEDIR 								:= ROOTDIR + 'done/';
	export ERRORDIR 							:= ROOTDIR + 'error/';
	export FCRA_FILTERS 					:= ['inqlffd*.txt'];
	export FILE_TYPES 						:= ['inqlffd'];
	

END;

