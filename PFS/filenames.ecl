import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module

    export pfs_lBaseTemplate_built  :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name +'::cptcodes::built';
    export pfs_lBaseTemplate        :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::cptcodes::@version@';
//  export pfs_lKeyTemplate         :=_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::cptcodes::@version@';    
    export pfs_lInputTemplate       :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::cptcodes' ;
    export pfs_lInputHistTemplate   :=_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::cptcodes::history';
    export pfs_Base                 := tools.mod_FilenamesBuild(pfs_lBaseTemplate, pversion);
end;

    