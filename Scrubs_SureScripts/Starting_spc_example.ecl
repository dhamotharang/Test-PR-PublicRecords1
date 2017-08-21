IMPORT HMS_Surescritps, SALT;		/

SureScritps_base := Dataset([],HMS_Surescritps.layouts.base);	
SALT.MAC_Default_SPC(SureScripts_base,base_spc);
OUTPUT(base_spc);