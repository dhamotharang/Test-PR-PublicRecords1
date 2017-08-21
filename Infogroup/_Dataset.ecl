IMPORT _Control, Data_Services, VersionControl;

EXPORT _Dataset(BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT name								:= 'infogroup';
	EXPORT thor_cluster_files	:= IF(pUseProd,
																	Data_Services.foreign_prod + 'thor_data400::',
																	'~thor_data400::');
	EXPORT max_record_size		:= 40000;
	EXPORT groupname					:= VersionControl.Groupname();
	EXPORT IPAddress          := IF(VersionControl._Flags.IsDataland,
																	_Control.IPAddress.bctlpedata12,
																	_Control.IPAddress.bctlpedata11);

END;
