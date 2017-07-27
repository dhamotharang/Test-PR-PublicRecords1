import tools,Medschool_standardization;

EXPORT filenames(string pversion = '', boolean pUseProd = false) := module

		export medschool_lBaseTemplate                    := Medschool_standardization._Dataset(pUseProd).thor_cluster_files +'base::'+_Dataset().name+ '::medschool::@version@';
		export medschool_Base                             := tools.mod_FilenamesBuild(medschool_lBaseTemplate, pversion);
		export medschool_wordlist_lBaseTemplate           := Medschool_standardization._Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::medschool_wordlist::@version@';
		export medschool_wordlist_Base                    := tools.mod_FilenamesBuild(medschool_wordlist_lBaseTemplate, pversion);
		export non_medschool_lBaseTemplate                := Medschool_standardization._Dataset(pUseProd).thor_cluster_files +'base::'+_Dataset().name+ '::nonmedschool::@version@';
		export non_medschool_base                         := tools.mod_FilenamesBuild(non_medschool_lBaseTemplate, pversion);
		export non_medschool_wordlist_lBaseTemplate       := Medschool_standardization._Dataset(pUseProd).thor_cluster_files + 'base::'+_Dataset().name+ '::nonmedschool_wordlist::@version@';
		export non_medschool_wordlist_Base                := tools.mod_FilenamesBuild(non_medschool_wordlist_lBaseTemplate, pversion);

end;
