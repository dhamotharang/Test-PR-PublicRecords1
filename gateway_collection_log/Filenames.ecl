IMPORT versioncontrol;
EXPORT Filenames(STRING pversion = '', BOOLEAN pUseProd = FALSE) := MODULE

 EXPORT lInputTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::'  + _Dataset().name + '::@version@::data';
 EXPORT lBaseTemplate  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@::Full';

 EXPORT Input          := versioncontrol.mInputFilenameVersions(lInputTemplate);

 EXPORT Base           := versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);

 EXPORT dAll_filenames :=  Base.dAll_filenames ;
 
END;
