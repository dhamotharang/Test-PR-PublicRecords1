export File_DOC_Offenses_Plus
 := dataset(Crim_Common.Name_Moxie_DOC_Offenses_Prod,
			{Layout_Moxie_DOC_Offenses.previous,unsigned8 __fpos { virtual(fileposition)}},flat,unsorted);