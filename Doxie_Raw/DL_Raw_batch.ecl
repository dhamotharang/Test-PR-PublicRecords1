import doxie,doxie_files,ut,doxie_build,ut,mdr,drivers, suppress;

inrec := doxie_Raw.Layout_DLRawBatchInput;
outrec := inrec;
export outrec DL_Raw_batch(grouped dataset(inrec) inputs, boolean DoFail = false) := 
FUNCTION

ig := inputs;

dl_limit := 2000;

//**** DID match		
lds1 := ig;
rds1 := doxie_files.key_DL_DID;
jcond1(lds1 le, rds1 ri) := le.input.did > 0 and
													 KEYED(le.input.did = ri.did);
jtra1(lds1 le, rds1 ri) := doxie_raw.transform_DLRaw(le, project(ri, transform(recordof(doxie_files.key_dl_number), self := left, self := [])));

DL_from_DID := 
	if(DoFail,
		join(lds1, rds1, jcond1(left, right), jtra1(left, right),  limit(dl_limit, FAIL(203,doxie.errorcodes(203))), left outer),
	  join(lds1, rds1, jcond1(left, right), jtra1(left, right),  atmost(dl_limit), left outer));
		
		
//**** DLNum match
lds := DL_from_DID;
rds := doxie_files.key_dl_number;
jcond(lds le, rds ri) := le.dl_number = '' and   //has not already hit in join above
												 le.input.dl_value <> '' and          //has info to hit this key
												 length(trim(le.input.dl_value)) > 4 and   //since we only check up to length, let make sure 
												 KEYED(le.input.dl_value = ri.s_dl[1..length(trim(le.input.dl_value))]);
jtra(lds le, rds ri) := doxie_raw.transform_DLRaw(le, ri);

DL_Fetched := 
	if(DoFail,
		join(lds, rds, jcond(left, right), jtra(left, right),  limit(dl_limit, FAIL(203,doxie.errorcodes(203))), left outer),
	  join(lds, rds, jcond(left, right), jtra(left, right),  keep(dl_limit), left outer));
							//***  bug 18731 prevents  atmost(dl_limit) here, so use keep for now
return DL_Fetched;
	
END;

