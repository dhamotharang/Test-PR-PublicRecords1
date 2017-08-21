// MSS0815 / Mississippi Real Estate Appraisers
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_MSS0815 := MODULE

	SHARED code 								:= 'MSS0815';
	SHARED working_dir					:= 'using';
	//Used by 20121129 and 20130304 - begin
	 EXPORT apr 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 'apr', 
													   // Prof_License_Mari.layout_MSS0815.active_inactive,
													   Prof_License_Mari.layout_MSS0815.common,
													   CSV(SEPARATOR(','),heading(1),quote('"')));
	 EXPORT re 			:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + working_dir + '::' + 're', 
													   Prof_License_Mari.layout_MSS0815.common,
													   CSV(SEPARATOR(','),heading(1),quote('"')));

END;
