basefile := Corp.File_Corporate_Affiliations_Plus;

keyfile := Corp.Key_Corporate_Affiliations_DID;

basefile FetchBaseRecords(basefile L) := transform
  self := L;
end;

export Fetch_CA_DID(unsigned6 did_key) := 
   fetch(basefile,
		 keyfile(did_key <> 0, did=did_key),
         right.__filepos,
         FetchBaseRecords(left));