import versioncontrol;
export Filenames(string pversion = '') :=
module
   export lInputTemplate   := _Dataset().thor_cluster_files + 'in::'   + _Dataset().name + '::@version@::data';
   export lBaseTemplate := _Dataset().thor_cluster_files + 'base::' + _Dataset().name + '::@version@::data';
   export Input   := versioncontrol.mInputFilenameVersions(lInputTemplate                 );
   export Base    := versioncontrol.mBuildFilenameVersions(lBaseTemplate   ,pversion   );
                                                                        
   export dAll_filenames :=
        Base.dAll_filenames
   ;
end;
