IMPORT BIPV2;

export Constants := module

	export text_search := module
		export string stem		:= '~thor_data400::base';
		export string srcType	:= 'liensv2';
		export string qual		:= 'test';
		export string dateSegName			:= 'process-date';
		export unsigned2 alertSWDays	:= 31;
	end;

	EXPORT MAXCOUNT_PARTIES   := 25;
	EXPORT MAXCOUNT_FILINGS   := 15;
  
  EXPORT UNSIGNED2 JOIN_LIMIT     := 10000;
	EXPORT UNSIGNED1 JOIN_TYPE      := BIPV2.IDconstants.JoinTypes.KeepJoin;
	EXPORT UNSIGNED1 LIENS_DID_KEEP := 1000;
  
end;