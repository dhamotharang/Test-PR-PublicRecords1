EXPORT _Constants(BOOLEAN	pUseOtherEnvironment = FALSE) := MODULE

	EXPORT autokey_buildskipset := ['S', 'F'];
	/*
		'P' -- skip person phone key
		'S' -- skip ssn key
		'-' -- build zipPrlname key
		'Q' -- skip biz phone key
		'F' -- skip Fein key
		'C' -- skip person keys altogether
		'B' -- skip business keys altogether 
	*/

	SHARED lTemplate(STRING ptype) := _Dataset(pUseOtherEnvironment).thor_cluster_files + ptype + '::' +
	                                     _Dataset().name + '::@version@::';

	EXPORT FileTemplate    := lTemplate('base');
	EXPORT keyTemplate     := lTemplate('key');
	EXPORT autokeytemplate := keyTemplate + 'autokey::';
	EXPORT ak_qa_keyname   := _Dataset(pUseOtherEnvironment).thor_cluster_files + 'key::abms::qa::autokey::';
	EXPORT statsTemplate   := lTemplate('stats');


  // Autokey Search variables
	EXPORT         TYPE_STR	        := 'AK';
	EXPORT BOOLEAN WORK_HARD        := TRUE; 
	EXPORT BOOLEAN NO_FAIL          := TRUE;
	EXPORT BOOLEAN USE_ALL_LOOKUPS  := TRUE;
	EXPORT         AUTOKEY_NAME     := ABMS._Dataset().thor_cluster_files + 'key::' + ABMS._Dataset().name +
	                                      '::qa::autokey::';
	EXPORT         AUTOKEY_SKIP_SET := autokey_buildskipset;

END;