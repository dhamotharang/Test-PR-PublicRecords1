// WVS0816 / West Virginia Real Estate Appr Lic & Cert Board / Real Estate Appraisers //
IMPORT _control, Prof_License_Mari;

EXPORT file_WVS0816 := DATASET(Common_Prof_Lic_Mari.SourcesFolder + 'WVS0816' + '::' + 'using' + '::' + 'apr', 
															 //Prof_License_Mari.layout_WVS0816,
															 Prof_License_Mari.layout_WVS0816.LAYOUT_RAW,
															 CSV(SEPARATOR(','),heading(0),quote('"')));
