
DIDs := table(distribute(Lssi.File_LSSI_Base(clean_phone <> '' and did > 0), hash(did)), {did}, did);

oldDIDs := dedup(distribute(Dataset('~thor_data400::base::lssi_main_father', LSSI.layout_LSSI_Base, flat, OPT)(did > 0), hash(did)), did, local); 

findnew := join(dids, olddids, left.did = right.did, transform({unsigned6 did}, self.did := left.did), left only, local); 
		//LEFT ONLY One record for each add did record with no match in the father base add did

export BWR_New_DIDs_Weekly :=  parallel(
output(count(DIDs), named('Cnt_Add_Recs_With_New_Dids')),
output(choosen(findnew, 100), named('Sample_New_Unique_LSSI_DIDs_Only')));
