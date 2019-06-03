// CCPA-110 - remove global_sid and record_sid for backward compatibility
EXPORT layout_base_in  :=  RECORD
	Prof_License_Mari.Layouts.Base - [Global_sid, Record_sid];
END; 


