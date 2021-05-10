import _control, doxie, STD;
#IF(_control.environment.onThor and ~_control.Environment.onVault)
import dops;
#END;

export file_version(boolean isFCRA = FALSE) := module

  // pulls the latest dops version for the specified dataset
  export get_dataset_version(string dops_dataset) := function
    #IF(_control.environment.onThor and ~_control.Environment.onVault and ~_control.Environment.onThor_LeadIntegrity)
    data_env := IF(isFCRA, 'F', 'N');
    dataset_name := IF(isFCRA, 'FCRA_', '') + dops_dataset; // this works only when FCRA datasets are prefixed by FCRA_ (most cases).
    version := dops.GetBuildVersion(dataset_name, 'B', data_env, 'P'); 
    #ELSE
    version := doxie.Version_SuperKey;
    #END
    RETURN version;
  end;

  // If file name has @version@, it gets replaced with latest dops version on thor or default 'QA' version on Roxie.
  // Also fails with ERROR on thor if file version cannot be found.
  export get_file(string dops_dataset, string fname) := function

    ds_version := get_dataset_version(dops_dataset);
    file_name := Std.Str.FindReplace(fname, '@version@', ds_version);
    
    #IF(_control.environment.onThor and ~_control.Environment.onVault)
    version_exists := IF(ds_version<>'' AND file_name<>'', STD.File.FileExists(file_name), FALSE) : INDEPENDENT;
    RETURN IF(version_exists, file_name, ERROR(file_name + ' not found'));
    #ELSE
    RETURN file_name;
    #END

  end;

end;
