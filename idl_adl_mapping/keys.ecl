import header, Data_Services, doxie, ut;

export keys := module
	did_rid_ds := Header.File_LAB_pairs;
	export key_rid := INDEX(did_rid_ds, {rid}, {did}, ut.Data_Location.Person_header + 'thor_data400::key::LAB.DID_RID_' + doxie.version_superkey);
end;