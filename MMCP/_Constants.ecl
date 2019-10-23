EXPORT _Constants(BOOLEAN	pUseOtherEnvironment = FALSE) := MODULE

	EXPORT autokey_buildskipset := ['P', 'Q', 'F'];
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
	EXPORT ak_qa_keyname   := _Dataset(pUseOtherEnvironment).thor_cluster_files + 'key::mmcp::qa::autokey::';
	EXPORT statsTemplate   := lTemplate('stats');

  // Autokey Search variables
	EXPORT         TYPE_STR	        := 'AK';
	EXPORT BOOLEAN WORK_HARD        := TRUE; 
	EXPORT BOOLEAN NO_FAIL          := TRUE;
	EXPORT BOOLEAN USE_ALL_LOOKUPS  := TRUE;
	EXPORT         AUTOKEY_NAME     := MMCP._Dataset().thor_cluster_files + 'key::' + MMCP._Dataset().name +
	                                      '::qa::autokey::';
	EXPORT         AUTOKEY_SKIP_SET := autokey_buildskipset;

  EXPORT mi_cust_id := 1535116; // A hard-coded number that signifies a MI record
	EXPORT il_cust_id := 1594356; // A hard-coded number that signifies an IL record

END;