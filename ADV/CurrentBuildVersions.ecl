import ut,did_add, riskwise;

EXPORT CurrentBuildVersions := module
	 
	EXPORT Layout := RECORD
		string datasetname{xpath('datasetname')};
		string envment{xpath('envment')};
		string location{xpath('location')};
		string cluster{xpath('cluster')};
		string buildversion{xpath('buildversion')};
		string keycount{xpath('keycount')};
		string releasedate{xpath('releasedate')};
	 END;

	EXPORT File := dataset('~foreign::10.194.10.1::' + 'adv::sourcecurrentversions', Layout,  CSV(heading(single), quote('"')));	
end;