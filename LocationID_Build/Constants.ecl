export Constants := module
	export string  BuildServer           := _Constants().GroupName;
	export string  HistoryFileNamePrefix := '~location_id_build::' + KeySuffix + '::workunit_history::';
	export string  HistoryFileNameSFName := '~location_id_build::qa::workunit_history';
	
	export integer NumOfIterations := 1;
end;