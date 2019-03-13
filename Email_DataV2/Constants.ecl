IMPORT ut, _control;

EXPORT Constants (string filedate = '') := MODULE
	
	EXPORT Cluster := '~thor_200::';
	
	// autokey
	EXPORT ak_keyname := Cluster	+	'key::email_dataV2::autokey::@version@::';
	EXPORT ak_qa_keyname := Cluster	+	'key::email_dataV2::autokey::qa::';
	EXPORT ak_logical := Cluster	+	'key::email_dataV2::'+filedate+'::autokey::';
	EXPORT ak_dataset := File_AutoKey;
	EXPORT ak_skipSet := ['P','B'];
	EXPORT ak_typeStr	:= 'BC';
	EXPORT STRING srcType:= 'email_dataV2';
	
	// DF-21686 specify fields to be blanked out in thor_200::key::email_datav2::fcra::qa::did
	EXPORT fields_to_clear := 'orig_ip,dotid,dotscore,dotweight,empid,empscore,empweight,powid,powscore,powweight,proxid,proxscore,'+
														'proxweight,seleid,selescore,seleweight,orgid,orgscore,orgweight,ultid,ultscore,ultweight';

END;
