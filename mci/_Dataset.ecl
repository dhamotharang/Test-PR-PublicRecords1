﻿import Data_Services, versioncontrol;

export _Dataset(boolean pUseProd = false, string gcid = '') := module

	export Name										:= gcid;
	export thor_cluster_Files			:= '~usgv::mci::';
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;