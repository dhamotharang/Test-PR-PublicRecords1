import UPIN,did_add, business_header,header_slimsort, didville, ut,Business_Header_SS;

infile := UPIN.Cleaned_UPIN;

outrec := record
	unsigned6 did := 0;
	unsigned1 did_score:= 0;
	UPIN.Layout_UPIN_Common;
end;

matchset :=['A','Z'];

did_Add.MAC_Match_Flex(infile, matchset,
	 '', '', Physician_Clean_fname, Physician_Clean_mname, Physician_Clean_lname, Physician_Clean_name_suffix, 
	 physician_Clean_prim_range, physician_Clean_prim_name, physician_Clean_sec_range, physician_Clean_zip, physician_Clean_st, '',
	 did,   			
	 outrec, 
	 false, did_score,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped 
	 outfile)

dataset_with_did := outfile;

Layout_DID := record
		string12 did;
		string3  did_score;
		UPIN.Layout_UPIN_common;
end;

Layout_DID tdid(dataset_with_did L) := Transform
	self.did := if((unsigned)L.did <> 0,intformat(L.did, 12, 1),'');
	self.did_score	:= (string3)L.did_score;
	self := L;
end;
	
outf := Project(dataset_with_did,tdid(left));
outf_dedup := dedup(outf, all);
 
output(outf_dedup,,'~thor_data400::base::Cleaned_UPIN_did',overwrite);


//export Cleaned_UPIN_DID := 'todo';