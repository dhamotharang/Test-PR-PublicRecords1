import ut;

export Fn_CleanFnameTranspose(dataset(header.Layout_Header) head0) := 
FUNCTION

head := distribute(head0, hash(did));

//****** COUNT THE OCCURENCES OF FNAME AND LNAME
frec := record
	head.did;
	head.fname;
	cnt := count(group);
end;

lrec := record
	head.did;
	head.lname;
	cnt := count(group);
end;

fnames := table(head, frec, did, fname, local);
lnames := table(head, lrec, did, lname, local);

//****** IDENTIFY LNAMES THAT ARE STUCK IN FNAME FIELD
is_SigBigger(unsigned4 big, unsigned4 small) := big >= (2 * small);

nrec := record
	head.did;
	typeof(head.fname) orig_fname;
	typeof(head.fname) new_fname;
end;

nrec xf_orig_names(fnames fna, lnames lna) := transform
	self.did := fna.did;
	self.orig_fname := fna.fname;
	self.new_fname := '';
end;

orig_names := join(fnames, lnames, 
			  left.did = right.did and 
			  left.fname = right.lname and
			  //UT.StringSimilar(left.fname, right.lname) <= 1 and
			  is_SigBigger(right.cnt,left.cnt),
			  xf_orig_names(left, right), 
			  local);

//****** FIND A GOOD REPLACEMENT
nrec xf_new_fnames(orig_names l, fnames r) := transform
	self.new_fname := r.fname;
	self := l;
end;

fnames_srt := sort(fnames, did, -cnt, local);
fnames_ddp := dedup(fnames_srt, did, local);

new_fnames := join(orig_names, fnames_ddp,
				   left.did =right.did,
				   xf_new_fnames(left, right),
				   local);
				  

//****** CORRECT THEM
head xf_corr(head l, new_fnames r) := transform
	self.fname := if(r.new_fname <> '', r.new_fname, l.fname);
	self := l;
end;
	

corr := join(head, new_fnames,
			 left.did = right.did and
			 left.fname = right.orig_fname,
			 xf_corr(left, right),
			 left outer,
			 local);
			 

// output(choosen(orig_names(did in dids), 1000), named('orig_names'));
// output(fnames_srt, named('fnames_srt'));
// output(fnames_ddp, named('fnames_ddp'));
// output(choosen(new_fnames(did in dids), 1000), named('new_fnames'));
// output(choosen(corr(did in dids), 1000), named('corr'));
return corr;
	
END;