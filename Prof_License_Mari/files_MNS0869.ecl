// MNS0869 / Minnesotas Bookstore /	Real Estate // raw files
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT files_MNS0869 := MODULE

	EXPORT rea 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MNS0869' + '::' + 'using' + '::' + 'rea', 
													 Prof_License_Mari.layout_MNS0869.rea,
													 CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));
													 
	EXPORT rec 		:= dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MNS0869' + '::' + 'using' + '::' + 'rec', 
													 Prof_License_Mari.layout_MNS0869.rec,
													 CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

END;
/*
export files_MNS0869 := MODULE

	export rea  := dataset('~thor_data400::in::prolic::MNS0869::rea',Prof_License_Mari.layout_MNS0869.rea,csv(SEPARATOR(',')));
                 								 
	export rec  := dataset('~thor_data400::in::prolic::MNS0869::rec',Prof_License_Mari.layout_MNS0869.rec,csv(SEPARATOR(',')));

END;
*/