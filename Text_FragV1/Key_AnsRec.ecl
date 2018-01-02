IMPORT Text_Search,data_services;
STRING stem := data_services.data_location.prefix() + 'THOR_DATA400::FULL';
STRING sourceType := 'FRAGS';
info := Text_Search.FileName_Info_Instance(stem, sourceType, '');
ansIndxName := Text_FragV1.FileName(info, Text_FragV1.Types.FileType.AnswerDocX);

EXPORT Key_AnsRec := Indx_AnsRec(ansIndxName);