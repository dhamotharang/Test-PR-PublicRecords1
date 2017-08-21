// NMS0843 / New Mexico Real Estate Appraisers Board / Real Estate Appraisers //
//This file is replaced by files_NMS0843 3/27/13 Cathy Tio
IMPORT _control, Prof_License_Mari;

// export file_NMS0843 := dataset('~thor_data400::in::prolic::NMS0843::REAB_Active.txt',Prof_License_Mari.layout_NMS0843,csv(SEPARATOR('\t'),QUOTE('"'),heading(1)));
export file_NMS0843 := dataset(Common_Prof_Lic_Mari.SourcesFolder + 'NMS0843' + '::' + 'using' + '::' + 'apr', 
															 Prof_License_Mari.layout_NMS0843.appr,
															 CSV(SEPARATOR(','),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 