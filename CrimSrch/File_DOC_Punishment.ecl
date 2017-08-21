import Crim_Common, hygenics_search;

export File_DOC_Punishment
 := dataset('~thor_data400::base::crim_punishment_' + Version.DOC_Punishment+ '_new',
			hygenics_search.Layout_Moxie_DOC_Punishment,flat,unsorted);