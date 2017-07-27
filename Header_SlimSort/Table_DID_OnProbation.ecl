import header,mdr;

df := header.file_headers;

slimrec := record
	df.did;
	df.src;
end;

df2 := table(df,slimrec);

df3 := group(sort(df2,did,local),did,local);

df3 roll(df3 L, df3 R) := transform
	self.did := l.did;
	self.src := if (~mdr.Source_is_on_Probation(L.src),L.src,R.src);
end;

df4 := rollup(df3,true,roll(LEFT,RIGHT));

df5 := df4(mdr.Source_is_on_Probation(src));

didrec := record
	df5.did;
end;

df6 := table(df5,didrec);

export Table_DID_OnProbation := df6 : persist('persist::DIDs_On_Probation');