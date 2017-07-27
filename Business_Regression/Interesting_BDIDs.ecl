import business_header;


dids_fat := dataset('~thor_data400::CEMTEMP::BH_Match_Base',business_header.layout_business_header_base ,flat);

did_rec := record
	dids_fat.bdid;
end;

dids_dups := table(dids_fat, did_rec);
export Interesting_BDIDs := dedup(dids_dups, bdid, all);