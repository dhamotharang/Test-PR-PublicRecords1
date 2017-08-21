IMPORT  doxie,mdr, PRTE2_MFind;

EXPORT keys := MODULE


//key_did
sort_did   := SORT(Files.file_did, did, trim_vid);
dedup_did  := DEDUP(sort_did, did, trim_vid);

EXPORT key_did := INDEX(
	 dedup_did, 
	 {did}, 
	 {trim_vid}, 
	 Constants.keyname_mfind + doxie.Version_SuperKey + '::did');
	 
//key_vid
sort_vid   := SORT(FILES.file_vid,trim_vid);

EXPORT key_vid := INDEX(
	 sort_vid, 
	 {trim_vid}, 
	 {sort_vid}, 
	 Constants.keyname_mfind + doxie.Version_SuperKey + '::vid');

END;
