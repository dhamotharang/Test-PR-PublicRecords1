IMPORT Text_Search;
STRING stem := '~THOR_DATA400::FULL';
STRING sourceType := 'FRAGS';
info := Text_Search.FileName_Info_Instance(stem, sourceType, '');

EXPORT Key_LocalDict := Text_Search.Indx_LocalDict(info);