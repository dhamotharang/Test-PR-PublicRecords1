EXPORT key_locid_rawaid_map := module
     shared emptyDs := dataset([],Layouts.LocIDRawIdRec);
	  
     export Key(dataset(Layouts.LocIDRawIdRec) inDs = emptyDs,
					 string fileName                             = keynames().locidRawAidMap.qa
					 ) := index(inDs, {locId}, {inDs}, fileName );
					
end;
