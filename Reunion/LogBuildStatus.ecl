import PromoteSupers, std;

EXPORT LogBuildStatus(string sf_name, string _buildversion = '', string _feedversion = '', unsigned2 _status = 0) := module

    shared rec := {string buildversion, string feedversion, unsigned2 status};
    
    EXPORT Read  := dataset(sf_name, rec, thor,OPT);
	
    ds	:= dataset([{_buildversion, _feedversion, _status}],rec) + Read(buildversion <> _buildversion);
	PromoteSupers.MAC_SF_BuildProcess(ds, sf_name, PostVer ,2,,true,thorlib.wuid()+(string)_status);
	EXPORT Write := sequential(
                        if(~STD.File.FileExists(sf_name), STD.File.CreateSuperFile(sf_name)),
                        if(~STD.File.FileExists(sf_name + '_father'), STD.File.CreateSuperFile(sf_name + '_father')),
                        PostVer);  
    
    EXPORT GetLatestVersionCompletedStatus :=max(Read(buildversion=_buildversion),status);

    
    EXPORT GetLatest := MODULE
                EXPORT buildversionName := max(read,buildversion);
                EXPORT feedversionName  := max(read,feedversion);
                EXPORT versionStatus    := max(read(buildversion=buildversionName),status);
    END;
END;