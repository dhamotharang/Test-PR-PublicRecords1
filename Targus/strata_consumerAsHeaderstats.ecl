import Targus, strata;

export strata_consumerAsHeaderstats(string versionDate) := function
	strata.createAsHeaderStats(Targus.consumer_as_header(Targus.File_consumer_base),'Targus White Pages','Data',versionDate,'',statsOut);

	return statsOut;
end;