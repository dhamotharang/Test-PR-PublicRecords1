IMPORT Text_Search;
STRING stem := '~THOR_DATA400::FULL';
STRING sourceType := 'FRAGS';
info := Text_Search.FileName_Info_Instance(stem, sourceType, '');

EXPORT Key_Nominal3 := Text_Search.Indx_Nominal3(info);