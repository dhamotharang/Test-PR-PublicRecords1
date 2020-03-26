IMPORT ut, _control;

EXPORT Constants (string filedate = '') := MODULE
	
	EXPORT Cluster := '~thor_200::';
	
	// autokey
	EXPORT ak_keyname := Cluster	+	'key::email_dataV2::autokey::@version@::';
	EXPORT ak_qa_keyname := Cluster	+	'key::email_dataV2::autokey::qa::';
	EXPORT ak_logical := Cluster	+	'key::email_dataV2::'+filedate+'::autokey::';
	EXPORT ak_skipSet := ['P','B'];
	EXPORT ak_typeStr	:= 'BC';
	
END;
