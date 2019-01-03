import PromoteSupers, std;
/*
status code:
1 - Started
2..n - Intermeditate State
0 - Completed
*/

EXPORT LogBuildStatus(string sf_name, string _version = '', unsigned2 _status = 0) := module

    shared rec := {string version, unsigned2 status};
    
    EXPORT Read  := dataset(sf_name, rec, thor,OPT);
	
    ds	:= dataset([{_version, _status}],rec) + Read(version <> _version);
	PromoteSupers.MAC_SF_BuildProcess(ds, sf_name, PostVer ,2,,true,thorlib.wuid()+(string)_status);
	EXPORT Write := sequential(
                        if(~STD.File.FileExists(sf_name), STD.File.CreateSuperFile(sf_name)),
                        if(~STD.File.FileExists(sf_name + '_father'), STD.File.CreateSuperFile(sf_name + '_father')),
                        PostVer);  
    
    EXPORT GetLatestVersionCompletedStatus :=max(Read(version=_version),status);

    
    EXPORT GetLatest := MODULE
                EXPORT versionName    := max(read,version);
                EXPORT versionStatus  := max(read(version=versionName),status);
            END;
END;