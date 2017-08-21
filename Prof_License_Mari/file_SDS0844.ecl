// South Dakota Real Estate Commission
IMPORT _control, Prof_License_Mari;

EXPORT file_SDS0844 := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'SDS0844' + '::' + 'using' + '::' + 'rle_license', 
															 Prof_License_Mari.layout_SDS0844.raw,
															 CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR('\r\n')));
															 
//export file_SDS0844 := dataset('~thor_data400::in::proflic_mari::sds0844::using::rle_license',Prof_License_Mari.layout_SDS0844.src,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\r\n')));


