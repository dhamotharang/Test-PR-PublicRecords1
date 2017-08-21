//Raw professional license file from KY S0809
EXPORT file_KYS0809 := MODULE

	SHARED code 								:= 'KYS0809';
	EXPORT apr								:= dataset(Common_Prof_Lic_Mari.SourcesFolder + code + '::' + 'using' + '::' + 'apr', 
																					Prof_License_Mari.layout_KYS0809,
																					CSV(SEPARATOR(','),heading(1),quote('"'),TERMINATOR(['\n','\r\n','\n\r']))); 	
END;
