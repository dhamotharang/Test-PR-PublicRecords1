import doxie;

export key_corp_supp_corpkey := index(corp.File_Corp_supp_Base,{corp_key,record_type},{file_corp_supp_base},'~thor_Data400::key::corp_supp_corpkey_' + doxie.Version_SuperKey);
