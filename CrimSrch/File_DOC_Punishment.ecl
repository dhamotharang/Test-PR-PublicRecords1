import Crim_Common;

export File_DOC_Punishment
 := dataset('~thor_data400::base::crim_punishment_' + Version.DOC_Punishment,
			Crim_Common.Layout_Moxie_DOC_Punishment.previous,flat,unsorted);