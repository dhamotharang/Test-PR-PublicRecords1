import ut,misc,vehlic,PromoteSupers,roxiekeybuild;

h := header_slimsort.header_hash;
PromoteSupers.Mac_SF_BuildProcess(h,'~thor_data400::base::header_hashes',writeFile,2,pCompress := true)

ds := dataset('~thor_data400::base::header_hashes', {h.hash_val, h.did}, flat);
i := index(ds,{ds.hash_val},{ds.did},'~thor_data400::key::header_hashes'+thorlib.WUID());
roxiekeybuild.Mac_SK_BuildProcess(i,'~thor_data400::key::header_hashes','~thor_data400::key::header_hashes',writeKey,2)

export proc_make_hashes := sequential(writeFile/*,writeKey*/,misc.header_hash_validate,vehlic.vina_for_distrix);