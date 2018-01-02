import corp, data_services;

df := corp.File_Corp_Cont_Base(did != 0, bdid != 0);

export Key_Corp_Contacts_DID := index(df,{did},{bdid},data_services.data_location.prefix() + 'thor_Data400::key::corp_cont_didkey');
