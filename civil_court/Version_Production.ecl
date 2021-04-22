IMPORT STD, dops;

latest_build_versions := SORT(
	dops.GetLatestBuildVersions('CivilCourtKeys','B','N','P',0),
	-releasedate
); 

EXPORT Version_Production := latest_build_versions[1].buildversion;
