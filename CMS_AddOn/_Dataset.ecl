IMPORT VersionControl;

EXPORT _Dataset(BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT name								:= 'cms_addon';
	EXPORT thor_cluster_files	:= IF(pUseProd,
																	VersionControl.foreign_prod + 'thor::',
																	'~thor::');
	EXPORT max_record_size		:= 40000;
	EXPORT groupname					:= VersionControl.Groupname();

END;
