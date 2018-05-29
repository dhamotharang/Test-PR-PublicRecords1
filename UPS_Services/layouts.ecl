Import BIPV2;
EXPORT layouts := module

	 export RecBipRecordOut2 := record(BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(dataset([],BIPV2.IDfunctions.rec_SearchInput)).RecordOut2)
																	 string1 powid_status_public;
																	 string1 seleid_status_public;
																	 string1 orgid_status_public;
																	 string1 ultid_status_public;
																 end;

end;