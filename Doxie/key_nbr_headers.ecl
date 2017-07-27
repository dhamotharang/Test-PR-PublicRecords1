import Data_Services,doxie,ut;

df := doxie.nbr_headers;

thinRec := record
	df.zip,
	df.prim_name,
	df.suffix,
	df.predir,
	df.postdir,
	df.prim_range,
	df.sec_range,
	df.uid,
	df.RawAID
end;
df2 := table(
	df,
	thinRec
);

df3 := dedup(sort(df2,record));

export key_nbr_headers := index(
	df3,																																	// baserecset
	{zip, prim_name, suffix, predir, postdir, prim_range, sec_range},			// keys
	{uid, RawAID},																																// payload
	Data_Services.Data_location.Prefix('PersonHeader') + 'thor_Data400::key::header_nbr_' + doxie.Version_SuperKey		// indexfile
);

// Build this on the "400way" cluster with...
//
// import doxie;
// buildindex(doxie.key_nbr_headers, OVERWRITE);
