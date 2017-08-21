// EXPORT file_NYS0828 := DATASET('~thor_data400::in::proflic_mari::nys0828::using::appr',Prof_License_Mari.layout_NYS0828.appraiser,FLAT,__COMPRESSED__,OPT,UNSORTED);

EXPORT file_NYS0828 := MODULE
EXPORT appraiser    := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'NYS0828' + '::' + 'using' + '::' + 'appraiser', 
															 Prof_License_Mari.layout_NYS0828.COMMON,
															 CSV(SEPARATOR(','),HEADING(1),QUOTE('"')));	

EXPORT professional := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'NYS0828' + '::' + 'using' + '::' + 'professional', 
															 Prof_License_Mari.layout_NYS0828.COMMON,
															 CSV(SEPARATOR(','),HEADING(1),QUOTE('"')));		
END;