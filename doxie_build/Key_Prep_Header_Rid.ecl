import header;

t := header.Prepped_For_Keys;

rid_rec := record
  t.rid;
  t.did;
  end;

rid_records := dedup(sort(table(t,rid_rec),record,record));

export Key_Prep_Header_RID := INDEX(rid_records, {rid_records}, '~thor_data400::key::header.rid' + thorlib.wuid());