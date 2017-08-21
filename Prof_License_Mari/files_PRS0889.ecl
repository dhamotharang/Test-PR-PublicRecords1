// PRS0889 / Commissioner of Financial Inst of Puerto Rico / Multiple Professions //
export files_PRS0889 := MODULE

	EXPORT cbanks				:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PRS0889' + '::' + 'using' + '::' + 'cbanks', 
													Prof_License_Mari.layout_PRS0889.other_bank,
													CSV(SEPARATOR(','),heading(1),quote('"')));

	EXPORT lenders			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'PRS0889' + '::' + 'using' + '::' + 'lenders', 
													Prof_License_Mari.layout_PRS0889.other_bank,
													CSV(SEPARATOR(','),heading(1),quote('"')));
													 
END;