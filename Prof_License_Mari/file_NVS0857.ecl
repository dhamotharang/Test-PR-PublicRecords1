//Nevada Real Estate Division Appraiser Licenses File NVS0857

// #workunit('name','Files NVS0857');
IMPORT _control, Prof_License_Mari;

EXPORT file_NVS0857 := MODULE

EXPORT appr       := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'NVS0857' + '::' + 'using' + '::' + 'appr', 
															 Prof_License_Mari.layout_NVS0857,
															 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));															 
EXPORT b_broker   := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'NVS0857' + '::' + 'using' + '::' + 'businessBroker', 
															 Prof_License_Mari.layout_NVS0857,
															 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r']))); 
EXPORT sale       := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'NVS0857' + '::' + 'using' + '::' + 'brokersalesperson', 
															 Prof_License_Mari.layout_NVS0857,
															 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r']))); 
EXPORT broker     := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'NVS0857' + '::' + 'using' + '::' + 'broker', 
															 Prof_License_Mari.layout_NVS0857,
															 CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));				 
	END;														 



