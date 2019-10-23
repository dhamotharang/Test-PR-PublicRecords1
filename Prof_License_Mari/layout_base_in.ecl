// CCPA-110 - remove global_sid and record_sid for backward compatibility
EXPORT layout_base_in  :=  RECORD,maxlength(8000)
	Prof_License_Mari.Layouts.Base - [Global_sid, Record_sid];
END; 


