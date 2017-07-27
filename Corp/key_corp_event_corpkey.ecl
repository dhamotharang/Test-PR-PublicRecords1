import doxie;

export key_corp_event_corpkey := index(corp.File_Corp_event_Base,{corp_key,record_type},{file_corp_event_base},'~thor_Data400::key::corp_event_corpkey_' + doxie.Version_SuperKey);
