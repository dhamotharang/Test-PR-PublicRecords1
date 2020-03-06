
EXPORT Files := module
	
		EXPORT MAIN 				:= dataset([], layouts.Main);
		EXPORT EXT_SOURCES 	:= dataset([], layouts.External_Sources);
		EXPORT IN_FILE			:= dataset([], layouts.key_in);
    EXPORT TOKENS				:= dataset([], layouts.base);
		EXPORT VERSION			:= dataset([],{unsigned8 version});

END;