// common module for generating file names
EXPORT mod_FileNames(STRING prefix) := MODULE
	// superfiles
	EXPORT current 			:= TRIM(prefix) + 'current';
	EXPORT father				:= TRIM(prefix) + 'father';
	EXPORT grandfather	:= TRIM(prefix) + 'grandfather';
	EXPORT archive			:= TRIM(prefix) + 'archive';
	
	// logical files
	EXPORT logical(STRING version, STRING wu = '', STRING iter = '') :=  prefix + TRIM(version) + IF(TRIM(iter) > '', '_' + TRIM(iter), '') + IF(TRIM(wu) > '', '_' + TRIM(wu), '');
END;
