import header, data_services;

t := header.Prepped_For_Keys;

rid_rec := record
  t.rid;
  t.did;
  end;

rid_records := dedup(sort(table(t,rid_rec),record,record));

export Key_Prep_Header_RID := INDEX(rid_records, 
                                    {rid_records}, 
                                    data_services.data_location.prefix() + 'thor_data400::key::header.rid' + thorlib.wuid());