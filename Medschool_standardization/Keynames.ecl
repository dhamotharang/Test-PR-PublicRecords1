import  tools,Medschool_standardization;

export KeyNames(string		pversion= '', boolean pUseProd = false) := module

		export medschool_lFileTemplate	                  := Medschool_standardization._Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ Medschool_standardization._Dataset().name + '::medschool::@version@::';
		export medschool_wordlist_lFileTemplate	          := Medschool_standardization._Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ Medschool_standardization._Dataset().name + '::medschool_wordlist::@version@::';
		export non_medschool_lFileTemplate	              := Medschool_standardization._Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ Medschool_standardization._Dataset().name + '::non_medschool::@version@::';
		export non_medschool_wordlist_lFileTemplate	      := Medschool_standardization._Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ Medschool_standardization._Dataset().name + '::non_medschool_wordlist::@version@::';
		export medschool_lmsid_key		                    := medschool_lFileTemplate + 'msid';
		export medschool_msid_key		                      := tools.mod_FilenamesBuild(medschool_lmsid_key,pversion);
		export medschool_msid_dAll_filenames	            := medschool_msid_key.dAll_filenames;
		export medschool_wordlist_lword_key		            := medschool_wordlist_lFileTemplate + 'words';
		export medschool_wordlist_word_key		            := tools.mod_FilenamesBuild(medschool_wordlist_lword_key,pversion);
		export medschool_wordlist_word_dAll_filenames	    := medschool_wordlist_word_key.dAll_filenames;
		export non_medschool_lmsid_key		                := non_medschool_lFileTemplate + 'msid';
		export non_medschool_msid_key		                  := tools.mod_FilenamesBuild(non_medschool_lmsid_key,pversion);
		export non_medschool_msid_dAll_filenames	        := non_medschool_msid_key.dAll_filenames;
		export non_medschool_wordlist_lword_key		        := non_medschool_wordlist_lFileTemplate + 'words';
		export non_medschool_wordlist_word_key		        := tools.mod_FilenamesBuild(non_medschool_wordlist_lword_key,pversion);
		export non_medschool_wordlist_word_dAll_filenames	:= non_medschool_wordlist_word_key.dAll_filenames;
		
end;