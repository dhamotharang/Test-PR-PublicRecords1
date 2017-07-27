import ut;
export Build_all(string version=version) := function

ut.MAC_SF_BuildProcess(Build_base,'~thor_data400::base::certegy',certegybase,2,,true);

Build_all_keys := Build_keys(version);

zDoPopulationStats:=STRATA_Stats;

built := sequential(
					certegybase
					// ,Build_all_keys
					,zDoPopulationStats);

return built;

end;
