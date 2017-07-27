export MAC_Match_Hash(inf,outf) := macro

#uniquename(hrec)
%hrec% := record
	inf;
	integer8	hval;
	unsigned1 rank1;
	unsigned1	rank2;
end;

#uniquename(normIt)
%hrec% %normIt%(inf L, integer C) := transform
	self.hval := header_slimsort.Mac_Hash_InputFile(C);
	self.rank1 := map(    C in [ 1,7,11,15] => 1,
					  C in [ 2,3] => 2,
					  C in [ 3,8,12] => 3,
					  C in [ 4,13] => 4,
					  C in [ 5,9,14,16] => 5,
					  6);
	self.rank2 := C;
	self := L;
end;

#uniquename(df2)
%df2% := normalize(inf,17,%normIt%(LEFT,COUNTER));

#uniquename(pre_outrec)
%pre_outrec% := record
	unsigned6	did;
	unsigned1	rank1;
	unsigned1	rank2;
	inf;
end;

#uniquename(check)
%pre_outrec% %check%(%df2% L, header_slimsort.key_header_Hash R) := transform
	self.did := R.did;
	self.rank1 := if (R.did = 0, 100, L.rank1);
	self.rank2 := if (R.did = 0, 100, L.rank2);
	self := L;
end;

#uniquename(outf1)
%outf1% := join(%df2%,header_slimsort.key_header_Hash,left.hval = right.hash_val,%check%(LEFT,RIGHT),left outer);

#uniquename(outf2)
%outf2% := dedup(sort(%outf1%, rank1, rank2),seq);

#uniquename(outrec)
%outrec% := didville.layout_did_hash_out;

#uniquename(into_out)
%outrec% %into_out%(%outf2% L) := transform
	self := L;
end;

outf := project(%outf2%,%into_out%(LEFT));

endmacro;
