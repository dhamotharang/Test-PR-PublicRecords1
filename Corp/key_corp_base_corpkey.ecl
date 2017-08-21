import doxie;

export key_corp_base_corpkey := index(fPrepareCorpBaseFile(corp.File_Corp_Base),{corp_key, record_type},{file_corp_base},'~thor_Data400::key::corp_base_corpkey_' + doxie.Version_SuperKey);
