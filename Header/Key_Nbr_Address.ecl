import doxie,Data_Services,mdr;

df := header.file_headers(mdr.sourcetools.sourceisonprobation(src)=false,prim_name<>'',zip<>'');

slimrec := record
	df.prim_name;
	df.prim_range;
	df.sec_range;
	df.zip;
	df.zip4;
	df.suffix;
	df.did;
	df.dt_first_seen;
	df.dt_last_seen;
	df.RawAID;
end;

df2 := table(df,slimrec);

df3 := group(sort(distribute(df2,hash(did,prim_name,zip,prim_range)),did,prim_name,zip,prim_range,sec_Range,suffix,dt_first_seen, -dt_last_seen,local),did,prim_name,zip,prim_range,sec_Range,suffix,local);

df3 roll_dates(df3 L, df3 R) := transform
	self.dt_first_seen := if (L.dt_first_seen < R.dt_first_seen and L.dt_first_seen != 0, L.dt_first_seen, R.dt_first_seen);
	self.dt_last_seen := if (L.dt_last_seen > R.dt_last_seen, L.dt_last_seen, R.dt_last_seen);
	self := l;
end;

df4 := rollup(df3, true, roll_dates(LEFT,RIGHT));

df5 := group(df4);

export Key_Nbr_Address := index(df5,{prim_name,zip,z2 := zip4[1..2], suffix, prim_range},{did,sec_range,dt_first_seen,dt_last_seen,RawAID},
Data_Services.Data_location.Prefix('PersonHeader') +'thor_Data400::key::nbr_address_' + doxie.Version_SuperKey);
