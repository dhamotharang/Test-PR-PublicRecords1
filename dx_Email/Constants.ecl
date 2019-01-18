IMPORT ut, _control, Email_DataV2;

EXPORT Constants (string filedate = '') := MODULE
	
	EXPORT Cluster := '~thor_200::';
	
	// autokey
	EXPORT ak_keyname := Cluster	+	'key::email_dataV2::autokey::@version@::';
	EXPORT ak_qa_keyname := Cluster	+	'key::email_dataV2::autokey::qa::';
	EXPORT ak_logical := Cluster	+	'key::email_dataV2::'+filedate+'::autokey::';
	EXPORT ak_dataset := Email_DataV2.File_AutoKey;
	EXPORT ak_skipSet := ['P','B'];
	EXPORT ak_typeStr	:= 'BC';
	EXPORT STRING srcType:= 'email_dataV2';
	
END;
