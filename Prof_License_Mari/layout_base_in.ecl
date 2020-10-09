// CCPA-110 - remove global_sid and record_sid for backward compatibility
IMPORT dx_common;
EXPORT layout_base_in  :=  RECORD,maxlength(8000)
	//DF-28229
	Prof_License_Mari.Layouts.Base - dx_common.layout_metadata;
END; 


