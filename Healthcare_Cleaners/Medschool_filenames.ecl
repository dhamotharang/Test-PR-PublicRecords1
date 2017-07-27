import versioncontrol,tools;
EXPORT Medschool_filenames(string pversion = '', boolean pUseProd = false) := module
export medschool_lBaseTemplate              := _Dataset(pUseProd).thor_cluster_files +'base::'+_Dataset().name+ '::medschool';
export medschool_lBaseTemplate1              := _Dataset(pUseProd).thor_cluster_files +'base::'+_Dataset().name+ '::medschools';
export medschool_Base                       := tools.mod_FilenamesBuild(medschool_lBaseTemplate, pversion);
export medschool_wordlist_lBaseTemplate     := _Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::medschool_wordlist';
export medschool_wordlist_lBaseTemplate1     := _Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::medschools_wordlist';
export medschool_wordlist_Base              := tools.mod_FilenamesBuild(medschool_wordlist_lBaseTemplate, pversion);
export non_medschool_lBaseTemplate          := _Dataset(pUseProd).thor_cluster_files +'base::'+_Dataset().name+ '::non_medschool';
export non_medschool_lBaseTemplate1          := _Dataset(pUseProd).thor_cluster_files +'base::'+_Dataset().name+ '::non_medschools';
export non_medschool_base                   := tools.mod_FilenamesBuild(non_medschool_lBaseTemplate, pversion);
export non_medschool_wordlist_lBaseTemplate := _Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::non_medschool_wordlist';
export non_medschool_wordlist_lBaseTemplate1 := _Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::non_medschools_wordlist';
export non_medschool_wordlist_Base          := tools.mod_FilenamesBuild(non_medschool_wordlist_lBaseTemplate, pversion);
end;