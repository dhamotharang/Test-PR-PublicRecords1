import header, header_quick, dx_Header;

src_rec := record
	unsigned6 rid;
	unsigned6 did;
	unsigned6 first_seen;
	unsigned3 dt_nonglb_last_seen;
end;

export data_key_RID (boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

t  := $.Prepped_For_Keys;

fqh := header_quick.file_header_quick;

rid_rec := record
  t.rid;
  t.did;
  t.first_seen;
  t.dt_nonglb_last_seen;
  end;

rid_records0 := dedup(sort(table(t,rid_rec),record,record));

rid_rec2 := record
  fqh.rid;
  fqh.did;
  unsigned6 first_seen := header.get_header_first_seen(fqh);
  fqh.dt_nonglb_last_seen;
end;

Fheader     := dedup(sort(table(fqh,rid_rec2),record,record));

rid_records	:=	if(pCombo,pDataset,if(pFastHeader,Fheader,rid_records0));

return PROJECT (rid_records, dx_Header.layouts.i_rid);

end;