import doxie, data_services;

df1 := corp.File_Corp_Event_Base(bdid != 0);

df2 := dedup(sort(distribute(df1,hash(bdid)),bdid,corp_key,local),bdid,corp_key,local);

export key_corp_event_bdid := index(df2,
                                    {bdid},
                                    {corp_key},
                                    data_services.data_location.prefix() + 'thor_Data400::key::corp_event_bdid_' + doxie.Version_SuperKey);
