//New Mexico Estate Appraisers NMS0843
IMPORT _control, Prof_License_Mari;

EXPORT files_NMS0843 := MODULE

	SHARED code				:= 'NMS0843';
	EXPORT appr				:=	DATASET(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'apr', 
																Prof_License_Mari.layout_NMS0843.common,
																CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));
	END;
