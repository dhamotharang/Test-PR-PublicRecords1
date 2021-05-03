import _control;

EXPORT IDconstants := 
MODULE

export JoinTypes :=
MODULE
	export KeepJoin 						:= 0;
	export LimitTransformJoin 	:= 1;
END;

export xlink_version_BDID				:= 1;											//The production linking from 2012 and before.
export xlink_version_BIP				:= 2;											//BIP 2.0 linking - Stable
export xlink_version_BIP_dev		:= 3;											//BIP 2.0 linking - Bleeding edge
export xlink_versions_BDID_BIP	:= 
	[xlink_version_BDID,xlink_version_BIP];
export xlink_versions_default 	:= '[1]';									//This is used by the xlink macros to decide which IDs to append when the macro call is not explicit
																														//Parameter list seems to require this formatting as a string containing a set.

export SRC_RID_field_default 		:= 'source_record_id';

export Fetch_Level_DotID        := 'D';
export Fetch_Level_EmpID        := 'E';
export Fetch_Level_PowID        := 'W';
export Fetch_Level_ProxID       := 'P';
export Fetch_Level_SELEID       := 'S';
export Fetch_Level_OrgID        := 'O';
export Fetch_Level_UltID        := 'U';

export Set_Fetch_Level_DotID_And_Down        	:= [Fetch_Level_DotID];
export Set_Fetch_Level_EmpID_And_Down       	:= [Fetch_Level_DotID,Fetch_Level_EmpID];
export Set_Fetch_Level_PowID_And_Down       	:= [Fetch_Level_DotID,Fetch_Level_EmpID,Fetch_Level_PowID];
export Set_Fetch_Level_ProxID_And_Down       	:= [Fetch_Level_DotID,Fetch_Level_EmpID,Fetch_Level_PowID,Fetch_Level_ProxID];
export Set_Fetch_Level_SELEID_And_Down       	:= [Fetch_Level_DotID,Fetch_Level_EmpID,Fetch_Level_PowID,Fetch_Level_ProxID,Fetch_Level_SELEID];
export Set_Fetch_Level_OrgID_And_Down       	:= [Fetch_Level_DotID,Fetch_Level_EmpID,Fetch_Level_PowID,Fetch_Level_ProxID,Fetch_Level_SELEID,Fetch_Level_OrgID];

export Set_Fetch_Level_Above_DotID     				:= [Fetch_Level_EmpID,Fetch_Level_PowID,Fetch_Level_ProxID,Fetch_Level_SELEID,Fetch_Level_OrgID,Fetch_Level_UltID];
export Set_Fetch_Level_Above_EmpID     				:= [Fetch_Level_PowID,Fetch_Level_ProxID,Fetch_Level_SELEID,Fetch_Level_OrgID,Fetch_Level_UltID];
export Set_Fetch_Level_Above_PowID     				:= [Fetch_Level_ProxID,Fetch_Level_SELEID,Fetch_Level_OrgID,Fetch_Level_UltID];
export Set_Fetch_Level_Above_ProxID    				:= [Fetch_Level_SELEID,Fetch_Level_OrgID,Fetch_Level_UltID];
export Set_Fetch_Level_Above_SELEID    				:= [Fetch_Level_OrgID,Fetch_Level_UltID];
export Set_Fetch_Level_Above_OrgID		       	:= [Fetch_Level_UltID];

export USE_LOCAL_KEYS := true; // A true here will override the next USE_LOCAL_*_KEYS attributes
export USE_LOCAL_ROXIE_SALT_KEYS := true; // Used if USE_LOCAL_KEYS is false
export USE_LOCAL_ROXIE_BEST_KEYS := true; // Used if USE_LOCAL_KEYS is false
export USE_LOCAL_THOR_SALT_KEYS := true; // Used if USE_LOCAL_KEYS is false
export USE_LOCAL_THOR_BEST_KEYS := true; // Used if USE_LOCAL_KEYS is false

export USE_DX_CONSUMER_BEST := false;

export APPEND_WEIGHT_THRESHOLD_ROXIE := 44;
export APPEND_WEIGHT_THRESHOLD_THOR := 37;

export URL_ROXIE_DEV := 'dev155vip.hpcc.risk.regn.net:9876'; // useful for testing and devlopment
export URL_ROXIE_CERT := _control.RoxieEnv.boca_certvip; // useful for testing and development
export URL_ROXIE_PROD := _control.RoxieEnv.boca_prodvip;
export URL_ROXIETHOR_PROD := 'roxiethorvip.hpcc.risk.regn.net:9856';

END;