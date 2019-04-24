IMPORT dx_header;

src_rec := record
	unsigned6 rid;
	unsigned6 did;
	unsigned6 first_seen;
	unsigned3 dt_nonglb_last_seen;
end;

EXPORT Key_Header_RID(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := 
  dx_header.key_rid(, pFastHeader, pCombo);
