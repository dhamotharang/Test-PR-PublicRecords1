// SCS0852 / South Carolina Real Estate Commission / Real Estate //
IMPORT _control, Prof_License_Mari;

EXPORT files_SCS0852 := MODULE

	SHARED code				:= 'SCS0852';
	
	EXPORT active			:=	dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'active', 
																Prof_License_Mari.layout_SCS0852.rActiveAgent,
																CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 
	EXPORT inactive		:=	dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'inactive', 
																Prof_License_Mari.layout_SCS0852.rInActiveAgent,
																CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 
END;