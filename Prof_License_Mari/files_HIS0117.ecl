//Raw professional license files from HIS0117
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_HIS0117 := MODULE

	SHARED code 								:= 'HIS0117';
	SHARED working_dir					:= 'using';
	
	EXPORT legal_sortname				:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'legal_sortname', 
																					Prof_License_Mari.layout_HIS0117.legal_sortname,
																					CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	EXPORT license_data					:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'license_data', 
																					Prof_License_Mari.layout_HIS0117.license,
																					CSV(SEPARATOR(','),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));			
END;

/* export files_HIS0117 := MODULE
   
   export legal_sortname	:= dataset('~thor_data400::in::prolic::his0117::legal_sortname.txt',Prof_License_Mari.layout_HIS0117.legal_sortname,csv(SEPARATOR(','),QUOTE('"')));
   export license_data := dataset('~thor_data400::in::prolic::his0117::license_data.txt',Prof_License_Mari.layout_HIS0117.license,csv(SEPARATOR(','),QUOTE('"')));
   END;
*/