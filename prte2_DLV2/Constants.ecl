EXPORT Constants := module

EXPORT KeyName_dl2 := 	'~prte::key::dl2::'; 

EXPORT file_in := '~PRTE::IN::DL2::DRVLIC';

EXPORT file_base := '~PRTE::BASE::DL2::DRVLIC';

EXPORT ak_keyname := KeyName_dl2 +'autokey::@version@::'; 

EXPORT ak_qa_name := regexreplace('@version@', ak_keyname,'qa',nocase);

EXPORT ak_logical(string filedate) := KeyName_dl2 + filedate + '::autokey::'; 

EXPORT skip_set := ['B','P','Q','F'];

EXPORT ak_typestr := 'DL'; 

END;