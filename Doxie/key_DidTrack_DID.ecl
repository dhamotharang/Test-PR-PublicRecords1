import header,doxie;
r := doxie.File_Didtrack;

export key_DidTrack_DID := INDEX(
	r,
	{r.did,r.current,r.rid},
	{r},
	'~thor_data400::key::didtrack.did_' + version_superkey);
