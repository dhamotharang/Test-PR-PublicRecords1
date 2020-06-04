
EXPORT mac_filter_orphanrecords(pOverrideDataset
																,pOverrideFieldName // flag_file_id or did/lexid or ssn
																,pOrphanFieldName // flag_file_id or did/lexid or ssn
																,pFileID
																,ret_dFiltered) := macro
	import STD, Overrides;
	#uniquename(dOrphanRecords)
	%dOrphanRecords% := Overrides.File_Override_Orphans.orphan_file(STD.Str.ToUpperCase(trim(datagroup)) = STD.Str.ToUpperCase(trim(pFileID)));
	ret_dFiltered := pOverrideDataset((unsigned6)pOverrideFieldName not in set(%dOrphanRecords%,(unsigned6)pOrphanFieldName));
	
	
endmacro;