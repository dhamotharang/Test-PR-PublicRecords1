import PromoteSupers, std;
/*
status code:
1 - Started
2..n - Intermeditate State
0 - Completed
*/

EXPORT LogBuildStatus(string sf_name, string version = '', unsigned2 status = 0) := module

    shared rec := {string version, unsigned2 status};
	ds	:= dataset([{version, status}],rec) + dataset(sf_name, rec, thor)(version <> version);
	PromoteSupers.MAC_SF_BuildProcess(ds, sf_name, PostVer ,2,,true,thorlib.wuid()+(string)status);
	EXPORT Write := sequential(
                        if(~STD.File.FileExists(sf_name), STD.File.CreateSuperFile(sf_name)),
                        if(~STD.File.FileExists(sf_name + '_father'), STD.File.CreateSuperFile(sf_name + '_father')),
                        PostVer);  
    
    EXPORT Read  := dataset(sf_name, rec, thor);
END;