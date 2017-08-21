import header,doxie;
r := doxie.File_Didtrack;

export key_DidTrack_RID := INDEX(
	r,
	{r.rid,r.current,r.did},
	{r},
	'~thor_data400::key::didtrack.rid_' + version_superkey);
