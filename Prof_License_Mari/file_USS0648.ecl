//National Credit Union Administration / Other Lenders //

export file_USS0648 := MODULE
		export foicu := dataset('~thor_data400::in::prolic::uss0648::foicu.txt',Prof_License_Mari.layout_USS0648.r_FOICU,csv(SEPARATOR(','),quote('"'),heading(1)));
		export cred_union := dataset('~thor_data400::in::prolic::uss0648::credunionbrch.txt',Prof_License_Mari.layout_USS0648.r_CRED_UNION,csv(SEPARATOR(','),quote('"'),heading(1)));

END;