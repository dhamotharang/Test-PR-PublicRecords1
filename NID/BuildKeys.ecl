EXPORT BuildKeys := PARALLEL(
	BUILDINDEX(Key_Repository,OVERWRITE),
    BUILDINDEX(Key_Repository_ClnName,OVERWRITE),	
	BUILDINDEX(Key_Repository_ParsedName,OVERWRITE),
    BUILDINDEX(Key_Repository_Name,OVERWRITE),
	BUILDINDEX(Key_Repository_BizName,OVERWRITE)
);