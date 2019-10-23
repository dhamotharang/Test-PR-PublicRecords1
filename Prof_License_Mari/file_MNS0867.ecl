// MNS0867 / Minnesotas Bookstore /	Real Estate Appraisers //
#workunit('name','Yogurt: File MNS0867');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices;

EXPORT file_MNS0867 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'MNS0867' + '::' + 'using' + '::' + 'apr', 
													 Prof_License_Mari.layout_MNS0867,
													 CSV(SEPARATOR('\t'),heading(0),quote('"'),TERMINATOR(['\n','\r\n','\n\r'])));

//export file_MNS0867 := dataset('~thor400_88::in::prolic::MNS0867::appraisers',Prof_License_Mari.layout_MNS0867,csv(SEPARATOR(',')));
