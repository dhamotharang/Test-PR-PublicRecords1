
Import VersionControl, Tools;

Export Filenames( String pversion = '', Boolean pUseprod = False ) := Module 

    Export lBaseTemplate_Built  := _Dataset(pUseProd).thor_cluster_files + 'base' + _Dataset().Name + '::built';
    Export lBaseTemplate   := _Dataset(pUseProd).thor_cluster_files + 'base' + _Dataset().name + '::@version@';
    Export lInputTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name;
    Export lInputHistTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::history';
    Export Base  := tools.mod_FilenamesBuild(lBaseTemplate, pversion );
    Export dAll_filenames := Base.dAll_filenames; 

End;


// ?????